From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8804: Merge CODEC probe and bus
	probe
Date: Sun, 22 Feb 2015 16:43:22 +0000
Message-ID: <1424623402-473-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1424623402-473-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FC5626078A
 for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2015 17:45:14 +0100 (CET)
In-Reply-To: <1424623402-473-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Charles Keepax <ckeepax@gmail.com>

All of the things in the CODEC probe, such as getting the regulators and
verifying the chip ID, are better done in bus probe. It is better to
fail during bus probe if this is the wrong chip and all resource
allocation should be done in the bus probe anyway. This patch merges
the CODEC probe into bus probe.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |  180 ++++++++++++++++++++------------------------
 1 files changed, 82 insertions(+), 98 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index b5a04fc..1bd4ace 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -182,9 +182,9 @@ static bool wm8804_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8804_reset(struct snd_soc_codec *codec)
+static int wm8804_reset(struct wm8804_priv *wm8804)
 {
-	return snd_soc_write(codec, WM8804_RST_DEVID1, 0x0);
+	return regmap_write(wm8804->regmap, WM8804_RST_DEVID1, 0x0);
 }
 
 static int wm8804_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -515,100 +515,6 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8804_codec_remove(struct snd_soc_codec *codec)
-{
-	struct wm8804_priv *wm8804;
-	int i;
-
-	wm8804 = snd_soc_codec_get_drvdata(codec);
-
-	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
-		regulator_unregister_notifier(wm8804->supplies[i].consumer,
-					      &wm8804->disable_nb[i]);
-	return 0;
-}
-
-static int wm8804_codec_probe(struct snd_soc_codec *codec)
-{
-	struct wm8804_priv *wm8804;
-	int i, id1, id2, ret;
-
-	wm8804 = snd_soc_codec_get_drvdata(codec);
-
-	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++)
-		wm8804->supplies[i].supply = wm8804_supply_names[i];
-
-	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8804->supplies),
-				 wm8804->supplies);
-	if (ret) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
-	wm8804->disable_nb[0].notifier_call = wm8804_regulator_event_0;
-	wm8804->disable_nb[1].notifier_call = wm8804_regulator_event_1;
-
-	/* This should really be moved into the regulator core */
-	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++) {
-		ret = regulator_register_notifier(wm8804->supplies[i].consumer,
-						  &wm8804->disable_nb[i]);
-		if (ret != 0) {
-			dev_err(codec->dev,
-				"Failed to register regulator notifier: %d\n",
-				ret);
-		}
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8804->supplies),
-				    wm8804->supplies);
-	if (ret) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		return ret;
-	}
-
-	id1 = snd_soc_read(codec, WM8804_RST_DEVID1);
-	if (id1 < 0) {
-		dev_err(codec->dev, "Failed to read device ID: %d\n", id1);
-		ret = id1;
-		goto err_reg_enable;
-	}
-
-	id2 = snd_soc_read(codec, WM8804_DEVID2);
-	if (id2 < 0) {
-		dev_err(codec->dev, "Failed to read device ID: %d\n", id2);
-		ret = id2;
-		goto err_reg_enable;
-	}
-
-	id2 = (id2 << 8) | id1;
-
-	if (id2 != 0x8805) {
-		dev_err(codec->dev, "Invalid device ID: %#x\n", id2);
-		ret = -EINVAL;
-		goto err_reg_enable;
-	}
-
-	ret = snd_soc_read(codec, WM8804_DEVREV);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read device revision: %d\n",
-			ret);
-		goto err_reg_enable;
-	}
-	dev_info(codec->dev, "revision %c\n", ret + 'A');
-
-	ret = wm8804_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
-		goto err_reg_enable;
-	}
-
-	return 0;
-
-err_reg_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
-	return ret;
-}
-
 static const struct snd_soc_dai_ops wm8804_dai_ops = {
 	.hw_params = wm8804_hw_params,
 	.set_fmt = wm8804_set_fmt,
@@ -646,8 +552,6 @@ static struct snd_soc_dai_driver wm8804_dai = {
 };
 
 static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
-	.probe = wm8804_codec_probe,
-	.remove = wm8804_codec_remove,
 	.set_bias_level = wm8804_set_bias_level,
 	.idle_bias_off = true,
 
@@ -671,6 +575,8 @@ EXPORT_SYMBOL_GPL(wm8804_regmap_config);
 int wm8804_probe(struct device *dev, struct regmap *regmap)
 {
 	struct wm8804_priv *wm8804;
+	unsigned int id1, id2;
+	int i, ret;
 
 	wm8804 = devm_kzalloc(dev, sizeof(*wm8804), GFP_KERNEL);
 	if (!wm8804)
@@ -680,13 +586,91 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 
 	wm8804->regmap = regmap;
 
+	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++)
+		wm8804->supplies[i].supply = wm8804_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(wm8804->supplies),
+				      wm8804->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	wm8804->disable_nb[0].notifier_call = wm8804_regulator_event_0;
+	wm8804->disable_nb[1].notifier_call = wm8804_regulator_event_1;
+
+	/* This should really be moved into the regulator core */
+	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++) {
+		ret = regulator_register_notifier(wm8804->supplies[i].consumer,
+						  &wm8804->disable_nb[i]);
+		if (ret != 0) {
+			dev_err(dev,
+				"Failed to register regulator notifier: %d\n",
+				ret);
+		}
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8804->supplies),
+				    wm8804->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		goto err_reg_enable;
+	}
+
+	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device ID: %d\n", ret);
+		goto err_reg_enable;
+	}
+
+	ret = regmap_read(regmap, WM8804_DEVID2, &id2);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device ID: %d\n", ret);
+		goto err_reg_enable;
+	}
+
+	id2 = (id2 << 8) | id1;
+
+	if (id2 != 0x8805) {
+		dev_err(dev, "Invalid device ID: %#x\n", id2);
+		ret = -EINVAL;
+		goto err_reg_enable;
+	}
+
+	ret = regmap_read(regmap, WM8804_DEVREV, &id1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device revision: %d\n",
+			ret);
+		goto err_reg_enable;
+	}
+	dev_info(dev, "revision %c\n", id1 + 'A');
+
+	ret = wm8804_reset(wm8804);
+	if (ret < 0) {
+		dev_err(dev, "Failed to issue reset: %d\n", ret);
+		goto err_reg_enable;
+	}
+
 	return snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
 				      &wm8804_dai, 1);
+
+err_reg_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(wm8804_probe);
 
 void wm8804_remove(struct device *dev)
 {
+	struct wm8804_priv *wm8804;
+	int i;
+
+	wm8804 = dev_get_drvdata(dev);
+
+	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
+		regulator_unregister_notifier(wm8804->supplies[i].consumer,
+					      &wm8804->disable_nb[i]);
+
 	snd_soc_unregister_codec(dev);
 }
 EXPORT_SYMBOL_GPL(wm8804_remove);
-- 
1.7.2.5
