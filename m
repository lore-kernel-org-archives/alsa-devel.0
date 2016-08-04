From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 3/4] ASoC: da7213: Refactor sysclk(), pll() functions to
 improve handling
Date: Thu, 4 Aug 2016 15:35:40 +0100
Message-ID: <c49bf78ac801dfd1fd1fa41d5e65d866fd30a177.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently the handling of the PLL in the driver is a little clunky,
and not ideal for all modes. This patch updates the code to make it
cleaner and more sensible for the various PLL states.

Key items of note are:
 - MCLK squaring is now handled directly as part of the sysclk()
   function, removing the need for a private flag to set this feature.
 - All PLL modes are defined as an enum, and are handled as a case
   statement in pll() function to clean up configuration. This also
   removes any need for a private flag for SRM.
 - For 32KHz mode, checks are made on codec master mode and correct
   MCLK rates, to avoid incorrect usage of PLL for this operation.
 - For 32KHz mode, SRM flag now correctly enabled and fout set to
   sensible value to achieve appropriate PLL dividers.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 85 +++++++++++++++++++++++++++--------------------
 sound/soc/codecs/da7213.h | 12 ++++---
 2 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 7701f4e..79b8324 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1297,10 +1297,13 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	switch (clk_id) {
 	case DA7213_CLKSRC_MCLK:
-		da7213->mclk_squarer_en = false;
+		snd_soc_update_bits(codec, DA7213_PLL_CTRL,
+				    DA7213_PLL_MCLK_SQR_EN, 0);
 		break;
 	case DA7213_CLKSRC_MCLK_SQR:
-		da7213->mclk_squarer_en = true;
+		snd_soc_update_bits(codec, DA7213_PLL_CTRL,
+				    DA7213_PLL_MCLK_SQR_EN,
+				    DA7213_PLL_MCLK_SQR_EN);
 		break;
 	default:
 		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
@@ -1324,7 +1327,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-/* Supported PLL input frequencies are 5MHz - 54MHz. */
+/* Supported PLL input frequencies are 32KHz, 5MHz - 54MHz. */
 static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			      int source, unsigned int fref, unsigned int fout)
 {
@@ -1336,22 +1339,26 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	u32 freq_ref;
 	u64 frac_div;
 
-	/* Reset PLL configuration */
-	snd_soc_write(codec, DA7213_PLL_CTRL, 0);
-
-	pll_ctrl = 0;
-
 	/* Workout input divider based on MCLK rate */
 	if (da7213->mclk_rate == 32768) {
+		if (!da7213->master) {
+			dev_err(codec->dev,
+				"32KHz only valid if codec is clock master\n");
+			return -EINVAL;
+		}
+
 		/* 32KHz PLL Mode */
 		indiv_bits = DA7213_PLL_INDIV_9_TO_18_MHZ;
 		indiv = DA7213_PLL_INDIV_9_TO_18_MHZ_VAL;
+		source = DA7213_SYSCLK_PLL_32KHZ;
 		freq_ref = 3750000;
-		pll_ctrl |= DA7213_PLL_32K_MODE;
+
 	} else {
-		/* 5 - 54MHz MCLK */
 		if (da7213->mclk_rate < 5000000) {
-			goto pll_err;
+			dev_err(codec->dev,
+				"PLL input clock %d below valid range\n",
+				da7213->mclk_rate);
+			return -EINVAL;
 		} else if (da7213->mclk_rate <= 9000000) {
 			indiv_bits = DA7213_PLL_INDIV_5_TO_9_MHZ;
 			indiv = DA7213_PLL_INDIV_5_TO_9_MHZ_VAL;
@@ -1365,32 +1372,44 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			indiv_bits = DA7213_PLL_INDIV_36_TO_54_MHZ;
 			indiv = DA7213_PLL_INDIV_36_TO_54_MHZ_VAL;
 		} else {
-			goto pll_err;
+			dev_err(codec->dev,
+				"PLL input clock %d above valid range\n",
+				da7213->mclk_rate);
+			return -EINVAL;
 		}
 		freq_ref = (da7213->mclk_rate / indiv);
 	}
 
-	pll_ctrl |= indiv_bits;
+	pll_ctrl = indiv_bits;
 
-	/* PLL Bypass mode */
-	if (source == DA7213_SYSCLK_MCLK) {
-		snd_soc_write(codec, DA7213_PLL_CTRL, pll_ctrl);
+	/* Configure PLL */
+	switch (source) {
+	case DA7213_SYSCLK_MCLK:
+		snd_soc_update_bits(codec, DA7213_PLL_CTRL,
+				    DA7213_PLL_INDIV_MASK |
+				    DA7213_PLL_MODE_MASK, pll_ctrl);
 		return 0;
-	}
+	case DA7213_SYSCLK_PLL:
+		break;
+	case DA7213_SYSCLK_PLL_SRM:
+		pll_ctrl |= DA7213_PLL_SRM_EN;
+		fout = DA7213_PLL_FREQ_OUT_94310400;
+		break;
+	case DA7213_SYSCLK_PLL_32KHZ:
+		if (da7213->mclk_rate != 32768) {
+			dev_err(codec->dev,
+				"32KHz mode only valid with 32KHz MCLK\n");
+			return -EINVAL;
+		}
 
-	/*
-	 * If Codec is slave and SRM enabled,
-	 * freq_out is (98304000 + 90316800)/2 = 94310400
-	 */
-	if (!da7213->master && da7213->srm_en) {
+		pll_ctrl |= DA7213_PLL_32K_MODE | DA7213_PLL_SRM_EN;
 		fout = DA7213_PLL_FREQ_OUT_94310400;
-		pll_ctrl |= DA7213_PLL_SRM_EN;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid PLL config\n");
+		return -EINVAL;
 	}
 
-	/* Enable MCLK squarer if required */
-	if (da7213->mclk_squarer_en)
-		pll_ctrl |= DA7213_PLL_MCLK_SQR_EN;
-
 	/* Calculate dividers for PLL */
 	pll_integer = fout / freq_ref;
 	frac_div = (u64)(fout % freq_ref) * 8192ULL;
@@ -1405,14 +1424,11 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 
 	/* Enable PLL */
 	pll_ctrl |= DA7213_PLL_EN;
-	snd_soc_write(codec, DA7213_PLL_CTRL, pll_ctrl);
+	snd_soc_update_bits(codec, DA7213_PLL_CTRL,
+			    DA7213_PLL_INDIV_MASK | DA7213_PLL_MODE_MASK,
+			    pll_ctrl);
 
 	return 0;
-
-pll_err:
-	dev_err(codec_dai->dev, "Unsupported PLL input frequency %d\n",
-		da7213->mclk_rate);
-	return -EINVAL;
 }
 
 /* DAI operations */
@@ -1607,9 +1623,6 @@ static int da7213_probe(struct snd_soc_codec *codec)
 			    DA7213_ALC_CALIB_MODE_MAN, 0);
 	da7213->alc_calib_auto = true;
 
