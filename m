From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] ASoC: regulator notifier registration
	should be managed
Date: Fri, 8 Feb 2019 14:45:20 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1902081441530.26636@axis700.grange>
References: <alpine.DEB.2.20.1902060859440.14292@axis700.grange>
 <alpine.DEB.2.20.1902080838390.22709@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 84B4D267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 14:45:48 +0100 (CET)
In-Reply-To: <alpine.DEB.2.20.1902080838390.22709@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Regulator notifiers, that were registered during codec driver probing,
must be unregistered during driver release, or device managed versions
have to be used. This patch fixes codec drivers, that weren't explicitly
unregistering notifiers and simplifies those, that did that manually.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---

v2: fix a typo. /me shouldn't rely on automatic building without knowing 
exactly what configurations they're using. Compile-tested myself this 
time.

 sound/soc/codecs/max9860.c       |  3 ++-
 sound/soc/codecs/pcm512x.c       |  5 +++--
 sound/soc/codecs/tlv320aic31xx.c | 16 +++-------------
 sound/soc/codecs/tlv320aic3x.c   | 25 ++++---------------------
 sound/soc/codecs/wm8770.c        | 18 +++---------------
 sound/soc/codecs/wm8962.c        |  9 +++------
 sound/soc/codecs/wm8995.c        | 29 +++++++----------------------
 sound/soc/codecs/wm8996.c        |  9 +++------
 8 files changed, 28 insertions(+), 86 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index de3d44e9199b..8be636fe6552 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -615,7 +615,8 @@ static int max9860_probe(struct i2c_client *i2c)
 
 	max9860->dvddio_nb.notifier_call = max9860_dvddio_event;
 
