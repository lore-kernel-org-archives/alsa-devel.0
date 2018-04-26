From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: compress: Fix up some trivial
	formatting issues
Date: Thu, 26 Apr 2018 17:30:07 +0100
Message-ID: <20180426163007.5632-4-ckeepax@opensource.cirrus.com>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C8C2677F6
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 18:30:14 +0200 (CEST)
In-Reply-To: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: vinod.koul@intel.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-compress.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3d107652b7ca3..e661182716608 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -287,8 +287,8 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
 			snd_soc_dapm_stream_event(rtd,
-					SNDRV_PCM_STREAM_PLAYBACK,
-					SND_SOC_DAPM_STREAM_STOP);
+						  SNDRV_PCM_STREAM_PLAYBACK,
+						  SND_SOC_DAPM_STREAM_STOP);
 		} else {
 			rtd->pop_wait = 1;
 			queue_delayed_work(system_power_efficient_wq,
@@ -298,8 +298,8 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(rtd,
-			SNDRV_PCM_STREAM_CAPTURE,
-			SND_SOC_DAPM_STREAM_STOP);
+					  SNDRV_PCM_STREAM_CAPTURE,
+					  SND_SOC_DAPM_STREAM_STOP);
 	}
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -423,7 +423,6 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 	else
 		stream = SNDRV_PCM_STREAM_CAPTURE;
 
-
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger) {
@@ -518,10 +517,10 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
-					SND_SOC_DAPM_STREAM_START);
+					  SND_SOC_DAPM_STREAM_START);
 	else
 		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
-					SND_SOC_DAPM_STREAM_START);
+					  SND_SOC_DAPM_STREAM_START);
 
 	/* cancel any delayed stream shutdown that is pending */
 	rtd->pop_wait = 0;
@@ -537,7 +536,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
-					struct snd_compr_params *params)
+				   struct snd_compr_params *params)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream =
@@ -596,7 +595,7 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_params(struct snd_compr_stream *cstream,
-					struct snd_codec *params)
+				struct snd_codec *params)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -629,7 +628,7 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_caps(struct snd_compr_stream *cstream,
-				struct snd_compr_caps *caps)
+			      struct snd_compr_caps *caps)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -654,7 +653,7 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
-				struct snd_compr_codec_caps *codec)
+				    struct snd_compr_codec_caps *codec)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -713,7 +712,7 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 }
 
 static int soc_compr_pointer(struct snd_compr_stream *cstream,
-			struct snd_compr_tstamp *tstamp)
+			     struct snd_compr_tstamp *tstamp)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -767,7 +766,7 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
-				struct snd_compr_metadata *metadata)
+				  struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -798,7 +797,7 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
-				struct snd_compr_metadata *metadata)
+				  struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -957,7 +956,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		break;
 	}
 
-
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction,
 				new_name, compr);
-- 
2.11.0
