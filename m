From: Raphael Poggi <poggi.raph@gmail.com>
Subject: [PATCH 4/4] sound: codecs: pcm1792a: introduce channel side
Date: Fri, 20 Nov 2015 11:09:17 +0100
Message-ID: <1448014157-36526-5-git-send-email-raphael.poggi@avalun.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Raphael Poggi <poggi.raph@gmail.com>

Add possibility to choose the channel side using the device tree,
and also modify it using alsa ctrl.

Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
---
 sound/soc/codecs/pcm1792a.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index febaa48..005b679 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -65,6 +65,12 @@ static const struct reg_default pcm1792a_reg_defaults[] = {
 	{ PCM1792A_DEVICE_ID, 0x00 },
 };
 
+enum __pcm1792_side {
+	STEREO,
+	MONORAL_LEFT,
+	MONORAL_RIGHT
+};
+
 static bool pcm1792a_accessible_reg(struct device *dev, unsigned int reg)
 {
 	return reg >= 0x10 && reg <= 0x17;
@@ -83,6 +89,7 @@ struct pcm1792a_private {
 	struct regmap *regmap;
 	unsigned int format;
 	unsigned int rate;
+	unsigned int side;
 };
 
 static int pcm1792a_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -153,6 +160,13 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
 	ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
 				 PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
 
+	if (priv->side == MONORAL_LEFT)
+		val = PCM1792A_CHANNEL_MONO_LEFT;
+	else if (priv->side == MONORAL_RIGHT)
+		val = PCM1792A_CHANNEL_MONO_RIGHT;
+
+	regmap_update_bits(priv->regmap, PCM1792A_CHANNEL, PCM1792A_CHANNEL_MONO_MASK, val);
+
 	return ret;
 }
 
@@ -222,10 +236,31 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm1792a = {
 	.num_dapm_routes	= ARRAY_SIZE(pcm1792a_dapm_routes),
 };
 
+static int pcm1792a_of_init(struct spi_device *spi)
+{
+	int ret = 0;
+	struct pcm1792a_private *pcm1792a = dev_get_drvdata(&spi->dev);
+	const char *name;
+	struct device_node *np = spi->dev.of_node;
+
+	name = of_get_property(np, "ti,side", NULL);
+	if (name) {
+		if (!strcmp(name, "left"))
+			pcm1792a->side = MONORAL_LEFT;
+		else
+			pcm1792a->side = MONORAL_RIGHT;
+	}
+	else
+		pcm1792a->side = STEREO;
+
+	return ret;
+}
+
 static int pcm1792a_spi_probe(struct spi_device *spi)
 {
 	struct pcm1792a_private *pcm1792a;
 	int ret;
+	struct device_node *np = spi->dev.of_node;
 
 	pcm1792a = devm_kzalloc(&spi->dev, sizeof(struct pcm1792a_private),
 				GFP_KERNEL);
@@ -241,6 +276,17 @@ static int pcm1792a_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	if (np) {
+		ret = pcm1792a_of_init(spi);
+		if (ret)
+			return ret;
+	}
+
+	if (pcm1792a->side == MONORAL_LEFT)
+		regmap_update_bits(pcm1792a->regmap, PCM1792A_CHANNEL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_LEFT);
+	else if (pcm1792a->side == MONORAL_RIGHT)
+		regmap_update_bits(pcm1792a->regmap, PCM1792A_CHANNEL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_RIGHT);
+
 	return snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_pcm1792a, &pcm1792a_dai, 1);
 }
-- 
2.1.0