-	ret = regulator_register_notifier(max9860->dvddio, &max9860->dvddio_nb);
+	ret = devm_regulator_register_notifier(max9860->dvddio,
+					       &max9860->dvddio_nb);
 	if (ret)
 		dev_err(dev, "Failed to register DVDDIO notifier: %d\n", ret);
 
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4cc24a5d5c31..18f414be849f 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1520,8 +1520,9 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
 	pcm512x->supply_nb[2].notifier_call = pcm512x_regulator_event_2;
 
 	for (i = 0; i < ARRAY_SIZE(pcm512x->supplies); i++) {
-		ret = regulator_register_notifier(pcm512x->supplies[i].consumer,
-						  &pcm512x->supply_nb[i]);
+		ret = devm_regulator_register_notifier(
+						pcm512x->supplies[i].consumer,
+						&pcm512x->supply_nb[i]);
 		if (ret != 0) {
 			dev_err(dev,
 				"Failed to register regulator notifier: %d\n",
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 608ad49ad978..7a4a607cca3c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1274,8 +1274,9 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 		aic31xx->disable_nb[i].nb.notifier_call =
 			aic31xx_regulator_event;
 		aic31xx->disable_nb[i].aic31xx = aic31xx;
-		ret = regulator_register_notifier(aic31xx->supplies[i].consumer,
-						  &aic31xx->disable_nb[i].nb);
+		ret = devm_regulator_register_notifier(
+						aic31xx->supplies[i].consumer,
+						&aic31xx->disable_nb[i].nb);
 		if (ret) {
 			dev_err(component->dev,
 				"Failed to request regulator notifier: %d\n",
@@ -1298,19 +1299,8 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static void aic31xx_codec_remove(struct snd_soc_component *component)
-{
-	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-		regulator_unregister_notifier(aic31xx->supplies[i].consumer,
-					      &aic31xx->disable_nb[i].nb);
-}
-
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
-	.remove			= aic31xx_codec_remove,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.controls		= common31xx_snd_controls,
 	.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6a271e6e6b8f..6dcc3ace9d70 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1605,13 +1605,14 @@ static int aic3x_probe(struct snd_soc_component *component)
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
 		aic3x->disable_nb[i].nb.notifier_call = aic3x_regulator_event;
 		aic3x->disable_nb[i].aic3x = aic3x;
-		ret = regulator_register_notifier(aic3x->supplies[i].consumer,
-						  &aic3x->disable_nb[i].nb);
+		ret = devm_regulator_register_notifier(
+						aic3x->supplies[i].consumer,
+						&aic3x->disable_nb[i].nb);
 		if (ret) {
 			dev_err(component->dev,
 				"Failed to request regulator notifier: %d\n",
 				 ret);
-			goto err_notif;
+			return ret;
 		}
 	}
 
@@ -1669,29 +1670,11 @@ static int aic3x_probe(struct snd_soc_component *component)
 	aic3x_add_widgets(component);
 
 	return 0;
-
-err_notif:
-	while (i--)
-		regulator_unregister_notifier(aic3x->supplies[i].consumer,
-					      &aic3x->disable_nb[i].nb);
-	return ret;
-}
-
-static void aic3x_remove(struct snd_soc_component *component)
-{
-	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
-	int i;
-
-	list_del(&aic3x->list);
-	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
-		regulator_unregister_notifier(aic3x->supplies[i].consumer,
-					      &aic3x->disable_nb[i].nb);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_aic3x = {
 	.set_bias_level		= aic3x_set_bias_level,
 	.probe			= aic3x_probe,
-	.remove			= aic3x_remove,
 	.controls		= aic3x_snd_controls,
 	.num_controls		= ARRAY_SIZE(aic3x_snd_controls),
 	.dapm_widgets		= aic3x_dapm_widgets,
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 806245c70f8b..37467c512597 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -666,8 +666,9 @@ static int wm8770_spi_probe(struct spi_device *spi)
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); i++) {
-		ret = regulator_register_notifier(wm8770->supplies[i].consumer,
-						  &wm8770->disable_nb[i]);
+		ret = devm_regulator_register_notifier(
+						wm8770->supplies[i].consumer,
+						&wm8770->disable_nb[i]);
 		if (ret) {
 			dev_err(&spi->dev,
 				"Failed to register regulator notifier: %d\n",
@@ -687,25 +688,12 @@ static int wm8770_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int wm8770_spi_remove(struct spi_device *spi)
-{
-	struct wm8770_priv *wm8770 = spi_get_drvdata(spi);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8770->supplies); ++i)
-		regulator_unregister_notifier(wm8770->supplies[i].consumer,
-					      &wm8770->disable_nb[i]);
-
-	return 0;
-}
-
 static struct spi_driver wm8770_spi_driver = {
 	.driver = {
 		.name = "wm8770",
 		.of_match_table = wm8770_of_match,
 	},
 	.probe = wm8770_spi_probe,
-	.remove = wm8770_spi_remove
 };
 
 module_spi_driver(wm8770_spi_driver);
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index efd8910b1ff7..467ed78dd2df 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3424,8 +3424,9 @@ static int wm8962_probe(struct snd_soc_component *component)
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++) {
-		ret = regulator_register_notifier(wm8962->supplies[i].consumer,
-						  &wm8962->disable_nb[i]);
+		ret = devm_regulator_register_notifier(
+						wm8962->supplies[i].consumer,
+						&wm8962->disable_nb[i]);
 		if (ret != 0) {
 			dev_err(component->dev,
 				"Failed to register regulator notifier: %d\n",
@@ -3467,15 +3468,11 @@ static int wm8962_probe(struct snd_soc_component *component)
 static void wm8962_remove(struct snd_soc_component *component)
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
-	int i;
 
 	cancel_delayed_work_sync(&wm8962->mic_work);
 
 	wm8962_free_gpio(component);
 	wm8962_free_beep(component);
-	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
-		regulator_unregister_notifier(wm8962->supplies[i].consumer,
-					      &wm8962->disable_nb[i]);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm8962 = {
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 68c99fe37097..79ee91906bb9 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -1995,20 +1995,6 @@ static int wm8995_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
-static void wm8995_remove(struct snd_soc_component *component)
-{
-	struct wm8995_priv *wm8995;
-	int i;
-
-	wm8995 = snd_soc_component_get_drvdata(component);
-
-	for (i = 0; i < ARRAY_SIZE(wm8995->supplies); ++i)
-		regulator_unregister_notifier(wm8995->supplies[i].consumer,
-					      &wm8995->disable_nb[i]);
-
-	regulator_bulk_free(ARRAY_SIZE(wm8995->supplies), wm8995->supplies);
-}
-
 static int wm8995_probe(struct snd_soc_component *component)
 {
 	struct wm8995_priv *wm8995;
@@ -2021,8 +2007,9 @@ static int wm8995_probe(struct snd_soc_component *component)
 	for (i = 0; i < ARRAY_SIZE(wm8995->supplies); i++)
 		wm8995->supplies[i].supply = wm8995_supply_names[i];
 
-	ret = regulator_bulk_get(component->dev, ARRAY_SIZE(wm8995->supplies),
-				 wm8995->supplies);
+	ret = devm_regulator_bulk_get(component->dev,
+				      ARRAY_SIZE(wm8995->supplies),
+				      wm8995->supplies);
 	if (ret) {
 		dev_err(component->dev, "Failed to request supplies: %d\n", ret);
 		return ret;
@@ -2039,8 +2026,9 @@ static int wm8995_probe(struct snd_soc_component *component)
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8995->supplies); i++) {
-		ret = regulator_register_notifier(wm8995->supplies[i].consumer,
-						  &wm8995->disable_nb[i]);
+		ret = devm_regulator_register_notifier(
+						wm8995->supplies[i].consumer,
+						&wm8995->disable_nb[i]);
 		if (ret) {
 			dev_err(component->dev,
 				"Failed to register regulator notifier: %d\n",
@@ -2052,7 +2040,7 @@ static int wm8995_probe(struct snd_soc_component *component)
 				    wm8995->supplies);
 	if (ret) {
 		dev_err(component->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_reg_get;
+		return ret;
 	}
 
 	ret = snd_soc_component_read32(component, WM8995_SOFTWARE_RESET);
@@ -2099,8 +2087,6 @@ static int wm8995_probe(struct snd_soc_component *component)
 
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8995->supplies), wm8995->supplies);
-err_reg_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8995->supplies), wm8995->supplies);
 	return ret;
 }
 
@@ -2188,7 +2174,6 @@ static struct snd_soc_dai_driver wm8995_dai[] = {
 
 static const struct snd_soc_component_driver soc_component_dev_wm8995 = {
 	.probe			= wm8995_probe,
-	.remove			= wm8995_remove,
 	.set_bias_level		= wm8995_set_bias_level,
 	.controls		= wm8995_snd_controls,
 	.num_controls		= ARRAY_SIZE(wm8995_snd_controls),
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 91711f8958c5..ab04ea18c312 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2801,8 +2801,9 @@ static int wm8996_i2c_probe(struct i2c_client *i2c,
 
 	/* This should really be moved into the regulator core */
 	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++) {
-		ret = regulator_register_notifier(wm8996->supplies[i].consumer,
-						  &wm8996->disable_nb[i]);
+		ret = devm_regulator_register_notifier(
+						wm8996->supplies[i].consumer,
+						&wm8996->disable_nb[i]);
 		if (ret != 0) {
 			dev_err(&i2c->dev,
 				"Failed to register regulator notifier: %d\n",
@@ -3071,16 +3072,12 @@ static int wm8996_i2c_probe(struct i2c_client *i2c,
 static int wm8996_i2c_remove(struct i2c_client *client)
 {
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
-	int i;
 
 	wm8996_free_gpio(wm8996);
 	if (wm8996->pdata.ldo_ena > 0) {
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		gpio_free(wm8996->pdata.ldo_ena);
 	}
-	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
-		regulator_unregister_notifier(wm8996->supplies[i].consumer,
-					      &wm8996->disable_nb[i]);
 
 	return 0;
 }
-- 
2.17.1
