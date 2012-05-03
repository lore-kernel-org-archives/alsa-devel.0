From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Minor improvements and a bugfix
Date: Thu, 3 May 2012 19:27:52 +0530
Message-ID: <1336053472.29584.16.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe005.messaging.microsoft.com [216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id B949D10405F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 15:46:26 +0200 (CEST)
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

This patch improves playback quality for few sample rates like 8000 and
11025 Hz. 

This also fixes an issue observed during testing of pll slave mode. Due
to the issue, on some rare occasions there was no sound output for first
time playback after system boot, though all subsequent playbacks were
fine. It was mainly because of the sequence in which SRM bit was
enabled.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 10f52ff..af5db70 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -850,8 +850,19 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	if (da7210->mclk_rate && (da7210->mclk_rate != sysclk)) {
 		/* PLL mode, disable PLL bypass */
 		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
+
+		if (!da7210->master) {
+			/* PLL slave mode, also enable SRM */
+			snd_soc_update_bits(codec, DA7210_PLL,
+						   (DA7210_MCLK_SRM_EN |
+						    DA7210_MCLK_DET_EN),
+						   (DA7210_MCLK_SRM_EN |
+						    DA7210_MCLK_DET_EN));
+		}
 	} else {
-		/* PLL bypass mode, enable PLL bypass */
+		/* PLL bypass mode, enable PLL bypass and Auto Detection */
+		snd_soc_update_bits(codec, DA7210_PLL, DA7210_MCLK_DET_EN,
+						       DA7210_MCLK_DET_EN);
 		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP,
 							    DA7210_PLL_BYP);
 	}
@@ -1014,18 +1025,9 @@ static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	snd_soc_update_bits(codec, DA7210_PLL_DIV3,
 				   DA7210_PLL_DIV_L_MASK, pll_div3);
 
-	if (da7210->master) {
-		/* In master mode, no need to enable SRM */
-		snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN,
-						       DA7210_PLL_EN);
-	} else {
-		/* In slave mode, enable SRM and PLL */
-		snd_soc_update_bits(codec, DA7210_PLL,
-				   (DA7210_PLL_EN | DA7210_MCLK_SRM_EN |
-						     DA7210_MCLK_DET_EN),
-				   (DA7210_PLL_EN | DA7210_MCLK_SRM_EN |
-						    DA7210_MCLK_DET_EN));
-	}
+	/* Enable PLL */
+	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
+
 	/* Enable active mode */
 	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN,
 						    DA7210_SC_MST_EN);
-- 
1.7.1
