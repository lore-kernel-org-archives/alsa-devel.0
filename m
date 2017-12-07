From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 02/10] ASoC: tlv320aic31xx: Use fwnode APIs
	over raw OF calls
Date: Thu, 7 Dec 2017 09:38:52 -0600
Message-ID: <20171207153900.9831-3-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id C16142671A6
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 16:39:02 +0100 (CET)
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Use fwnode_* API instead of of_*, the results are the same but
fwnode_* is cleaner and we get ACPI support.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 77 +++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 13471a900085..655c99db2426 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -157,7 +157,9 @@ struct aic31xx_priv {
 	u8 i2c_regs_status;
 	struct device *dev;
 	struct regmap *regmap;
+	enum aic31xx_type codec_type;
 	struct gpio_desc *gpio_reset;
+	int micbias_vg;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
@@ -450,7 +452,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 		/* change mic bias voltage to user defined */
 		snd_soc_update_bits(codec, AIC31XX_MICBIAS,
 				    AIC31XX_MICBIAS_MASK,
-				    aic31xx->pdata.micbias_vg <<
+				    aic31xx->micbias_vg <<
 				    AIC31XX_MICBIAS_SHIFT);
 		dev_dbg(codec->dev, "%s: turned on\n", __func__);
 		break;
@@ -673,14 +675,14 @@ static int aic31xx_add_controls(struct snd_soc_codec *codec)
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
@@ -698,7 +700,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT) {
+	if (aic31xx->codec_type & DAC31XX_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, dac31xx_dapm_widgets,
 			ARRAY_SIZE(dac31xx_dapm_widgets));
@@ -722,7 +724,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
+	if (aic31xx->codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, aic311x_dapm_widgets,
 			ARRAY_SIZE(aic311x_dapm_widgets));
@@ -1279,42 +1281,6 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
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
-	ret = of_get_named_gpio(np, "reset-gpios", 0);
-	if (ret > 0) {
-		aic31xx->pdata.gpio_reset = ret;
-	} else {
-		ret = of_get_named_gpio(np, "gpio-reset", 0);
-		if (ret > 0) {
-			dev_warn(aic31xx->dev, "Using deprecated property \"gpio-reset\", please update your DT");
-			aic31xx->pdata.gpio_reset = ret;
-		}
-	}
-}
-#else /* CONFIG_OF */
-static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
-{
-}
 #endif /* CONFIG_OF */
 
 #ifdef CONFIG_ACPI
@@ -1329,6 +1295,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct aic31xx_priv *aic31xx;
+	unsigned int micbias_value = MICBIAS_2_0V;
 	int i, ret;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
@@ -1347,15 +1314,29 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
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
+		dev_err(aic31xx->dev, "Bad ai31xx-micbias-vg value %d\n",
+			micbias_value);
+		aic31xx->micbias_vg = MICBIAS_2_0V;
+	}
+
+	if (dev_get_platdata(aic31xx->dev)) {
+		memcpy(&aic31xx->pdata, dev_get_platdata(aic31xx->dev), sizeof(aic31xx->pdata));
+		aic31xx->codec_type = aic31xx->pdata.codec_type;
+		aic31xx->micbias_vg = aic31xx->pdata.micbias_vg;
+	}
 
 	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
 						      GPIOD_OUT_LOW);
@@ -1375,7 +1356,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
+	if (aic31xx->codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
 				dac31xx_dai_driver,
-- 
2.15.0
