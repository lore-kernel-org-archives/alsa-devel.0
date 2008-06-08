From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: fix sound ouput for Opti930
Date: Sun, 8 Jun 2008 07:57:53 +0200
Message-ID: <20080608075753.6e55b6ba.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 7B83D2474F
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jun 2008 07:55:18 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes silenced output from the Opti930.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The bug was introduced by me in the patch which added 
QS1000 wavetable support:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f81b953d43c2c12f617da3ecec25e04b5c9e6eb2

Simply do not change digital input bits on Opti930.

diff -urp linux-rc2/sound/isa/opti9xx/opti92x-ad1848.c linux-rc5/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-rc2/sound/isa/opti9xx/opti92x-ad1848.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-rc5/sound/isa/opti9xx/opti92x-ad1848.c	2008-06-07 23:59:27.218950875 +0200
@@ -491,16 +491,9 @@ static int __devinit snd_opti9xx_configu
 		break;
 
 #else	/* OPTi93X */
-	case OPTi9XX_HW_82C930:
 	case OPTi9XX_HW_82C931:
 	case OPTi9XX_HW_82C933:
-		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x03);
-		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0x00, 0xff);
-		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0x10 |
-			(chip->hardware == OPTi9XX_HW_82C930 ? 0x00 : 0x04),
-			0x34);
-		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(5), 0x20, 0xbf);
-		/* 
+		/*
 		 * The BTC 1817DW has QS1000 wavetable which is connected
 		 * to the serial digital input of the OPTI931.
 		 */
@@ -510,6 +503,13 @@ static int __devinit snd_opti9xx_configu
 		 * or digital input signal.
 		 */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(26), 0x01, 0x01);
+	case OPTi9XX_HW_82C930: /* FALL THROUGH */
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x03);
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0x00, 0xff);
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0x10 |
+			(chip->hardware == OPTi9XX_HW_82C930 ? 0x00 : 0x04),
+			0x34);
+		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(5), 0x20, 0xbf);
 		break;
 #endif	/* OPTi93X */
 

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26
