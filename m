From: rmgls@free.fr
Subject: Mbox II DigiDisign
Date: Wed, 21 Nov 2007 19:38:54 +0100
Message-ID: <20071121173853.E8EAA1AB3D4@smtp1-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by alsa0.perex.cz (Postfix) with ESMTP id D85E924C6C
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 18:38:56 +0100 (CET)
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 552401AB2F0
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 18:38:56 +0100 (CET)
Received: from free.fr (roa76-6-82-238-235-5.fbx.proxad.net [82.238.235.5])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E8EAA1AB3D4
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 18:38:53 +0100 (CET)
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


hello all,

Can you tell me please if the external usb audio interface
mbox 2 from digidisign is supported by alsa?

Here is my config,

sony laptop, with an integrated alc260 chip (snd-hda).
and the mbox on debian.

now the different debian messages:

    	dmesg
...
usb 2-1: new full speed USB device using uhci_hcd and address 3
usb 2-1: config 1 interface 2 has no altsetting 1
usb 2-1: config 1 interface 3 has no altsetting 1
usb 2-1: config 1 interface 4 has no altsetting 1
usb 2-1: config 1 interface 5 has no altsetting 1
usb 2-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver snd-usb-audio
usb 2-1: USB disconnect, address 3
usb 2-1: new full speed USB device using uhci_hcd and address 4
usb 2-1: config 1 interface 2 has no altsetting 1
usb 2-1: config 1 interface 3 has no altsetting 1
usb 2-1: config 1 interface 4 has no altsetting 1
usb 2-1: config 1 interface 5 has no altsetting 1
usb 2-1: configuration #1 chosen from 1 choice


        cat /dev/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.15 emulation code)
Kernel: Linux mydomain.music 2.6.22-2-686 #1 SMP Fri Aug 31 00:24:01 UTC 2007 i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
HDA Intel at 0x80000000 irq 19
Digidesign Mbox 2  at usb-0000:00:1d.1-1, full speed

Audio devices:
0: ALC260 Analog (DUPLEX)
1: USB Audio (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: Realtek ALC260
1: USB Mixer

aplay plays nothing and reports: (alsa-lib pcm error).
alsamixer -c 1 reports:
no mixer elem found.

   a google search does not provide no interesting technical sheet,
at least i did not found any.
have you something please:
datasheets, config?

thanks in advance.
Best regards

rmgls@free.fr
