From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8983: Convert to devm_kzalloc()
Date: Mon, 10 Sep 2012 15:29:21 +0800
Message-ID: <1347262162-5335-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA312264FB0
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 09:58:09 +0200 (CEST)
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
 sound/soc/codecs/wm8983.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 367388f..57c33fc 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1085,7 +1085,7 @@ static int __devinit wm8983_spi_probe(struct spi_device *spi)
 	struct wm8983_priv *wm8983;
 	int ret;
 
-	wm8983 = kzalloc(sizeof *wm8983, GFP_KERNEL);
+	wm8983 = devm_kzalloc(&spi->dev, sizeof *wm8983, GFP_KERNEL);
 	if (!wm8983)
 		return -ENOMEM;
 
@@ -1094,15 +1094,12 @@ static int __devinit wm8983_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm8983, &wm8983_dai, 1);
-	if (ret < 0)
-		kfree(wm8983);
 	return ret;
 }
 
 static int __devexit wm8983_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -1123,7 +1120,7 @@ static __devinit int wm8983_i2c_probe(struct i2c_client *i2c,
 	struct wm8983_priv *wm8983;
 	int ret;
 
-	wm8983 = kzalloc(sizeof *wm8983, GFP_KERNEL);
+	wm8983 = devm_kzalloc(&i2c->dev, sizeof *wm8983, GFP_KERNEL);
 	if (!wm8983)
 		return -ENOMEM;
 
@@ -1132,15 +1129,13 @@ static __devinit int wm8983_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8983, &wm8983_dai, 1);
-	if (ret < 0)
-		kfree(wm8983);
+
 	return ret;
 }
 
 static __devexit int wm8983_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
