From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Fix up some trivial
	formatting issues" to the asoc tree
Date: Fri, 11 May 2018 04:25:28 +0100 (BST)
Message-ID: <20180511032528.ED89544007A@finisterre.ee.mobilebroadband>
References: <20180426163007.5632-4-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01E00267677
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:25:37 +0200 (CEST)
In-Reply-To: <20180426163007.5632-4-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Fix up some trivial formatting issues

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 89027d9ebb5948392dd5a4ccc72d5a4eaa865537 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 26 Apr 2018 17:30:07 +0100
Subject: [PATCH] ASoC: compress: Fix up some trivial formatting issues

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 62875c6a93a1..e095115fa9f9 100644
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
@@ -428,7 +428,6 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 	else
 		stream = SNDRV_PCM_STREAM_CAPTURE;
 
-
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger) {
@@ -522,10 +521,10 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 
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
@@ -541,7 +540,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
-					struct snd_compr_params *params)
+				   struct snd_compr_params *params)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream =
@@ -612,7 +611,7 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_params(struct snd_compr_stream *cstream,
-					struct snd_codec *params)
+				struct snd_codec *params)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -646,7 +645,7 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_caps(struct snd_compr_stream *cstream,
-				struct snd_compr_caps *caps)
+			      struct snd_compr_caps *caps)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -672,7 +671,7 @@ static int soc_compr_get_caps(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
-				struct snd_compr_codec_caps *codec)
+				    struct snd_compr_codec_caps *codec)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -731,7 +730,7 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 }
 
 static int soc_compr_pointer(struct snd_compr_stream *cstream,
-			struct snd_compr_tstamp *tstamp)
+			     struct snd_compr_tstamp *tstamp)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -786,7 +785,7 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
-				struct snd_compr_metadata *metadata)
+				  struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -816,7 +815,7 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
-				struct snd_compr_metadata *metadata)
+				  struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
@@ -976,7 +975,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		break;
 	}
 
-
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction,
 				new_name, compr);
-- 
2.17.0
