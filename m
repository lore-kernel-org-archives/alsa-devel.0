From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset DSP pipe when
	host/link DMA is reset" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:57 +0100
Message-ID: <E1bAH2z-0001lL-K8@debutante>
References: <1464958783-19344-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 752A72665AF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:28:02 +0200 (CEST)
In-Reply-To: <1464958783-19344-2-git-send-email-jeeja.kp@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Reset DSP pipe when host/link DMA is reset

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

>From 2004432f946e985fe98b67d515c52d69747016f9 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 3 Jun 2016 18:29:34 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset DSP pipe when host/link DMA is
 reset

In case of XRUN recovery PCM prepare will be called. In this case
Host/Link DMAs are reset and reconfigured, hence the corresponding
FE/BE pipe needs to be reset in order to get to a clean state.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 23 +++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      | 17 +++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  5 ++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 226db84ba20f..c6824036fc24 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1130,6 +1130,29 @@ int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 	return 0;
 }
 
+/*
+ * Reset the pipeline by sending set pipe state IPC this will reset the DMA
+ * from the DSP side
+ */
+int skl_reset_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
+{
+	int ret;
+
+	/* If pipe was not created in FW, do not try to pause or delete */
+	if (pipe->state < SKL_PIPE_PAUSED)
+		return 0;
+
+	ret = skl_set_pipe_state(ctx, pipe, PPL_RESET);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "Failed to reset pipe ret=%d\n", ret);
+		return ret;
+	}
+
+	pipe->state = SKL_PIPE_RESET;
+
+	return 0;
+}
+
 /* Algo parameter set helper function */
 int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 				u32 param_id, struct skl_module_cfg *mcfg)
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 7c81b31748ff..ff0491716e06 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -227,16 +227,25 @@ static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct skl *skl = get_skl_ctx(dai->dev);
 	unsigned int format_val;
 	int err;
+	struct skl_module_cfg *mconfig;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+
 	format_val = skl_get_format(substream, dai);
 	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
 				hdac_stream(stream)->stream_tag, format_val);
 	snd_hdac_stream_reset(hdac_stream(stream));
 
+	/* In case of XRUN recovery, reset the FW pipe to clean state */
+	if (mconfig && (substream->runtime->status->state ==
+					SNDRV_PCM_STATE_XRUN))
+		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+
 	err = snd_hdac_stream_set_params(hdac_stream(stream), format_val);
 	if (err < 0)
 		return err;
@@ -521,6 +530,8 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 	struct skl_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct hdac_ext_link *link;
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_module_cfg *mconfig = NULL;
 
 	dma_params  = (struct skl_dma_params *)
 			snd_soc_dai_get_dma_data(codec_dai, substream);
@@ -535,6 +546,12 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 
 	snd_hdac_ext_link_stream_reset(link_dev);
 
+	/* In case of XRUN recovery, reset the FW pipe to clean state */
+	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
+	if (mconfig && (substream->runtime->status->state ==
+					SNDRV_PCM_STATE_XRUN))
+		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+
 	snd_hdac_ext_link_stream_setup(link_dev, format_val);
 
 	snd_hdac_ext_link_set_stream_id(link, hdac_stream(link_dev)->stream_tag);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e4b399cd7868..d4a58bcd8c7d 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -244,7 +244,8 @@ enum skl_pipe_state {
 	SKL_PIPE_INVALID = 0,
 	SKL_PIPE_CREATED = 1,
 	SKL_PIPE_PAUSED = 2,
-	SKL_PIPE_STARTED = 3
+	SKL_PIPE_STARTED = 3,
+	SKL_PIPE_RESET = 4
 };
 
 struct skl_pipe_module {
@@ -357,6 +358,8 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
 
 int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
 
+int skl_reset_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+
 int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config);
 
 int skl_bind_modules(struct skl_sst *ctx, struct skl_module_cfg
-- 
2.8.1
