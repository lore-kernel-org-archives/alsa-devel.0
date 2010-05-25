From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 7/7] ASoC: TWL4030: Use BIAS_OFF instead of
	BIAS_STANDBY, when not in use
Date: Tue, 25 May 2010 14:34:08 +0300
Message-ID: <1274787248-18583-8-git-send-email-peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D5BBC24483
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:34:36 +0200 (CEST)
In-Reply-To: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Restructure the codec power code in order to be able to hit
off when the codec is not in use.

Since the audio registers are accessible while the codec is powered
down, there is no need for additional safety mechanism.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   86 ++++++++++++++++++++++++++------------------
 1 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 72a19ce..79d1cf9 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1818,13 +1818,6 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (mode != old_mode) {
-		/* change rate and set CODECPDZ */
-		twl4030_codec_enable(codec, 0);
-		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
-		twl4030_codec_enable(codec, 1);
-	}
-
 	/* sample size */
 	old_format = twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF);
 	format = old_format;
@@ -1842,16 +1835,20 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (format != old_format) {
-
-		/* clear CODECPDZ before changing format (codec requirement) */
-		twl4030_codec_enable(codec, 0);
-
-		/* change format */
-		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
-
-		/* set CODECPDZ afterwards */
-		twl4030_codec_enable(codec, 1);
+	if (format != old_format || mode != old_mode) {
+		if (twl4030->codec_powered) {
+			/*
+			 * If the codec is powered, than we need to toggle the
+			 * codec power.
+			 */
+			twl4030_codec_enable(codec, 0);
+			twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+			twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+			twl4030_codec_enable(codec, 1);
+		} else {
+			twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+			twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+		}
 	}
 
 	/* Store the important parameters for the DAI configuration and set
@@ -1901,6 +1898,7 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			     unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_format, format;
 
 	/* get format */
@@ -1935,15 +1933,17 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	if (format != old_format) {
-
-		/* clear CODECPDZ before changing format (codec requirement) */
-		twl4030_codec_enable(codec, 0);
-
-		/* change format */
-		twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
-
-		/* set CODECPDZ afterwards */
-		twl4030_codec_enable(codec, 1);
+		if (twl4030->codec_powered) {
+			/*
+			 * If the codec is powered, than we need to toggle the
+			 * codec power.
+			 */
+			twl4030_codec_enable(codec, 0);
+			twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+			twl4030_codec_enable(codec, 1);
+		} else {
+			twl4030_write(codec, TWL4030_REG_AUDIO_IF, format);
+		}
 	}
 
 	return 0;
@@ -2035,6 +2035,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_mode, mode;
 
 	/* Enable voice digital filters */
@@ -2059,10 +2060,17 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (mode != old_mode) {
-		/* change rate and set CODECPDZ */
-		twl4030_codec_enable(codec, 0);
-		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
-		twl4030_codec_enable(codec, 1);
+		if (twl4030->codec_powered) {
+			/*
+			 * If the codec is powered, than we need to toggle the
+			 * codec power.
+			 */
+			twl4030_codec_enable(codec, 0);
+			twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+			twl4030_codec_enable(codec, 1);
+		} else {
+			twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+		}
 	}
 
 	return 0;
@@ -2092,6 +2100,7 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_format, format;
 
 	/* get format */
@@ -2123,10 +2132,17 @@ static int twl4030_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	if (format != old_format) {
-		/* change format and set CODECPDZ */
-		twl4030_codec_enable(codec, 0);
-		twl4030_write(codec, TWL4030_REG_VOICE_IF, format);
-		twl4030_codec_enable(codec, 1);
+		if (twl4030->codec_powered) {
+			/*
+			 * If the codec is powered, than we need to toggle the
+			 * codec power.
+			 */
+			twl4030_codec_enable(codec, 0);
+			twl4030_write(codec, TWL4030_REG_VOICE_IF, format);
+			twl4030_codec_enable(codec, 1);
+		} else {
+			twl4030_write(codec, TWL4030_REG_VOICE_IF, format);
+		}
 	}
 
 	return 0;
@@ -2235,7 +2251,6 @@ static int twl4030_soc_probe(struct platform_device *pdev)
 	socdev->card->codec = codec;
 
 	twl4030_init_chip(pdev);
-	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
@@ -2296,6 +2311,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 	codec->read = twl4030_read_reg_cache;
 	codec->write = twl4030_write;
 	codec->set_bias_level = twl4030_set_bias_level;
+	codec->idle_bias_off = 1;
 	codec->dai = twl4030_dai;
 	codec->num_dai = ARRAY_SIZE(twl4030_dai);
 	codec->reg_cache_size = sizeof(twl4030_reg);
-- 
1.7.1
