From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM5100 gpiolib support to direct
	regmap API usage
Date: Wed,  9 Nov 2011 17:29:11 +0000
Message-ID: <1320859751-24306-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 498EB243B5
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 18:29:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   52 +++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 77ffde0..a00ef95 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2353,24 +2353,22 @@ static inline struct wm5100_priv *gpio_to_wm5100(struct gpio_chip *chip)
 static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
-	struct snd_soc_codec *codec = wm5100->codec;
 
-	snd_soc_update_bits(codec, WM5100_GPIO_CTRL_1 + offset,
-			    WM5100_GP1_LVL, !!value << WM5100_GP1_LVL_SHIFT);
+	regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
+			   WM5100_GP1_LVL, !!value << WM5100_GP1_LVL_SHIFT);
 }
 
 static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
-	struct snd_soc_codec *codec = wm5100->codec;
 	int val, ret;
 
 	val = (1 << WM5100_GP1_FN_SHIFT) | (!!value << WM5100_GP1_LVL_SHIFT);
 
-	ret = snd_soc_update_bits(codec, WM5100_GPIO_CTRL_1 + offset,
-				  WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
-				  WM5100_GP1_LVL, val);
+	ret = regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
+				 WM5100_GP1_FN_MASK | WM5100_GP1_DIR |
+				 WM5100_GP1_LVL, val);
 	if (ret < 0)
 		return ret;
 	else
@@ -2380,25 +2378,24 @@ static int wm5100_gpio_direction_out(struct gpio_chip *chip,
 static int wm5100_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
-	struct snd_soc_codec *codec = wm5100->codec;
+	unsigned int reg;
 	int ret;
 
-	ret = snd_soc_read(codec, WM5100_GPIO_CTRL_1 + offset);
+	ret = regmap_read(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset, &reg);
 	if (ret < 0)
 		return ret;
 
-	return (ret & WM5100_GP1_LVL) != 0;
+	return (reg & WM5100_GP1_LVL) != 0;
 }
 
 static int wm5100_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
-	struct snd_soc_codec *codec = wm5100->codec;
 
-	return snd_soc_update_bits(codec, WM5100_GPIO_CTRL_1 + offset,
-				   WM5100_GP1_FN_MASK | WM5100_GP1_DIR,
-				   (1 << WM5100_GP1_FN_SHIFT) |
-				   (1 << WM5100_GP1_DIR_SHIFT));
+	return regmap_update_bits(wm5100->regmap, WM5100_GPIO_CTRL_1 + offset,
+				  WM5100_GP1_FN_MASK | WM5100_GP1_DIR,
+				  (1 << WM5100_GP1_FN_SHIFT) |
+				  (1 << WM5100_GP1_DIR_SHIFT));
 }
 
 static struct gpio_chip wm5100_template_chip = {
@@ -2411,14 +2408,14 @@ static struct gpio_chip wm5100_template_chip = {
 	.can_sleep		= 1,
 };
 
-static void wm5100_init_gpio(struct snd_soc_codec *codec)
+static void wm5100_init_gpio(struct i2c_client *i2c)
 {
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 	int ret;
 
 	wm5100->gpio_chip = wm5100_template_chip;
 	wm5100->gpio_chip.ngpio = 6;
-	wm5100->gpio_chip.dev = codec->dev;
+	wm5100->gpio_chip.dev = &i2c->dev;
 
 	if (wm5100->pdata.gpio_base)
 		wm5100->gpio_chip.base = wm5100->pdata.gpio_base;
@@ -2427,24 +2424,24 @@ static void wm5100_init_gpio(struct snd_soc_codec *codec)
 
 	ret = gpiochip_add(&wm5100->gpio_chip);
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to add GPIOs: %d\n", ret);
 }
 
-static void wm5100_free_gpio(struct snd_soc_codec *codec)
+static void wm5100_free_gpio(struct i2c_client *i2c)
 {
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 	int ret;
 
 	ret = gpiochip_remove(&wm5100->gpio_chip);
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to remove GPIOs: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to remove GPIOs: %d\n", ret);
 }
 #else
-static void wm5100_init_gpio(struct snd_soc_codec *codec)
+static void wm5100_init_gpio(struct i2c_client *i2c)
 {
 }
 
-static void wm5100_free_gpio(struct snd_soc_codec *codec)
+static void wm5100_free_gpio(struct i2c_client *i2c)
 {
 }
 #endif
@@ -2466,7 +2463,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 
 	regcache_cache_only(wm5100->regmap, true);
 
-	wm5100_init_gpio(codec);
 
 	for (i = 0; i < ARRAY_SIZE(wm5100_dig_vu); i++)
 		snd_soc_update_bits(codec, wm5100_dig_vu[i], WM5100_OUT_VU,
@@ -2574,7 +2570,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 err_gpio:
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
-	wm5100_free_gpio(codec);
 
 	return ret;
 }
@@ -2590,7 +2585,6 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 	}
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
-	wm5100_free_gpio(codec);
 	return 0;
 }
 
@@ -2744,6 +2738,8 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 		goto err_reset;
 	}
 
+	wm5100_init_gpio(i2c);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
@@ -2755,6 +2751,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_reset:
+	wm5100_free_gpio(i2c);
 	if (wm5100->pdata.reset) {
 		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
 		gpio_free(wm5100->pdata.reset);
@@ -2788,6 +2785,7 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *client)
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
+	wm5100_free_gpio(client);
 	if (wm5100->pdata.reset) {
 		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
 		gpio_free(wm5100->pdata.reset);
-- 
1.7.7.2
