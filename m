From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Add constrains for second
	stream
Date: Fri, 27 Mar 2009 10:39:08 +0200
Message-ID: <1238143148-31894-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1238143148-31894-1-git-send-email-peter.ujfalusi@nokia.com>
	<1238143148-31894-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4109A10388F
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 09:39:17 +0100 (CET)
In-Reply-To: <1238143148-31894-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

In case of duplex mode (capture and playback at the same time), the second
stream has to have the same parameters (rate, sample size) as the already
running stream.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   54 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index b07d8d6..4199498 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -122,6 +122,9 @@ struct twl4030_priv {
 	unsigned int bypass_state;
 	unsigned int codec_powered;
 	unsigned int codec_muted;
+
+	struct snd_pcm_substream *master_substream;
+	struct snd_pcm_substream *slave_substream;
 };
 
 /*
@@ -1217,6 +1220,50 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static int twl4030_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+
+	/* If we already have a playback or capture going then constrain
+	 * this substream to match it.
+	 */
+	if (twl4030->master_substream) {
+		struct snd_pcm_runtime *master_runtime;
+		master_runtime = twl4030->master_substream->runtime;
+
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_RATE,
+					     master_runtime->rate,
+					     master_runtime->rate);
+
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+					     master_runtime->sample_bits,
+					     master_runtime->sample_bits);
+
+		twl4030->slave_substream = substream;
+	} else
+		twl4030->master_substream = substream;
+
+	return 0;
+}
+
+static void twl4030_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
+
+	if (twl4030->master_substream == substream)
+		twl4030->master_substream = twl4030->slave_substream;
+
+	twl4030->slave_substream = NULL;
+}
+
 static int twl4030_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -1224,8 +1271,13 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 mode, old_mode, format, old_format;
 
+	if (substream == twl4030->slave_substream)
+		/* Ignoring hw_params for slave substream */
+		return 0;
+
 	/* bit rate */
 	old_mode = twl4030_read_reg_cache(codec,
 			TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
@@ -1384,6 +1436,8 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
 static struct snd_soc_dai_ops twl4030_dai_ops = {
+	.startup	= twl4030_startup,
+	.shutdown	= twl4030_shutdown,
 	.hw_params	= twl4030_hw_params,
 	.set_sysclk	= twl4030_set_dai_sysclk,
 	.set_fmt	= twl4030_set_dai_fmt,
-- 
1.6.2
