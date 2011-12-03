From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/21] ASoC: Convert WM8741 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:15 +0000
Message-ID: <1322948009-27658-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 670D6243DC
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
 sound/soc/codecs/wm8741.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index bf471dc..24d8ec5 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -503,7 +503,8 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 	struct wm8741_priv *wm8741;
 	int ret;
 
-	wm8741 = kzalloc(sizeof(struct wm8741_priv), GFP_KERNEL);
+	wm8741 = devm_kzalloc(&i2c->dev, sizeof(struct wm8741_priv),
+			      GFP_KERNEL);
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
@@ -512,20 +513,13 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8741, &wm8741_dai, 1);
-	if (ret != 0)
-		goto err;
 
 	return ret;
-
-err:
-	kfree(wm8741);
-	return ret;
 }
 
 static int wm8741_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -553,7 +547,8 @@ static int __devinit wm8741_spi_probe(struct spi_device *spi)
 	struct wm8741_priv *wm8741;
 	int ret;
 
-	wm8741 = kzalloc(sizeof(struct wm8741_priv), GFP_KERNEL);
+	wm8741 = devm_kzalloc(&spi->dev, sizeof(struct wm8741_priv),
+			     GFP_KERNEL);
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
@@ -562,15 +557,12 @@ static int __devinit wm8741_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8741, &wm8741_dai, 1);
-	if (ret < 0)
-		kfree(wm8741);
 	return ret;
 }
 
 static int __devexit wm8741_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
-- 
1.7.7.3
