From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: es18xx: Enable wavetable input from ESS chips
Date: Wed, 26 Dec 2007 23:48:37 +0100
Message-ID: <20071226234837.6dc3484a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DE2524929
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 23:46:20 +0100 (CET)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 031AF507382
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 23:46:15 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 875202BF722
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 23:46:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch enables wavetable chips ES689/ES69X connected to
ESS ES18xx chips. The wavetable chip uses FM DAC if the clock signal
from the wavetable is active.
It has no effect if there is no ESS wavetable chip present.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch has a gotcha. In theory, the OPL synthesis or wavetable input should
use FM DAC depending on the active clock signal from the wavetable chip.
Unfortunately, the default state of the wavetable chip from ESS (ES689/ES690/ES692)
is to send clock signal all the time. This blocks OPL3 signal if the wavetable chip is 
present.

This problem can be solved with sysex command 4 send to the wavetable chip.
It sets the wavetable chip to auto-deactivate mode which switches the wavetable off
 if there are 5 seconds without midi input (according to the es1879 datasheet).

I tested this patch on the es1868 chip without the wavetable. The OPL3 synthesis
worked (no clock signal from the wavetable).

I tested it on the card with es1868 chip and es690 wavetable. The OPL3 synthesis
did not work, the wavetable worked. Both the OPL3 and wavetable worked if the
 sysex command 4 was sent to the wavetable chip (e.g. by amidi tool).

Is it ok to add this sysex command sending to the driver? How?
The wavetable clock signal can be detected (there is status bit which says if wavetable is
active).

Another question is about ES938 chip (bass, treble and 3D control) on the card.
This chip is controlled by sysex midi commands. It can be detected (by reading
settings with sysex commands). Is it possible to add this to the alsamixer or external tool
for setting these controls is recommended?

Regards,
Krzysztof

diff -urp linux-2.6.24/sound/isa/es18xx.c linux-new/sound/isa/es18xx.c
--- linux-2.6.24/sound/isa/es18xx.c	2007-12-25 23:23:03.000000000 +0100
+++ linux-new/sound/isa/es18xx.c	2007-12-26 16:30:08.000000000 +0100
@@ -1442,6 +1442,8 @@ static int __devinit snd_es18xx_initiali
 		snd_es18xx_write(chip, 0xB2, 0x50);
 		/* Enable MPU and hardware volume interrupt */
 		snd_es18xx_mixer_write(chip, 0x64, 0x42);
+		/* Enable ESS wavetable input */
+		snd_es18xx_mixer_bits(chip, 0x48, 0x10, 0x10);
 	}
 	else {
 		int irqmask, dma1mask, dma2mask;


----------------------------------------------------------------------
Rozdajemy nagrody! Wygraj samochod!

Sprawdz >> http://link.interia.pl/f1cb8
