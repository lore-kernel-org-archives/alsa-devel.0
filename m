From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/17] ASoC: tlv320aic31xx: General source formatting cleanup
Date: Wed, 8 Nov 2017 18:27:25 -0600
Message-ID: <20171109002741.10897-2-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109002741.10897-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Simple non-functional changes including:

 * Fix header copyright tags
 * Fix spelling errors
 * Reformat code for easier reading
 * Move some code blocks to a more natural ordering
 * Remove unneeded code
 * Remove assignments that are always overridden
 * Normalize function return paths

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 93 ++++++++++++++++++++++------------------
 sound/soc/codecs/tlv320aic31xx.h |  4 +-
 2 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 359eba15bb89..63fd93b0a953 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC TLV320AIC31XX codec driver
  *
- * Copyright (C) 2014 Texas Instruments, Inc.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Author: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
  *
@@ -144,8 +144,7 @@ static const struct regmap_config aic31xx_i2c_regmap = {
 	.max_register = 12 * 128,
 };
 
-#define AIC31XX_NUM_SUPPLIES	6
-static const char * const aic31xx_supply_names[AIC31XX_NUM_SUPPLIES] = {
+static const char * const aic31xx_supply_names[] = {
 	"HPVDD",
 	"SPRVDD",
 	"SPLVDD",
@@ -154,6 +153,8 @@ static const char * const aic31xx_supply_names[AIC31XX_NUM_SUPPLIES] = {
 	"DVDD",
 };
 
+#define AIC31XX_NUM_SUPPLIES ARRAY_SIZE(aic31xx_supply_names)
+
 struct aic31xx_disable_nb {
 	struct notifier_block nb;
 	struct aic31xx_priv *aic31xx;
@@ -185,7 +186,7 @@ struct aic31xx_rate_divs {
 	u8 madc;
 };
 
-/* ADC dividers can be disabled by cofiguring them to 0 */
+/* ADC dividers can be disabled by configuring them to 0 */
 static const struct aic31xx_rate_divs aic31xx_divs[] = {
 	/* mclk/p    rate  pll: j     d        dosr ndac mdac  aors nadc madc */
 	/* 8k rate */
@@ -840,11 +841,17 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
 
 	dev_dbg(codec->dev,
 		"pll %d.%04d/%d dosr %d n %d m %d aosr %d n %d m %d bclk_n %d\n",
-		aic31xx_divs[i].pll_j, aic31xx_divs[i].pll_d,
-		aic31xx->p_div, aic31xx_divs[i].dosr,
-		aic31xx_divs[i].ndac, aic31xx_divs[i].mdac,
-		aic31xx_divs[i].aosr, aic31xx_divs[i].nadc,
-		aic31xx_divs[i].madc, bclk_n);
+		aic31xx_divs[i].pll_j,
+		aic31xx_divs[i].pll_d,
+		aic31xx->p_div,
+		aic31xx_divs[i].dosr,
+		aic31xx_divs[i].ndac,
+		aic31xx_divs[i].mdac,
+		aic31xx_divs[i].aosr,
+		aic31xx_divs[i].nadc,
+		aic31xx_divs[i].madc,
+		bclk_n
+	);
 
 	return 0;
 }
@@ -981,8 +988,9 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	dev_dbg(codec->dev, "## %s: clk_id = %d, freq = %d, dir = %d\n",
 		__func__, clk_id, freq, dir);
 
-	for (i = 1; freq/i > 20000000 && i < 8; i++)
-		;
+	for (i = 1; i < 8; i++)
+		if (freq / i <= 20000000)
+			break;
 	if (freq/i > 20000000) {
 		dev_err(aic31xx->dev, "%s: Too high mclk frequency %u\n",
 			__func__, freq);
@@ -990,9 +998,9 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	}
 	aic31xx->p_div = i;
 
-	for (i = 0; i < ARRAY_SIZE(aic31xx_divs) &&
-		     aic31xx_divs[i].mclk_p != freq/aic31xx->p_div; i++)
-		;
+	for (i = 0; i < ARRAY_SIZE(aic31xx_divs); i++)
+		if (aic31xx_divs[i].mclk_p == freq / aic31xx->p_div)
+			break;
 	if (i == ARRAY_SIZE(aic31xx_divs)) {
 		dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
 			__func__, freq);
@@ -1004,6 +1012,7 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			    clk_id << AIC31XX_PLL_CLKIN_SHIFT);
 
 	aic31xx->sysclk = freq;
+
 	return 0;
 }
 
