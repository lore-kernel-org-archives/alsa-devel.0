From: Stefan.Hagendorn@lindy.cc
Subject: i8x0 chip only support 32,44.1,48 KHz ???
Date: Sat, 13 Jul 2002 15:21:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <agp9m8$ksc$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I try to use a programm which demands a sampling rate of 16KHz from the 
soundsystem. Setting the device to 32 or 44 KHz works but setting the 
device to 16KHz result in switching back to 48KHz. I updated to the latest 

CVS Version of Alsa Kernel drivers. Is this a bug or does my intel8x0/ac97 

don't support a sampling rate of < 32KHz ?? 

 I had a look on the programm and I use the IOCTL which is used to test 
for the sampling rates to made my own small testprogramm and got the 
following results :

#define snddevice "/dev/dsp"
int main ()
{
        int i;
        int fd;
        int rateT;
        int RATES[8] = {8000,16000,22050,24000,32000,44000,44100,48000};
        for (i=0 ; i < 8 ; i++)
        {
                fd = open(snddevice , O_RDONLY, 0);
                rateT = RATES[i];
                ioctl(fd, SNDCTL_DSP_SPEED, &rateT);
                printf ("Setting to %d ", RATES[i]);
                printf ("returned %d\n",rateT);
                close(fd);
        }
        exit(0);
}

returns the following

[root@voyager hagie]# ./a.out 
Setting to 8000 returned 48000
Setting to 16000 returned 48000
Setting to 22050 returned 48000
Setting to 24000 returned 48000
Setting to 32000 returned 32000
Setting to 44000 returned 48000
Setting to 44100 returned 44100
Setting to 48000 returned 48000

here are some additional informations about my drivers:


[root@voyager cvoicecontrol]# cat /proc/asound/oss/sndstat 
Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc2 emulation code)
Kernel: Linux voyager.lindy.cc 2.4.18-xfs #2 Son Mai 26 18:55:02 CEST 2002 

i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
Intel 82801BA-ICH2 at 0xe000, irq 10

Audio devices:
0: Intel 82801BA-ICH2 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: mixer00

[root@voyager cvoicecontrol]# cat /proc/asound/cards
0 [card0          ]: ICH - Intel 82801BA-ICH2
                     Intel 82801BA-ICH2 at 0xe000, irq 10


[root@voyager cvoicecontrol]# cat /proc/asound/card0/ac97#0
0-0/0: Avance Logic ALC200/200P rev 0

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 
Rate=48kHz


[root@voyager cvoicecontrol]# cat /proc/asound/card0/ac97#0regs 
0:00 = 5950
0:02 = 0202
0:04 = 1f1f
0:06 = 0002
0:08 = 0000
0:0a = 801e
0:0c = 001f
0:0e = 0042
0:10 = 0202
0:12 = 0202
0:14 = 9f1f
0:16 = 0000
0:18 = 0202
0:1a = 0000
0:1c = 0f0f
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 010e
0:28 = 0605
0:2a = 0401
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = ffff
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0011
0:70 = 8210
0:72 = 6aa9
0:74 = 0062
0:76 = 1f0f
0:78 = 0000
0:7a = 57c2
0:7c = 414c
0:7e = 4710

Thanks in advance
Stefan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
