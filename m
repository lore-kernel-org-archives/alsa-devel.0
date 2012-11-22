From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 07/10] ASoC: wm8804: Convert to use devm_regmap_init_{spi,i2c}()
Date: Thu, 22 Nov 2012 09:38:39 +0530
Message-ID: <1353557322-25353-8-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/wm8804.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index c088020..837bfb5 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -711,7 +711,7 @@ static int __devinit wm8804_spi_probe(struct spi_device *spi)
 	if (!wm8804)
 		return -ENOMEM;
 
-	wm8804->regmap = regmap_init_spi(spi, &wm8804_regmap_config);
+	wm8804->regmap = devm_regmap_init_spi(spi, &wm8804_regmap_config);
 	if (IS_ERR(wm8804->regmap)) {
 		ret = PTR_ERR(wm8804->regmap);
 		return ret;
@@ -727,9 +727,7 @@ static int __devinit wm8804_spi_probe(struct spi_device *spi)
 
 static int __devexit wm8804_spi_remove(struct spi_device *spi)
 {
-	struct wm8804_priv *wm8804 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(wm8804->regmap);
 	return 0;
 }
 
@@ -755,7 +753,7 @@ static __devinit int wm8804_i2c_probe(struct i2c_client *i2c,
 	if (!wm8804)
 		return -ENOMEM;
 
-	wm8804->regmap = regmap_init_i2c(i2c, &wm8804_regmap_config);
+	wm8804->regmap = devm_regmap_init_i2c(i2c, &wm8804_regmap_config);
 	if (IS_ERR(wm8804->regmap)) {
 		ret = PTR_ERR(wm8804->regmap);
 		return ret;
@@ -765,23 +763,12 @@ static __devinit int wm8804_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8804, &wm8804_dai, 1);
-	if (ret != 0)
-		goto err;
-
-	return 0;
-
-err:
-	regmap_exit(wm8804->regmap);
 	return ret;
 }
 
 static __devexit int wm8804_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm8804_priv *wm8804 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
-	regmap_exit(wm8804->regmap);
-
 	return 0;
 }
 
-- 
1.7.4.1