@@ -1065,7 +1074,7 @@ static void aic31xx_clk_off(struct snd_soc_codec *codec)
 static int aic31xx_power_on(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
+	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(aic31xx->supplies),
 				    aic31xx->supplies);
@@ -1078,7 +1087,7 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	}
 	regcache_cache_only(aic31xx->regmap, false);
 	ret = regcache_sync(aic31xx->regmap);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(codec->dev,
 			"Failed to restore cache: %d\n", ret);
 		regcache_cache_only(aic31xx->regmap, true);
@@ -1086,19 +1095,24 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 				       aic31xx->supplies);
 		return ret;
 	}
+
 	return 0;
 }
 
 static int aic31xx_power_off(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
+	int ret;
 
 	regcache_cache_only(aic31xx->regmap, true);
 	ret = regulator_bulk_disable(ARRAY_SIZE(aic31xx->supplies),
 				     aic31xx->supplies);
+	if (ret) {
+		dev_err(aic31xx->dev, "Failed to disable regulators\n");
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
@@ -1137,14 +1151,11 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 
 static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 {
-	int ret = 0;
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int i;
+	int i, ret;
 
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
 
-	aic31xx = snd_soc_codec_get_drvdata(codec);
-
 	aic31xx->codec = codec;
 
 	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
@@ -1169,8 +1180,10 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	ret = aic31xx_add_widgets(codec);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int aic31xx_codec_remove(struct snd_soc_codec *codec)
@@ -1289,6 +1302,14 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 }
 #endif /* CONFIG_OF */
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aic31xx_acpi_match[] = {
+	{ "10TI3100", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
+#endif
+
 static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 {
 	int ret, i;
@@ -1318,10 +1339,12 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 	ret = devm_regulator_bulk_get(aic31xx->dev,
 				      ARRAY_SIZE(aic31xx->supplies),
 				      aic31xx->supplies);
-	if (ret != 0)
+	if (ret) {
 		dev_err(aic31xx->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
@@ -1329,18 +1352,15 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 {
 	struct aic31xx_priv *aic31xx;
 	int ret;
-	const struct regmap_config *regmap_config;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
 		id->name, (int) id->driver_data);
 
-	regmap_config = &aic31xx_i2c_regmap;
-
 	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
-	if (aic31xx == NULL)
+	if (!aic31xx)
 		return -ENOMEM;
 
-	aic31xx->regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
 	if (IS_ERR(aic31xx->regmap)) {
 		ret = PTR_ERR(aic31xx->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -1386,14 +1406,6 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id aic31xx_acpi_match[] = {
-	{ "10TI3100", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
-#endif
-
 static struct i2c_driver aic31xx_i2c_driver = {
 	.driver = {
 		.name	= "tlv320aic31xx-codec",
@@ -1404,9 +1416,8 @@ static struct i2c_driver aic31xx_i2c_driver = {
 	.remove		= aic31xx_i2c_remove,
 	.id_table	= aic31xx_i2c_id,
 };
-
 module_i2c_driver(aic31xx_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC TLV320AIC3111 codec driver");
-MODULE_AUTHOR("Jyri Sarha");
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 730fb2058869..b3571d0db76b 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC TLV320AIC31XX codec driver
  *
- * Copyright (C) 2013 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -10,8 +10,8 @@
  * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
  * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
  */
+
 #ifndef _TLV320AIC31XX_H
 #define _TLV320AIC31XX_H
 
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
