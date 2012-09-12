From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8737: Move regulator acquisition
	to device registration
Date: Wed, 12 Sep 2012 12:59:09 +0800
Message-ID: <1347425950-17097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 403EB261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 07:06:40 +0200 (CEST)
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

This is better style as we acquire resources we will need before we go into
the ASoC card probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8737.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 8c25442..3bf5bc7 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -557,7 +557,7 @@ static int wm8737_resume(struct snd_soc_codec *codec)
 static int wm8737_probe(struct snd_soc_codec *codec)
 {
 	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
-	int ret, i;
+	int ret;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8737->control_type);
 	if (ret != 0) {
@@ -565,16 +565,6 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8737->supplies); i++)
-		wm8737->supplies[i].supply = wm8737_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8737->supplies),
-				 wm8737->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8737->supplies),
 				    wm8737->supplies);
 	if (ret != 0) {
@@ -607,17 +597,12 @@ static int wm8737_probe(struct snd_soc_codec *codec)
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
 err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
-
 	return ret;
 }
 
 static int wm8737_remove(struct snd_soc_codec *codec)
 {
-	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
-
 	wm8737_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(wm8737->supplies), wm8737->supplies);
 	return 0;
 }
 
@@ -645,13 +630,23 @@ static __devinit int wm8737_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8737_priv *wm8737;
-	int ret;
+	int ret, i;
 
 	wm8737 = devm_kzalloc(&i2c->dev, sizeof(struct wm8737_priv),
 			      GFP_KERNEL);
 	if (wm8737 == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8737->supplies); i++)
+		wm8737->supplies[i].supply = wm8737_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8737->supplies),
+				      wm8737->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8737);
 	wm8737->control_type = SND_SOC_I2C;
 
@@ -691,13 +686,23 @@ static struct i2c_driver wm8737_i2c_driver = {
 static int __devinit wm8737_spi_probe(struct spi_device *spi)
 {
 	struct wm8737_priv *wm8737;
-	int ret;
+	int ret, i;
 
 	wm8737 = devm_kzalloc(&spi->dev, sizeof(struct wm8737_priv),
 			      GFP_KERNEL);
 	if (wm8737 == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8737->supplies); i++)
+		wm8737->supplies[i].supply = wm8737_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(wm8737->supplies),
+				      wm8737->supplies);
+	if (ret != 0) {
+		dev_err(&spi->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	wm8737->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8737);
 
-- 
1.7.10.4
