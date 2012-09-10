From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8741: Move regulator acquisition
	to I2C/SPI probe()
Date: Mon, 10 Sep 2012 18:02:29 +0800
Message-ID: <1347271351-4087-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0930126508A
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 12:02:46 +0200 (CEST)
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

Better style as we acquire resources before trying the ASoC card probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 35f3d23..742744b 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -403,17 +403,6 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 {
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
-		wm8741->supplies[i].supply = wm8741_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8741->supplies),
-				 wm8741->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
-	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8741->supplies),
 				    wm8741->supplies);
@@ -450,7 +439,6 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 err:
 	return ret;
 }
@@ -460,7 +448,6 @@ static int wm8741_remove(struct snd_soc_codec *codec)
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
-	regulator_bulk_free(ARRAY_SIZE(wm8741->supplies), wm8741->supplies);
 
 	return 0;
 }
@@ -492,13 +479,23 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8741_priv *wm8741;
-	int ret;
+	int ret, i;
 
 	wm8741 = devm_kzalloc(&i2c->dev, sizeof(struct wm8741_priv),
 			      GFP_KERNEL);
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
+		wm8741->supplies[i].supply = wm8741_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8741->supplies),
+				      wm8741->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err;
+	}
+
 	i2c_set_clientdata(i2c, wm8741);
 	wm8741->control_type = SND_SOC_I2C;
 
@@ -536,13 +533,23 @@ static struct i2c_driver wm8741_i2c_driver = {
 static int __devinit wm8741_spi_probe(struct spi_device *spi)
 {
 	struct wm8741_priv *wm8741;
-	int ret;
+	int ret, i;
 
 	wm8741 = devm_kzalloc(&spi->dev, sizeof(struct wm8741_priv),
 			     GFP_KERNEL);
 	if (wm8741 == NULL)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8741->supplies); i++)
+		wm8741->supplies[i].supply = wm8741_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8741->supplies),
+				      wm8741->supplies);
+	if (ret != 0) {
+		dev_err(&spi->dev, "Failed to request supplies: %d\n", ret);
+		goto err;
+	}
+
 	wm8741->control_type = SND_SOC_SPI;
 	spi_set_drvdata(spi, wm8741);
 
-- 
1.7.10.4
