From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Minor bugfix for non pll slave
 mode
Date: Fri, 27 Apr 2012 16:44:04 +0530
Message-ID: <1335525244.22171.16.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DCDA24383
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 13:02:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a bug discovered during testing of non pll slave mode.
Due to the bug chip was not getting correctly configured and as a result
there was no sound output while playback. After applying this patch,
both pll and non pll modes work fine.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index f92d1f7..10f52ff 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1159,8 +1159,9 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	/* Enable Aux2 */
 	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
 
-	/* Set PLL Master clock range 10-20 MHz */
-	snd_soc_write(codec, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ);
+	/* Set PLL Master clock range 10-20 MHz, enable PLL bypass */
+	snd_soc_write(codec, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ |
+					      DA7210_PLL_BYP);
 
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
@@ -1191,8 +1192,8 @@ static struct reg_default da7210_regmap_i2c_patch[] = {
 
 	/* System controller master disable */
 	{ DA7210_STARTUP1, 0x00 },
-	/* make sure that DA7210 use bypass mode before start up */
-	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP },
+	/* Set PLL Master clock range 10-20 MHz */
+	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ },
 
 	/* to unlock */
 	{ DA7210_A_HID_UNLOCK, 0x8B},
@@ -1290,8 +1291,8 @@ static struct reg_default da7210_regmap_spi_patch[] = {
 
 	/* System controller master disable */
 	{ DA7210_STARTUP1, 0x00 },
-	/* make sure that DA7210 use bypass mode before start up */
-	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP },
+	/* Set PLL Master clock range 10-20 MHz */
+	{ DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ },
 
 	/* to set PAGE1 of SPI register space */
 	{ DA7210_PAGE_CONTROL, 0x80 },
-- 
1.7.1
