From: Bryan Green <bryan.d.green@nasa.gov>
Subject: no audio output with TYAN S7025 motherboard and
	Realtek ALC262
Date: Wed, 03 Mar 2010 10:54:54 -0800
Message-ID: <20100303185454.4D36231781@vis06.nas.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pagent2.arc.nasa.gov (pagent2.arc.nasa.gov [128.102.31.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 92324103961
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 19:54:57 +0100 (CET)
Received: from vis06.nas.nasa.gov (vis06.nas.nasa.gov [129.99.125.6])
	by pagent2.arc.nasa.gov (8.12.11.20060308/8.12.11) with ESMTP id
	o23Issfl008683
	for <alsa-devel@alsa-project.org>; Wed, 3 Mar 2010 10:54:54 -0800
Received: from vis06.nas.nasa.gov (localhost [127.0.0.1])
	by vis06.nas.nasa.gov (Postfix) with ESMTP id 4D36231781
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 10:54:54 -0800 (PST)
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
I have several systems with a TYAN S7025 motherboard and Realtek ALC262 chipset.
I have not been able to produce any audio output.  Well, that is except for
one of the systems: after a variety of tweeks and tests, I got sound working
on one system, but I do not know what change enabled sound to start working,
and I have not been able to reproduce the effect on the other systems.

I have tested with kernels up to 2.6.33, and with ALSA version 1.0.22.1.
For a non-working system, 'alsaconf' gives the following output:
Unknown hardware: "HDA-Intel" "Realtek ALC262"
"HDA:10ec0262,10ec0262,00100202" "0x8086" "0x3a3e"

And dmesg gives the following:
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: irq 89 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
hda_codec: ALC262: BIOS auto-probing.
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x1c, aux=0x0
   dig-in=0x1f
realtek: No valid SSID, checking pincfg 0x411111f0 for NID 0x1d
realtek: Enable default setup for auto mode as fallback
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input8

For the working system, the dmesg output is the same except for two lines:
autoconfig: line_outs=1 (0x1b/0x0/0x0/0x0/0x0)
   inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x1c, aux=0x14

Is there a method for tweaking these values on the non-working system to match
the working system, to see if that works?

I've uploaded the alsa-info output from a non-working system here:
http://www.alsa-project.org/db/?f=91057bfc12790688f1d257743e53d5d0ec2ce1e2

I've uploaded the alsa-info output from the working system here:
http://www.alsa-project.org/db/?f=198420f14cd0062713636408640636e6d474cf94

Thanks,
-bryan
