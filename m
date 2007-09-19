From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: opti931 + QS1000 wavetable
Date: Wed, 19 Sep 2007 22:42:27 +0200
Message-ID: <20070919224227.ce121de1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D00562463D
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 22:34:52 +0200 (CEST)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 6922913EE1F
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 22:34:51 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 5AD50769BB6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 22:34:51 +0200 (CEST)
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

This patch adds support for a wavetable chip on 
the BTC 1817DW board.
The QS1000 is connected through the digital input
to the Opti931 chip.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is not a hot-fix and can be postponed after 1.0.15
(before Takashi asks).

A cornerstone of this patch is to set the auto-source
selection for the FM DAC. This way it does not affects
boards using the FM OPL synthesizers which do
not use the digital input.
If any other wavetable is connected to the opti chip
through the digital input, the format setting (MC_REG(21))
should be revised if it is correct for the new board.
However, in the whole opti92x-ad1848 this
register was never touched (so probably nobody
ever used the digital input ).

Regards,
Krzysztof

diff -urp linux-ref/sound/isa/opti9xx/opti92x-ad1848.c linux-2.6.23/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-ref/sound/isa/opti9xx/opti92x-ad1848.c	2007-09-12 13:33:51.000000000 +0200
+++ linux-2.6.23/sound/isa/opti9xx/opti92x-ad1848.c	2007-09-19 22:13:02.000000000 +0200
@@ -501,6 +501,16 @@ static int __devinit snd_opti9xx_configu
 			(chip->hardware == OPTi9XX_HW_82C930 ? 0x00 : 0x04),
 			0x34);
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(5), 0x20, 0xbf);
+		/* 
+		 * The BTC 1817DW has QS1000 wavetable which is connected
+		 * to the serial digital input of the OPTI931.
+		 */
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(21), 0x82, 0xff);
+		/* 
+		 * This bit sets OPTI931 to automaticaly select FM
+		 * or digital input signal.
+		 */
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(26), 0x01, 0x01);
 		break;
 #endif	/* OPTi93X */
 


----------------------------------------------------------------------
Zaaresztuj ministra Koszmarka!
http://link.interia.pl/f1ba6
