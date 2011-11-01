From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Move most WM8996 resource
	acquisition to I2C probe
Date: Tue,  1 Nov 2011 19:53:18 +0000
Message-ID: <1320177199-1897-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320177199-1897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BCDA310385C
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

Now that the WM8996 driver is using the regmap API for register I/O we no
longer need the ASoC card to be active in order to interact with the chip.
In order to be more idiomatic for Linux move most of the existing probe()
function out into the I2C probe() function prior to registration with ASoC.

The IRQ and GPIO init will be moved separately as these are slightly more
involved.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |  185 +++++++++++++++++++++++---------------------
 1 files changed, 97 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 2cea205..cb9709a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -50,6 +50,7 @@ static const char *wm8996_supply_names[WM8996_NUM_SUPPLIES] = {
 };
 
 struct wm8996_priv {
+	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
 	int ldo1ena;
@@ -106,7 +107,7 @@ static int wm8996_regulator_event_##n(struct notifier_block *nb, \
 	struct wm8996_priv *wm8996 = container_of(nb, struct wm8996_priv, \
 						  disable_nb[n]); \
 	if (event & REGULATOR_EVENT_DISABLE) { \
-		wm8996->codec->cache_sync = 1; \
+		regcache_cache_only(wm8996->regmap, true);	\
 	} \
 	return 0; \
 }
@@ -1713,9 +1714,15 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8996_reset(struct snd_soc_codec *codec)
+static int wm8996_reset(struct wm8996_priv *wm8996)
 {
-	return snd_soc_write(codec, WM8996_SOFTWARE_RESET, 0x8915);
+	if (wm8996->pdata.ldo_ena > 0) {
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
+		return 0;
+	} else {
+		return regmap_write(wm8996->regmap, WM8996_SOFTWARE_RESET,
+				    0x8915);
+	}
 }
 
 static const int bclk_divs[] = {
@@ -2786,40 +2793,18 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 
 	dapm->idle_bias_off = true;
 
-	codec->control_data = regmap_init_i2c(i2c, &wm8996_regmap);
-	if (IS_ERR(codec->control_data)) {
-		ret = PTR_ERR(codec->control_data);
-		dev_err(codec->dev, "regmap_init() failed: %d\n", ret);
-		goto err;
-	}
+	codec->control_data = wm8996->regmap;
 
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err_regmap;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
-		wm8996->supplies[i].supply = wm8996_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8996->supplies),
-				 wm8996->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err_regmap;
+		goto err;
 	}
 
 	wm8996->disable_nb[0].notifier_call = wm8996_regulator_event_0;
 	wm8996->disable_nb[1].notifier_call = wm8996_regulator_event_1;
 	wm8996->disable_nb[2].notifier_call = wm8996_regulator_event_2;
 
-	wm8996->cpvdd = regulator_get(&i2c->dev, "CPVDD");
-	if (IS_ERR(wm8996->cpvdd)) {
-		ret = PTR_ERR(wm8996->cpvdd);
-		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
-		goto err_get;
-	}
-
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++) {
 		ret = regulator_register_notifier(wm8996->supplies[i].consumer,
@@ -2831,49 +2816,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8996->supplies),
-				    wm8996->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_cpvdd;
-	}
-
-	if (wm8996->pdata.ldo_ena >= 0) {
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
-		msleep(5);
-	}
-
-	ret = snd_soc_read(codec, WM8996_SOFTWARE_RESET);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read ID register: %d\n", ret);
-		goto err_enable;
-	}
-	if (ret != 0x8915) {
-		dev_err(codec->dev, "Device is not a WM8996, ID %x\n", ret);
-		ret = -EINVAL;
-		goto err_enable;
-	}
-
-	ret = snd_soc_read(codec, WM8996_CHIP_REVISION);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read device revision: %d\n",
-			ret);
-		goto err_enable;
-	}
-	
-	dev_info(codec->dev, "revision %c\n",
-		 (ret & WM8996_CHIP_REV_MASK) + 'A');
-
-	if (wm8996->pdata.ldo_ena >= 0) {
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
-	} else {
-		ret = wm8996_reset(codec);
-		if (ret < 0) {
-			dev_err(codec->dev, "Failed to issue reset\n");
-			goto err_enable;
-		}
-	}
-
 	regcache_cache_only(codec->control_data, true);
 
 	/* Apply platform data settings */
