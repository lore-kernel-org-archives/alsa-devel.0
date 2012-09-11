From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm8900: Convert to devm_kzalloc()
Date: Tue, 11 Sep 2012 09:27:11 +0800
Message-ID: <1347326833-2019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4F04264F09
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 03:36:40 +0200 (CEST)
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
 sound/soc/codecs/wm8900.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 077c962..5f7a78e 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1226,7 +1226,8 @@ static int __devinit wm8900_spi_probe(struct spi_device *spi)
 	struct wm8900_priv *wm8900;
 	int ret;
 
-	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
+	wm8900 = devm_kzalloc(&spi->dev, sizeof(struct wm8900_priv),
+			      GFP_KERNEL);
 	if (wm8900 == NULL)
 		return -ENOMEM;
 
@@ -1235,15 +1236,13 @@ static int __devinit wm8900_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8900, &wm8900_dai, 1);
-	if (ret < 0)
-		kfree(wm8900);
+
 	return ret;
 }
 
 static int __devexit wm8900_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -1264,7 +1263,8 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 	struct wm8900_priv *wm8900;
 	int ret;
 
-	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
+	wm8900 = devm_kzalloc(&i2c->dev, sizeof(struct wm8900_priv),
+			      GFP_KERNEL);
 	if (wm8900 == NULL)
 		return -ENOMEM;
 
@@ -1273,15 +1273,13 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8900, &wm8900_dai, 1);
-	if (ret < 0)
-		kfree(wm8900);
+
 	return ret;
 }
 
 static __devexit int wm8900_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
