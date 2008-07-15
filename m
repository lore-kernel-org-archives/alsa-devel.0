From: georg <georg.brand@web.de>
Subject: CS5530 on Geode GX1 won't work
Date: Tue, 15 Jul 2008 23:15:22 +0200
Message-ID: <200807152315.23490.georg.brand@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F07B24511
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 23:15:28 +0200 (CEST)
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

Hello

As Alsa-User mailinglist could not help, I hopefully sent my mail to this list 
now.

I am playing around, trying to get this sound card working for a while now. 

The Hardware is an embedded Geode GX1. Kernel is vanilla 2.6.25.9.

Problem:
------------------------ 8<-------------------------
root@tux:~# aplay foo.wav         
ALSA lib pcm_dmix.c:866:(snd_pcm_dmix_open) unable to open slave
aplay: main:546: audio open error: Device or resource busy

root@tux:~# lspci 
...
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
...

root@tux:~# lsmod
Module                  Size  Used by
snd_cs5530              4388  0 
snd_sb16_dsp            8608  1 snd_cs5530
snd_sb_common          14432  2 snd_cs5530,snd_sb16_dsp
snd_pcm                63208  1 snd_sb16_dsp
snd_timer              19492  1 snd_pcm
snd                    38804  5 
snd_cs5530,snd_sb16_dsp,snd_sb_common,snd_pcm,snd_timer
snd_page_alloc          7752  1 snd_pcm

dmesg:
...
CS5530: XpressAudio at 0x220
CS5530: MPU at 0x330
CS5530: IRQ: 5 DMA8: 1 DMA16: 5
...

root@tux:~# cat /proc/interrupts 
           CPU0       
  0:     249130    XT-PIC-XT        timer
  1:          2    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:          0    XT-PIC-XT        SoundBlaster
  9:     184193    XT-PIC-XT        ohci_hcd:usb1, eth0
 12:          1    XT-PIC-XT      
 14:      41917    XT-PIC-XT        ide0


root@tux:~# strace aplay foo.wav
...
shmctl(32768, 0x102 /* SHM_??? */, 0xbfc94a68) = 0
shmctl(32768, 0x101 /* SHM_??? */, 0xbfc94a68) = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfc947a8)  = 0
ioctl(3, 0x40045532, 0xbfc947a4)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = -1 EBUSY (Device or resource 
busy)
close(3)                                = 0
write(2, "ALSA lib pcm_dmix.c:866:(snd_pcm"..., 44ALSA lib pcm_dmix.c:866:
(snd_pcm_dmix_open) ) = 44
write(2, "unable to open slave", 20unable to open slave)    = 20
write(2, "\n", 1)                       = 1
...

root@tux:~# lsof | grep -i pcmC0D0p
root@tux:~# 

root@tux:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Audio [CS5530 Audio], device 0: SB16 DSP [DSP v4.12]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

root@tux:~# aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)

------------------------ 8<-------------------------

No one is using the sound device. But strace shows error 'Device or resource 
busy'. The thing that confuses me is the output of 'aplay -L'...

Any help is appreciated :-)...

Bye
Georg
