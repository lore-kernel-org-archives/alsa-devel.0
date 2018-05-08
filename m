From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/19] ASoC: rt5640: Remove unused
	rt5640_platform_data
Date: Tue,  8 May 2018 17:35:48 +0200
Message-ID: <20180508153604.23711-4-hdegoede@redhat.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F782676A9
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:12 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

There are no in tree users of platform-data for the rt5640 codec driver,
so lets remove support for it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/sound/rt5640.h    | 27 --------------------
 sound/soc/codecs/rt5640.c | 53 ++++++++++++---------------------------
 sound/soc/codecs/rt5640.h |  3 +--
 3 files changed, 17 insertions(+), 66 deletions(-)
 delete mode 100644 include/sound/rt5640.h

diff --git a/include/sound/rt5640.h b/include/sound/rt5640.h
deleted file mode 100644
index e3c84b92ff70..000000000000
--- a/include/sound/rt5640.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * linux/sound/rt5640.h -- Platform data for RT5640
- *
- * Copyright 2011 Realtek Microelectronics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __LINUX_SND_RT5640_H
-#define __LINUX_SND_RT5640_H
-
-struct rt5640_platform_data {
-	/* IN1 & IN2 & IN3 can optionally be differential */
-	bool in1_diff;
-	bool in2_diff;
-	bool in3_diff;
-
-	bool dmic_en;
-	bool dmic1_data_pin; /* 0 = IN1P; 1 = GPIO3 */
-	bool dmic2_data_pin; /* 0 = IN1N; 1 = GPIO4 */
-
-	int ldo1_en; /* GPIO for LDO1_EN */
-};
-
-#endif
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 140bad07429e..616f0a69b850 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2138,10 +2138,6 @@ static int rt5640_probe(struct snd_soc_component *component)
 		return -ENODEV;
 	}
 
-	if (rt5640->pdata.dmic_en)
-		rt5640_dmic_enable(component, rt5640->pdata.dmic1_data_pin,
-					  rt5640->pdata.dmic2_data_pin);
-
 	return 0;
 }
 
@@ -2159,8 +2155,8 @@ static int rt5640_suspend(struct snd_soc_component *component)
 	rt5640_reset(component);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
-	if (gpio_is_valid(rt5640->pdata.ldo1_en))
-		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 0);
+	if (gpio_is_valid(rt5640->ldo1_en))
+		gpio_set_value_cansleep(rt5640->ldo1_en, 0);
 
 	return 0;
 }
@@ -2169,8 +2165,8 @@ static int rt5640_resume(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
-		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 1);
+	if (gpio_is_valid(rt5640->ldo1_en)) {
+		gpio_set_value_cansleep(rt5640->ldo1_en, 1);
 		msleep(400);
 	}
 
@@ -2302,22 +2298,16 @@ MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
 
 static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
 {
-	rt5640->pdata.in1_diff = of_property_read_bool(np,
-					"realtek,in1-differential");
-	rt5640->pdata.in2_diff = of_property_read_bool(np,
-					"realtek,in2-differential");
-
-	rt5640->pdata.ldo1_en = of_get_named_gpio(np,
-					"realtek,ldo1-en-gpios", 0);
+	rt5640->ldo1_en = of_get_named_gpio(np, "realtek,ldo1-en-gpios", 0);
 	/*
 	 * LDO1_EN is optional (it may be statically tied on the board).
 	 * -ENOENT means that the property doesn't exist, i.e. there is no
 	 * GPIO, so is not an error. Any other error code means the property
 	 * exists, but could not be parsed.
 	 */
-	if (!gpio_is_valid(rt5640->pdata.ldo1_en) &&
-			(rt5640->pdata.ldo1_en != -ENOENT))
-		return rt5640->pdata.ldo1_en;
+	if (!gpio_is_valid(rt5640->ldo1_en) &&
+			(rt5640->ldo1_en != -ENOENT))
+		return rt5640->ldo1_en;
 
 	return 0;
 }
@@ -2325,7 +2315,6 @@ static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
 static int rt5640_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
-	struct rt5640_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5640_priv *rt5640;
 	int ret;
 	unsigned int val;
@@ -2337,22 +2326,12 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	i2c_set_clientdata(i2c, rt5640);
 
-	if (pdata) {
-		rt5640->pdata = *pdata;
-		/*
-		 * Translate zero'd out (default) pdata value to an invalid
-		 * GPIO ID. This makes the pdata and DT paths consistent in
-		 * terms of the value left in this field when no GPIO is
-		 * specified, but means we can't actually use GPIO 0.
-		 */
-		if (!rt5640->pdata.ldo1_en)
-			rt5640->pdata.ldo1_en = -EINVAL;
-	} else if (i2c->dev.of_node) {
+	if (i2c->dev.of_node) {
 		ret = rt5640_parse_dt(rt5640, i2c->dev.of_node);
 		if (ret)
 			return ret;
 	} else
-		rt5640->pdata.ldo1_en = -EINVAL;
+		rt5640->ldo1_en = -EINVAL;
 
 	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
 	if (IS_ERR(rt5640->regmap)) {
@@ -2362,13 +2341,13 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
-		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
+	if (gpio_is_valid(rt5640->ldo1_en)) {
+		ret = devm_gpio_request_one(&i2c->dev, rt5640->ldo1_en,
 					    GPIOF_OUT_INIT_HIGH,
 					    "RT5640 LDO1_EN");
 		if (ret < 0) {
 			dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
-				rt5640->pdata.ldo1_en, ret);
+				rt5640->ldo1_en, ret);
 			return ret;
 		}
 		msleep(400);
@@ -2391,15 +2370,15 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5640->regmap, RT5640_DUMMY1,
 				RT5640_MCLK_DET, RT5640_MCLK_DET);
 
-	if (rt5640->pdata.in1_diff)
+	if (device_property_read_bool(&i2c->dev, "realtek,in1-differential"))
 		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
 					RT5640_IN_DF1, RT5640_IN_DF1);
 
-	if (rt5640->pdata.in2_diff)
+	if (device_property_read_bool(&i2c->dev, "realtek,in2-differential"))
 		regmap_update_bits(rt5640->regmap, RT5640_IN3_IN4,
 					RT5640_IN_DF2, RT5640_IN_DF2);
 
-	if (rt5640->pdata.in3_diff)
+	if (device_property_read_bool(&i2c->dev, "realtek,in3-differential"))
 		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
 					RT5640_IN_DF2, RT5640_IN_DF2);
 
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index c473e8ae2eda..2db6586f5ab4 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -13,7 +13,6 @@
 #define _RT5640_H
 
 #include <linux/clk.h>
-#include <sound/rt5640.h>
 
 /* Info */
 #define RT5640_RESET				0x00
@@ -2103,10 +2102,10 @@ enum {
 
 struct rt5640_priv {
 	struct snd_soc_component *component;
-	struct rt5640_platform_data pdata;
 	struct regmap *regmap;
 	struct clk *mclk;
 
+	int ldo1_en; /* GPIO for LDO1_EN */
 	int sysclk;
 	int sysclk_src;
 	int lrck[RT5640_AIFS];
-- 
2.17.0
