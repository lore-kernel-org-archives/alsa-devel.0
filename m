From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Move most WM5100 resource allocation
	to I2C probe
Date: Wed,  9 Nov 2011 16:31:54 +0000
Message-ID: <1320856314-23012-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320856314-23012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52310243A2
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 17:31:58 +0100 (CET)
In-Reply-To: <1320856314-23012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

More standard Linuxish.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  263 ++++++++++++++++++++++-----------------------
 1 files changed, 131 insertions(+), 132 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 01959e1..77ffde0 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -205,17 +205,15 @@ static void wm5100_free_sr(struct snd_soc_codec *codec, int rate)
 	}
 }
 
-static int wm5100_reset(struct snd_soc_codec *codec)
+static int wm5100_reset(struct wm5100_priv *wm5100)
 {
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-
 	if (wm5100->pdata.reset) {
 		gpio_set_value_cansleep(wm5100->pdata.reset, 0);
 		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
 
 		return 0;
 	} else {
-		return snd_soc_write(codec, WM5100_SOFTWARE_RESET, 0);
+		return regmap_write(wm5100->regmap, WM5100_SOFTWARE_RESET, 0);
 	}
 }
 
@@ -2466,98 +2464,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm5100->core_supplies); i++)
-		wm5100->core_supplies[i].supply = wm5100_core_supply_names[i];
-
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm5100->core_supplies),
-				 wm5100->core_supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request core supplies: %d\n",
-			ret);
-		return ret;
-	}
-
-	wm5100->cpvdd = regulator_get(&i2c->dev, "CPVDD");
-	if (IS_ERR(wm5100->cpvdd)) {
-		ret = PTR_ERR(wm5100->cpvdd);
-		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
-		goto err_core;
-	}
-
-	wm5100->dbvdd2 = regulator_get(&i2c->dev, "DBVDD2");
-	if (IS_ERR(wm5100->dbvdd2)) {
-		ret = PTR_ERR(wm5100->dbvdd2);
-		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
-		goto err_cpvdd;
-	}
-
-	wm5100->dbvdd3 = regulator_get(&i2c->dev, "DBVDD3");
-	if (IS_ERR(wm5100->dbvdd3)) {
-		ret = PTR_ERR(wm5100->dbvdd3);
-		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
-		goto err_dbvdd2;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
-				    wm5100->core_supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable core supplies: %d\n",
-			ret);
-		goto err_dbvdd3;
-	}
-
-	if (wm5100->pdata.ldo_ena) {
-		ret = gpio_request_one(wm5100->pdata.ldo_ena,
-				       GPIOF_OUT_INIT_HIGH, "WM5100 LDOENA");
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to request LDOENA %d: %d\n",
-				wm5100->pdata.ldo_ena, ret);
-			goto err_enable;
-		}
-		msleep(2);
-	}
-
-	if (wm5100->pdata.reset) {
-		ret = gpio_request_one(wm5100->pdata.reset,
-				       GPIOF_OUT_INIT_HIGH, "WM5100 /RESET");
-		if (ret < 0) {
-			dev_err(&i2c->dev, "Failed to request /RESET %d: %d\n",
-				wm5100->pdata.reset, ret);
-			goto err_ldo;
-		}
-	}
-
-	ret = snd_soc_read(codec, WM5100_SOFTWARE_RESET);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read ID register\n");
-		goto err_reset;
-	}
-	switch (ret) {
-	case 0x8997:
-	case 0x5100:
-		break;
-
-	default:
-		dev_err(codec->dev, "Device is not a WM5100, ID is %x\n", ret);
-		ret = -EINVAL;
-		goto err_reset;
-	}
-
-	ret = snd_soc_read(codec, WM5100_DEVICE_REVISION);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read revision register\n");
-		goto err_reset;
-	}
-	wm5100->rev = ret & WM5100_DEVICE_REVISION_MASK;
-
-	dev_info(codec->dev, "revision %c\n", wm5100->rev + 'A');
-
-	ret = wm5100_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_reset;
-	}
-
 	regcache_cache_only(wm5100->regmap, true);
 
 	wm5100_init_gpio(codec);
@@ -2669,28 +2575,6 @@ err_gpio:
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 	wm5100_free_gpio(codec);
-err_reset:
-	if (wm5100->pdata.reset) {
-		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
-		gpio_free(wm5100->pdata.reset);
-	}
-err_ldo:
-	if (wm5100->pdata.ldo_ena) {
-		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
-		gpio_free(wm5100->pdata.ldo_ena);
-	}
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
-			       wm5100->core_supplies);
-err_dbvdd3:
-	regulator_put(wm5100->dbvdd3);
-err_dbvdd2:
-	regulator_put(wm5100->dbvdd2);
-err_cpvdd:
-	regulator_put(wm5100->cpvdd);
-err_core:
-	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
-			    wm5100->core_supplies);
 
 	return ret;
 }
@@ -2707,19 +2591,6 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 	wm5100_free_gpio(codec);
-	if (wm5100->pdata.reset) {
-		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
-		gpio_free(wm5100->pdata.reset);
-	}
-	if (wm5100->pdata.ldo_ena) {
-		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
-		gpio_free(wm5100->pdata.ldo_ena);
-	}
-	regulator_put(wm5100->dbvdd3);
-	regulator_put(wm5100->dbvdd2);
-	regulator_put(wm5100->cpvdd);
-	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
-			    wm5100->core_supplies);
 	return 0;
 }
 
