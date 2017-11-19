From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ASoC: soc-pcm: Add some blank lines for
 better code readability
Date: Sun, 19 Nov 2017 21:21:41 +0100
Message-ID: <fc48c14e-3fdc-c84f-9079-fad8273ec28a@users.sourceforge.net>
References: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 705CC266E76
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 21:21:50 +0100 (CET)
In-Reply-To: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 20:37:58 +0100

Use blank lines at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ea771316afa9..dc1b984bd68e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -165,6 +165,7 @@ int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+
 	runtime->hw.info = hw->info;
 	runtime->hw.formats = hw->formats;
 	runtime->hw.period_bytes_min = hw->period_bytes_min;
@@ -1067,6 +1068,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 codec_err:
 	while (--i >= 0) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
@@ -1238,6 +1240,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 	}
 	return 0;
 }
+
 /*
  * soc level wrapper for pointer callback
  * If cpu_dai, codec_dai, platform driver has the delay callback, than
@@ -1403,6 +1406,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 
 			for (i = 0; i < be->num_codecs; i++) {
 				struct snd_soc_dai *dai = be->codec_dais[i];
+
 				if (dai->playback_widget == widget)
 					return be;
 			}
@@ -1419,6 +1423,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 
 			for (i = 0; i < be->num_codecs; i++) {
 				struct snd_soc_dai *dai = be->codec_dais[i];
+
 				if (dai->capture_widget == widget)
 					return be;
 			}
@@ -1469,6 +1474,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 
 			for (i = 0; i < rtd->num_codecs; ++i) {
 				struct snd_soc_dai *dai = rtd->codec_dais[i];
+
 				if (dai->playback_widget == widget)
 					return true;
 			}
@@ -1483,6 +1489,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 
 			for (i = 0; i < rtd->num_codecs; ++i) {
 				struct snd_soc_dai *dai = rtd->codec_dais[i];
+
 				if (dai->capture_widget == widget)
 					return true;
 			}
@@ -1530,6 +1537,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/* is there a valid CODEC DAI widget for this BE */
 		for (i = 0; i < dpcm->be->num_codecs; i++) {
 			struct snd_soc_dai *dai = dpcm->be->codec_dais[i];
+
 			widget = dai_get_widget(dai, stream);
 
 			/* prune the BE if it's no longer in our active list */
@@ -2603,6 +2611,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	/* disconnect any non started BEs */
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+
 		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 	}
@@ -2736,6 +2745,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 	mutex_unlock(&card->mutex);
 	return paths;
 }
+
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
@@ -3299,6 +3309,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+
 		params = &dpcm->hw_params;
 
 		offset += snprintf(buf + offset, size - offset,
-- 
2.15.0
