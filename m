From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Allow digital mute for capture
Date: Wed,  6 Feb 2013 17:59:16 +0000
Message-ID: <1360173556-28048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC0AE26007E
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 18:59:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Help avoid noise from the power up of the capture path propagating through
into the start of the recording (especially noise caused by the ramp of
microphone biases) by keeping the capture muted until after we've finished
powering things up with DAPM in the same manner we do for playback. This
allows us to take advantage of soft mute support in the hardware more
effectively and is more consistent.

The core code using the existing digital mute operation is updated to take
advantage of this. Some additional cases in the soc-pcm code and suspend
will need separate handling but these are less practically relevant than
the main runtime stream start/stop case.

Rather than refactor the digital mute function in every single driver a
new operation is added for drivers taking advantage of this functionality,
the old operation should be phased out over time.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h  |    3 ++-
 sound/soc/soc-compress.c |   19 +++++++++----------
 sound/soc/soc-core.c     |   12 ++++++++++--
 sound/soc/soc-dapm.c     |    6 ++++--
 sound/soc/soc-pcm.c      |    7 +++----
 5 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 8bcdd71..6afdaf6 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -126,7 +126,8 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 
 /* Digital Audio Interface mute */
-int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute);
+int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
+			     int direction);
 
 struct snd_soc_dai_ops {
 	/*
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 35726cb..b5b3db7 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -116,12 +116,13 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		cpu_dai->playback_active--;
 		codec_dai->playback_active--;
-		snd_soc_dai_digital_mute(codec_dai, 1);
 	} else {
 		cpu_dai->capture_active--;
 		codec_dai->capture_active--;
 	}
 
+	snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+
 	cpu_dai->active--;
 	codec_dai->active--;
 	codec->active--;
@@ -178,15 +179,13 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
-		switch (cmd) {
-		case SNDRV_PCM_TRIGGER_START:
-			snd_soc_dai_digital_mute(codec_dai, 0);
-			break;
-		case SNDRV_PCM_TRIGGER_STOP:
-			snd_soc_dai_digital_mute(codec_dai, 1);
-			break;
-		}
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+		break;
 	}
 
 out:
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dcee552..1283d86 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3547,12 +3547,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
  * snd_soc_dai_digital_mute - configure DAI system or master clock.
  * @dai: DAI
  * @mute: mute enable
+ * @direction: stream to mute
  *
  * Mutes the DAI DAC.
  */
-int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
+int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
+			     int direction)
 {
-	if (dai->driver && dai->driver->ops->digital_mute)
+	if (!dai->driver)
+		return -ENOTSUPP;
+
+	if (dai->driver->ops->mute_stream)
+		return dai->driver->ops->mute_stream(dai, mute, direction);
+	else if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
+		 dai->driver->ops->digital_mute)
 		return dai->driver->ops->digital_mute(dai, mute);
 	else
 		return -ENOTSUPP;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 17dba18..1dc5b72 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3255,14 +3255,16 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_dai_digital_mute(sink, 0);
+		ret = snd_soc_dai_digital_mute(sink, 0,
+					       SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret != 0 && ret != -ENOTSUPP)
 			dev_warn(sink->dev, "ASoC: Failed to unmute: %d\n", ret);
 		ret = 0;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_dai_digital_mute(sink, 1);
+		ret = snd_soc_dai_digital_mute(sink, 1,
+					       SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret != 0 && ret != -ENOTSUPP)
 			dev_warn(sink->dev, "ASoC: Failed to mute: %d\n", ret);
 		ret = 0;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 786c2e7..a8d72a9 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -383,8 +383,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dai_digital_mute(codec_dai, 1);
+	snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
 
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
@@ -488,7 +487,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	snd_soc_dai_digital_mute(codec_dai, 0);
+	snd_soc_dai_digital_mute(codec_dai, 0, substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -586,7 +585,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* apply codec digital mute */
 	if (!codec->active)
-		snd_soc_dai_digital_mute(codec_dai, 1);
+		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
 
 	/* free any machine hw params */
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
-- 
1.7.10.4
