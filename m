From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Add device init/exit annotations to
	new-style Wolfson CODEC drivers
Date: Thu, 19 Feb 2009 19:02:39 +0000
Message-ID: <1235070160-10709-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090219190140.GA9707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 250EF10380B
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 20:03:22 +0100 (CET)
In-Reply-To: <20090219190140.GA9707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |    2 +-
 sound/soc/codecs/wm8731.c |    8 ++++----
 sound/soc/codecs/wm8900.c |    8 ++++----
 sound/soc/codecs/wm8903.c |    8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index d356278..359e5cc 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1574,7 +1574,7 @@ struct snd_soc_codec_device soc_codec_dev_wm8350 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8350);
 
-static int wm8350_codec_probe(struct platform_device *pdev)
+static __devinit int wm8350_codec_probe(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 	struct wm8350_data *priv;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 9c9fc3b..4cac319 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -686,8 +686,8 @@ static struct spi_driver wm8731_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static int wm8731_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8731_priv *wm8731;
 	struct snd_soc_codec *codec;
@@ -707,7 +707,7 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	return wm8731_register(wm8731);
 }
 
-static int wm8731_i2c_remove(struct i2c_client *client)
+static __devexit int wm8731_i2c_remove(struct i2c_client *client)
 {
 	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
 	wm8731_unregister(wm8731);
@@ -726,7 +726,7 @@ static struct i2c_driver wm8731_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8731_i2c_probe,
-	.remove =   wm8731_i2c_remove,
+	.remove =   __devexit_p(wm8731_i2c_remove),
 	.id_table = wm8731_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 85c0f1b..da5ca64 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1272,8 +1272,8 @@ static int wm8900_resume(struct platform_device *pdev)
 
 static struct snd_soc_codec *wm8900_codec;
 
-static int wm8900_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8900_priv *wm8900;
 	struct snd_soc_codec *codec;
@@ -1372,7 +1372,7 @@ err:
 	return ret;
 }
 
-static int wm8900_i2c_remove(struct i2c_client *client)
+static __devexit int wm8900_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_dai(&wm8900_dai);
 	snd_soc_unregister_codec(wm8900_codec);
@@ -1398,7 +1398,7 @@ static struct i2c_driver wm8900_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8900_i2c_probe,
-	.remove = wm8900_i2c_remove,
+	.remove = __devexit_p(wm8900_i2c_remove),
 	.id_table = wm8900_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d36b2b1..c6fa8a7 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1562,8 +1562,8 @@ static int wm8903_resume(struct platform_device *pdev)
 
 static struct snd_soc_codec *wm8903_codec;
 
-static int wm8903_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8903_priv *wm8903;
 	struct snd_soc_codec *codec;
@@ -1669,7 +1669,7 @@ err:
 	return ret;
 }
 
-static int wm8903_i2c_remove(struct i2c_client *client)
+static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
 
@@ -1699,7 +1699,7 @@ static struct i2c_driver wm8903_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe    = wm8903_i2c_probe,
-	.remove   = wm8903_i2c_remove,
+	.remove   = __devexit_p(wm8903_i2c_remove),
 	.id_table = wm8903_i2c_id,
 };
 
-- 
1.5.6.3
