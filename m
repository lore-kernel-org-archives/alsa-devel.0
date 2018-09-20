From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: convert for_each_rtd_codec_dai() for
	missing part" to the asoc tree
Date: Thu, 20 Sep 2018 18:36:17 +0100 (BST)
Message-ID: <20180920173618.049A2440078@finisterre.ee.mobilebroadband>
References: <8736u7r47n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CA0626789F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:36:20 +0200 (CEST)
In-Reply-To: <8736u7r47n.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: convert for_each_rtd_codec_dai() for missing part

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

>From 7afecb3073e357ebfe4087e4ab8bb493c32bb652 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:28:04 +0000
Subject: [PATCH] ASoC: convert for_each_rtd_codec_dai() for missing part

commit 0b7990e38971 ("ASoC: add for_each_rtd_codec_dai() macro")
added for_each_rtd_codec_dai(), but it didn't convert few loop
which is not using "rtd". This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 79f5dd541d29..e387fff352c8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1301,6 +1301,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
+	struct snd_soc_dai *dai;
 	int i;
 
 	dev_dbg(card->dev, "ASoC: find BE for widget %s\n", widget->name);
@@ -1318,8 +1319,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->playback_widget == widget)
 				return be;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for_each_rtd_codec_dai(be, i, dai) {
 				if (dai->playback_widget == widget)
 					return be;
 			}
@@ -1338,8 +1338,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->capture_widget == widget)
 				return be;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for_each_rtd_codec_dai(be, i, dai) {
 				if (dai->capture_widget == widget)
 					return be;
 			}
@@ -1435,6 +1434,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list = *list_;
 	struct snd_soc_dapm_widget *widget;
+	struct snd_soc_dai *dai;
 	int prune = 0;
 
 	/* Destroy any old FE <--> BE connections */
@@ -1449,8 +1449,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 
 		/* is there a valid CODEC DAI widget for this BE */
-		for (i = 0; i < dpcm->be->num_codecs; i++) {
-			struct snd_soc_dai *dai = dpcm->be->codec_dais[i];
+		for_each_rtd_codec_dai(dpcm->be, i, dai) {
 			widget = dai_get_widget(dai, stream);
 
 			/* prune the BE if it's no longer in our active list */
@@ -1685,6 +1684,7 @@ static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_dai *dai;
 	int stream = substream->stream;
 
 	if (!fe->dai_link->dpcm_merged_format)
@@ -1701,16 +1701,15 @@ static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
 		struct snd_soc_pcm_stream *codec_stream;
 		int i;
 
-		for (i = 0; i < be->num_codecs; i++) {
+		for_each_rtd_codec_dai(be, i, dai) {
 			/*
 			 * Skip CODECs which don't support the current stream
 			 * type. See soc_pcm_init_runtime_hw() for more details
 			 */
-			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
-						      stream))
+			if (!snd_soc_dai_stream_valid(dai, stream))
 				continue;
 
-			codec_dai_drv = be->codec_dais[i]->driver;
+			codec_dai_drv = dai->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
@@ -1795,6 +1794,7 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
 		struct snd_soc_pcm_stream *cpu_stream;
+		struct snd_soc_dai *dai;
 		int i;
 
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -1806,16 +1806,15 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 		*rate_max = min_not_zero(*rate_max, cpu_stream->rate_max);
 		*rates = snd_pcm_rate_mask_intersect(*rates, cpu_stream->rates);
 
-		for (i = 0; i < be->num_codecs; i++) {
+		for_each_rtd_codec_dai(be, i, dai) {
 			/*
 			 * Skip CODECs which don't support the current stream
 			 * type. See soc_pcm_init_runtime_hw() for more details
 			 */
-			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
-						      stream))
+			if (!snd_soc_dai_stream_valid(dai, stream))
 				continue;
 
-			codec_dai_drv = be->codec_dais[i]->driver;
+			codec_dai_drv = dai->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
@@ -2784,6 +2783,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 	struct snd_soc_dpcm *dpcm;
 	struct list_head *clients =
 		&fe->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients;
+	struct snd_soc_dai *dai;
 
 	list_for_each_entry(dpcm, clients, list_be) {
 
@@ -2793,8 +2793,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 		if (be->dai_link->ignore_suspend)
 			continue;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			struct snd_soc_dai *dai = be->codec_dais[i];
+		for_each_rtd_codec_dai(be, i, dai) {
 			struct snd_soc_dai_driver *drv = dai->driver;
 
 			dev_dbg(be->dev, "ASoC: BE digital mute %s\n",
-- 
2.19.0
