From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 08/10] ASoC: wm8985: Convert to use devm_regmap_init_{spi,i2c}()
Date: Thu, 22 Nov 2012 09:38:40 +0530
Message-ID: <1353557322-25353-9-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/wm8985.c |   30 ++++--------------------------
 1 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 14f6663..7b3f409 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1122,33 +1122,22 @@ static int __devinit wm8985_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8985);
 
-	wm8985->regmap = regmap_init_spi(spi, &wm8985_regmap);
+	wm8985->regmap = devm_regmap_init_spi(spi, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
 		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
-	if (ret != 0)
-		goto err;
-
-	return 0;
-
-err:
-	regmap_exit(wm8985->regmap);
 	return ret;
 }
 
 static int __devexit wm8985_spi_remove(struct spi_device *spi)
 {
-	struct wm8985_priv *wm8985 = spi_get_drvdata(spi);
-
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(wm8985->regmap);
-
 	return 0;
 }
 
@@ -1175,33 +1164,22 @@ static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8985);
 
-	wm8985->regmap = regmap_init_i2c(i2c, &wm8985_regmap);
+	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
-	if (ret != 0)
-		goto err;
-
-	return 0;
-
-err:
-	regmap_exit(wm8985->regmap);
 	return ret;
 }
 
 static __devexit int wm8985_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm8985_priv *wm8985 = i2c_get_clientdata(i2c);
-
 	snd_soc_unregister_codec(&i2c->dev);
-	regmap_exit(wm8985->regmap);
-
 	return 0;
 }
 
-- 
1.7.4.1
