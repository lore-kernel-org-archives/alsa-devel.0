From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7213: Add DT support to codec driver
Date: Mon, 5 Oct 2015 16:40:18 +0100
Message-ID: <8b10191f4e14b32f831d32c66c7edebd861b70ac.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for DT bindings in the codec driver.
As part of this support, the mclk data can now be provided and
used to control the mclk during codec operation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 181 ++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/da7213.h |   8 +-
 2 files changed, 171 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a9c86ef..c654044 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -12,6 +12,7 @@
  * option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -1222,23 +1223,44 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	if ((da7213->clk_src == clk_id) && (da7213->mclk_rate == freq))
+		return 0;
+
+	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
+		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
+			freq);
+		return -EINVAL;
+	}
 
 	switch (clk_id) {
+	case DA7213_CLKSRC_MCLK_SQR:
+		da7213->mclk_squarer_en = true;
+		break;
 	case DA7213_CLKSRC_MCLK:
-		if ((freq == 32768) ||
-		    ((freq >= 5000000) && (freq <= 54000000))) {
-			da7213->mclk_rate = freq;
-			return 0;
-		} else {
-			dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
-				freq);
-			return -EINVAL;
-		}
+		da7213->mclk_squarer_en = false;
 		break;
 	default:
 		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
 		return -EINVAL;
 	}
+
+	da7213->clk_src = clk_id;
+
+	if (da7213->mclk) {
+		freq = clk_round_rate(da7213->mclk, freq);
+		ret = clk_set_rate(da7213->mclk, freq);
+		if (ret) {
+			dev_err(codec_dai->dev, "Failed to set clock rate %d\n",
+				freq);
+			return ret;
+		}
+	}
+
+	da7213->mclk_rate = freq;
+
+	return 0;
 }
 
 /* Supported PLL input frequencies are 5MHz - 54MHz. */
@@ -1366,12 +1388,17 @@ static struct snd_soc_dai_driver da7213_dai = {
 static int da7213_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			/* MCLK */
+			clk_prepare_enable(da7213->mclk);
+
 			/* Enable VMID reference & master bias */
 			snd_soc_update_bits(codec, DA7213_REFERENCES,
 					    DA7213_VMID_EN | DA7213_BIAS_EN,
@@ -1382,15 +1409,126 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 		/* Disable VMID reference & master bias */
 		snd_soc_update_bits(codec, DA7213_REFERENCES,
 				    DA7213_VMID_EN | DA7213_BIAS_EN, 0);
+
+		/* MCLK */
+		clk_disable_unprepare(da7213->mclk);
 		break;
 	}
 	return 0;
 }
 
