From: Benjamin Hovey <bend.hovey@gmail.com>
Subject: snd-via82xx setting
Date: Sun, 30 Jan 2011 21:48:39 -0500
Message-ID: <AANLkTimbB8WNVDJCD+rEng9NZbJGvtEkVBBXmxQS==7D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B9A4C1037E3
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 03:48:40 +0100 (CET)
Received: by wwe15 with SMTP id 15so5128606wwe.20
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2011 18:48:39 -0800 (PST)
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

FYI, the below system required the following non-default settings for ALSA
to play any SPDIF output correctly.  Prior to finding this setting, output
from different sources, WAV, MP3, CD, etc, were played at a slightly faster
speed than they should have.

snd_via82xx: dxs_support=3

When installed, the default setting was dxs_support=5.

Hope this helps.  I am new to Linux and it took me quite a while to find out
how to set this setting (I put it in  /etc/modprobe.d/alsa-base.conf)
Cheers



upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Mon Jan 31 02:37:03 UTC 2011


!!Linux Distribution
!!------------------

Ubuntu 10.04.1 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu
10.04.1 LTS"


!!DMI Information
!!---------------

Manufacturer:      VIA Technologies, Inc.
Product Name:      KT600-8237
Product Version:


!!Kernel Information
!!------------------

Kernel release:    2.6.32-28-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.23
Utilities version:  1.0.22


!!Loaded ALSA modules
!!-------------------

snd_via82xx
snd_emu10k1


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with VT1616i at 0xe400, irq 22
 1 [Live           ]: EMU10K1 - SB Live! Platinum [CT4760P]
                      SB Live! Platinum [CT4760P] (rev.8, serial:0x80401102)
at 0xb000, irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus
DVD Decoder (rev 02)
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:09.0 0401: 1102:0002 (rev 08)
    Subsystem: 1102:8040
--
00:11.5 0401: 1106:3059 (rev 60)
    Subsystem: 147b:1408


!!Modprobe options (Sound related)
!!--------------------------------

snd_via82xx: index=0
snd_emu10k1: index=1
snd_via82xx: dxs_support=4
snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-us122l: index=-2
snd-usb-usx2y: index=-2
snd-usb-caiaq: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388
snd-pcsp: index=-2
snd_via82xx: index=0
snd_emu10k1: index=1
snd_via82xx: dxs_support=3
snd_via82xx: ac97_clock=48000
