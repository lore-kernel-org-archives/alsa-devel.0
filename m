From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_dpcm_be() macro" to the
	asoc tree
Date: Thu, 20 Sep 2018 18:35:17 +0100 (BST)
Message-ID: <20180920173517.673D5440078@finisterre.ee.mobilebroadband>
References: <87lg7zppi2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FFBA26789E
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:20 +0200 (CEST)
In-Reply-To: <87lg7zppi2.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_dpcm_be() macro

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

>From 8d6258a4dd267838e2f10643c3d91b79fe75ef6e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:31:09 +0000
Subject: [PATCH] ASoC: add for_each_dpcm_be() macro

To be more readable code, this patch adds
new for_each_dpcm_be() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dpcm.h     |  7 ++++++
 sound/soc/fsl/fsl_asrc_dma.c |  2 +-
 sound/soc/sh/rcar/ctu.c      |  2 +-
 sound/soc/sh/rcar/src.c      |  2 +-
 sound/soc/soc-compress.c     |  4 +--
 sound/soc/soc-pcm.c          | 48 +++++++++++++++++-------------------
 6 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index f130de6cfe8e..4be3a2b7c106 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -106,6 +106,13 @@ struct snd_soc_dpcm_runtime {
 #define for_each_dpcm_fe(be, stream, dpcm)				\
 	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
 
+#define for_each_dpcm_be(fe, stream, dpcm)				\
+	list_for_each_entry(dpcm, &(fe)->dpcm[stream].be_clients, list_be)
+#define for_each_dpcm_be_safe(fe, stream, dpcm, _dpcm)			\
+	list_for_each_entry_safe(dpcm, _dpcm, &(fe)->dpcm[stream].be_clients, list_be)
+#define for_each_dpcm_be_rollback(fe, stream, dpcm)			\
+	list_for_each_entry_continue_reverse(dpcm, &(fe)->dpcm[stream].be_clients, list_be)
+
 /* can this BE stop and free */
 int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 1033ac6631b0..01052a0808b0 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -151,7 +151,7 @@ static int fsl_asrc_dma_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* Fetch the Back-End dma_data from DPCM */
-	list_for_each_entry(dpcm, &rtd->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(rtd, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *substream_be;
 		struct snd_soc_dai *dai = be->cpu_dai;
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 6a55aa753003..ad702377a6c3 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -258,7 +258,7 @@ static int rsnd_ctu_hw_params(struct rsnd_mod *mod,
 		struct snd_pcm_hw_params *be_params;
 		int stream = substream->stream;
 
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		for_each_dpcm_be(fe, stream, dpcm) {
 			be_params = &dpcm->hw_params;
 			if (params_channels(fe_params) != params_channels(be_params))
 				ctu->channels = params_channels(be_params);
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index beccfbac7581..cd38a43b976f 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -158,7 +158,7 @@ static int rsnd_src_hw_params(struct rsnd_mod *mod,
 		struct snd_soc_dpcm *dpcm;
 		struct snd_pcm_hw_params *be_params;
 
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		for_each_dpcm_be(fe, stream, dpcm) {
 			be_params = &dpcm->hw_params;
 
 			if (params_rate(fe_params) != params_rate(be_params))
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 409d082e80d1..699397a09167 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -157,7 +157,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	ret = dpcm_be_dai_startup(fe, stream);
 	if (ret < 0) {
 		/* clean up all links */
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+		for_each_dpcm_be(fe, stream, dpcm)
 			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
 		dpcm_be_disconnect(fe, stream);
@@ -321,7 +321,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	ret = dpcm_be_dai_shutdown(fe, stream);
 
 	/* mark FE's links ready to prune */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7916630e6fa..03f36e534050 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -174,7 +174,7 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 {
 	struct snd_soc_dpcm *dpcm;
 
-	list_for_each_entry(dpcm, &fe->dpcm[dir].be_clients, list_be) {
+	for_each_dpcm_be(fe, dir, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 
@@ -1211,7 +1211,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 
 	/* only add new dpcms */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		if (dpcm->be == be && dpcm->fe == fe)
 			return 0;
 	}
@@ -1272,7 +1272,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
 
-	list_for_each_entry_safe(dpcm, d, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
 		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
 				stream ? "capture" : "playback",
 				dpcm->be->dai_link->name);
@@ -1438,7 +1438,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	int prune = 0;
 
 	/* Destroy any old FE <--> BE connections */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		unsigned int i;
 
 		/* is there a valid CPU DAI widget for this BE */
@@ -1544,7 +1544,7 @@ void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm;
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->be->dpcm[stream].runtime_update =
 						SND_SOC_DPCM_UPDATE_NO;
 }
@@ -1555,7 +1555,7 @@ static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 
 	/* disable any enabled and non active backends */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -1584,7 +1584,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	int err, count = 0;
 
 	/* only startup BE DAIs that are either sinks or sources to this FE DAI */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -1638,7 +1638,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 
 unwind:
 	/* disable any enabled and non active backends */
-	list_for_each_entry_continue_reverse(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be_rollback(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
@@ -1695,7 +1695,7 @@ static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
 	 * if FE want to use it (= dpcm_merged_format)
 	 */
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
@@ -1736,7 +1736,7 @@ static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
 	 * if FE want to use it (= dpcm_merged_chan)
 	 */
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
@@ -1788,7 +1788,7 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 	 * if FE want to use it (= dpcm_merged_chan)
 	 */
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
@@ -1891,7 +1891,7 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 	}
 
 	/* apply symmetry for BE */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
@@ -1976,7 +1976,7 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 
 	/* only shutdown BEs that are either sinks or sources to this FE DAI */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -2040,7 +2040,7 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 
 	/* only hw_params backends that are either sinks or sources
 	 * to this frontend DAI */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -2109,7 +2109,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	int ret;
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -2160,7 +2160,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 
 unwind:
 	/* disable any enabled and non active backends */
-	list_for_each_entry_continue_reverse(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be_rollback(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
@@ -2240,7 +2240,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -2426,7 +2426,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
@@ -2636,7 +2636,7 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 	dpcm_be_dai_shutdown(fe, stream);
 disconnect:
 	/* disconnect any non started BEs */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
@@ -2781,11 +2781,9 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
-	struct list_head *clients =
-		&fe->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients;
 	struct snd_soc_dai *dai;
 
-	list_for_each_entry(dpcm, clients, list_be) {
+	for_each_dpcm_be(fe, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		int i;
@@ -2834,7 +2832,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	ret = dpcm_fe_dai_startup(fe_substream);
 	if (ret < 0) {
 		/* clean up all links */
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+		for_each_dpcm_be(fe, stream, dpcm)
 			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
 		dpcm_be_disconnect(fe, stream);
@@ -2857,7 +2855,7 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	ret = dpcm_fe_dai_shutdown(fe_substream);
 
 	/* mark FE's links ready to prune */
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
 	dpcm_be_disconnect(fe, stream);
@@ -3326,7 +3324,7 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		goto out;
 	}
 
-	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
 
-- 
2.19.0
