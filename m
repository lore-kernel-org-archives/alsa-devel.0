From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: wm8985: Convert to devm_kzalloc()
Date: Sat, 21 Jan 2012 15:45:23 +0000
Message-ID: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66428103846
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:45:33 +0100 (CET)
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
 sound/soc/codecs/wm8985.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index c0c86b3..e62a4c5 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1079,7 +1079,7 @@ static int __devinit wm8985_spi_probe(struct spi_device *spi)
 	struct wm8985_priv *wm8985;
 	int ret;
 
-	wm8985 = kzalloc(sizeof *wm8985, GFP_KERNEL);
+	wm8985 = devm_kzalloc(&spi->dev, sizeof *wm8985, GFP_KERNEL);
 	if (!wm8985)
 		return -ENOMEM;
 
@@ -1088,15 +1088,12 @@ static int __devinit wm8985_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
-	if (ret < 0)
-		kfree(wm8985);
 	return ret;
 }
 
 static int __devexit wm8985_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -1117,7 +1114,7 @@ static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
 	struct wm8985_priv *wm8985;
 	int ret;
 
-	wm8985 = kzalloc(sizeof *wm8985, GFP_KERNEL);
+	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
 	if (!wm8985)
 		return -ENOMEM;
 
@@ -1126,15 +1123,12 @@ static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
-	if (ret < 0)
-		kfree(wm8985);
 	return ret;
 }
 
 static __devexit int wm8985_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
