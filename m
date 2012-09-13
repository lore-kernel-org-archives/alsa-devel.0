From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ad193x: Use managed regmap init
Date: Thu, 13 Sep 2012 12:03:23 +0200
Message-ID: <1347530603-13957-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 6013726257D
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 12:02:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |   50 +++++++++------------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 13e62be..2f75266 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -381,40 +381,25 @@ static const struct regmap_config ad193x_spi_regmap_config = {
 static int __devinit ad193x_spi_probe(struct spi_device *spi)
 {
 	struct ad193x_priv *ad193x;
-	int ret;
 
 	ad193x = devm_kzalloc(&spi->dev, sizeof(struct ad193x_priv),
 			      GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
-	ad193x->regmap = regmap_init_spi(spi, &ad193x_spi_regmap_config);
-	if (IS_ERR(ad193x->regmap)) {
-		ret = PTR_ERR(ad193x->regmap);
-		goto err_out;
-	}
+	ad193x->regmap = devm_regmap_init_spi(spi, &ad193x_spi_regmap_config);
+	if (IS_ERR(ad193x->regmap))
+		return PTR_ERR(ad193x->regmap);
 
 	spi_set_drvdata(spi, ad193x);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_ad193x, &ad193x_dai, 1);
-	if (ret < 0)
-		goto err_regmap_exit;
-
-	return 0;
-
-err_regmap_exit:
-	regmap_exit(ad193x->regmap);
-err_out:
-	return ret;
+	return snd_soc_register_codec(&spi->dev, &soc_codec_dev_ad193x,
+			&ad193x_dai, 1);
 }
 
 static int __devexit ad193x_spi_remove(struct spi_device *spi)
 {
-	struct ad193x_priv *ad193x = spi_get_drvdata(spi);
-
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(ad193x->regmap);
 	return 0;
 }
 
@@ -449,40 +434,25 @@ static int __devinit ad193x_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ad193x_priv *ad193x;
-	int ret;
 
 	ad193x = devm_kzalloc(&client->dev, sizeof(struct ad193x_priv),
 			      GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
-	ad193x->regmap = regmap_init_i2c(client, &ad193x_i2c_regmap_config);
-	if (IS_ERR(ad193x->regmap)) {
-		ret = PTR_ERR(ad193x->regmap);
-		goto err_out;
-	}
+	ad193x->regmap = devm_regmap_init_i2c(client, &ad193x_i2c_regmap_config);
+	if (IS_ERR(ad193x->regmap))
+		return PTR_ERR(ad193x->regmap);
 
 	i2c_set_clientdata(client, ad193x);
 
-	ret =  snd_soc_register_codec(&client->dev,
-			&soc_codec_dev_ad193x, &ad193x_dai, 1);
-	if (ret < 0)
-		goto err_regmap_exit;
-
-	return 0;
-
-err_regmap_exit:
-	regmap_exit(ad193x->regmap);
-err_out:
-	return ret;
+	return snd_soc_register_codec(&client->dev, &soc_codec_dev_ad193x,
+			&ad193x_dai, 1);
 }
 
 static int __devexit ad193x_i2c_remove(struct i2c_client *client)
 {
-	struct ad193x_priv *ad193x = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(ad193x->regmap);
 	return 0;
 }
 
-- 
1.7.10.4
