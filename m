From: Andrea Venturi <andrea.venturi.axel@gmail.com>
Subject: debugging kernel module: ASoC sun7i A20 I2S DAI driver
 for simple sound card setup (with UDA1380 codec)
Date: Thu, 09 Jul 2015 15:15:24 +0200
Message-ID: <559E73EC.40505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A114265139
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 15:15:09 +0200 (CEST)
Received: by wgck11 with SMTP id k11so223479720wgc.0
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2015 06:15:08 -0700 (PDT)
Received: from [10.0.0.5] ([31.177.43.87])
 by smtp.googlemail.com with ESMTPSA id v3sm8272856wiz.14.2015.07.09.06.15.07
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jul 2015 06:15:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hello,

i'm writing here because i'm facing an issue on a new driver and like a 
feedback from the community. wht place better then this ML!

i'm using an Allwinner A20 based card with I2S/I2C wires exposed (Olimex 
A20 SOM + EVB), and an external UDA1380 codec (dirty cheap purchase from 
those china techno junk sites)

i'd like to make this bundle work together; my aim is to produce the 
mainline kernel DAI module for the actually missing I2S HW feature for 
Allwinner SOC (at least sun4i A10 and sun7i A20, don't know if the )

i gathered as more info as possible about Alsa ASoC implementation; but, 
boys, is not very easy to catch on as there's a huge bulk of 
documentation scattered all over the web with varying degree of 
obsolescence in place.. and usually the newer stuff is the less 
documented :-)

anyway, as my "awareness" of the whole Alsa scenario went increasing (at 
least in my opinion..), i found the Freescale SAI (see 
.../sound/soc/fsl/fsl_sai.c) module to be the nearest/better/more modern 
"example" from which starting modeling the sunxi I2S module.

so, now, i've shaped a Sunxi I2S kernel module that loads someway on my 
HW testbed.

all the tech details (with source and tests) are published here: 
https://gist.github.com/aventuri/c40d08b946b0d1da5081

you'll find:
- sunxi-i2s.c
- a DTS with the sound entry for a simple sound card
- a slightly modded uda1380.c codec driver; as a sidenote, i had to 
modify for params loading from DTS.

if more details are needed, i'll add stuff on request, of course..

the starting mainline kernel is linux 4.1.rc sunxi-wip from here:

   https://github.com/jwrdegoede/linux-sunxi/tree/sunxi-wip

where the i2s clocks and dmaengine (and the analog codec of AW sunxi, 
but it's not needed here) are already in place.

the "gory details" about HW registers are coming from the my reading of 
A20 PDF and allwinner I2S linux-sunxi legacy I2S driver for 3.4: 
https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.4/sound/soc/sunxi/i2s 


these registers CAN be way off as i'm still debugging a bit before 
starting checking them carefully..

now, the kernel modules (snd-soc-simple-card snd-soc-sunxi-i2s and 
snd-soc-uda1380) are loaded ok and doing someway a proper initialization 
of HW and kernel data structures (check on the gist before).

i can see the alsa device nodes

# ls -lR /dev/snd
/dev/snd:
total 0
crw-rw----    1 root     root      116,   0 Jan  1 03:00 controlC0
crw-rw----    1 root     root      116,  24 Jan  1 03:00 pcmC0D0c
crw-rw----    1 root     root      116,  16 Jan  1 03:00 pcmC0D0p
crw-rw----    1 root     root      116,  33 Jan  1 03:00 timer

and alsamixer is more or less showing all the controllers (many are from 
the UDA codec, of course, already working..)

the problem i'm facing now is that the when i launch aplay with a wav 
file, when it accesses the dev node "/dev/snd/pcmC0D0p" is spitting out: 
"open error: Invalid argument"

these are the last few rows of a "strace aplay wav/equinox-48KHz.wav" 
execution:

# aplay wav/equinox-48KHz.wav
[ 9018.638837] [I2S]Entered sunxi_i2s_startup: hw is subdevice #0, 
stream is: playback
[ 9018.646858] [I2S]Entered sunxi_i2s_shutdown, need to clear some HW regs?
aplay: main:722: audio open error: Invalid argument
#

=====================
...
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
ioctl(3, SNDRV_CTL_IOCTL_CARD_INFO or UI_DEV_CREATE, 0xbeac43b8) = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE|O_CLOEXEC) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
ioctl(3, SNDRV_CTL_IOCTL_PVERSION or USBDEVFS_CONTROL, 0xbeac4540) = 0
ioctl(3, SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE, 0xbeac457c) = 0
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_LARGEFILE|O_CLOEXEC) = -1 
EINVAL (Invalid argument)
close(3)                                = 0
write(2, "aplay: main:722: ", 17aplay: main:722: )       = 17
write(2, "audio open error: Invalid argume"..., 34audio open error: 
Invalid argument) = 34
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?
+++ exited with 1 +++
#
==================

now my question is: how can i start debugging this step?

which kernel tools i could use to pinpoint quickly who is answering back 
this "invalid argument" in the called function chain.

i suppose some "sound params" in the my own kernel driver is not filled 
correctly; i tried with many wav files (44.1 48 etc..) but always get 
this reply.

i tried with the "kernel function tracing" tool 
(/sys/kernel/debug/tracing/...) but it doesn't help a lot..

any suggestion? any indication on documents about effective Alsa ASoC 
debugging or architecture?

bests

andrea
