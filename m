From: Marek Zelem <marek@terminus.sk>
Subject: No sound card found for ATI SB600 Azalia
Date: Mon, 23 Jul 2007 23:00:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0707232239190.25733@shell.terminus.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-mail.terminus.sk (seldon.terminus.sk [85.248.119.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 40072103899
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 23:00:35 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by s-mail.terminus.sk (Postfix) with ESMTP id 8168634058
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 23:00:34 +0200 (CEST)
Received: from s-mail.terminus.sk ([127.0.0.1])
	by localhost (s-mail [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09132-01 for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 23:00:19 +0200 (CEST)
Received: from shell.terminus.sk (unknown [10.9.9.69])
	by s-mail.terminus.sk (Postfix) with ESMTP id 2263B34060
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 23:00:19 +0200 (CEST)
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

   I have Dell Latitude D531 notebook with
	00:14.2 Audio device: ATI Technologies Inc SB600 Azalia
sound card. Module snd_hda_intel is automaticaly loaded but no sound card
is detected. Here is the dmesg output:

ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
ALSA
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:558:
hda_intel: azx_get_response timeout, switching to polling mode...
ALSA
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:564:
hda_intel: azx_get_response timeout, switching to single_cmd mode...
hda_codec: No auto-config is available, default to model=ref
ALSA
/usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1020:
hda-intel: no codecs initialized
ACPI: PCI interrupt for device 0000:00:14.2 disabled

I have linux kernel 2.6.22.1. Also tried alsa 1.0.14 kernel modules built
from alsa sources. The result was the same.

I have also tried all model=xxx arguments, nothing helped.

A also tried pci=noacpi but that caused boot failure.

Am I doing something wrong? Can you please help me with that?

Btw, the system is 64bit, could that be a problem?

lspci -nnv for sound card is:

00:14.2 Audio device [0403]: ATI Technologies Inc SB600 Azalia [1002:4383]
        Subsystem: Dell Unknown device [1028:0206]
        Flags: slow devsel, IRQ 16
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2

  Thanks in advance

Marek
