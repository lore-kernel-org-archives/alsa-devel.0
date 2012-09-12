From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: wm8711: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:32:56 +0800
Message-ID: <1347413580-11137-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2B252615F0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:33:36 +0200 (CEST)
In-Reply-To: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8711.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 0b76d1d..1b1209a 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -414,7 +414,8 @@ static int __devinit wm8711_spi_probe(struct spi_device *spi)
 	struct wm8711_priv *wm8711;
 	int ret;
 
-	wm8711 = kzalloc(sizeof(struct wm8711_priv), GFP_KERNEL);
+	wm8711 = devm_kzalloc(&spi->dev, sizeof(struct wm8711_priv),
+			      GFP_KERNEL);
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
@@ -423,15 +424,14 @@ static int __devinit wm8711_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8711, &wm8711_dai, 1);
-	if (ret < 0)
-		kfree(wm8711);
+
 	return ret;
 }
 
 static int __devexit wm8711_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
+
 	return 0;
 }
 
@@ -453,7 +453,8 @@ static __devinit int wm8711_i2c_probe(struct i2c_client *client,
 	struct wm8711_priv *wm8711;
 	int ret;
 
-	wm8711 = kzalloc(sizeof(struct wm8711_priv), GFP_KERNEL);
+	wm8711 = devm_kzalloc(&client->dev, sizeof(struct wm8711_priv),
+			      GFP_KERNEL);
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
@@ -462,15 +463,13 @@ static __devinit int wm8711_i2c_probe(struct i2c_client *client,
 
 	ret =  snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_wm8711, &wm8711_dai, 1);
-	if (ret < 0)
-		kfree(wm8711);
+
 	return ret;
 }
 
 static __devexit int wm8711_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
