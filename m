From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl-asoc-card: Specify codec_dai_name for DAI links
Date: Wed, 12 Aug 2015 13:06:12 -0700
Message-ID: <1439409972-56973-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, fabio.estevam@freescale.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

The dev->name of CODEC might not be identical to its codec_dai_name,
so using dev->name to probe the CODEC dai is not a correct approach.

This patch specifies each supporting codec_dai_name instead of using
dev->name any more.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index de43887..040362f 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -407,6 +407,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct fsl_asoc_card_priv *priv;
 	struct i2c_client *codec_dev;
 	struct clk *codec_clk;
+	const char *codec_dai_name;
 	u32 width;
 	int ret;
 
@@ -459,6 +460,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	/* Diversify the card configurations */
 	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
+		codec_dai_name = "cs42888";
 		priv->card.set_bias_level = NULL;
 		priv->cpu_priv.sysclk_freq[TX] = priv->codec_priv.mclk_freq;
 		priv->cpu_priv.sysclk_freq[RX] = priv->codec_priv.mclk_freq;
@@ -467,9 +469,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
+		codec_dai_name = "sgtl5000";
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
+		codec_dai_name = "wm8962";
 		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
 		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
 		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
@@ -521,7 +525,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	/* Normal DAI Link */
 	priv->dai_link[0].cpu_of_node = cpu_np;
 	priv->dai_link[0].codec_of_node = codec_np;
-	priv->dai_link[0].codec_dai_name = codec_dev->name;
+	priv->dai_link[0].codec_dai_name = codec_dai_name;
 	priv->dai_link[0].platform_of_node = cpu_np;
 	priv->dai_link[0].dai_fmt = priv->dai_fmt;
 	priv->card.num_links = 1;
@@ -530,7 +534,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		/* DPCM DAI Links only if ASRC exsits */
 		priv->dai_link[1].cpu_of_node = asrc_np;
 		priv->dai_link[1].platform_of_node = asrc_np;
-		priv->dai_link[2].codec_dai_name = codec_dev->name;
+		priv->dai_link[2].codec_dai_name = codec_dai_name;
 		priv->dai_link[2].codec_of_node = codec_np;
 		priv->dai_link[2].cpu_of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
-- 
1.9.1
