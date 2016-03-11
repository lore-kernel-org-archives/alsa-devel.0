From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: [PATCH V6] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Sat, 12 Mar 2016 00:29:00 +0100
Message-ID: <20160311232856.GC27257@panicking>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
 <20160222031944.GT18327@sirena.org.uk>
 <20160311225937.GA27257@panicking>
 <20160311230930.GB27257@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160311230930.GB27257@panicking>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

ASoC: pcm179x: Add support for pcm1795 and pcm1796

Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Tested-by: Angelo Adamo <adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes v5 -> v6
	- Add device tree documentation

Changes v4 -> v5
	- remove dead code

Changes v3 -> v4:
	- clean up compatible list
	- use enum type instead of pointer of int

Changes v2 -> v3:
	- rebase after i2c support

Changes v1 -> v2:
	- Use switch for support new variants
	- sort the compatible list

 .../devicetree/bindings/sound/pcm179x.txt          |  2 +
 sound/soc/codecs/pcm179x-i2c.c                     |  6 --
 sound/soc/codecs/pcm179x-spi.c                     |  6 --
 sound/soc/codecs/pcm179x.c                         | 65 ++++++++++++++++++++--
 sound/soc/codecs/pcm179x.h                         |  9 ++-
 5 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm179x.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
index 436c2b2..f642eaf 100644
--- a/Documentation/devicetree/bindings/sound/pcm179x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm179x.txt
@@ -5,6 +5,8 @@ This driver supports both the I2C and SPI bus.
 Required properties:
 
  - compatible: "ti,pcm1792a"
+ - compatible: "ti,pcm1795"
+ - compatible: "ti,pcm1796"
 
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 4118106..609f07f 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -44,12 +44,6 @@ static int pcm179x_i2c_remove(struct i2c_client *client)
 	return pcm179x_common_exit(&client->dev);
 }
 
-static const struct of_device_id pcm179x_of_match[] = {
-	{ .compatible = "ti,pcm1792a", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pcm179x_of_match);
-
 static const struct i2c_device_id pcm179x_i2c_ids[] = {
 	{ "pcm179x", 0 },
 	{ }
diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
index da924d4..6ae0e4d 100644
--- a/sound/soc/codecs/pcm179x-spi.c
+++ b/sound/soc/codecs/pcm179x-spi.c
@@ -43,12 +43,6 @@ static int pcm179x_spi_remove(struct spi_device *spi)
 	return pcm179x_common_exit(&spi->dev);
 }
 
-static const struct of_device_id pcm179x_of_match[] = {
-	{ .compatible = "ti,pcm1792a", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pcm179x_of_match);
-
 static const struct spi_device_id pcm179x_spi_ids[] = {
 	{ "pcm179x", 0 },
 	{ },
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 06a6657..fb01822 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -68,14 +70,42 @@ static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
 	return accessible && reg != 0x16 && reg != 0x17;
 }
 
+enum pcm179x_type {
+	PCM1792A,
+	PCM1795,
+	PCM1796,
+};
+
 struct pcm179x_private {
 	struct regmap *regmap;
 	unsigned int format;
 	unsigned int rate;
+	enum pcm179x_type codec_model;
 };
 
+static int pcm179x_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	u64 formats = PCM1792A_FORMATS;
+
+	switch (priv->codec_model) {
+	case PCM1795:
+		formats = PCM1795_FORMATS;
+		break;
+	default:
+		break;
+	}
+
+	snd_pcm_hw_constraint_mask64(substream->runtime,
+				     SNDRV_PCM_HW_PARAM_FORMAT, formats);
+
+	return 0;
+}
+
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
-                             unsigned int format)
+			       unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
@@ -112,8 +142,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
 		switch (params_width(params)) {
-		case 24:
 		case 32:
+			val = 1;
+			break;
+		case 24:
 			val = 2;
 			break;
 		case 16:
@@ -125,8 +157,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_I2S:
 		switch (params_width(params)) {
-		case 24:
 		case 32:
+			val = 4;
+			break;
+		case 24:
 			val = 5;
 			break;
 		case 16:
@@ -152,6 +186,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops pcm179x_dai_ops = {
+	.startup	= pcm179x_startup,
 	.set_fmt	= pcm179x_set_dai_fmt,
 	.hw_params	= pcm179x_hw_params,
 	.digital_mute	= pcm179x_digital_mute,
@@ -190,7 +225,7 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.rate_min = 10000,
 		.rate_max = 200000,
-		.formats = PCM1792A_FORMATS, },
+		.formats = PCM179X_FORMATS, },
 	.ops = &pcm179x_dai_ops,
 };
 
@@ -214,15 +249,37 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
 	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
 };
 
+const struct of_device_id pcm179x_of_match[] = {
+	{ .compatible = "ti,pcm1792a", },
+	{ .compatible = "ti,pcm1795", .data = (void *)PCM1795, },
+	{ .compatible = "ti,pcm1796", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm179x_of_match);
+EXPORT_SYMBOL_GPL(pcm179x_of_match);
+
 int pcm179x_common_init(struct device *dev, struct regmap *regmap)
 {
 	struct pcm179x_private *pcm179x;
+	struct device_node *np = dev->of_node;
+	enum pcm179x_type codec_model = PCM1792A;
 
 	pcm179x = devm_kzalloc(dev, sizeof(struct pcm179x_private),
 				GFP_KERNEL);
 	if (!pcm179x)
 		return -ENOMEM;
 
+	if (np) {
+		const struct of_device_id *of_id;
+
+		of_id = of_match_device(pcm179x_of_match, dev);
+		if (of_id)
+			codec_model = (enum pcm179x_type) of_id->data;
+	}
+
+	if (codec_model)
+		pcm179x->codec_model =  codec_model;
+
 	pcm179x->regmap = regmap;
 	dev_set_drvdata(dev, pcm179x);
 
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index 11e3312..4c00047 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -17,10 +17,15 @@
 #ifndef __PCM179X_H__
 #define __PCM179X_H__
 
-#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
-			  SNDRV_PCM_FMTBIT_S16_LE)
+#define PCM179X_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S16_LE)
+
+#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
+
+#define PCM1795_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 extern const struct regmap_config pcm179x_regmap_config;
+extern const struct of_device_id pcm179x_of_match[];
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap);
 int pcm179x_common_exit(struct device *dev);
-- 
2.7.0

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
