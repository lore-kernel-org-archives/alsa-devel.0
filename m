From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8988: Convert to devm_kzalloc()
Date: Sat, 21 Jan 2012 23:28:03 +0000
Message-ID: <1327188483-23756-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327188483-23756-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BBC324368
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 00:28:12 +0100 (CET)
In-Reply-To: <1327188483-23756-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8988.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 40aebaf..4ef9d4c 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -799,7 +799,8 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 	struct wm8988_priv *wm8988;
 	int ret;
 
-	wm8988 = kzalloc(sizeof(struct wm8988_priv), GFP_KERNEL);
+	wm8988 = devm_kzalloc(&spi->dev, sizeof(struct wm8988_priv),
+			      GFP_KERNEL);
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
@@ -808,15 +809,13 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
-	if (ret < 0)
-		kfree(wm8988);
+
 	return ret;
 }
 
 static int __devexit wm8988_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -837,7 +836,8 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 	struct wm8988_priv *wm8988;
 	int ret;
 
-	wm8988 = kzalloc(sizeof(struct wm8988_priv), GFP_KERNEL);
+	wm8988 = devm_kzalloc(&i2c->dev, sizeof(struct wm8988_priv),
+			      GFP_KERNEL);
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
@@ -846,15 +846,12 @@ static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8988, &wm8988_dai, 1);
-	if (ret < 0)
-		kfree(wm8988);
 	return ret;
 }
 
 static __devexit int wm8988_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
