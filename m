From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform
	data
Date: Wed, 29 Nov 2017 15:32:50 -0600
Message-ID: <20171129213300.20021-10-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E5C3026798F
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:04 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Platform data is not used by anyone (at least in upstream) so
drop this data and switch to using fwnode(DT/ACPI) only.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 72 +++++++++++++---------------------------
 sound/soc/codecs/tlv320aic31xx.h |  6 ----
 2 files changed, 23 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index ab03a19f6aaa..0e00421d363b 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -157,8 +157,9 @@ struct aic31xx_priv {
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
@@ -450,7 +451,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 		/* change mic bias voltage to user defined */
 		snd_soc_update_bits(codec, AIC31XX_MICBIAS,
 				    AIC31XX_MICBIAS_MASK,
-				    aic31xx->pdata.micbias_vg <<
+				    aic31xx->micbias_vg <<
 				    AIC31XX_MICBIAS_SHIFT);
 		dev_dbg(codec->dev, "%s: turned on\n", __func__);
 		break;
@@ -673,14 +674,14 @@ static int aic31xx_add_controls(struct snd_soc_codec *codec)
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
@@ -698,7 +699,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT) {
+	if (aic31xx->codec_type & DAC31XX_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, dac31xx_dapm_widgets,
 			ARRAY_SIZE(dac31xx_dapm_widgets));
@@ -722,7 +723,7 @@ static int aic31xx_add_widgets(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
+	if (aic31xx->codec_type & AIC31XX_STEREO_CLASS_D_BIT) {
 		ret = snd_soc_dapm_new_controls(
 			dapm, aic311x_dapm_widgets,
 			ARRAY_SIZE(aic311x_dapm_widgets));
@@ -1257,42 +1258,6 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
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
@@ -1307,6 +1272,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct aic31xx_priv *aic31xx;
+	unsigned int micbias_value = MICBIAS_2_0V;
 	int i, ret;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
@@ -1325,15 +1291,23 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
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
@@ -1353,7 +1327,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
+	if (aic31xx->codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
 				dac31xx_dai_driver,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 15ac7cba86fe..ab94e6a0c742 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -29,12 +29,6 @@ enum aic31xx_type {
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
