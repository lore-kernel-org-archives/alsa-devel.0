From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH v2 2/4] ASoC: Intel: bytcr_rt5640: move codec clks to card driver data
Date: Thu, 12 Jan 2017 20:00:59 +0800
Message-ID: <20170112120101.16933-3-shrirang.bagul@canonical.com>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shrirang Bagul <shrirang.bagul@canonical.com>, Irina Tirdea <irina.tirdea@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch moves codec specific clock indices to card driver data.
Functions configuring clocks can be re-used for other codec chips with
similar features (viz. RT5660)

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 1bd985f..f6fd397 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -53,8 +53,23 @@ enum {
 #define BYT_RT5640_MCLK_EN	BIT(22)
 #define BYT_RT5640_MCLK_25MHZ	BIT(23)
 
+enum {
+	SCLK_PLL1 = 0,
+	SCLK_RCCLK,
+	PLL1_BCLK,
+	PLL1_MCLK,
+};
+
 struct byt_rt5640_private {
 	struct clk *mclk;
+	int *clks;
+};
+
+static int byt_rt5640_clks[] = {
+	RT5640_SCLK_S_PLL1,
+	RT5640_SCLK_S_RCCLK,
+	RT5640_PLL1_S_BCLK1,
+	RT5640_PLL1_S_MCLK
 };
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
@@ -132,7 +147,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 				return ret;
 			}
 		}
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
+		ret = snd_soc_dai_set_sysclk(codec_dai, priv->clks[SCLK_PLL1],
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 	} else {
@@ -141,7 +156,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		 * turning off the platform clock. Codec needs clock
 		 * for Jack detection and button press
 		 */
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_RCCLK,
+		ret = snd_soc_dai_set_sysclk(codec_dai, priv->clks[SCLK_RCCLK],
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
@@ -259,6 +274,7 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
@@ -277,25 +293,25 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 			/* 2x16 bit slots on SSP0 */
 			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_BCLK1,
+						priv->clks[PLL1_BCLK],
 						params_rate(params) * 32,
 						params_rate(params) * 512);
 		} else {
 			/* 2x15 bit slots on SSP2 */
 			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_BCLK1,
+						priv->clks[PLL1_BCLK],
 						params_rate(params) * 50,
 						params_rate(params) * 512);
 		}
 	} else {
 		if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ) {
 			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_MCLK,
+						priv->clks[PLL1_MCLK],
 						25000000,
 						params_rate(params) * 512);
 		} else {
 			ret = snd_soc_dai_set_pll(codec_dai, 0,
-						RT5640_PLL1_S_MCLK,
+						priv->clks[PLL1_MCLK],
 						19200000,
 						params_rate(params) * 512);
 		}
@@ -717,6 +733,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* register the soc card */
+	priv->clks = byt_rt5640_clks;
 	byt_rt5640_card.dev = &pdev->dev;
 	mach = byt_rt5640_card.dev->platform_data;
 	snd_soc_card_set_drvdata(&byt_rt5640_card, priv);
-- 
2.9.3
