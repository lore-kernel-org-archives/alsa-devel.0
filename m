From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: make BE and FE order inline
	with dpcm" to the asoc tree
Date: Tue,  7 Aug 2018 15:39:58 +0100 (BST)
Message-ID: <20180807143958.7DCBE112433B@debutante.sirena.org.uk>
References: <20180803123003.13444-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1EA267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 16:40:05 +0200 (CEST)
In-Reply-To: <20180803123003.13444-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, ckeepax@opensource.cirrus.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, ramesh.babu@intel.com, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org, namartax.kohli@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: make BE and FE order inline with dpcm

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

>From 0b0722e191757ca6851382d78c15277ca9c5c211 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 3 Aug 2018 13:30:03 +0100
Subject: [PATCH] ASoC: compress: make BE and FE order inline with dpcm

For some reason order of startup/hw_params/prepare are reversed
in dynamic compress usecase when compared to dpcm usecase. This is
a issue with platforms like QCOM where it expects the BE to be
initialized before FE.

Interestingly the compress trigger callback order is inline with dpcm.

Am not 100% sure why the compress audio case has been reversed.
This patch is making the order inline with dpcm.

If the reverse ordering is just co-incendental then this change
makes sense and will avoid inventing some new mechanism to cope
with ordering.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 96 +++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b9e1673fea51..409d082e80d1 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -140,6 +140,30 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		stream = SNDRV_PCM_STREAM_CAPTURE;
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	fe->dpcm[stream].runtime = fe_substream->runtime;
+
+	ret = dpcm_path_get(fe, stream, &list);
+	if (ret < 0)
+		goto be_err;
+	else if (ret == 0)
+		dev_dbg(fe->dev, "Compress ASoC: %s no valid %s route\n",
+			fe->dai_link->name, stream ? "capture" : "playback");
+	/* calculate valid and active FE <-> BE dpcms */
+	dpcm_process_paths(fe, stream, &list, 1);
+	fe->dpcm[stream].runtime = fe_substream->runtime;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	ret = dpcm_be_dai_startup(fe, stream);
+	if (ret < 0) {
+		/* clean up all links */
+		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+
+		dpcm_be_disconnect(fe, stream);
+		fe->dpcm[stream].runtime = NULL;
+		goto out;
+	}
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
 		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
@@ -153,7 +177,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	ret = soc_compr_components_open(cstream, &component);
 	if (ret < 0)
-		goto machine_err;
+		goto open_err;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
@@ -164,31 +188,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-	fe->dpcm[stream].runtime = fe_substream->runtime;
-
-	ret = dpcm_path_get(fe, stream, &list);
-	if (ret < 0)
-		goto fe_err;
-	else if (ret == 0)
-		dev_dbg(fe->dev, "Compress ASoC: %s no valid %s route\n",
-			fe->dai_link->name, stream ? "capture" : "playback");
-
-	/* calculate valid and active FE <-> BE dpcms */
-	dpcm_process_paths(fe, stream, &list, 1);
-
-	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
-
-	ret = dpcm_be_dai_startup(fe, stream);
-	if (ret < 0) {
-		/* clean up all links */
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
-			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
-
-		dpcm_be_disconnect(fe, stream);
-		fe->dpcm[stream].runtime = NULL;
-		goto path_err;
-	}
-
 	dpcm_clear_pending_state(fe, stream);
 	dpcm_path_put(&list);
 
@@ -201,17 +200,14 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	return 0;
 
-path_err:
-	dpcm_path_put(&list);
-fe_err:
-	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
-		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
 	soc_compr_components_free(cstream, component);
-
+open_err:
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
 out:
+	dpcm_path_put(&list);
+be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	mutex_unlock(&fe->card->mutex);
 	return ret;
@@ -551,6 +547,24 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	/*
+	 * Create an empty hw_params for the BE as the machine driver must
+	 * fix this up to match DSP decoder and ASRC configuration.
+	 * I.e. machine driver fixup for compressed BE is mandatory.
+	 */
+	memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
+		sizeof(struct snd_pcm_hw_params));
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	ret = dpcm_be_dai_hw_params(fe, stream);
+	if (ret < 0)
+		goto out;
+
+	ret = dpcm_be_dai_prepare(fe, stream);
+	if (ret < 0)
+		goto out;
+
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_params) {
 		ret = cpu_dai->driver->cops->set_params(cstream, params, cpu_dai);
 		if (ret < 0)
@@ -577,24 +591,6 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
-	/*
-	 * Create an empty hw_params for the BE as the machine driver must
-	 * fix this up to match DSP decoder and ASRC configuration.
-	 * I.e. machine driver fixup for compressed BE is mandatory.
-	 */
-	memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
-		sizeof(struct snd_pcm_hw_params));
-
-	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
-
-	ret = dpcm_be_dai_hw_params(fe, stream);
-	if (ret < 0)
-		goto out;
-
-	ret = dpcm_be_dai_prepare(fe, stream);
-	if (ret < 0)
-		goto out;
-
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 
-- 
2.18.0
