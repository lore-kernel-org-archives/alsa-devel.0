From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Convert WM8776 to devm_kzalloc()
Date: Fri,  9 Dec 2011 20:27:17 +0800
Message-ID: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D2E824346
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 13:27:27 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8776.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index fbf80c5..38b4556 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -452,7 +452,8 @@ static int __devinit wm8776_spi_probe(struct spi_device *spi)
 	struct wm8776_priv *wm8776;
 	int ret;
 
-	wm8776 = kzalloc(sizeof(struct wm8776_priv), GFP_KERNEL);
+	wm8776 = devm_kzalloc(&spi->dev, sizeof(struct wm8776_priv),
+			      GFP_KERNEL);
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
@@ -461,15 +462,13 @@ static int __devinit wm8776_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
-	if (ret < 0)
-		kfree(wm8776);
+
 	return ret;
 }
 
 static int __devexit wm8776_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -491,7 +490,8 @@ static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
 	struct wm8776_priv *wm8776;
 	int ret;
 
-	wm8776 = kzalloc(sizeof(struct wm8776_priv), GFP_KERNEL);
+	wm8776 = devm_kzalloc(&i2c->dev, sizeof(struct wm8776_priv),
+			      GFP_KERNEL);
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
@@ -500,15 +500,13 @@ static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
-	if (ret < 0)
-		kfree(wm8776);
+
 	return ret;
 }
 
 static __devexit int wm8776_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
