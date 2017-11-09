From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 06/17] ASoC: tlv320aic31xx: Remove platform data
Date: Wed, 8 Nov 2017 18:27:30 -0600
Message-ID: <20171109002741.10897-7-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Platform data is not used by anyone (at least in upstream) so
drop this data and switch to using fwnode(DT/ACPI) only.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 65 ++++++++++++++--------------------------
 sound/soc/codecs/tlv320aic31xx.h |  6 ----
 2 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c72a2ea7d41b..44502a847af4 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -165,8 +165,9 @@ struct aic31xx_priv {
 	u8 i2c_regs_status;
 	struct device *dev;
 	struct regmap *regmap;
+	enum aic31xx_type codec_type;
 	struct gpio_desc *gpio_reset;
-	struct aic31xx_pdata pdata;
+	int micbias_vg;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -458,7 +459,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 		/* change mic bias voltage to user defined */
 		snd_soc_update_bits(codec, AIC31XX_MICBIAS,
 				    AIC31XX_MICBIAS_MASK,
-				    aic31xx->pdata.micbias_vg <<
+				    aic31xx->micbias_vg <<
 				    AIC31XX_MICBIAS_SHIFT);
 		dev_dbg(codec->dev, "%s: turned on\n", __func__);
 		break;
@@ -681,14 +682,14 @@ static int aic31xx_add_controls(struct snd_soc_codec *codec)
 	int ret = 0;
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 
-	if (!(aic31xx->pdata.codec_type & DAC31XX_BIT))
+	if (!(aic31xx->codec_type & DAC31XX_BIT))
 		ret = snd_soc_add_codec_controls(
 			codec, aic31xx_snd_controls,
 			ARRAY_SIZE(aic31xx_snd_controls));
 	if (ret)
 		return ret;
 
-	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT)
+	if (aic31xx->codec_type & AIC31XX_STEREO_CLASS_D_BIT)
 		ret = snd_soc_add_codec_controls(
 			codec, aic311x_snd_controls,
 			ARRAY_SIZE(aic311x_snd_controls));
@@ -706,7 +707,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT) {
+	if (aic31xx->codec_type & DAC31XX_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, dac31xx_dapm_widgets,
 			ARRAY_SIZE(dac31xx_dapm_widgets));
@@ -730,7 +731,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
+	if (aic31xx->codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, aic311x_dapm_widgets,
 			ARRAY_SIZE(aic311x_dapm_widgets));
@@ -1272,35 +1273,6 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic31xx_of_match);
-
-static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
-{
-	struct device_node *np = aic31xx->dev->of_node;
-	unsigned int value = MICBIAS_2_0V;
-	int ret;
-
-	of_property_read_u32(np, "ai31xx-micbias-vg", &value);
-	switch (value) {
-	case MICBIAS_2_0V:
-	case MICBIAS_2_5V:
-	case MICBIAS_AVDDV:
-		aic31xx->pdata.micbias_vg = value;
-		break;
-	default:
-		dev_err(aic31xx->dev,
-			"Bad ai31xx-micbias-vg value %d DT\n",
-			value);
-		aic31xx->pdata.micbias_vg = MICBIAS_2_0V;
-	}
-
-	ret = of_get_named_gpio(np, "reset-gpio", 0);
-	if (ret > 0)
-		aic31xx->pdata.gpio_reset = ret;
-}
-#else /* CONFIG_OF */
-static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
-{
-}
 #endif /* CONFIG_OF */
 
 #ifdef CONFIG_ACPI
@@ -1315,6 +1287,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct aic31xx_priv *aic31xx;
+	unsigned int micbias_value = MICBIAS_2_0V;
 	int i, ret;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
@@ -1333,15 +1306,23 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	}
 	aic31xx->dev = &i2c->dev;
 
-	aic31xx->pdata.codec_type = id->driver_data;
+	aic31xx->codec_type = id->driver_data;
 
 	dev_set_drvdata(aic31xx->dev, aic31xx);
 
-	if (dev_get_platdata(aic31xx->dev))
-		memcpy(&aic31xx->pdata, dev_get_platdata(aic31xx->dev),
-		       sizeof(aic31xx->pdata));
-	else if (aic31xx->dev->of_node)
-		aic31xx_pdata_from_of(aic31xx);
+	fwnode_property_read_u32(aic31xx->dev->fwnode, "ai31xx-micbias-vg",
+				 &micbias_value);
+	switch (micbias_value) {
+	case MICBIAS_2_0V:
+	case MICBIAS_2_5V:
+	case MICBIAS_AVDDV:
+		aic31xx->micbias_vg = micbias_value;
+		break;
+	default:
+		dev_err(aic31xx->dev, "Bad ai31xx-micbias-vg value %d in DT\n",
+			micbias_value);
+		aic31xx->micbias_vg = MICBIAS_2_0V;
+	}
 
 	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
 						      GPIOD_OUT_LOW);
@@ -1361,7 +1342,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
+	if (aic31xx->codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
 				dac31xx_dai_driver,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 4f126cd82add..9bc53af9c3a0 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -36,12 +36,6 @@ enum aic31xx_type {
 	DAC3101 = DAC31XX_BIT | AIC31XX_STEREO_CLASS_D_BIT,
 };
 
-struct aic31xx_pdata {
-	enum aic31xx_type codec_type;
-	unsigned int gpio_reset;
-	int micbias_vg;
-};
-
 #define AIC31XX_REG(page, reg)	((page * 128) + reg)
 
 #define AIC31XX_PAGECTL		AIC31XX_REG(0, 0) /* Page Control Register */
-- 
2.15.0
