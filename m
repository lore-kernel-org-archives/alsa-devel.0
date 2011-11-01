From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Convert WM8996 gpiolib to regmap
Date: Tue,  1 Nov 2011 19:53:19 +0000
Message-ID: <1320177199-1897-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320177199-1897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C18B8103897
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 20:53:24 +0100 (CET)
In-Reply-To: <1320177199-1897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Actually pretty straightforward.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   56 +++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index cb9709a..fd5bb1a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -50,6 +50,7 @@ static const char *wm8996_supply_names[WM8996_NUM_SUPPLIES] = {
 };
 
 struct wm8996_priv {
+	struct device *dev;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
@@ -2325,48 +2326,45 @@ static inline struct wm8996_priv *gpio_to_wm8996(struct gpio_chip *chip)
 static void wm8996_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
-	struct snd_soc_codec *codec = wm8996->codec;
 
-	snd_soc_update_bits(codec, WM8996_GPIO_1 + offset,
-			    WM8996_GP1_LVL, !!value << WM8996_GP1_LVL_SHIFT);
+	regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
+			   WM8996_GP1_LVL, !!value << WM8996_GP1_LVL_SHIFT);
 }
 
 static int wm8996_gpio_direction_out(struct gpio_chip *chip,
 				     unsigned offset, int value)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
-	struct snd_soc_codec *codec = wm8996->codec;
 	int val;
 
 	val = (1 << WM8996_GP1_FN_SHIFT) | (!!value << WM8996_GP1_LVL_SHIFT);
 
-	return snd_soc_update_bits(codec, WM8996_GPIO_1 + offset,
-				   WM8996_GP1_FN_MASK | WM8996_GP1_DIR |
-				   WM8996_GP1_LVL, val);
+	return regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
+				  WM8996_GP1_FN_MASK | WM8996_GP1_DIR |
+				  WM8996_GP1_LVL, val);
 }
 
 static int wm8996_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
-	struct snd_soc_codec *codec = wm8996->codec;
+	unsigned int reg;
 	int ret;
 
-	ret = snd_soc_read(codec, WM8996_GPIO_1 + offset);
+	ret = regmap_read(wm8996->regmap, WM8996_GPIO_1 + offset, &reg);
 	if (ret < 0)
 		return ret;
 
-	return (ret & WM8996_GP1_LVL) != 0;
+	return (reg & WM8996_GP1_LVL) != 0;
 }
 
 static int wm8996_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm8996_priv *wm8996 = gpio_to_wm8996(chip);
-	struct snd_soc_codec *codec = wm8996->codec;
 
-	return snd_soc_update_bits(codec, WM8996_GPIO_1 + offset,
-				   WM8996_GP1_FN_MASK | WM8996_GP1_DIR,
-				   (1 << WM8996_GP1_FN_SHIFT) |
-				   (1 << WM8996_GP1_DIR_SHIFT));
+	return regmap_update_bits(wm8996->regmap, WM8996_GPIO_1 + offset,
+				  WM8996_GP1_FN_MASK | WM8996_GP1_DIR,
+				  (1 << WM8996_GP1_FN_SHIFT) |
+				  (1 << WM8996_GP1_DIR_SHIFT));
 }
 
 static struct gpio_chip wm8996_template_chip = {
@@ -2379,14 +2377,13 @@ static struct gpio_chip wm8996_template_chip = {
 	.can_sleep		= 1,
 };
 
-static void wm8996_init_gpio(struct snd_soc_codec *codec)
+static void wm8996_init_gpio(struct wm8996_priv *wm8996)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	wm8996->gpio_chip = wm8996_template_chip;
 	wm8996->gpio_chip.ngpio = 5;
-	wm8996->gpio_chip.dev = codec->dev;
+	wm8996->gpio_chip.dev = wm8996->dev;
 
 	if (wm8996->pdata.gpio_base)
 		wm8996->gpio_chip.base = wm8996->pdata.gpio_base;
@@ -2395,24 +2392,23 @@ static void wm8996_init_gpio(struct snd_soc_codec *codec)
 
 	ret = gpiochip_add(&wm8996->gpio_chip);
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+		dev_err(wm8996->dev, "Failed to add GPIOs: %d\n", ret);
 }
 
-static void wm8996_free_gpio(struct snd_soc_codec *codec)
+static void wm8996_free_gpio(struct wm8996_priv *wm8996)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	ret = gpiochip_remove(&wm8996->gpio_chip);
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to remove GPIOs: %d\n", ret);
+		dev_err(wm8996->dev, "Failed to remove GPIOs: %d\n", ret);
 }
 #else
-static void wm8996_init_gpio(struct snd_soc_codec *codec)
+static void wm8996_init_gpio(struct wm8996_priv *wm8996)
 {
 }
 
-static void wm8996_free_gpio(struct snd_soc_codec *codec)
+static void wm8996_free_gpio(struct wm8996_priv *wm8996)
 {
 }
 #endif
@@ -2974,8 +2970,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 				    WM8996_AIF2TX_LRCLK_MODE,
 				    WM8996_AIF2TX_LRCLK_MODE);
 
-	wm8996_init_gpio(codec);
-
 	if (i2c->irq) {
 		if (wm8996->pdata.irq_flags)
 			irq_flags = wm8996->pdata.irq_flags;
@@ -3029,8 +3023,6 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 
-	wm8996_free_gpio(codec);
-
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
 		regulator_unregister_notifier(wm8996->supplies[i].consumer,
 					      &wm8996->disable_nb[i]);
@@ -3117,6 +3109,7 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm8996);
+	wm8996->dev = &i2c->dev;
 
 	if (dev_get_platdata(&i2c->dev))
 		memcpy(&wm8996->pdata, dev_get_platdata(&i2c->dev),
@@ -3197,14 +3190,18 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap;
 	}
 
+	wm8996_init_gpio(wm8996);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8996, wm8996_dai,
 				     ARRAY_SIZE(wm8996_dai));
 	if (ret < 0)
-		goto err_regmap;
+		goto err_gpiolib;
 
 	return ret;
 
+err_gpiolib:
+	wm8996_free_gpio(wm8996);
 err_regmap:
 	regmap_exit(wm8996->regmap);
 err_enable:
@@ -3229,6 +3226,7 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
+	wm8996_free_gpio(wm8996);
 	regulator_put(wm8996->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 	regmap_exit(wm8996->regmap);
-- 
1.7.7.1
