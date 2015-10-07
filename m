From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Add DT support to codec driver"
	to the asoc tree
Date: Wed, 07 Oct 2015 15:12:16 +0100
Message-ID: <E1ZjpS4-0007U7-Or@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6CBB265E1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:13:00 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Add DT support to codec driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e90996a3ea224fbeb459b8052ecd366d7990e1f3 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 7 Oct 2015 14:27:08 +0100
Subject: [PATCH] ASoC: da7213: Add DT support to codec driver

This patch adds support for DT bindings in the codec driver.
As part of this support, the mclk data can now be provided and
used to control the mclk during codec operation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 123 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a9c86ef..ab1486b 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1387,10 +1387,118 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
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
@@ -1450,8 +1558,15 @@ static int da7213_probe(struct snd_soc_codec *codec)
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
@@ -1507,6 +1622,7 @@ static int da7213_probe(struct snd_soc_codec *codec)
 		/* Set MCLK squaring */
 		da7213->mclk_squarer_en = pdata->mclk_squaring;
 	}
+
 	return 0;
 }
 
@@ -1537,7 +1653,6 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da7213_priv *da7213;
-	struct da7213_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	int ret;
 
 	da7213 = devm_kzalloc(&i2c->dev, sizeof(struct da7213_priv),
@@ -1545,9 +1660,6 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	if (!da7213)
 		return -ENOMEM;
 
-	if (pdata)
-		da7213->pdata = pdata;
-
 	i2c_set_clientdata(i2c, da7213);
 
 	da7213->regmap = devm_regmap_init_i2c(i2c, &da7213_regmap_config);
@@ -1582,6 +1694,7 @@ MODULE_DEVICE_TABLE(i2c, da7213_i2c_id);
 static struct i2c_driver da7213_i2c_driver = {
 	.driver = {
 		.name = "da7213",
+		.of_match_table = of_match_ptr(da7213_of_match),
 	},
 	.probe		= da7213_i2c_probe,
 	.remove		= da7213_remove,
-- 
2.5.0
