From: Federico Fuga <f.fuga@people.it>
Subject: Inappropriate ioctl for device on alsalib with uclibc
	and arm platform
Date: Mon, 19 Nov 2007 16:21:39 +0100
Message-ID: <4741AA03.5070903@people.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpi2.ngi.it (smtpi2.ngi.it [88.149.128.21])
	by alsa0.perex.cz (Postfix) with ESMTP id EFC87248BE
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 16:21:34 +0100 (CET)
Received: from [192.168.2.1] (88-149-234-187.dynamic.ngi.it [88.149.234.187])
	(authenticated bits=0)
	by smtpi2.ngi.it (8.13.8/8.13.8) with ESMTP id lAJFLWHn013194
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 16:21:33 +0100
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

Hi,

Maybe I am a little bit off-topic here, but I think this question may be related with a bug (maybe not in the alsa library, but I am a little confused now), so I apologize in advance.
I am building a uclibc-based system on arm board.
I have compiled the library 1.0.14a with uClibc 0.9.29 and kernel
2.6.23.1 / kernel headers 2.6.22.
Settings the config params of mixer with "alsactl restore" fails with
an "inappropriate ioctl for device" error:

# alsactl restore
alsactl: set_control:1159: Cannot write control '2:0:0:Speaker Playback
Volume:0' : Inappropriate ioctl for device

while traceing with strace I see that:

open("/usr/lib/libasound.so.2", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=716844, ...}) = 0
close(4)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 4
close(4)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 4
ioctl(4, USBDEVFS_CONTROL, 0xbeab09ec)  = 0
ioctl(4, UI_DEV_CREATE, 0xbeab0ad0)     = 0
ioctl(4, USBDEVFS_CONNECTINFO, 0xbeab0654) = 0
ioctl(4, USBDEVFS_HUB_PORTINFO, 0xbeab0768) = -1 ENOTTY (Inappropriate
ioctl for device)
write(2, "alsactl", 7alsactl)                  = 7


but aplay see all the board and seems to work properly:

# aplay  -l
**** List of PLAYBACK Hardware Devices ****
card 0: EMX270 [EM-X270], device 0: AC97 HiFi AC97 HiFi-AC97-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: EMX270 [EM-X270], device 1: AC97 Aux AC97 Aux-AC97-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
# aplay -L
default:CARD=EMX270
    EM-X270,
    Default Audio Device
null
    Discard all samples (playback) or generate zero samples (capture)
# speaker-test

speaker-test 1.0.14

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 8 to 32768
Period size range from 8 to 2040
Using max buffer size 32768
Periods = 4
was set period_size = 1024
was set buffer_size = 32768
 0 - Front Left
Time per period = 2.528627
 0 - Front Left
Time per period = 2.999174

But I hear no sound (the levels are all off).
In a similar installation based on glibc (Armstrong linux) with the same
version of kernel, alsa and all other stuff works correctly.

root@em-x270:~$ cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer


The device nodes in /dev/sound are created by udev, and major/minor codes and permissions seems ok.
Can you give me some hint on how to solve this issue?

Thank you in advance

ing. Federico Fuga
