From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 09/10] ASoC: wm8988: Convert to use devm_regmap_init_{spi,i2c}()
Date: Thu, 22 Nov 2012 09:38:41 +0530
Message-ID: <1353557322-25353-10-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/wm8988.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 1d4c5cf..715788d 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -882,7 +882,7 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
-	wm8988->regmap = regmap_init_spi(spi, &wm8988_regmap);
+	wm8988->regmap = devm_regmap_init_spi(spi, &wm8988_regmap);
 	if (IS_ERR(wm8988->regmap)) {
 		ret = PTR_ERR(wm8988->regmap);
 		dev_err(&spi->dev, "Failed to init regmap: %d\n", ret);
@@ -893,17 +893,12 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
-	if (ret != 0)
-		regmap_exit(wm8988->regmap);
-
 	return ret;
 }
 
 static int __devexit wm8988_spi_remove(struct spi_device *spi)
 {
-	struct wm8988_priv *wm8988 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(wm8988->regmap);
 	return 0;
 }
 
@@ -931,7 +926,7 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8988);
 
-	wm8988->regmap = regmap_init_i2c(i2c, &wm8988_regmap);
+	wm8988->regmap = devm_regmap_init_i2c(i2c, &wm8988_regmap);
 	if (IS_ERR(wm8988->regmap)) {
 		ret = PTR_ERR(wm8988->regmap);
 		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
@@ -940,17 +935,12 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
-	if (ret != 0)
-		regmap_exit(wm8988->regmap);
-
 	return ret;
 }
 
 static __devexit int wm8988_i2c_remove(struct i2c_client *client)
 {
-	struct wm8988_priv *wm8988 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8988->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
