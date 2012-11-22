From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 04/10] ASoC: ak4104: Convert to use devm_regmap_init_spi()
Date: Thu, 22 Nov 2012 09:38:36 +0530
Message-ID: <1353557322-25353-5-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/ak4104.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index eec086b..4b11b82 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -222,7 +222,7 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	if (ak4104 == NULL)
 		return -ENOMEM;
 
-	ak4104->regmap = regmap_init_spi(spi, &ak4104_regmap);
+	ak4104->regmap = devm_regmap_init_spi(spi, &ak4104_regmap);
 	if (IS_ERR(ak4104->regmap)) {
 		ret = PTR_ERR(ak4104->regmap);
 		return ret;
@@ -247,30 +247,19 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	 * the device, but there is no hardware ID register. */
 	ret = regmap_read(ak4104->regmap, AK4104_REG_RESERVED, &val);
 	if (ret != 0)
-		goto err;
-	if (val != AK4104_RESERVED_VAL) {
-		ret = -ENODEV;
-		goto err;
-	}
+		return ret;
+	if (val != AK4104_RESERVED_VAL)
+		return -ENODEV;
 
 	spi_set_drvdata(spi, ak4104);
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_device_ak4104, &ak4104_dai, 1);
-	if (ret != 0)
-		goto err;
-
-	return 0;
-
-err:
-	regmap_exit(ak4104->regmap);
 	return ret;
 }
 
 static int __devexit ak4104_spi_remove(struct spi_device *spi)
 {
-	struct ak4104_private *ak4101 = spi_get_drvdata(spi);
-	regmap_exit(ak4101->regmap);
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
-- 
1.7.4.1