@@ -2758,6 +2629,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 {
 	struct wm5100_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm5100_priv *wm5100;
+	unsigned int reg;
 	int ret, i;
 
 	wm5100 = kzalloc(sizeof(struct wm5100_priv), GFP_KERNEL);
@@ -2780,16 +2652,130 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm5100);
 
+	for (i = 0; i < ARRAY_SIZE(wm5100->core_supplies); i++)
+		wm5100->core_supplies[i].supply = wm5100_core_supply_names[i];
+
+	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm5100->core_supplies),
+				 wm5100->core_supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request core supplies: %d\n",
+			ret);
+		goto err_regmap;
+	}
+
+	wm5100->cpvdd = regulator_get(&i2c->dev, "CPVDD");
+	if (IS_ERR(wm5100->cpvdd)) {
+		ret = PTR_ERR(wm5100->cpvdd);
+		dev_err(&i2c->dev, "Failed to get CPVDD: %d\n", ret);
+		goto err_core;
+	}
+
+	wm5100->dbvdd2 = regulator_get(&i2c->dev, "DBVDD2");
+	if (IS_ERR(wm5100->dbvdd2)) {
+		ret = PTR_ERR(wm5100->dbvdd2);
+		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
+		goto err_cpvdd;
+	}
+
+	wm5100->dbvdd3 = regulator_get(&i2c->dev, "DBVDD3");
+	if (IS_ERR(wm5100->dbvdd3)) {
+		ret = PTR_ERR(wm5100->dbvdd3);
+		dev_err(&i2c->dev, "Failed to get DBVDD2: %d\n", ret);
+		goto err_dbvdd2;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
+				    wm5100->core_supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable core supplies: %d\n",
+			ret);
+		goto err_dbvdd3;
+	}
+
+	if (wm5100->pdata.ldo_ena) {
+		ret = gpio_request_one(wm5100->pdata.ldo_ena,
+				       GPIOF_OUT_INIT_HIGH, "WM5100 LDOENA");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request LDOENA %d: %d\n",
+				wm5100->pdata.ldo_ena, ret);
+			goto err_enable;
+		}
+		msleep(2);
+	}
+
+	if (wm5100->pdata.reset) {
+		ret = gpio_request_one(wm5100->pdata.reset,
+				       GPIOF_OUT_INIT_HIGH, "WM5100 /RESET");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request /RESET %d: %d\n",
+				wm5100->pdata.reset, ret);
+			goto err_ldo;
+		}
+	}
+
+	ret = regmap_read(wm5100->regmap, WM5100_SOFTWARE_RESET, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read ID register\n");
+		goto err_reset;
+	}
+	switch (reg) {
+	case 0x8997:
+	case 0x5100:
+		break;
+
+	default:
+		dev_err(&i2c->dev, "Device is not a WM5100, ID is %x\n", reg);
+		ret = -EINVAL;
+		goto err_reset;
+	}
+
+	ret = regmap_read(wm5100->regmap, WM5100_DEVICE_REVISION, &reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read revision register\n");
+		goto err_reset;
+	}
+	wm5100->rev = reg & WM5100_DEVICE_REVISION_MASK;
+
+	dev_info(&i2c->dev, "revision %c\n", wm5100->rev + 'A');
+
+	ret = wm5100_reset(wm5100);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to issue reset\n");
+		goto err_reset;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to register WM5100: %d\n", ret);
-		goto err_regmap;
+		goto err_reset;
 	}
 
 	return ret;
 
+err_reset:
+	if (wm5100->pdata.reset) {
+		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
+		gpio_free(wm5100->pdata.reset);
+	}
+err_ldo:
+	if (wm5100->pdata.ldo_ena) {
+		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
+		gpio_free(wm5100->pdata.ldo_ena);
+	}
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
+			       wm5100->core_supplies);
+err_dbvdd3:
+	regulator_put(wm5100->dbvdd3);
+err_dbvdd2:
+	regulator_put(wm5100->dbvdd2);
+err_cpvdd:
+	regulator_put(wm5100->cpvdd);
+err_core:
+	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
+			    wm5100->core_supplies);
 err_regmap:
 	regmap_exit(wm5100->regmap);
 err_alloc:
@@ -2802,6 +2788,19 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *client)
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
+	if (wm5100->pdata.reset) {
+		gpio_set_value_cansleep(wm5100->pdata.reset, 1);
+		gpio_free(wm5100->pdata.reset);
+	}
+	if (wm5100->pdata.ldo_ena) {
+		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
+		gpio_free(wm5100->pdata.ldo_ena);
+	}
+	regulator_put(wm5100->dbvdd3);
+	regulator_put(wm5100->dbvdd2);
+	regulator_put(wm5100->cpvdd);
+	regulator_bulk_free(ARRAY_SIZE(wm5100->core_supplies),
+			    wm5100->core_supplies);
 	regmap_exit(wm5100->regmap);
 	kfree(wm5100);
 
-- 
1.7.7.2
