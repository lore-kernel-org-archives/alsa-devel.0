From: "Chris Falk" <cfalk2@uic.edu>
Subject: random static, distortion on M-audio Revolution 5.1
Date: Sat, 8 Sep 2007 18:48:32 -0500 (CDT)
Message-ID: <59610.75.0.152.239.1189295312.squirrel@webmail.uic.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout-2.priv.cc.uic.edu (smtpout-2.cc.uic.edu
	[128.248.155.233])
	by alsa0.perex.cz (Postfix) with SMTP id 0F4AD103808
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 01:48:33 +0200 (CEST)
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

Hi guys,  I've got a strange problem... Although my M-audio Revolution 5.1
sounds great, it will randomly "lock up".  This seems to occur randomly
regardless of what programs I am running.  It has happened while browsing,
while listening to mp3s with audacious, or while watching tv with xine. 
If I am running a program that has audio, it will start playing slower,
and the frequencies seem warped to some low freq.  There is also static,
and some popping noises.  If I am not running an audio program, I will
hear the static and popping noises, and when I try to play an mp3, it will
seem to be stuck at time 00:00.  Sometimes the problem will go away if I
stop my audio programs upon hearing the static, or if I unload the alsa
modules and wait a few minutes before loading them again.

The first thing that came to my mind was EM interference.  I tried
swapping the positions of my pci cards (I have a pchdtv 5500 tuner in
addition to the sound card), but the problem did not go away.

I thought perhaps there was some defect in the card, but I have not
experienced any problems with it when I boot to Windows.

Here's some info on my system...

2.6.22-gentoo-r5
Advanced Linux Sound Architecture Driver Version 1.0.14
02:0a.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
        Subsystem: VIA Technologies Inc. M-Audio Revolution 5.1
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at a000 [size=32]
        I/O ports at a400 [size=128]
        Capabilities: [80] Power Management version 1

If I am experiencing the problem, and I immediately try to restart alsa
using /etc/init.d/alsasound restart, then I get these error messages in
dmesg...

ice1724: i2c busy timeout
ice1724: i2c busy timeout
ice1724: i2c busy timeout
ice1724: i2c busy timeout
ice1724: No matching model found for ID 0x12121212
ice1724: i2c busy timeout
ice1724: i2c busy timeout
ice1724: Invalid EEPROM version 18
ice1724: i2c busy timeout
ice1724: i2c busy timeout
ice1724: i2c busy timeout
nvidia: module license 'NVIDIA' taints kernel.
ice1724: i2c busy timeout
ice1724: i2c busy timeout
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ice1712/ice1724.c:143: snd_vt1724_ac97_wait_bit: timeout
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ice1712/ice1724.c:143: snd_vt1724_ac97_wait_bit: timeout
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ice1712/ice1724.c:143: snd_vt1724_ac97_wait_bit: timeout
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ac97/ac97_codec.c:2046: AC'97 0 does not respond - RESET
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ice1712/ice1724.c:143: snd_vt1724_ac97_wait_bit: timeout
ALSA sound/pci/ice1712/ice1724.c:133: snd_vt1724_ac97_ready: timeout
ALSA sound/pci/ice1712/ice1724.c:143: snd_vt1724_ac97_wait_bit: timeout
ALSA sound/pci/ac97/ac97_codec.c:2055: AC'97 0 access is not valid
[0xffffffff], removing mixer.
ice1712: cannot initialize pro ac97, skipped

This problem is driving me crazy!  I visited #alsa and googled all over
looking for any clues, but could not find anything.  I'm extremely
grateful for all of the work you guys do, and for any help you could
provide me.  Thanks!!

Chris
