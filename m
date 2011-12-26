From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 03/10] ASoC: Convert ad193x to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:51:16 +0800
Message-ID: <1324903876.26543.4.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B1601103888
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:51:23 +0100 (CET)
Received: by iaae16 with SMTP id e16so18095190iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:51:23 -0800 (PST)
In-Reply-To: <1324903728.26543.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ad193x.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index c1b7d92..a4a6bef 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -385,14 +385,15 @@ static int __devinit ad193x_spi_probe(struct spi_device *spi)
 	struct ad193x_priv *ad193x;
 	int ret;
 
-	ad193x = kzalloc(sizeof(struct ad193x_priv), GFP_KERNEL);
+	ad193x = devm_kzalloc(&spi->dev, sizeof(struct ad193x_priv),
+			      GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
 	ad193x->regmap = regmap_init_spi(spi, &ad193x_spi_regmap_config);
 	if (IS_ERR(ad193x->regmap)) {
 		ret = PTR_ERR(ad193x->regmap);
-		goto err_free;
+		goto err_out;
 	}
 
 	spi_set_drvdata(spi, ad193x);
@@ -406,9 +407,7 @@ static int __devinit ad193x_spi_probe(struct spi_device *spi)
 
 err_regmap_exit:
 	regmap_exit(ad193x->regmap);
-err_free:
-	kfree(ad193x);
-
+err_out:
 	return ret;
 }
 
@@ -418,7 +417,6 @@ static int __devexit ad193x_spi_remove(struct spi_device *spi)
 
 	snd_soc_unregister_codec(&spi->dev);
 	regmap_exit(ad193x->regmap);
-	kfree(ad193x);
 	return 0;
 }
 
@@ -455,14 +453,15 @@ static int __devinit ad193x_i2c_probe(struct i2c_client *client,
 	struct ad193x_priv *ad193x;
 	int ret;
 
-	ad193x = kzalloc(sizeof(struct ad193x_priv), GFP_KERNEL);
+	ad193x = devm_kzalloc(&client->dev, sizeof(struct ad193x_priv),
+			      GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
 	ad193x->regmap = regmap_init_i2c(client, &ad193x_i2c_regmap_config);
 	if (IS_ERR(ad193x->regmap)) {
 		ret = PTR_ERR(ad193x->regmap);
-		goto err_free;
+		goto err_out;
 	}
 
 	i2c_set_clientdata(client, ad193x);
@@ -476,8 +475,7 @@ static int __devinit ad193x_i2c_probe(struct i2c_client *client,
 
 err_regmap_exit:
 	regmap_exit(ad193x->regmap);
-err_free:
-	kfree(ad193x);
+err_out:
 	return ret;
 }
 
@@ -487,7 +485,6 @@ static int __devexit ad193x_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(ad193x->regmap);
-	kfree(ad193x);
 	return 0;
 }
 
-- 
1.7.5.4
