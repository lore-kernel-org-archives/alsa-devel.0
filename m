From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 1/2] ASoC: rt5677: Switch to use
	descriptor-based gpiod API
Date: Mon, 22 Jun 2015 11:12:59 -0700
Message-ID: <1434996780-34535-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id A376926512B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 20:13:19 +0200 (CEST)
Received: by igblr2 with SMTP id lr2so59140351igb.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 11:13:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

This patch makes the driver use the new descriptor-based gpiod API
so that gpio assignment info can be provided by Device Tree, ACPI
or board files.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5677.c | 85 +++++++++++++++++------------------------------
 sound/soc/codecs/rt5677.h |  5 +--
 2 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index aba00fd8..c166217 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -15,13 +15,11 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -4761,10 +4759,10 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
-	if (gpio_is_valid(rt5677->pow_ldo2))
-		gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
-	if (gpio_is_valid(rt5677->reset_pin))
-		gpio_set_value_cansleep(rt5677->reset_pin, 0);
+	if (rt5677->pow_ldo2)
+		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+	if (rt5677->reset_pin)
+		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 
 	return 0;
 }
@@ -4778,10 +4776,10 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 		regcache_cache_only(rt5677->regmap, true);
 		regcache_mark_dirty(rt5677->regmap);
 
-		if (gpio_is_valid(rt5677->pow_ldo2))
-			gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
-		if (gpio_is_valid(rt5677->reset_pin))
-			gpio_set_value_cansleep(rt5677->reset_pin, 0);
+		if (rt5677->pow_ldo2)
+			gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+		if (rt5677->reset_pin)
+			gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 	}
 
 	return 0;
@@ -4792,12 +4790,11 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
-		if (gpio_is_valid(rt5677->pow_ldo2))
-			gpio_set_value_cansleep(rt5677->pow_ldo2, 1);
-		if (gpio_is_valid(rt5677->reset_pin))
-			gpio_set_value_cansleep(rt5677->reset_pin, 1);
-		if (gpio_is_valid(rt5677->pow_ldo2) ||
-		    gpio_is_valid(rt5677->reset_pin))
+		if (rt5677->pow_ldo2)
+			gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
+		if (rt5677->reset_pin)
+			gpiod_set_value_cansleep(rt5677->reset_pin, 1);
+		if (rt5677->pow_ldo2 || rt5677->reset_pin)
 			msleep(10);
 
 		regcache_cache_only(rt5677->regmap, false);
@@ -5034,24 +5031,6 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 	rt5677->pdata.lout3_diff = of_property_read_bool(np,
 					"realtek,lout3-differential");
 
-	rt5677->pow_ldo2 = of_get_named_gpio(np,
-					"realtek,pow-ldo2-gpio", 0);
-	rt5677->reset_pin = of_get_named_gpio(np,
-					"realtek,reset-gpio", 0);
-
-	/*
-	 * POW_LDO2 is optional (it may be statically tied on the board).
-	 * -ENOENT means that the property doesn't exist, i.e. there is no
-	 * GPIO, so is not an error. Any other error code means the property
-	 * exists, but could not be parsed.
-	 */
-	if (!gpio_is_valid(rt5677->pow_ldo2) &&
-			(rt5677->pow_ldo2 != -ENOENT))
-		return rt5677->pow_ldo2;
-	if (!gpio_is_valid(rt5677->reset_pin) &&
-			(rt5677->reset_pin != -ENOENT))
-		return rt5677->reset_pin;
-
 	of_property_read_u8_array(np, "realtek,gpio-config",
 		rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
 
@@ -5155,30 +5134,26 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		rt5677->reset_pin = -EINVAL;
 	}
 
-	if (gpio_is_valid(rt5677->pow_ldo2)) {
-		ret = devm_gpio_request_one(&i2c->dev, rt5677->pow_ldo2,
-					    GPIOF_OUT_INIT_HIGH,
-					    "RT5677 POW_LDO2");
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to request POW_LDO2 %d: %d\n",
-				rt5677->pow_ldo2, ret);
-			return ret;
-		}
+	/* pow-ldo2 and reset are optional. The codec pins may be statically
+	 * connected on the board without gpios. If the gpio device property
+	 * isn't specified, devm_gpiod_get_optional returns NULL.
+	 */
+	rt5677->pow_ldo2 = devm_gpiod_get_optional(&i2c->dev,
+			"realtek,pow-ldo2", GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5677->pow_ldo2)) {
+		ret = PTR_ERR(rt5677->pow_ldo2);
+		dev_err(&i2c->dev, "Failed to request POW_LDO2: %d\n", ret);
+		rt5677->pow_ldo2 = 0;
 	}
-
-	if (gpio_is_valid(rt5677->reset_pin)) {
-		ret = devm_gpio_request_one(&i2c->dev, rt5677->reset_pin,
-					    GPIOF_OUT_INIT_HIGH,
-					    "RT5677 RESET");
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to request RESET %d: %d\n",
-				rt5677->reset_pin, ret);
-			return ret;
-		}
+	rt5677->reset_pin = devm_gpiod_get_optional(&i2c->dev,
+			"realtek,reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(rt5677->reset_pin)) {
+		ret = PTR_ERR(rt5677->reset_pin);
+		dev_err(&i2c->dev, "Failed to request RESET: %d\n", ret);
+		rt5677->reset_pin = 0;
 	}
 
-	if (gpio_is_valid(rt5677->pow_ldo2) ||
-	    gpio_is_valid(rt5677->reset_pin)) {
+	if (rt5677->pow_ldo2 || rt5677->reset_pin) {
 		/* Wait a while until I2C bus becomes available. The datasheet
 		 * does not specify the exact we should wait but startup
 		 * sequence mentiones at least a few milliseconds.
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 7eca38a..d46855a 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -14,6 +14,7 @@
 
 #include <sound/rt5677.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 
 /* Info */
 #define RT5677_RESET				0x00
@@ -1775,8 +1776,8 @@ struct rt5677_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
-	int pow_ldo2; /* POW_LDO2 pin */
-	int reset_pin; /* RESET pin */
+	struct gpio_desc *pow_ldo2; /* POW_LDO2 pin */
+	struct gpio_desc *reset_pin; /* RESET pin */
 	enum rt5677_type type;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
-- 
2.4.3.573.g4eafbef
