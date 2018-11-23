From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/5] ASoC: max9867: Fix power management
Date: Fri, 23 Nov 2018 15:27:29 +0100
Message-ID: <20181123142729.GC7347@lenoch>
References: <20181123142507.GA7347@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id EF7E1267A73
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:28:06 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992965AbeKWO1aS3Sxb (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Fri, 23 Nov 2018 15:27:30 +0100
Content-Disposition: inline
In-Reply-To: <20181123142507.GA7347@lenoch>
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Move device enable to probe function. Doing that from prepare
callback allows only DAC to be enabled.
While here move suspend and resume functions to more common place.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 62 +++++++++++++++-----------------------
 sound/soc/codecs/max9867.h |  2 +-
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 1cda54b59854..07a8205b211a 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -248,17 +248,6 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int max9867_prepare(struct snd_pcm_substream *substream,
-			 struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
-
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
-	return 0;
-}
-
 static int max9867_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -361,7 +350,6 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.set_fmt = max9867_dai_set_fmt,
 	.set_sysclk	= max9867_set_dai_sysclk,
-	.prepare	= max9867_prepare,
 	.digital_mute	= max9867_mute,
 	.hw_params = max9867_dai_hw_params,
 };
@@ -392,27 +380,6 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 	}
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int max9867_suspend(struct device *dev)
-{
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
-
-	/* Drop down to power saving mode when system is suspended */
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, ~MAX9867_SHTDOWN_MASK);
-	return 0;
-}
-
-static int max9867_resume(struct device *dev)
-{
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
-
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
-	return 0;
-}
-#endif
-
 static const struct snd_soc_component_driver max9867_component = {
 	.controls		= max9867_snd_controls,
 	.num_controls		= ARRAY_SIZE(max9867_snd_controls),
@@ -491,19 +458,40 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 	}
 	ret = regmap_read(max9867->regmap, MAX9867_REVISION, &reg);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to read: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to read revision: %d\n", ret);
 		return ret;
 	}
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
-	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
-			max9867_dai, ARRAY_SIZE(max9867_dai));
+	ret = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+				 MAX9867_SHTDOWN, MAX9867_SHTDOWN);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to enable: %d\n", ret);
 		return ret;
 	}
+	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
+			max9867_dai, ARRAY_SIZE(max9867_dai));
+	if (ret < 0)
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 	return ret;
 }
 
+static int __maybe_unused max9867_suspend(struct device *dev)
+{
+	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+
+	/* Drop down to power saving mode when system is suspended */
+	return regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+				  MAX9867_SHTDOWN, 0);
+}
+
+static int __maybe_unused max9867_resume(struct device *dev)
+{
+	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+
+	return regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+				  MAX9867_SHTDOWN, MAX9867_SHTDOWN);
+}
+
 static const struct i2c_device_id max9867_i2c_id[] = {
 	{ "max9867", 0 },
 	{ }
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index 55cd9976ff47..d9170850c96e 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -67,7 +67,7 @@
 #define MAX9867_MICCONFIG    0x15
 #define MAX9867_MODECONFIG   0x16
 #define MAX9867_PWRMAN       0x17
-#define MAX9867_SHTDOWN_MASK (1<<7)
+#define MAX9867_SHTDOWN      0x80
 #define MAX9867_REVISION     0xff
 
 #define MAX9867_CACHEREGNUM 10
-- 
2.19.1
