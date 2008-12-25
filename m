From: Sergey 'Jin' Bostandzhyan <jin@deadlock.dhs.org>
Subject: Acer Aspire 8920g / snd-hda-intel / ALC889 / surround
	sound
Date: Thu, 25 Dec 2008 20:24:56 +0100
Message-ID: <20081225192456.GA16788@deadlock.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from belief.htu.tuwien.ac.at (belief.htu.tuwien.ac.at
	[128.131.95.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E6D41037EB
	for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2008 20:24:56 +0100 (CET)
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

Hi,

there's been a thread about a similar issue around 2008-04, it ended with a
working front left/right setup, which is of course better than no sound, but
it would be really nice to be able to use all available speakers.

The notebook has 5.1 surround, but all speakers except front left and front
right stay silent.

I'm running Fedora 10, 2.6.27.9-159.fc10.x86_64,

# cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.18a.

# cat /proc/asound/cards 
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfc300000 irq 22
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xc7eec000 irq 17

When I select model "auto", then I get a working front left and front right
speaker. When I select model "acer-aspire", everything is mute and I have
to use the hda-verb utility to get some sound out of the front speakers, so 
right now I am using the "auto" option.

I see a segfault in alsactl when I look at dmesg, not sure if this is
related to the problem:

HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA sound/pci/hda/hda_codec.c:2587: hda_codec: model 'auto' is selected
ALSA sound/pci/hda/hda_codec.c:3303: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3307:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3311:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3312:    mono: mono_out=0x0
ALSA sound/pci/hda/hda_codec.c:3320:    inputs: mic=0x12, fmic=0x18, line=0x1a, fline=0x0, cd=0x0, aux=0x0
HDA Intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
HDA Intel 0000:01:00.1: setting latency timer to 64
alsactl[1631]: segfault at 0 ip 00000000004106e7 sp 00007fffb7682fa0 error 4 in alsactl[400000+14000]
alsactl[1624]: segfault at 0 ip 00000000004106e7 sp 00007fff4ba9e3c0 error 4 in alsactl[400000+14000]

The full output of the alsa-info script is here:
http://www.alsa-project.org/db/?f=405364959a8f52c85f045f35fa1f3bf4536b13bc

I have a working setup to compile the alsa-driver, so I'm ready to test
whatever is needed :) Any ideas?

Kind regards,
Jin
