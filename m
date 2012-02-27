From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8753: Convert to devm_kzalloc()
Date: Mon, 27 Feb 2012 15:26:11 +0000
Message-ID: <1330356371-19482-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0B152442A
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 16:26:13 +0100 (CET)
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
 sound/soc/codecs/wm8753.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 21ed75d..59c28db 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1557,7 +1557,8 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 	struct wm8753_priv *wm8753;
 	int ret;
 
-	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
+	wm8753 = devm_kzalloc(&spi->dev, sizeof(struct wm8753_priv),
+			      GFP_KERNEL);
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
@@ -1580,7 +1581,6 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 err_regmap:
 	regmap_exit(wm8753->regmap);
 err:
-	kfree(wm8753);
 	return ret;
 }
 
@@ -1612,7 +1612,8 @@ static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
 	struct wm8753_priv *wm8753;
 	int ret;
 
-	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
+	wm8753 = devm_kzalloc(&i2c->dev, sizeof(struct wm8753_priv),
+			      GFP_KERNEL);
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
@@ -1632,10 +1633,10 @@ static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
 		goto err_regmap;
 	}
+
 err_regmap:
 	regmap_exit(wm8753->regmap);
 err:
-	kfree(wm8753);
 	return ret;
 }
 
@@ -1645,7 +1646,6 @@ static __devexit int wm8753_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(wm8753->regmap);
-	kfree(wm8753);
 	return 0;
 }
 
-- 
1.7.9.1
