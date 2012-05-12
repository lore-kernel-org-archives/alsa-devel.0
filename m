From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8731: Convert to devm_ functions
Date: Sat, 12 May 2012 20:09:44 +0100
Message-ID: <1336849784-12570-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B58B724509
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 21:09:47 +0200 (CEST)
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

Use the devm_ versions of the regmap and memory allocation functions,
saving some error handling code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |   37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index a32caa7..9d1b9b02 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -635,16 +635,17 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 	struct wm8731_priv *wm8731;
 	int ret;
 
-	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
+	wm8731 = devm_kzalloc(&spi->dev, sizeof(struct wm8731_priv),
+			      GFP_KERNEL);
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
-	wm8731->regmap = regmap_init_spi(spi, &wm8731_regmap);
+	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
 		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	spi_set_drvdata(spi, wm8731);
@@ -653,25 +654,15 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&spi->dev, "Failed to register CODEC: %d\n", ret);
-		goto err_regmap;
+		return ret;
 	}
 
 	return 0;
-
-err_regmap:
-	regmap_exit(wm8731->regmap);
-err:
-	kfree(wm8731);
-	return ret;
 }
 
 static int __devexit wm8731_spi_remove(struct spi_device *spi)
 {
-	struct wm8731_priv *wm8731 = spi_get_drvdata(spi);
-
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(wm8731->regmap);
-	kfree(wm8731);
 	return 0;
 }
 
@@ -693,16 +684,17 @@ static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
 	struct wm8731_priv *wm8731;
 	int ret;
 
-	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
+	wm8731 = devm_kzalloc(&i2c->dev, sizeof(struct wm8731_priv),
+			      GFP_KERNEL);
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
-	wm8731->regmap = regmap_init_i2c(i2c, &wm8731_regmap);
+	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	i2c_set_clientdata(i2c, wm8731);
@@ -711,24 +703,15 @@ static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err_regmap;
+		return ret;
 	}
 
 	return 0;
-
-err_regmap:
-	regmap_exit(wm8731->regmap);
-err:
-	kfree(wm8731);
-	return ret;
 }
 
 static __devexit int wm8731_i2c_remove(struct i2c_client *client)
 {
-	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8731->regmap);
-	kfree(wm8731);
 	return 0;
 }
 
-- 
1.7.10
