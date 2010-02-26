From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ASoC: Allow mulitple usage count of codec and
	cpu dai
Date: Fri, 26 Feb 2010 09:12:32 +0900
Message-ID: <1267143152-15861-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 901F910399C
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:24:11 +0100 (CET)
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

If we are to have a snd_soc_dai i.e, cpu_dai and codec_dai, shared among two
or more dai_links we need to log the number of active users of the dai.
For that, we change semantics of the snd_soc_dai.active flag from indicator
to reference counter.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 include/sound/soc.h  |    2 +-
 sound/soc/soc-core.c |   31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

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
index 2b66719..0211369 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
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
@@ -534,15 +538,16 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 
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
-- 
1.6.2.5
