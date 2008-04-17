From: "Ihar Hrachyshka" <ihar.hrachyshka@gmail.com>
Subject: How to choose output channels for AD1386A sound?
Date: Thu, 17 Apr 2008 10:27:59 +0000
Message-ID: <fce2a370804170327j7c6bebb1j3f96d213d6aa677a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 6806A249DF
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 12:28:32 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so5603ywr.2
	for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2008 03:27:59 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!
I build my BF533-EZKIT-based board (Blackfin processor development
board) sound system on AD1386A sound. I use blackfin.uclinux.org
distribution for it. One of my board's function is to play three
different stereo sound streams simultaneously on it. What I done is
choosing for AD1386 '3 stereos' option. After loading the kernel, my
software is able to open pcm 3 times and plays sound properly, with no
glitches or smth. The only missed functionality is that I can't
specify the needed subdevice I want to play a stream on. I should have
the possibility to play, f.e., mplayer stream on the 3rd stereo output
while the 1st and the 2nd are not used. How can I do it?
Also that would be great if I can optionally play the same stream on
all the outputs.
If I'm not wrong, this can be made through asound.conf settings though
I can't figer out what are the right values. If I can choose next used
output through kernel interface (kobject value or smth) then please
tell me where should I look into.

Here are some info (line-in playing on the 1st subdevice):

root:~> aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ad1836 [ADI ad1836], device 0: AD1836_PCM [AD1836_PCM]
Subdevices: 2/3
Subdevice #0: subdevice #0
Subdevice #1: subdevice #1
Subdevice #2: subdevice #2

root:~> cat /proc/asound/devices
0: [ 0] : control
16: [ 0- 0]: digital audio playback
24: [ 0- 0]: digital audio capture
33: : timer

root:~> cat /proc/asound/pcm
00-00: AD1836_PCM : AD1836_PCM : playback 3 : capture 1

root:~> cat /proc/asound/cards
0 [ad1836 ]: AD1836 - ADI ad1836
ADI ad1836 at PF4 SPORT0 rx/tx dma 1/2 err irq 10

root:~> cat /proc/asound/ad1836/registers
DAC_CTRL_1 0x0000
DAC_CTRL_2 0x1000
DAC_VOL_1L 0x23ff
DAC_VOL_1R 0x33ff
DAC_VOL_2L 0x43fa
DAC_VOL_2R 0x53fa
DAC_VOL_3L 0x63fa
DAC_VOL_3R 0x73fa
ADC_PEAK_1L 0xffff -63 dBFS
ADC_PEAK_1R 0xffff -63 dBFS
ADC_PEAK_2L 0xffff -63 dBFS
ADC_PEAK_2R 0xffff -63 dBFS
ADC_CTRL_1 0xc000
ADC_CTRL_2 0xd180
ADC_CTRL_3 0xe03a

root:~> cat /proc/asound/ad1836/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: AD1836_PCM
name: AD1836_PCM
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 3
subdevices_avail: 2

root:~> ls /proc/asound/ad1836/pcm0p/
info oss sub0 sub1 sub2 xrun_debug

root:~> cat /proc/asound/ad1836/pcm0p/sub0/status
state: RUNNING
trigger_time: 1208611073.963748000
tstamp : 1208611991.506408000
delay : 6441
avail : 1751
avail_max : 6188
-----
hw_ptr : 44035799
appl_ptr : 44042240

root:~> cat /proc/asound/ad1836/pcm0p/sub1/status
closed

root:~> cat /proc/asound/ad1836/pcm0p/sub2/status
closed

Thanks for help.