-	/* Default to using SRM for slave mode */
-	da7213->srm_en = true;
-
 	/* Default PC counter to free-running */
 	snd_soc_update_bits(codec, DA7213_PC_COUNT, DA7213_PC_FREERUN_MASK,
 			    DA7213_PC_FREERUN_MASK);
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index fbb7a35..16ef56f 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -172,6 +172,7 @@
 #define DA7213_PLL_32K_MODE					(0x1 << 5)
 #define DA7213_PLL_SRM_EN					(0x1 << 6)
 #define DA7213_PLL_EN						(0x1 << 7)
+#define DA7213_PLL_MODE_MASK					(0x7 << 5)
 
 /* DA7213_DAI_CLK_MODE = 0x28 */
 #define DA7213_DAI_BCLKS_PER_WCLK_32				(0x0 << 0)
@@ -499,8 +500,6 @@
 #define DA7213_ALC_AVG_ITERATIONS	5
 
 /* PLL related */
-#define DA7213_SYSCLK_MCLK			0
-#define DA7213_SYSCLK_PLL			1
 #define DA7213_PLL_FREQ_OUT_90316800		90316800
 #define DA7213_PLL_FREQ_OUT_98304000		98304000
 #define DA7213_PLL_FREQ_OUT_94310400		94310400
@@ -515,6 +514,13 @@ enum da7213_clk_src {
 	DA7213_CLKSRC_MCLK_SQR,
 };
 
+enum da7213_sys_clk {
+	DA7213_SYSCLK_MCLK = 0,
+	DA7213_SYSCLK_PLL,
+	DA7213_SYSCLK_PLL_SRM,
+	DA7213_SYSCLK_PLL_32KHZ
+};
+
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
@@ -522,8 +528,6 @@ struct da7213_priv {
 	unsigned int mclk_rate;
 	int clk_src;
 	bool master;
-	bool mclk_squarer_en;
-	bool srm_en;
 	bool alc_calib_auto;
 	bool alc_en;
 	struct da7213_platform_data *pdata;
-- 
1.9.3
