From: albox@free.fr
Subject: Re: No sound on Medion laptop (intel 82801G)
Date: Mon, 25 Jun 2007 07:24:44 +0200
Message-ID: <1182749084.467f519cd06e8@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 874A624422
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 06:24:45 +0200 (CEST)
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

Here is the result :
$ sudo dmesg -c
$ sudo rmmod snd-hda-intel && sudo modprobe snd-hda-intel probe_mask=1
$ dmesg
[  638.324000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[  638.368000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ
22
[  638.368000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[  638.400000] ALSA
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
codec_mask = 0x3
[  638.576000] ALSA
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:1820:
hda_codec: model 'medion' is selected for config 161f:2054 (Medion laptop)

I can hear a quick sound (like a "bip") when I enter the command but after that,
the sound doesn't work.
