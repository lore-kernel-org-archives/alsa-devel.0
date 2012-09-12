From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: wm8728: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:32:57 +0800
Message-ID: <1347413580-11137-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BFD92615E6
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:33:38 +0200 (CEST)
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
 sound/soc/codecs/wm8728.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 1467f97..f274c25 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -280,7 +280,8 @@ static int __devinit wm8728_spi_probe(struct spi_device *spi)
 	struct wm8728_priv *wm8728;
 	int ret;
 
-	wm8728 = kzalloc(sizeof(struct wm8728_priv), GFP_KERNEL);
+	wm8728 = devm_kzalloc(&spi->dev, sizeof(struct wm8728_priv),
+			      GFP_KERNEL);
 	if (wm8728 == NULL)
 		return -ENOMEM;
 
@@ -289,15 +290,14 @@ static int __devinit wm8728_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8728, &wm8728_dai, 1);
-	if (ret < 0)
-		kfree(wm8728);
+
 	return ret;
 }
 
 static int __devexit wm8728_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
+
 	return 0;
 }
 
@@ -319,7 +319,8 @@ static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
 	struct wm8728_priv *wm8728;
 	int ret;
 
-	wm8728 = kzalloc(sizeof(struct wm8728_priv), GFP_KERNEL);
+	wm8728 = devm_kzalloc(&i2c->dev, sizeof(struct wm8728_priv),
+			      GFP_KERNEL);
 	if (wm8728 == NULL)
 		return -ENOMEM;
 
@@ -328,15 +329,13 @@ static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8728, &wm8728_dai, 1);
-	if (ret < 0)
-		kfree(wm8728);
+
 	return ret;
 }
 
 static __devexit int wm8728_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
