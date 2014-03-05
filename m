From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: Add helper functions for PCM runtime
	'active' management
Date: Wed,  5 Mar 2014 13:17:43 +0100
Message-ID: <1394021868-11860-2-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 2585226507D
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:20 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We have the same code that increments and decrements the active field of the
various PCM runtime components (all with the same bugs). Factor this out into
common helper functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h      |  2 ++
 sound/soc/soc-compress.c | 62 +++++++---------------------------
 sound/soc/soc-pcm.c      | 86 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 78 insertions(+), 72 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93c31c7..53d15e0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -414,6 +414,8 @@ struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 		const char *dai_link);
 
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd);
+void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream);
+void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index ef585af..91083e6 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -30,8 +30,6 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -52,17 +50,7 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 		}
 	}
 
-	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
-		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
-	} else {
-		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
-	}
-
-	cpu_dai->active++;
-	codec_dai->active++;
-	rtd->codec->active++;
+	snd_soc_runtime_activate(rtd, cstream->direction);
 
 	mutex_unlock(&rtd->pcm_mutex);
 
@@ -81,8 +69,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
 	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	struct snd_soc_dai *codec_dai = fe->codec_dai;
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
 	int stream;
@@ -140,17 +126,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 
-	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
-		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
-	} else {
-		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
-	}
-
-	cpu_dai->active++;
-	codec_dai->active++;
-	fe->codec->active++;
+	snd_soc_runtime_activate(fe, stream);
 
 	mutex_unlock(&fe->card->mutex);
 
@@ -202,23 +178,18 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
+	int stream;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
-		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
-	} else {
-		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
-	}
+	if (cstream->direction == SND_COMPRESS_PLAYBACK)
+		stream = SNDRV_PCM_STREAM_PLAYBACK;
+	else
+		stream = SNDRV_PCM_STREAM_CAPTURE;
 
-	snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+	snd_soc_runtime_deactivate(rtd, stream);
 
-	cpu_dai->active--;
-	codec_dai->active--;
-	codec->active--;
+	snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
 
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
@@ -260,26 +231,17 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_soc_platform *platform = fe->platform;
-	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
-	struct snd_soc_dai *codec_dai = fe->codec_dai;
 	struct snd_soc_dpcm *dpcm;
 	int stream, ret;
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
-	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
+	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
-		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
-	} else {
+	else
 		stream = SNDRV_PCM_STREAM_CAPTURE;
-		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
-	}
 
-	cpu_dai->active--;
-	codec_dai->active--;
-	fe->codec->active--;
+	snd_soc_runtime_deactivate(fe, stream);
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f098c80..1a98575 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -35,6 +35,66 @@
 #define DPCM_MAX_BE_USERS	8
 
 /**
+ * snd_soc_runtime_activate() - Increment active count for PCM runtime components
+ * @rtd: ASoC PCM runtime that is activated
+ * @stream: Direction of the PCM stream
+ *
+ * Increments the active count for all the DAIs and components attached to a PCM
+ * runtime. Should typically be called when a stream is opened.
+ *
+ * Must be called with the rtd->pcm_mutex being held
+ */
+void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	lockdep_assert_held(&rtd->pcm_mutex);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		cpu_dai->playback_active++;
+		codec_dai->playback_active++;
+	} else {
+		cpu_dai->capture_active++;
+		codec_dai->capture_active++;
+	}
+
+	cpu_dai->active++;
+	codec_dai->active++;
+	rtd->codec->active++;
+}
+
+/**
+ * snd_soc_runtime_deactivate() - Decrement active count for PCM runtime components
+ * @rtd: ASoC PCM runtime that is deactivated
+ * @stream: Direction of the PCM stream
+ *
+ * Decrements the active count for all the DAIs and components attached to a PCM
+ * runtime. Should typically be called when a stream is closed.
+ *
+ * Must be called with the rtd->pcm_mutex being held
+ */
+void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	lockdep_assert_held(&rtd->pcm_mutex);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		cpu_dai->playback_active--;
+		codec_dai->playback_active--;
+	} else {
+		cpu_dai->capture_active--;
+		codec_dai->capture_active--;
+	}
+
+	cpu_dai->active--;
+	codec_dai->active--;
+	rtd->codec->active--;
+}
+
+/**
  * snd_soc_runtime_ignore_pmdown_time() - Check whether to ignore the power down delay
  * @rtd: The ASoC PCM runtime that should be checked.
  *
@@ -402,16 +462,9 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		 runtime->hw.rate_max);
 
 dynamic:
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
-	} else {
-		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
-	}
-	cpu_dai->active++;
-	codec_dai->active++;
-	rtd->codec->active++;
+
+	snd_soc_runtime_activate(rtd, substream->stream);
+
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 
@@ -483,21 +536,10 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
-	} else {
-		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
-	}
-
-	cpu_dai->active--;
-	codec_dai->active--;
-	codec->active--;
+	snd_soc_runtime_deactivate(rtd, substream->stream);
 
 	/* clear the corresponding DAIs rate when inactive */
 	if (!cpu_dai->active)
-- 
1.8.0
