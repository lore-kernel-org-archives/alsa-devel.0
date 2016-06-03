From: jeeja.kp@intel.com
Subject: [PATCH 01/10] ASoC: Intel: Skylake: Reset DSP pipe
	when host/link DMA is reset
Date: Fri,  3 Jun 2016 18:29:34 +0530
Message-ID: <1464958783-19344-2-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB9A2606F8
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:15 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

In case of XRUN recovery PCM prepare will be called. In this case
Host/Link DMAs are reset and reconfigured, hence the corresponding
FE/BE pipe needs to be reset in order to get to a clean state.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 23 +++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c      | 17 +++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  5 ++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 226db84..c682403 100644
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
index 7c81b31..ff04917 100644
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
index e4b399c..d4a58bc 100644
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
2.5.0
