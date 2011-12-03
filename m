From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/21] ASoC: Convert WM8750 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:16 +0000
Message-ID: <1322948009-27658-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63BDA243D8
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:39 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8750.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b312fcc..b593abf 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -744,7 +744,8 @@ static int __devinit wm8750_spi_probe(struct spi_device *spi)
 	struct wm8750_priv *wm8750;
 	int ret;
 
-	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	wm8750 = devm_kzalloc(&spi->dev, sizeof(struct wm8750_priv),
+			      GFP_KERNEL);
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
@@ -753,15 +754,12 @@ static int __devinit wm8750_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8750, &wm8750_dai, 1);
-	if (ret < 0)
-		kfree(wm8750);
 	return ret;
 }
 
 static int __devexit wm8750_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -791,7 +789,8 @@ static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
 	struct wm8750_priv *wm8750;
 	int ret;
 
-	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	wm8750 = devm_kzalloc(&i2c->dev, sizeof(struct wm8750_priv),
+			      GFP_KERNEL);
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
@@ -800,15 +799,12 @@ static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8750, &wm8750_dai, 1);
-	if (ret < 0)
-		kfree(wm8750);
 	return ret;
 }
 
 static __devexit int wm8750_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
