From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: [PATCH V2] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Sun, 10 Jan 2016 18:38:18 +0100
Message-ID: <20160110173812.GA16304@panicking>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160110120045.GW6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
---
Changes v1 -> v2:
	- Use switch for support new variants
	- sort the compatible list

 sound/soc/codecs/pcm179x.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/pcm179x.h | 14 +++++++-----
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index a56c7b7..8784d52 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -74,8 +74,31 @@ struct pcm179x_private {
 	struct regmap *regmap;
 	unsigned int format;
 	unsigned int rate;
+#define PCM1795	1
+	unsigned int codec_model;
 };
 
+static int pcm179x_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	u64 formats;
+
+	switch (priv->codec_model) {
+	case PCM1795:
+		formats = PCM1795_FORMATS;
+		break;
+	default:
+		formats = PCM1792A_FORMATS;
+	}
+
+	snd_pcm_hw_constraint_mask64(substream->runtime,
+				     SNDRV_PCM_HW_PARAM_FORMAT, formats);
+
+	return 0;
+}
+
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
                              unsigned int format)
 {
@@ -114,8 +137,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
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
@@ -127,8 +152,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
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
@@ -154,6 +181,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops pcm179x_dai_ops = {
+	.startup	= pcm179x_startup,
 	.set_fmt	= pcm179x_set_dai_fmt,
 	.hw_params	= pcm179x_hw_params,
 	.digital_mute	= pcm179x_digital_mute,
@@ -189,13 +217,19 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = PCM1792A_RATES,
-		.formats = PCM1792A_FORMATS, },
+		.rates = PCM179X_RATES,
+		.formats = PCM179X_FORMATS, },
 	.ops = &pcm179x_dai_ops,
 };
 
+static const unsigned int codec_model = PCM1795;
+
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
+	{ .compatible = "ti,pcm1795",
+	  .data = &codec_model,
+	},
+	{ .compatible = "ti,pcm1796", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm179x_of_match);
@@ -222,8 +256,19 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
 static int pcm179x_spi_probe(struct spi_device *spi)
 {
 	struct pcm179x_private *pcm179x;
+	struct device *dev = &spi->dev;
+	struct device_node *np = spi->dev.of_node;
+	const unsigned int *codec_model = NULL;
 	int ret;
 
+	if (np) {
+		const struct of_device_id *of_id;
+
+		of_id = of_match_device(pcm179x_of_match, dev);
+		if (of_id)
+			codec_model = of_id->data;
+	}
+
 	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
 				GFP_KERNEL);
 	if (!pcm179x)
@@ -238,6 +283,9 @@ static int pcm179x_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	if (codec_model)
+		pcm179x->codec_model =  *codec_model;
+
 	return snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
 }
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index c6fdc06..d4b384d 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -17,11 +17,15 @@
 #ifndef __PCM179X_H__
 #define __PCM179X_H__
 
-#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-			SNDRV_PCM_RATE_192000)
+#define PCM179X_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
+		       SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
+		       SNDRV_PCM_RATE_192000)
 
-#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
-			  SNDRV_PCM_FMTBIT_S16_LE)
+#define PCM179X_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S16_LE)
+
+#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
+
+#define PCM1795_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 #endif
-- 
2.7.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
