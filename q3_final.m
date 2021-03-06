my_filter = designfilt('bandpassiir', 'StopbandFrequency1', 0.014, 'PassbandFrequency1', 0.015, 'PassbandFrequency2', 0.036, 'StopbandFrequency2', 0.037, 'StopbandAttenuation1', 100, 'PassbandRipple', 1, 'StopbandAttenuation2', 100, 'SampleRate', 20);

fid=fopen('XAN.BHZ.00.ori.SAC','r','ieee-le');
A=fread(fid,[70,1],'float32');
B=fread(fid,[40,1],'int32');
C=char(fread(fid,[1,192],'char'));
HR=fread(fid,'float32');
A(A==-12345.0)=NaN;
B(B==-12345)=NaN;
fclose(fid);

final_filtered = filter(my_filter,HR);
n=0:length(HR)-1;
normalized_n = (n*20/76001);
final_fft = fft(final_filtered);
abs_final_HR_fft = abs(HR'); 
abs_final_fft = abs(final_fft);
% dataset-filtered displayed in frequency domain
figure(1);
plot(normalized_n(1:425), abs_final_fft(1:425));
hold on;
line([0.015,0.015], [0 30000],'linestyle','--','Color','g');
line([0.036,0.036], [0 30000],'linestyle','--','Color','r');

% original dataset displayed in frequency domain
figure(2);
plot(normalized_n(1:425),abs_final_HR_fft(1:425));
hold on;
line([0.015,0.015], [0 160],'linestyle','--','Color','g');
line([0.036,0.036], [0 160],'linestyle','--','Color','r');

figure(3);
plot(n,HR');

figure(4);
plot(n,final_filtered);