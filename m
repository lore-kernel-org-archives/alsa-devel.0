From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm8770: Remove regulator allocation
	to SPI probe
Date: Wed, 10 Oct 2012 20:43:38 +0900
Message-ID: <1349869419-10357-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E45B2616DA
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:13 +0200 (CEST)
In-Reply-To: <1349869419-10357-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This is more idiomatic and ensures we don't try to do the ASoC card setup
until we've got all the required resources.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8770.c |   81 ++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 8eefe42..9092031 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -576,7 +576,6 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 {
 	struct wm8770_priv *wm8770;
 	int ret;
-	int i;
 
 	wm8770 = snd_soc_codec_get_drvdata(codec);
 	wm8770->codec = codec;
@@ -587,36 +586,11 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); i++)
-		wm8770->supplies[i].supply = wm8770_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8770->supplies),
-				 wm8770->supplies);
-	if (ret) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
-	wm8770->disable_nb[0].notifier_call = wm8770_regulator_event_0;
-	wm8770->disable_nb[1].notifier_call = wm8770_regulator_event_1;
-	wm8770->disable_nb[2].notifier_call = wm8770_regulator_event_2;
-
-	/* This should really be moved into the regulator core */
-	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); i++) {
-		ret = regulator_register_notifier(wm8770->supplies[i].consumer,
-						  &wm8770->disable_nb[i]);
-		if (ret) {
-			dev_err(codec->dev,
-				"Failed to register regulator notifier: %d\n",
-				ret);
-		}
-	}
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8770->supplies),
 				    wm8770->supplies);
 	if (ret) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_reg_get;
+		return ret;
 	}
 
 	ret = wm8770_reset(codec);
@@ -646,32 +620,14 @@ static int wm8770_probe(struct snd_soc_codec *codec)
 				  ARRAY_SIZE(wm8770_dapm_widgets));
 	snd_soc_dapm_add_routes(&codec->dapm, wm8770_intercon,
 				ARRAY_SIZE(wm8770_intercon));
-	return 0;
 
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8770->supplies), wm8770->supplies);
-err_reg_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8770->supplies), wm8770->supplies);
 	return ret;
 }
 
-static int wm8770_remove(struct snd_soc_codec *codec)
-{
-	struct wm8770_priv *wm8770;
-	int i;
-
-	wm8770 = snd_soc_codec_get_drvdata(codec);
-
-	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); ++i)
-		regulator_unregister_notifier(wm8770->supplies[i].consumer,
-					      &wm8770->disable_nb[i]);
-	regulator_bulk_free(ARRAY_SIZE(wm8770->supplies), wm8770->supplies);
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.probe = wm8770_probe,
-	.remove = wm8770_remove,
 	.set_bias_level = wm8770_set_bias_level,
 	.idle_bias_off = true,
 };
@@ -697,13 +653,38 @@ static const struct regmap_config wm8770_regmap = {
 static int __devinit wm8770_spi_probe(struct spi_device *spi)
 {
 	struct wm8770_priv *wm8770;
-	int ret;
+	int ret, i;
 
 	wm8770 = devm_kzalloc(&spi->dev, sizeof(struct wm8770_priv),
 			      GFP_KERNEL);
 	if (!wm8770)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); i++)
+		wm8770->supplies[i].supply = wm8770_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(wm8770->supplies),
+				      wm8770->supplies);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	wm8770->disable_nb[0].notifier_call = wm8770_regulator_event_0;
+	wm8770->disable_nb[1].notifier_call = wm8770_regulator_event_1;
+	wm8770->disable_nb[2].notifier_call = wm8770_regulator_event_2;
+
+	/* This should really be moved into the regulator core */
+	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); i++) {
+		ret = regulator_register_notifier(wm8770->supplies[i].consumer,
+						  &wm8770->disable_nb[i]);
+		if (ret) {
+			dev_err(&spi->dev,
+				"Failed to register regulator notifier: %d\n",
+				ret);
+		}
+	}
+
 	wm8770->regmap = devm_regmap_init_spi(spi, &wm8770_regmap);
 	if (IS_ERR(wm8770->regmap))
 		return PTR_ERR(wm8770->regmap);
@@ -718,7 +699,15 @@ static int __devinit wm8770_spi_probe(struct spi_device *spi)
 
 static int __devexit wm8770_spi_remove(struct spi_device *spi)
 {
+	struct wm8770_priv *wm8770 = spi_get_drvdata(spi);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); ++i)
+		regulator_unregister_notifier(wm8770->supplies[i].consumer,
+					      &wm8770->disable_nb[i]);
+
 	snd_soc_unregister_codec(&spi->dev);
+
 	return 0;
 }
 
-- 
1.7.10.4
