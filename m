From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: wm8904: Move regulator acquisition
	and device identification to I2C
Date: Mon, 11 Jun 2012 13:10:46 +0800
Message-ID: <1339391447-8721-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6721F1041E1
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:11:39 +0200 (CEST)
In-Reply-To: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

It's more idiomatic to have the resource allocation at this level.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |  112 +++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 61 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index ecab871..b178232 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -314,11 +314,6 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8904_reset(struct snd_soc_codec *codec)
-{
-	return snd_soc_write(codec, WM8904_SW_RESET_AND_ID, 0);
-}
-
 static int wm8904_configure_clocking(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
@@ -2082,52 +2077,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8904->supplies); i++)
-		wm8904->supplies[i].supply = wm8904_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8904->supplies),
-				 wm8904->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8904->supplies),
-				    wm8904->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	ret = snd_soc_read(codec, WM8904_SW_RESET_AND_ID);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read ID register\n");
-		goto err_enable;
-	}
-	if (ret != 0x8904) {
-		dev_err(codec->dev, "Device is not a WM8904, ID is %x\n", ret);
-		ret = -EINVAL;
-		goto err_enable;
-	}
-
-	ret = snd_soc_read(codec, WM8904_REVISION);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read device revision: %d\n",
-			ret);
-		goto err_enable;
-	}
-	dev_info(codec->dev, "revision %c\n", ret + 'A');
-
-	ret = wm8904_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_enable;
-	}
-
-	/* Can leave the device powered off until we need it */
-	regcache_cache_only(wm8904->regmap, true);
-	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-
 	/* Change some default settings - latch VU and enable ZC */
 	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_LEFT,
 			    WM8904_ADC_VU, WM8904_ADC_VU);
@@ -2187,19 +2136,12 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	wm8904_add_widgets(codec);
 
 	return 0;
-
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-	return ret;
 }
 
 static int wm8904_remove(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
-	regulator_bulk_free(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 	kfree(wm8904->retune_mobile_texts);
 	kfree(wm8904->drc_texts);
 
@@ -2230,7 +2172,8 @@ static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8904_priv *wm8904;
-	int ret;
+	unsigned int val;
+	int ret, i;
 
 	wm8904 = devm_kzalloc(&i2c->dev, sizeof(struct wm8904_priv),
 			      GFP_KERNEL);
@@ -2249,14 +2192,61 @@ static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, wm8904);
 	wm8904->pdata = i2c->dev.platform_data;
 
+	for (i = 0; i < ARRAY_SIZE(wm8904->supplies); i++)
+		wm8904->supplies[i].supply = wm8904_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8904->supplies),
+				      wm8904->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8904->supplies),
+				    wm8904->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(wm8904->regmap, WM8904_SW_RESET_AND_ID, &val);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read ID register: %d\n", ret);
+		goto err_enable;
+	}
+	if (val != 0x8904) {
+		dev_err(&i2c->dev, "Device is not a WM8904, ID is %x\n", val);
+		ret = -EINVAL;
+		goto err_enable;
+	}
+
+	ret = regmap_read(wm8904->regmap, WM8904_REVISION, &val);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read device revision: %d\n",
+			ret);
+		goto err_enable;
+	}
+	dev_info(&i2c->dev, "revision %c\n", val + 'A');
+
+	ret = regmap_write(wm8904->regmap, WM8904_SW_RESET_AND_ID, 0);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
+		goto err_enable;
+	}
+
+	/* Can leave the device powered off until we need it */
+	regcache_cache_only(wm8904->regmap, true);
+	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8904, &wm8904_dai, 1);
 	if (ret != 0)
-		goto err;
+		return ret;
 
 	return 0;
 
-err:
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 	return ret;
 }
 
-- 
1.7.10
