From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: Handle ignore_pmdown_time for CODEC
	to CODEC links
Date: Wed,  5 Mar 2014 13:17:42 +0100
Message-ID: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B6726509A
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:20 +0100 (CET)
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

For CODEC to CODEC links we should only immediately power down if both CODECs
are configured to ignore the power down delay. Factor the logic for this
into a helper function that can be used for both compressed and normal PCMs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h      |  2 ++
 sound/soc/soc-compress.c |  3 +--
 sound/soc/soc-pcm.c      | 27 +++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a00147..93c31c7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -413,6 +413,8 @@ struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 		const char *dai_link);
 
+bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd);
+
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 5e9690c..ef585af 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -235,8 +235,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	cpu_dai->runtime = NULL;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
-		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
-		    rtd->dai_link->ignore_pmdown_time) {
+		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
 			snd_soc_dapm_stream_event(rtd,
 					SNDRV_PCM_STREAM_PLAYBACK,
 					SND_SOC_DAPM_STREAM_STOP);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 47e1ce7..f098c80 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -35,6 +35,30 @@
 #define DPCM_MAX_BE_USERS	8
 
 /**
+ * snd_soc_runtime_ignore_pmdown_time() - Check whether to ignore the power down delay
+ * @rtd: The ASoC PCM runtime that should be checked.
+ *
+ * This function checks whether the power down delay should be ignored for a
+ * specific PCM runtime. Returns true if the delay is 0, if it the DAI link has
+ * been configured to ignore the delay, or if none of the components benefits
+ * from having the delay.
+ */
+bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
+{
+	bool ignore = true;
+
+	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
+		return true;
+
+	if (rtd->cpu_dai->codec)
+		ignore &= rtd->cpu_dai->codec->ignore_pmdown_time;
+
+	ignore &= rtd->codec_dai->codec->ignore_pmdown_time;
+
+	return ignore;
+}
+
+/**
  * snd_soc_set_runtime_hwparams - set the runtime hardware parameters
  * @substream: the pcm substream
  * @hw: the hardware parameters
@@ -496,8 +520,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
-		    rtd->dai_link->ignore_pmdown_time) {
+		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
 						  SNDRV_PCM_STREAM_PLAYBACK,
-- 
1.8.0
