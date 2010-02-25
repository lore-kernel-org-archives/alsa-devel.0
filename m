From: Jassi Brar <jassi.brar@samsung.com>
Subject: [RFC] ASoC: Allow mulitple usage of codec and cpu dai
Date: Thu, 25 Feb 2010 13:26:51 +0900
Message-ID: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A29191037E3
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 05:38:53 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

We can have a snd_soc_dai i.e, cpu_dai and codec_dai, shared among two or more
dai_links by avoiding shutting-down/powering-up if the dai is already in
an appropriate state.
For that, we change semantics of the snd_soc_dai.active flag from indicator
to reference counter.

This patch only attempts to block duplicate startup/shutdown and the mute
callbacks, presuming currently no dai driver anticipates 'dai reuse'.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 include/sound/soc.h  |    2 +-
 sound/soc/soc-core.c |   47 ++++++++++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 20 deletions(-)

The codec->active can also be deducted by codec_dai->capture/playback.active
So, we can get rid of snd_soc_codec.active field as well to reduce number of
variables we have to manage in future while making delicate changes in ASoC.

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 27a2ad9..f792c18 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -375,7 +375,7 @@ struct snd_soc_pcm_stream {
 	unsigned int rate_max;		/* max rate */
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
-	unsigned int active:1;		/* stream is in use */
+	unsigned int active;		/* num of active users of the stream */
 };
 
 /* SoC audio ops */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2b66719..459f1f5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -352,7 +352,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&pcm_mutex);
 
 	/* startup the audio subsystem */
-	if (cpu_dai->ops->startup) {
+	if (cpu_dai->active == 0 && cpu_dai->ops->startup) {
 		ret = cpu_dai->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open interface %s\n",
@@ -369,7 +369,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->ops->startup) {
+	if (codec_dai->active == 0 && codec_dai->ops->startup) {
 		ret = codec_dai->ops->startup(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open codec %s\n",
@@ -454,11 +454,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	pr_debug("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
 		 runtime->hw.rate_max);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->playback.active = codec_dai->playback.active = 1;
-	else
-		cpu_dai->capture.active = codec_dai->capture.active = 1;
-	cpu_dai->active = codec_dai->active = 1;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		cpu_dai->playback.active++;
+		codec_dai->playback.active++;
+	} else {
+		cpu_dai->capture.active++;
+		codec_dai->capture.active++;
+	}
+	cpu_dai->active++;
+	codec_dai->active++;
 	card->codec->active++;
 	mutex_unlock(&pcm_mutex);
 	return 0;
@@ -534,27 +538,28 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 
 	mutex_lock(&pcm_mutex);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->playback.active = codec_dai->playback.active = 0;
-	else
-		cpu_dai->capture.active = codec_dai->capture.active = 0;
-
-	if (codec_dai->playback.active == 0 &&
-		codec_dai->capture.active == 0) {
-		cpu_dai->active = codec_dai->active = 0;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		cpu_dai->playback.active--;
+		codec_dai->playback.active--;
+	} else {
+		cpu_dai->capture.active--;
+		codec_dai->capture.active--;
 	}
+
+	cpu_dai->active--;
+	codec_dai->active--;
 	codec->active--;
 
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (codec_dai->active == 0 && substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		snd_soc_dai_digital_mute(codec_dai, 1);
 
-	if (cpu_dai->ops->shutdown)
+	if (cpu_dai->active == 0 && cpu_dai->ops->shutdown)
 		cpu_dai->ops->shutdown(substream, cpu_dai);
 
-	if (codec_dai->ops->shutdown)
+	if (codec_dai->active == 0 && codec_dai->ops->shutdown)
 		codec_dai->ops->shutdown(substream, codec_dai);
 
 	if (machine->ops && machine->ops->shutdown)
@@ -563,6 +568,10 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	if (platform->pcm_ops->close)
 		platform->pcm_ops->close(substream);
 
+	/* Skip DAPM if codec is still active via some other dai_link */
+	if (codec_dai->active)
+		goto exit;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* start delayed pop wq here for playback streams */
 		codec_dai->pop_wait = 1;
@@ -574,7 +583,7 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 			codec_dai->capture.stream_name,
 			SND_SOC_DAPM_STREAM_STOP);
 	}
-
+exit:
 	mutex_unlock(&pcm_mutex);
 	return 0;
 }
-- 
1.6.2.5