@@ -3032,8 +2974,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 				    WM8996_AIF2TX_LRCLK_MODE,
 				    WM8996_AIF2TX_LRCLK_MODE);
 
-	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-
 	wm8996_init_gpio(codec);
 
 	if (i2c->irq) {
@@ -3073,17 +3013,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_enable:
-	if (wm8996->pdata.ldo_ena >= 0)
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
-
-	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-err_cpvdd:
-	regulator_put(wm8996->cpvdd);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-err_regmap:
-	regmap_exit(codec->control_data);
 err:
 	return ret;
 }
@@ -3107,7 +3036,6 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 					      &wm8996->disable_nb[i]);
 	regulator_put(wm8996->cpvdd);
 	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
-	regmap_exit(codec->control_data);
 
 	return 0;
 }
@@ -3181,7 +3109,8 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8996_priv *wm8996;
-	int ret;
+	int ret, i;
+	unsigned int reg;
 
 	wm8996 = kzalloc(sizeof(struct wm8996_priv), GFP_KERNEL);
 	if (wm8996 == NULL)
@@ -3203,14 +3132,89 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
+		wm8996->supplies[i].supply = wm8996_supply_names[i];
+
+	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8996->supplies),
+				 wm8996->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		goto err_gpio;
+	}
+
+	wm8996->cpvdd = regulator_get(&i2c->dev, "CPVDD");
+	if (IS_ERR(wm8996->cpvdd)) {
+		ret = PTR_ERR(wm8996->cpvdd);
+		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8996->supplies),
+				    wm8996->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_cpvdd;
+	}
+
+	if (wm8996->pdata.ldo_ena > 0) {
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
+		msleep(5);
+	}
+
+	wm8996->regmap = regmap_init_i2c(i2c, &wm8996_regmap);
+	if (IS_ERR(wm8996->regmap)) {
+		ret = PTR_ERR(wm8996->regmap);
+		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
+		goto err_enable;
+	}
+
+	ret = regmap_read(wm8996->regmap, WM8996_SOFTWARE_RESET, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read ID register: %d\n", ret);
+		goto err_regmap;
+	}
+	if (reg != 0x8915) {
+		dev_err(&i2c->dev, "Device is not a WM8996, ID %x\n", ret);
+		ret = -EINVAL;
+		goto err_regmap;
+	}
+
+	ret = regmap_read(wm8996->regmap, WM8996_CHIP_REVISION, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read device revision: %d\n",
+			ret);
+		goto err_regmap;
+	}
+
+	dev_info(&i2c->dev, "revision %c\n",
+		 (reg & WM8996_CHIP_REV_MASK) + 'A');
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
+
+	ret = wm8996_reset(wm8996);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to issue reset\n");
+		goto err_regmap;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8996, wm8996_dai,
 				     ARRAY_SIZE(wm8996_dai));
 	if (ret < 0)
-		goto err_gpio;
+		goto err_regmap;
 
 	return ret;
 
+err_regmap:
+	regmap_exit(wm8996->regmap);
+err_enable:
+	if (wm8996->pdata.ldo_ena > 0)
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
+	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
+err_cpvdd:
+	regulator_put(wm8996->cpvdd);
+err_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 err_gpio:
 	if (wm8996->pdata.ldo_ena > 0)
 		gpio_free(wm8996->pdata.ldo_ena);
@@ -3225,9 +3229,14 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
-	if (wm8996->pdata.ldo_ena > 0)
+	regulator_put(wm8996->cpvdd);
+	regulator_bulk_free(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
+	regmap_exit(wm8996->regmap);
+	if (wm8996->pdata.ldo_ena > 0) {
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		gpio_free(wm8996->pdata.ldo_ena);
-	kfree(i2c_get_clientdata(client));
+	}
+	kfree(wm8996);
 	return 0;
 }
 
-- 
1.7.7.1
