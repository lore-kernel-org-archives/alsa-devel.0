From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Configure DMA in
	PRE_PMD handler of Mixer" to the asoc tree
Date: Thu, 15 Dec 2016 12:20:47 +0000
Message-ID: <E1cHV1j-0000XP-CC@debutante>
References: <1480700509-23380-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A22D266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:20:53 +0100 (CET)
In-Reply-To: <1480700509-23380-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Configure DMA in PRE_PMD handler of Mixer

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From bb704a737cecc1c4c9f1b0251aa79d8276308ccc Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 8 Dec 2016 13:41:14 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Configure DMA in PRE_PMD handler of
 Mixer

If system is suspended when PCM was paused/stopped, restart doesn't
configure DMA as it is we are in Pause state and results in IO error
eventually.

Configure host/link DMA before initializing DSP Gateway copier module
instead of DAI prepare(). So moved DMA configuration to mixer PRE_PMD
widget handler instead of DAI prepare.

This uses previously added new API to do the configuration and removes
old DAI prepare code.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 50 +---------------------------------
 sound/soc/intel/skylake/skl-topology.c | 19 +++++++++++++
 2 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 105aab7593c8..aebae234152c 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -231,37 +231,19 @@ static int skl_be_prepare(struct snd_pcm_substream *substream,
 static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct skl *skl = get_skl_ctx(dai->dev);
-	unsigned int format_val;
-	int err;
 	struct skl_module_cfg *mconfig;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
 
-	format_val = skl_get_format(substream, dai);
-	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
-				hdac_stream(stream)->stream_tag, format_val);
-	snd_hdac_stream_reset(hdac_stream(stream));
-
 	/* In case of XRUN recovery, reset the FW pipe to clean state */
 	if (mconfig && (substream->runtime->status->state ==
 					SNDRV_PCM_STATE_XRUN))
 		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
 
-	err = snd_hdac_stream_set_params(hdac_stream(stream), format_val);
-	if (err < 0)
-		return err;
-
-	err = snd_hdac_stream_setup(hdac_stream(stream));
-	if (err < 0)
-		return err;
-
-	hdac_stream(stream)->prepared = 1;
-
-	return err;
+	return 0;
 }
 
 static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -436,7 +418,6 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		if (!w->ignore_suspend) {
-			skl_pcm_prepare(substream, dai);
 			/*
 			 * enable DMA Resume enable bit for the stream, set the
 			 * dpib & lpib position to resume before starting the
@@ -457,7 +438,6 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		 * pipeline is started but there is a delay in starting the
 		 * DMA channel on the host.
 		 */
-		snd_hdac_ext_stream_decouple(ebus, stream, true);
 		ret = skl_decoupled_trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
@@ -539,41 +519,15 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
-	struct hdac_ext_stream *link_dev =
-			snd_soc_dai_get_dma_data(dai, substream);
-	unsigned int format_val = 0;
-	struct skl_dma_params *dma_params;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct hdac_ext_link *link;
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_module_cfg *mconfig = NULL;
 
-	dma_params  = (struct skl_dma_params *)
-			snd_soc_dai_get_dma_data(codec_dai, substream);
-	if (dma_params)
-		format_val = dma_params->format;
-	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d codec_dai_name=%s\n",
-			hdac_stream(link_dev)->stream_tag, format_val, codec_dai->name);
-
-	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
-	if (!link)
-		return -EINVAL;
-
-	snd_hdac_ext_link_stream_reset(link_dev);
-
 	/* In case of XRUN recovery, reset the FW pipe to clean state */
 	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
 	if (mconfig && (substream->runtime->status->state ==
 					SNDRV_PCM_STATE_XRUN))
 		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
 
-	snd_hdac_ext_link_stream_setup(link_dev, format_val);
-
-	snd_hdac_ext_link_set_stream_id(link, hdac_stream(link_dev)->stream_tag);
-	link_dev->link_prepared = 1;
-
 	return 0;
 }
 
@@ -588,10 +542,8 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		skl_link_pcm_prepare(substream, dai);
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		snd_hdac_ext_stream_decouple(ebus, stream, true);
 		snd_hdac_ext_link_stream_start(link_dev);
 		break;
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 8f608c45e445..422a9dee9270 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -496,6 +496,20 @@ static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
 	return 0;
 }
 
+static int skl_tplg_module_prepare(struct skl_sst *ctx, struct skl_pipe *pipe,
+		struct snd_soc_dapm_widget *w, struct skl_module_cfg *mcfg)
+{
+	switch (mcfg->dev_type) {
+	case SKL_DEVICE_HDAHOST:
+		return skl_pcm_host_dma_prepare(ctx->dev, pipe->p_params);
+
+	case SKL_DEVICE_HDALINK:
+		return skl_pcm_link_dma_prepare(ctx->dev, pipe->p_params);
+	}
+
+	return 0;
+}
+
 /*
  * Inside a pipe instance, we can have various modules. These modules need
  * to instantiated in DSP by invoking INIT_MODULE IPC, which is achieved by
@@ -535,6 +549,11 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 			mconfig->m_state = SKL_MODULE_LOADED;
 		}
 
+		/* prepare the DMA if the module is gateway cpr */
+		ret = skl_tplg_module_prepare(ctx, pipe, w, mconfig);
+		if (ret < 0)
+			return ret;
+
 		/* update blob if blob is null for be with default value */
 		skl_tplg_update_be_blob(w, ctx);
 
-- 
2.11.0
