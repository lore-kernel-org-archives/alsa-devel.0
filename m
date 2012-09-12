From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8580: Move regulator acquisition
	to I2C probe
Date: Wed, 12 Sep 2012 12:05:32 +0800
Message-ID: <1347422732-5162-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347422732-5162-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64322261657
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 06:05:40 +0200 (CEST)
In-Reply-To: <1347422732-5162-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Better style as we get all the resources we need prior to starting the
ASoC level probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 2a07c70..a27f8fb 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -857,7 +857,7 @@ static struct snd_soc_dai_driver wm8580_dai[] = {
 static int wm8580_probe(struct snd_soc_codec *codec)
 {
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0,i;
+	int ret = 0;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
@@ -865,16 +865,6 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8580->supplies); i++)
-		wm8580->supplies[i].supply = wm8580_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8580->supplies),
-				 wm8580->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8580->supplies),
 				    wm8580->supplies);
 	if (ret != 0) {
@@ -896,7 +886,6 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 err_regulator_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 err_regulator_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 	return ret;
 }
 
@@ -908,7 +897,6 @@ static int wm8580_remove(struct snd_soc_codec *codec)
 	wm8580_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
-	regulator_bulk_free(ARRAY_SIZE(wm8580->supplies), wm8580->supplies);
 
 	return 0;
 }
@@ -946,7 +934,7 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8580_priv *wm8580;
-	int ret;
+	int ret, i;
 
 	wm8580 = devm_kzalloc(&i2c->dev, sizeof(struct wm8580_priv),
 			      GFP_KERNEL);
@@ -957,6 +945,16 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8580->regmap))
 		return PTR_ERR(wm8580->regmap);
 
+	for (i = 0; i < ARRAY_SIZE(wm8580->supplies); i++)
+		wm8580->supplies[i].supply = wm8580_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8580->supplies),
+				      wm8580->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8580);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
