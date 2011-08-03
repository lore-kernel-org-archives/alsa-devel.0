From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Refactor WM8741 regulator handling
	into CODEC generic code
Date: Wed,  3 Aug 2011 17:47:08 +0900
Message-ID: <1312361229-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C704B24634
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 10:47:17 +0200 (CEST)
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

No meaningful runtime impact but is more in line with other CODECs and
will support further work.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |   74 ++++++++++++++++++++++++++------------------
 1 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 3def27c..d4bfffd 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -422,17 +422,35 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 {
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
+		wm8741->supplies[i].supply = wm8741_supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8741->supplies),
+				 wm8741->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8741->supplies),
+				    wm8741->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_get;
+	}
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8741->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = wm8741_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
+		goto err_enable;
 	}
 
 	/* Change some default settings - latch VU */
@@ -451,10 +469,28 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 
 	dev_dbg(codec->dev, "Successful registration\n");
 	return ret;
+
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+err_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+err:
+	return ret;
+}
+
+static int wm8741_remove(struct snd_soc_codec *codec)
+{
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+
+	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.probe =	wm8741_probe,
+	.remove =	wm8741_remove,
 	.resume =	wm8741_resume,
 	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
 	.reg_word_size = sizeof(u16),
@@ -466,43 +502,22 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8741_priv *wm8741;
-	int ret, i;
+	int ret;
 
 	wm8741 = kzalloc(sizeof(struct wm8741_priv), GFP_KERNEL);
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
-		wm8741->supplies[i].supply = wm8741_supply_names[i];
-
-	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8741->supplies),
-				 wm8741->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8741->supplies),
-				    wm8741->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
-	}
-
 	i2c_set_clientdata(i2c, wm8741);
 	wm8741->control_type = SND_SOC_I2C;
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8741, &wm8741_dai, 1);
-	if (ret < 0)
-		goto err_enable;
-	return ret;
+	ret = snd_soc_register_codec(&i2c->dev,
+				     &soc_codec_dev_wm8741, &wm8741_dai, 1);
+	if (ret != 0)
+		goto err;
 
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
+	return ret;
 
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 err:
 	kfree(wm8741);
 	return ret;
@@ -513,7 +528,6 @@ static int wm8741_i2c_remove(struct i2c_client *client)
 	struct wm8741_priv *wm8741 = i2c_get_clientdata(client);
 
 	snd_soc_unregister_codec(&client->dev);
-	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 	kfree(i2c_get_clientdata(client));
 	return 0;
 }
-- 
1.7.5.4
