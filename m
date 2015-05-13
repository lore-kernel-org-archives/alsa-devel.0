From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add reset-gpio dts option
Date: Wed, 13 May 2015 08:25:15 -0700
Message-ID: <1431530715-21333-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D988265CBE
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 17:25:56 +0200 (CEST)
Received: by iebpz10 with SMTP id pz10so35351485ieb.2
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 08:25:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: oder_chiou@realtek.com, bardliao@realtek.com, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

It allows to configure codec's RESET pin gpio

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt |  2 ++
 sound/soc/codecs/rt5677.c                          | 32 ++++++++++++++++++++--
 sound/soc/codecs/rt5677.h                          |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index 740ff77..f070789 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -18,6 +18,7 @@ Required properties:
 Optional properties:
 
 - realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
+- realtek,reset-gpio : The GPIO that controls the CODEC's RESET pin.
 
 - realtek,in1-differential
 - realtek,in2-differential
@@ -70,6 +71,7 @@ rt5677 {
 
 	realtek,pow-ldo2-gpio =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+	realtek,reset-gpio = <&gpio TEGRA_GPIO(BB, 3) GPIO_ACTIVE_LOW>;
 	realtek,in1-differential = "true";
 	realtek,gpio-config = /bits/ 8  <0 0 0 0 0 2>;   /* pull up GPIO6 */
 	realtek,jd2-gpio = <3>;  /* Enables Jack detection for GPIO6 */
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8bb7be8..235064a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4765,6 +4765,8 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
 	if (gpio_is_valid(rt5677->pow_ldo2))
 		gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
+	if (gpio_is_valid(rt5677->reset_pin))
+		gpio_set_value_cansleep(rt5677->reset_pin, 0);
 
 	return 0;
 }
@@ -4780,6 +4782,8 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 
 		if (gpio_is_valid(rt5677->pow_ldo2))
 			gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
+		if (gpio_is_valid(rt5677->reset_pin))
+			gpio_set_value_cansleep(rt5677->reset_pin, 0);
 	}
 
 	return 0;
@@ -4790,10 +4794,13 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
-		if (gpio_is_valid(rt5677->pow_ldo2)) {
+		if (gpio_is_valid(rt5677->pow_ldo2))
 			gpio_set_value_cansleep(rt5677->pow_ldo2, 1);
+		if (gpio_is_valid(rt5677->reset_pin))
+			gpio_set_value_cansleep(rt5677->reset_pin, 1);
+		if (gpio_is_valid(rt5677->pow_ldo2) ||
+		    gpio_is_valid(rt5677->reset_pin))
 			msleep(10);
-		}
 
 		regcache_cache_only(rt5677->regmap, false);
 		regcache_sync(rt5677->regmap);
@@ -5031,6 +5038,8 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 
 	rt5677->pow_ldo2 = of_get_named_gpio(np,
 					"realtek,pow-ldo2-gpio", 0);
+	rt5677->reset_pin = of_get_named_gpio(np,
+					"realtek,reset-gpio", 0);
 
 	/*
 	 * POW_LDO2 is optional (it may be statically tied on the board).
@@ -5041,6 +5050,9 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 	if (!gpio_is_valid(rt5677->pow_ldo2) &&
 			(rt5677->pow_ldo2 != -ENOENT))
 		return rt5677->pow_ldo2;
+	if (!gpio_is_valid(rt5677->reset_pin) &&
+			(rt5677->reset_pin != -ENOENT))
+		return rt5677->reset_pin;
 
 	of_property_read_u8_array(np, "realtek,gpio-config",
 		rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
@@ -5142,6 +5154,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		}
 	} else {
 		rt5677->pow_ldo2 = -EINVAL;
+		rt5677->reset_pin = -EINVAL;
 	}
 
 	if (gpio_is_valid(rt5677->pow_ldo2)) {
@@ -5153,6 +5166,21 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 				rt5677->pow_ldo2, ret);
 			return ret;
 		}
+	}
+
+	if (gpio_is_valid(rt5677->reset_pin)) {
+		ret = devm_gpio_request_one(&i2c->dev, rt5677->reset_pin,
+					    GPIOF_OUT_INIT_HIGH,
+					    "RT5677 RESET");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request RESET %d: %d\n",
+				rt5677->reset_pin, ret);
+			return ret;
+		}
+	}
+
+	if (gpio_is_valid(rt5677->pow_ldo2) ||
+	    gpio_is_valid(rt5677->reset_pin)) {
 		/* Wait a while until I2C bus becomes available. The datasheet
 		 * does not specify the exact we should wait but startup
 		 * sequence mentiones at least a few milliseconds.
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 62571d0..7eca38a 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1776,6 +1776,7 @@ struct rt5677_priv {
 	int pll_in;
 	int pll_out;
 	int pow_ldo2; /* POW_LDO2 pin */
+	int reset_pin; /* RESET pin */
 	enum rt5677_type type;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
-- 
2.2.0.rc0.207.ga3a616c
