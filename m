From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Move WM8993 resource acquisition and
	device reset to bus probe
Date: Wed, 14 Dec 2011 17:00:54 +0800
Message-ID: <1323853254-9020-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9207243B5
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 10:01:08 +0100 (CET)
In-Reply-To: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8993.c |   89 +++++++++++++++++++++++++--------------------
 1 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index daf8296..592f18e 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1505,7 +1505,7 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret, i, val;
+	int ret;
 
 	wm8993->hubs_data.hp_startup_mode = 1;
 	wm8993->hubs_data.dcs_codes_l = -2;
@@ -1519,36 +1519,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8993->supplies); i++)
-		wm8993->supplies[i].supply = wm8993_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8993->supplies),
-				 wm8993->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
-				    wm8993->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	val = snd_soc_read(codec, WM8993_SOFTWARE_RESET);
-	if (val != 0x8993) {
-		dev_err(codec->dev, "Invalid ID register value %x\n", val);
-		ret = -EINVAL;
-		goto err_enable;
-	}
-
-	ret = snd_soc_write(codec, WM8993_SOFTWARE_RESET, 0xffff);
-	if (ret != 0)
-		goto err_enable;
-
-	regcache_cache_only(wm8993->regmap, true);
-
 	/* By default we're using the output mixers */
 	wm8993->class_w_users = 2;
 
@@ -1577,7 +1547,7 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 
 	ret = wm8993_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	if (ret != 0)
-		goto err_enable;
+		return ret;
 
 	snd_soc_add_controls(codec, wm8993_snd_controls,
 			     ARRAY_SIZE(wm8993_snd_controls));
@@ -1599,11 +1569,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-	return ret;
 }
 
 static int wm8993_remove(struct snd_soc_codec *codec)
@@ -1692,7 +1657,8 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8993_priv *wm8993;
-	int ret;
+	unsigned int reg;
+	int ret, i;
 
 	wm8993 = devm_kzalloc(&i2c->dev, sizeof(struct wm8993_priv),
 			      GFP_KERNEL);
@@ -1708,15 +1674,56 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8993);
 
+	for (i = 0; i < ARRAY_SIZE(wm8993->supplies); i++)
+		wm8993->supplies[i].supply = wm8993_supply_names[i];
+
+	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8993->supplies),
+				 wm8993->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		goto err;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
+				    wm8993->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_get;
+	}
+
+	ret = regmap_read(wm8993->regmap, WM8993_SOFTWARE_RESET, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
+		goto err_enable;
+	}
+
+	if (reg != 0x8993) {
+		dev_err(&i2c->dev, "Invalid ID register value %x\n", reg);
+		ret = -EINVAL;
+		goto err_enable;
+	}
+
+	ret = regmap_write(wm8993->regmap, WM8993_SOFTWARE_RESET, 0xffff);
+	if (ret != 0)
+		goto err_enable;
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
+
+	regcache_cache_only(wm8993->regmap, true);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8993, &wm8993_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err;
+		goto err_enable;
 	}
 
-	return ret;
+	return 0;
 
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
+err_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 err:
 	regmap_exit(wm8993->regmap);
 	return ret;
@@ -1728,6 +1735,8 @@ static __devexit int wm8993_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(wm8993->regmap);
+	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
+	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 
 	return 0;
 }
-- 
1.7.7.3
