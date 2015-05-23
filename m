From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask
Date: Sat, 23 May 2015 18:32:29 +0200
Message-ID: <5560AB9D.1010807@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <daniel@zonque.org>, Wolfram Sang <wsa@the-dreams.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_pcm_stream.formats is a bitmask of SNDRV_PCM_FMTBIT_*,
not of SNDRV_PCM_FORMAT_* (which are sequential integers),
however some of ASoC CODEC drivers use these values instead.

Found out by sparse on 0-day kernel tester.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index ee31fa7..38b3dad 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1186,16 +1186,16 @@ static struct snd_soc_dai_driver pm860x_dai[] = {
 			.channels_min	= 2,
 			.channels_max	= 2,
 			.rates		= PM860X_RATES,
-			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
-					  SNDRV_PCM_FORMAT_S18_3LE,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE | \
+					  SNDRV_PCM_FMTBIT_S18_3LE,
 		},
 		.capture = {
 			.stream_name	= "PCM Capture",
 			.channels_min	= 2,
 			.channels_max	= 2,
 			.rates		= PM860X_RATES,
-			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
-					  SNDRV_PCM_FORMAT_S18_3LE,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE | \
+					  SNDRV_PCM_FMTBIT_S18_3LE,
 		},
 		.ops	= &pm860x_pcm_dai_ops,
 	}, {
@@ -1207,16 +1207,16 @@ static struct snd_soc_dai_driver pm860x_dai[] = {
 			.channels_min	= 2,
 			.channels_max	= 2,
 			.rates		= SNDRV_PCM_RATE_8000_48000,
-			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
-					  SNDRV_PCM_FORMAT_S18_3LE,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE | \
+					  SNDRV_PCM_FMTBIT_S18_3LE,
 		},
 		.capture = {
 			.stream_name	= "I2S Capture",
 			.channels_min	= 2,
 			.channels_max	= 2,
 			.rates		= SNDRV_PCM_RATE_8000_48000,
-			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
-					  SNDRV_PCM_FORMAT_S18_3LE,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE | \
+					  SNDRV_PCM_FMTBIT_S18_3LE,
 		},
 		.ops	= &pm860x_i2s_dai_ops,
 	},
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 2341e8e..ed4cca7 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -320,7 +320,7 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_32000 | \
 			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE,
+		.formats = SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE,
 	},
 	/* alsa ops */
 	.ops = &stac9766_dai_ops_digital,
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index e7d2ecd..493faf5 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -998,8 +998,8 @@ static int wm8900_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 		      SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 
 #define WM8900_PCM_FORMATS \
-	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
-	 SNDRV_PCM_FORMAT_S24_LE)
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops wm8900_dai_ops = {
 	.hw_params	= wm8900_hw_params,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 9d18a0e..89cd2d6 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1054,8 +1054,8 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			  SNDRV_PCM_RATE_48000)
 
 #define WM9713_PCM_FORMATS \
-	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
-	 SNDRV_PCM_FORMAT_S24_LE)
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops wm9713_dai_ops_hifi = {
 	.prepare	= ac97_hifi_prepare,
