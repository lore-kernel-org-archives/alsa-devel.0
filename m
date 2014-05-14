From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/6] ASoC: ak4642: Add enable gpio support
Date: Wed, 14 May 2014 09:37:38 +0200
Message-ID: <1400053058-1115-7-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 64871261A2F
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:37:50 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/ak4642.txt |  3 ++
 sound/soc/codecs/ak4642.c                          | 41 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4642.txt b/Documentation/devicetree/bindings/sound/ak4642.txt
index 623d4e7..21bc8ef 100644
--- a/Documentation/devicetree/bindings/sound/ak4642.txt
+++ b/Documentation/devicetree/bindings/sound/ak4642.txt
@@ -7,6 +7,9 @@ Required properties:
   - compatible : "asahi-kasei,ak4642" or "asahi-kasei,ak4643" or "asahi-kasei,ak4648"
   - reg : The chip select number on the I2C bus
 
+Optional properties:
+  - enable-gpios : contains a GPIO used to enable the codec
+
 Example:
 
 &i2c {
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 6292a6a..67b8c25 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -29,6 +29,7 @@
 #include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -141,6 +142,7 @@ struct ak4642_drvdata {
 
 struct ak4642_priv {
 	const struct ak4642_drvdata *drvdata;
+	struct gpio_desc *pdn_gpio;
 };
 
 /*
@@ -596,9 +598,23 @@ static struct snd_soc_dai_driver ak4642_dai = {
 	.symmetric_rates = 1,
 };
 
+static int ak4642_suspend(struct snd_soc_codec *codec)
+{
+	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	if (priv->pdn_gpio)
+		gpiod_set_value(priv->pdn_gpio, 0);
+
+	return 0;
+}
+
 static int ak4642_resume(struct snd_soc_codec *codec)
 {
 	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	if (priv->pdn_gpio)
+		gpiod_set_value(priv->pdn_gpio, 1);
 
 	regcache_mark_dirty(regmap);
 	regcache_sync(regmap);
@@ -608,6 +624,15 @@ static int ak4642_resume(struct snd_soc_codec *codec)
 
 static int ak4642_probe(struct snd_soc_codec *codec)
 {
+	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	if (priv->pdn_gpio) {
+		ret = gpiod_direction_output(priv->pdn_gpio, 1);
+		if (ret)
+			return ret;
+	}
+
 	ak4642_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -615,13 +640,20 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 
 static int ak4642_remove(struct snd_soc_codec *codec)
 {
+	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
+
 	ak4642_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	if (priv->pdn_gpio)
+		gpiod_set_value(priv->pdn_gpio, 0);
+
 	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.probe			= ak4642_probe,
 	.remove			= ak4642_remove,
+	.suspend		= ak4642_suspend,
 	.resume			= ak4642_resume,
 	.set_bias_level		= ak4642_set_bias_level,
 	.controls		= ak4642_snd_controls,
@@ -669,6 +701,7 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 	const struct ak4642_drvdata *drvdata = NULL;
 	struct regmap *regmap;
 	struct ak4642_priv *priv;
+	struct gpio_desc *gpio;
 
 	if (np) {
 		const struct of_device_id *of_id;
@@ -691,6 +724,14 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 
 	priv->drvdata = drvdata;
 
+	gpio = devm_gpiod_get(&i2c->dev, "enable");
+	if (IS_ERR(gpio)) {
+		if (PTR_ERR(gpio) != -ENOENT)
+			return PTR_ERR(gpio);
+	} else {
+		priv->pdn_gpio = gpio;
+	}
+
 	i2c_set_clientdata(i2c, priv);
 
 	regmap = devm_regmap_init_i2c(i2c, drvdata->regmap_config);
-- 
2.0.0.rc0
