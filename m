From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Switch to use descriptor-based
	gpiod API" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:56 +0100
Message-ID: <E1ZCTNk-0005YU-NX@finisterre>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8032026572D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:08 +0200 (CEST)
In-Reply-To: <1434996780-34535-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Switch to use descriptor-based gpiod API

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

>From efd901ee4bc8312e3bbf5561fdab8e3765e26334 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Mon, 22 Jun 2015 11:12:59 -0700
Subject: [PATCH] ASoC: rt5677: Switch to use descriptor-based gpiod API

This patch makes the driver use the new descriptor-based gpiod API
so that gpio assignment info can be provided by Device Tree, ACPI
or board files.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 85 +++++++++++++++++------------------------------
 sound/soc/codecs/rt5677.h |  5 +--
 2 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9048ba7..2322430 100644
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
@@ -4764,10 +4762,10 @@ static int rt5677_remove(struct snd_soc_codec *codec)
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
@@ -4781,10 +4779,10 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
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
@@ -4795,12 +4793,11 @@ static int rt5677_resume(struct snd_soc_codec *codec)
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
@@ -5037,24 +5034,6 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
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
 
@@ -5158,30 +5137,26 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
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
2.1.4