+/* DT */
+static const struct of_device_id da7213_of_match[] = {
+	{ .compatible = "dlg,da7213", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da7213_of_match);
+
+static enum da7213_micbias_voltage
+	da7213_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
+{
+	switch (val) {
+	case 1600:
+		return DA7213_MICBIAS_1_6V;
+	case 2200:
+		return DA7213_MICBIAS_2_2V;
+	case 2500:
+		return DA7213_MICBIAS_2_5V;
+	case 3000:
+		return DA7213_MICBIAS_3_0V;
+	default:
+		dev_warn(codec->dev, "Invalid micbias level\n");
+		return DA7213_MICBIAS_2_2V;
+	}
+}
+
+static enum da7213_dmic_data_sel
+	da7213_of_dmic_data_sel(struct snd_soc_codec *codec, const char *str)
+{
+	if (!strcmp(str, "lrise_rfall")) {
+		return DA7213_DMIC_DATA_LRISE_RFALL;
+	} else if (!strcmp(str, "lfall_rrise")) {
+		return DA7213_DMIC_DATA_LFALL_RRISE;
+	} else {
+		dev_warn(codec->dev, "Invalid DMIC data select type\n");
+		return DA7213_DMIC_DATA_LRISE_RFALL;
+	}
+}
+
+static enum da7213_dmic_samplephase
+	da7213_of_dmic_samplephase(struct snd_soc_codec *codec, const char *str)
+{
+	if (!strcmp(str, "on_clkedge")) {
+		return DA7213_DMIC_SAMPLE_ON_CLKEDGE;
+	} else if (!strcmp(str, "between_clkedge")) {
+		return DA7213_DMIC_SAMPLE_BETWEEN_CLKEDGE;
+	} else {
+		dev_warn(codec->dev, "Invalid DMIC sample phase\n");
+		return DA7213_DMIC_SAMPLE_ON_CLKEDGE;
+	}
+}
+
+static enum da7213_dmic_clk_rate
+	da7213_of_dmic_clkrate(struct snd_soc_codec *codec, u32 val)
+{
+	switch (val) {
+	case 1500000:
+		return DA7213_DMIC_CLK_1_5MHZ;
+	case 3000000:
+		return DA7213_DMIC_CLK_3_0MHZ;
+	default:
+		dev_warn(codec->dev, "Invalid DMIC clock rate\n");
+		return DA7213_DMIC_CLK_1_5MHZ;
+	}
+}
+
+static struct da7213_platform_data
+	*da7213_of_to_pdata(struct snd_soc_codec *codec)
+{
+	struct device_node *np = codec->dev->of_node;
+	struct da7213_platform_data *pdata;
+	const char *of_str;
+	u32 of_val32;
+
+	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "dlg,micbias1-lvl", &of_val32) >= 0)
+		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, of_val32);
+	else
+		pdata->micbias1_lvl = DA7213_MICBIAS_2_2V;
+
+	if (of_property_read_u32(np, "dlg,micbias2-lvl", &of_val32) >= 0)
+		pdata->micbias2_lvl = da7213_of_micbias_lvl(codec, of_val32);
+	else
+		pdata->micbias2_lvl = DA7213_MICBIAS_2_2V;
+
+	if (!of_property_read_string(np, "dlg,dmic-data-sel", &of_str))
+		pdata->dmic_data_sel = da7213_of_dmic_data_sel(codec, of_str);
+	else
+		pdata->dmic_data_sel = DA7213_DMIC_DATA_LRISE_RFALL;
+
+	if (!of_property_read_string(np, "dlg,dmic-samplephase", &of_str))
+		pdata->dmic_samplephase =
+			da7213_of_dmic_samplephase(codec, of_str);
+	else
+		pdata->dmic_samplephase = DA7213_DMIC_SAMPLE_ON_CLKEDGE;
+
+	if (of_property_read_u32(np, "dlg,dmic-clkrate", &of_val32) >= 0)
+		pdata->dmic_clk_rate = da7213_of_dmic_clkrate(codec, of_val32);
+	else
+		pdata->dmic_clk_rate = DA7213_DMIC_CLK_3_0MHZ;
+
+	return pdata;
+}
+
+
 static int da7213_probe(struct snd_soc_codec *codec)
 {
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
-	struct da7213_platform_data *pdata = da7213->pdata;
 
 	/* Default to using ALC auto offset calibration mode. */
 	snd_soc_update_bits(codec, DA7213_ALC_CTRL1,
@@ -1450,8 +1588,15 @@ static int da7213_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, DA7213_LINE_CTRL,
 			    DA7213_LINE_AMP_OE, DA7213_LINE_AMP_OE);
 
+	/* Handle DT/Platform data */
+	if (codec->dev->of_node)
+		da7213->pdata = da7213_of_to_pdata(codec);
+	else
+		da7213->pdata = dev_get_platdata(codec->dev);
+
 	/* Set platform data values */
 	if (da7213->pdata) {
+		struct da7213_platform_data *pdata = da7213->pdata;
 		u8 micbias_lvl = 0, dmic_cfg = 0;
 
 		/* Set Mic Bias voltages */
@@ -1503,10 +1648,17 @@ static int da7213_probe(struct snd_soc_codec *codec)
 				    DA7213_DMIC_DATA_SEL_MASK |
 				    DA7213_DMIC_SAMPLEPHASE_MASK |
 				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
+	}
 
-		/* Set MCLK squaring */
-		da7213->mclk_squarer_en = pdata->mclk_squaring;
+	/* Check if MCLK provided */
+	da7213->mclk = devm_clk_get(codec->dev, "mclk");
+	if (IS_ERR(da7213->mclk)) {
+		if (PTR_ERR(da7213->mclk) != -ENOENT)
+			return PTR_ERR(da7213->mclk);
+		else
+			da7213->mclk = NULL;
 	}
+
 	return 0;
 }
 
@@ -1537,7 +1689,6 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da7213_priv *da7213;
-	struct da7213_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	int ret;
 
 	da7213 = devm_kzalloc(&i2c->dev, sizeof(struct da7213_priv),
@@ -1545,9 +1696,6 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	if (!da7213)
 		return -ENOMEM;
 
-	if (pdata)
-		da7213->pdata = pdata;
-
 	i2c_set_clientdata(i2c, da7213);
 
 	da7213->regmap = devm_regmap_init_i2c(i2c, &da7213_regmap_config);
@@ -1582,6 +1730,7 @@ MODULE_DEVICE_TABLE(i2c, da7213_i2c_id);
 static struct i2c_driver da7213_i2c_driver = {
 	.driver = {
 		.name = "da7213",
+		.of_match_table = da7213_of_match,
 	},
 	.probe		= da7213_i2c_probe,
 	.remove		= da7213_remove,
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 9cb9ddd..030fd69 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -13,6 +13,7 @@
 #ifndef _DA7213_H
 #define _DA7213_H
 
+#include <linux/clk.h>
 #include <linux/regmap.h>
 #include <sound/da7213.h>
 
@@ -504,14 +505,17 @@
 #define DA7213_PLL_INDIV_20_40_MHZ_VAL	8
 #define DA7213_PLL_INDIV_40_54_MHZ_VAL	16
 
-enum clk_src {
-	DA7213_CLKSRC_MCLK
+enum da7213_clk_src {
+	DA7213_CLKSRC_MCLK = 0,
+	DA7213_CLKSRC_MCLK_SQR,
 };
 
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 	unsigned int mclk_rate;
+	int clk_src;
 	bool master;
 	bool mclk_squarer_en;
 	bool srm_en;
-- 
1.9.3
