From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Skylake: Parse and update
	module config structure
Date: Mon, 21 Aug 2017 14:16:45 +0530
Message-ID: <20170821084646.6525-7-guneshwor.o.singh@intel.com>
References: <20170821084646.6525-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E22FE267479
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:47:08 +0200 (CEST)
In-Reply-To: <20170821084646.6525-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

A dsp path and the modules in the path can support various pcm
configurations. The list of supported pcm configurations from topology
manifest would be stored and later selected runtime based on the hw
pcm params. For legacy, module data is filled in the 0th index of
resource and interface table.

To accommodate both models, change the relevant structures and populate
them by parsing newly defined tokens. This change is backward compatible
with the existing model where driver computes the resources required by
each dsp module.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c |  59 ++++--
 sound/soc/intel/skylake/skl-pcm.c      |   3 +-
 sound/soc/intel/skylake/skl-topology.c | 342 +++++++++++++++++++++++++--------
 sound/soc/intel/skylake/skl-topology.h |  25 +++
 4 files changed, 334 insertions(+), 95 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index cec7ced6780e..bd3ad65ca706 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -431,9 +431,12 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_base_cfg *base_cfg)
 {
-	struct skl_module_fmt *format = &mconfig->in_fmt[0];
+	struct skl_module *module = mconfig->module;
+	struct skl_module_res *res = &module->resources[mconfig->res_idx];
+	struct skl_module_iface *fmt = &module->formats[mconfig->fmt_idx];
+	struct skl_module_fmt *format = &fmt->inputs[0].fmt;
 
-	base_cfg->audio_fmt.number_of_channels = (u8)format->channels;
+	base_cfg->audio_fmt.number_of_channels = format->channels;
 
 	base_cfg->audio_fmt.s_freq = format->s_freq;
 	base_cfg->audio_fmt.bit_depth = format->bit_depth;
@@ -448,10 +451,10 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 
 	base_cfg->audio_fmt.interleaving = format->interleaving_style;
 
-	base_cfg->cps = mconfig->mcps;
-	base_cfg->ibs = mconfig->ibs;
-	base_cfg->obs = mconfig->obs;
-	base_cfg->is_pages = mconfig->mem_pages;
+	base_cfg->cps = res->cps;
+	base_cfg->ibs = res->ibs;
+	base_cfg->obs = res->obs;
+	base_cfg->is_pages = res->is_pages;
 }
 
 /*
@@ -539,6 +542,9 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 			struct skl_cpr_cfg *cpr_mconfig)
 {
 	u32 dma_io_buf;
+	struct skl_module_res *res;
+	int res_idx = mconfig->res_idx;
+	struct skl *skl = get_skl_ctx(ctx->dev);
 
 	cpr_mconfig->gtw_cfg.node_id = skl_get_node_id(ctx, mconfig);
 
@@ -547,19 +553,27 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 		return;
 	}
 
+	if (skl->nr_modules) {
+		res = &mconfig->module->resources[mconfig->res_idx];
+		cpr_mconfig->gtw_cfg.dma_buffer_size = res->dma_buffer_size;
+		goto skip_buf_size_calc;
+	} else {
+		res = &mconfig->module->resources[res_idx];
+	}
+
 	switch (mconfig->hw_conn_type) {
 	case SKL_CONN_SOURCE:
 		if (mconfig->dev_type == SKL_DEVICE_HDAHOST)
-			dma_io_buf =  mconfig->ibs;
+			dma_io_buf =  res->ibs;
 		else
-			dma_io_buf =  mconfig->obs;
+			dma_io_buf =  res->obs;
 		break;
 
 	case SKL_CONN_SINK:
 		if (mconfig->dev_type == SKL_DEVICE_HDAHOST)
-			dma_io_buf =  mconfig->obs;
+			dma_io_buf =  res->obs;
 		else
-			dma_io_buf =  mconfig->ibs;
+			dma_io_buf =  res->ibs;
 		break;
 
 	default:
@@ -574,11 +588,12 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 	/* fallback to 2ms default value */
 	if (!cpr_mconfig->gtw_cfg.dma_buffer_size) {
 		if (mconfig->hw_conn_type == SKL_CONN_SOURCE)
-			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->obs;
+			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * res->obs;
 		else
-			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->ibs;
+			cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * res->ibs;
 	}
 
+skip_buf_size_calc:
 	cpr_mconfig->cpr_feature_mask = 0;
 	cpr_mconfig->gtw_cfg.config_length  = 0;
 
@@ -626,7 +641,9 @@ static void skl_setup_out_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_audio_data_format *out_fmt)
 {
-	struct skl_module_fmt *format = &mconfig->out_fmt[0];
+	struct skl_module *module = mconfig->module;
+	struct skl_module_iface *fmt = &module->formats[mconfig->fmt_idx];
+	struct skl_module_fmt *format = &fmt->outputs[0].fmt;
 
 	out_fmt->number_of_channels = (u8)format->channels;
 	out_fmt->s_freq = format->s_freq;
@@ -651,7 +668,9 @@ static void skl_set_src_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_src_module_cfg *src_mconfig)
 {
-	struct skl_module_fmt *fmt = &mconfig->out_fmt[0];
+	struct skl_module *module = mconfig->module;
+	struct skl_module_iface *iface = &module->formats[mconfig->fmt_idx];
+	struct skl_module_fmt *fmt = &iface->outputs[0].fmt;
 
 	skl_set_base_module_format(ctx, mconfig,
 		(struct skl_base_cfg *)src_mconfig);
@@ -668,7 +687,9 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_up_down_mixer_cfg *mixer_mconfig)
 {
-	struct skl_module_fmt *fmt = &mconfig->out_fmt[0];
+	struct skl_module *module = mconfig->module;
+	struct skl_module_iface *iface = &module->formats[mconfig->fmt_idx];
+	struct skl_module_fmt *fmt = &iface->outputs[0].fmt;
 	int i = 0;
 
 	skl_set_base_module_format(ctx,	mconfig,
@@ -1002,8 +1023,8 @@ int skl_unbind_modules(struct skl_sst *ctx,
 	struct skl_ipc_bind_unbind_msg msg;
 	struct skl_module_inst_id src_id = src_mcfg->id;
 	struct skl_module_inst_id dst_id = dst_mcfg->id;
-	int in_max = dst_mcfg->max_in_queue;
-	int out_max = src_mcfg->max_out_queue;
+	int in_max = dst_mcfg->module->max_input_pins;
+	int out_max = src_mcfg->module->max_output_pins;
 	int src_index, dst_index, src_pin_state, dst_pin_state;
 
 	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
@@ -1064,8 +1085,8 @@ int skl_bind_modules(struct skl_sst *ctx,
 {
 	int ret;
 	struct skl_ipc_bind_unbind_msg msg;
-	int in_max = dst_mcfg->max_in_queue;
-	int out_max = src_mcfg->max_out_queue;
+	int in_max = dst_mcfg->module->max_input_pins;
+	int out_max = src_mcfg->module->max_output_pins;
 	int src_index, dst_index;
 
 	skl_dump_bind_info(ctx, src_mcfg, dst_mcfg);
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index f6c9adb6faa2..a756882b9029 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1233,7 +1233,8 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 			mconfig->id.module_id = module->id;
-			mconfig->is_loadable = module->is_loadable;
+			if (mconfig->module)
+				mconfig->module->loadable = module->is_loadable;
 			return 0;
 		}
 	}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b562d9f7e7b5..8cf776508e95 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -49,6 +49,9 @@ static const int mic_quatro_list[][SKL_CH_QUATRO] = {
 {0, 1, 2, 3},
 };
 
+#define CHECK_HW_PARAMS(ch, freq, bps, prm_ch, prm_freq, prm_bps) \
+	((ch == prm_ch) && (bps == prm_bps) && (freq == prm_freq))
+
 void skl_tplg_d0i3_get(struct skl *skl, enum d0i3_capability caps)
 {
 	struct skl_d0i3_data *d0i3 =  &skl->skl_sst->d0i3;
@@ -153,8 +156,10 @@ static bool skl_is_pipe_mcps_avail(struct skl *skl,
 				struct skl_module_cfg *mconfig)
 {
 	struct skl_sst *ctx = skl->skl_sst;
+	u8 res_idx = mconfig->res_idx;
+	struct skl_module_res *res = &mconfig->module->resources[res_idx];
 
-	if (skl->resource.mcps + mconfig->mcps > skl->resource.max_mcps) {
+	if (skl->resource.mcps + res->cps > skl->resource.max_mcps) {
 		dev_err(ctx->dev,
 			"%s: module_id %d instance %d\n", __func__,
 			mconfig->id.module_id, mconfig->id.instance_id);
@@ -170,7 +175,10 @@ static bool skl_is_pipe_mcps_avail(struct skl *skl,
 static void skl_tplg_alloc_pipe_mcps(struct skl *skl,
 				struct skl_module_cfg *mconfig)
 {
-	skl->resource.mcps += mconfig->mcps;
+	u8 res_idx = mconfig->res_idx;
+	struct skl_module_res *res = &mconfig->module->resources[res_idx];
+
+	skl->resource.mcps += res->cps;
 }
 
 /*
@@ -179,7 +187,11 @@ static void skl_tplg_alloc_pipe_mcps(struct skl *skl,
 static void
 skl_tplg_free_pipe_mcps(struct skl *skl, struct skl_module_cfg *mconfig)
 {
-	skl->resource.mcps -= mconfig->mcps;
+	u8 res_idx = mconfig->res_idx;
+	struct skl_module_res *res = &mconfig->module->resources[res_idx];
+
+	res = &mconfig->module->resources[res_idx];
+	skl->resource.mcps -= res->cps;
 }
 
 /*
@@ -195,17 +207,21 @@ skl_tplg_free_pipe_mem(struct skl *skl, struct skl_module_cfg *mconfig)
 static void skl_dump_mconfig(struct skl_sst *ctx,
 					struct skl_module_cfg *mcfg)
 {
+	struct skl_module_iface *iface = &mcfg->module->formats[0];
+
 	dev_dbg(ctx->dev, "Dumping config\n");
 	dev_dbg(ctx->dev, "Input Format:\n");
-	dev_dbg(ctx->dev, "channels = %d\n", mcfg->in_fmt[0].channels);
-	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->in_fmt[0].s_freq);
-	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->in_fmt[0].ch_cfg);
-	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->in_fmt[0].valid_bit_depth);
+	dev_dbg(ctx->dev, "channels = %d\n", iface->inputs[0].fmt.channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", iface->inputs[0].fmt.s_freq);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", iface->inputs[0].fmt.ch_cfg);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n",
+				iface->inputs[0].fmt.valid_bit_depth);
 	dev_dbg(ctx->dev, "Output Format:\n");
-	dev_dbg(ctx->dev, "channels = %d\n", mcfg->out_fmt[0].channels);
-	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->out_fmt[0].s_freq);
-	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->out_fmt[0].valid_bit_depth);
-	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->out_fmt[0].ch_cfg);
+	dev_dbg(ctx->dev, "channels = %d\n", iface->outputs[0].fmt.channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", iface->outputs[0].fmt.s_freq);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n",
+				iface->outputs[0].fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", iface->outputs[0].fmt.ch_cfg);
 }
 
 static void skl_tplg_update_chmap(struct skl_module_fmt *fmt, int chs)
@@ -273,8 +289,8 @@ static void skl_tplg_update_params_fixup(struct skl_module_cfg *m_cfg,
 	struct skl_module_fmt *in_fmt, *out_fmt;
 
 	/* Fixups will be applied to pin 0 only */
-	in_fmt = &m_cfg->in_fmt[0];
-	out_fmt = &m_cfg->out_fmt[0];
+	in_fmt = &m_cfg->module->formats[0].inputs[0].fmt;
+	out_fmt = &m_cfg->module->formats[0].outputs[0].fmt;
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (is_fe) {
@@ -312,21 +328,23 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 {
 	int multiplier = 1;
 	struct skl_module_fmt *in_fmt, *out_fmt;
+	struct skl_module_res *res;
 
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
 	 * change for pin 0 only
 	 */
-	in_fmt = &mcfg->in_fmt[0];
-	out_fmt = &mcfg->out_fmt[0];
+	res = &mcfg->module->resources[0];
+	in_fmt = &mcfg->module->formats[0].inputs[0].fmt;
+	out_fmt = &mcfg->module->formats[0].outputs[0].fmt;
 
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
 
-	mcfg->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
+	res->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
 			in_fmt->channels * (in_fmt->bit_depth >> 3) *
 			multiplier;
 
-	mcfg->obs = DIV_ROUND_UP(out_fmt->s_freq, 1000) *
+	res->obs = DIV_ROUND_UP(out_fmt->s_freq, 1000) *
 			out_fmt->channels * (out_fmt->bit_depth >> 3) *
 			multiplier;
 }
@@ -365,6 +383,8 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 	struct nhlt_specific_cfg *cfg;
 	struct skl *skl = get_skl_ctx(ctx->dev);
 	u8 dev_type = skl_tplg_be_dev_type(m_cfg->dev_type);
+	int fmt_idx = m_cfg->fmt_idx;
+	struct skl_module_iface *m_iface = &m_cfg->module->formats[fmt_idx];
 
 	/* check if we already have blob */
 	if (m_cfg->formats_config.caps_size > 0)
@@ -375,23 +395,23 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 	case SKL_DEVICE_DMIC:
 		link_type = NHLT_LINK_DMIC;
 		dir = SNDRV_PCM_STREAM_CAPTURE;
-		s_freq = m_cfg->in_fmt[0].s_freq;
-		s_fmt = m_cfg->in_fmt[0].bit_depth;
-		ch = m_cfg->in_fmt[0].channels;
+		s_freq = m_iface->inputs[0].fmt.s_freq;
+		s_fmt = m_iface->inputs[0].fmt.bit_depth;
+		ch = m_iface->inputs[0].fmt.channels;
 		break;
 
 	case SKL_DEVICE_I2S:
 		link_type = NHLT_LINK_SSP;
 		if (m_cfg->hw_conn_type == SKL_CONN_SOURCE) {
 			dir = SNDRV_PCM_STREAM_PLAYBACK;
-			s_freq = m_cfg->out_fmt[0].s_freq;
-			s_fmt = m_cfg->out_fmt[0].bit_depth;
-			ch = m_cfg->out_fmt[0].channels;
+			s_freq = m_iface->outputs[0].fmt.s_freq;
+			s_fmt = m_iface->outputs[0].fmt.bit_depth;
+			ch = m_iface->outputs[0].fmt.channels;
 		} else {
 			dir = SNDRV_PCM_STREAM_CAPTURE;
-			s_freq = m_cfg->in_fmt[0].s_freq;
-			s_fmt = m_cfg->in_fmt[0].bit_depth;
-			ch = m_cfg->in_fmt[0].channels;
+			s_freq = m_iface->inputs[0].fmt.s_freq;
+			s_fmt = m_iface->inputs[0].fmt.bit_depth;
+			ch = m_iface->inputs[0].fmt.channels;
 		}
 		break;
 
@@ -549,6 +569,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 	struct snd_soc_dapm_widget *w;
 	struct skl_module_cfg *mconfig;
 	struct skl_sst *ctx = skl->skl_sst;
+	u8 cfg_idx;
 	int ret = 0;
 
 	list_for_each_entry(w_module, &pipe->w_list, node) {
@@ -564,11 +585,15 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 			return -EIO;
 		}
 
+		cfg_idx = mconfig->pipe->cur_config_idx;
+		mconfig->fmt_idx = mconfig->mod_cfg[cfg_idx].fmt_idx;
+		mconfig->res_idx = mconfig->mod_cfg[cfg_idx].res_idx;
+
 		/* check resource available */
 		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
 
-		if (mconfig->is_loadable && ctx->dsp->fw_ops.load_mod) {
+		if (mconfig->module->loadable && ctx->dsp->fw_ops.load_mod) {
 			ret = ctx->dsp->fw_ops.load_mod(ctx->dsp,
 				mconfig->id.module_id, mconfig->guid);
 			if (ret < 0)
@@ -633,7 +658,7 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 		mconfig  = w_module->w->priv;
 		uuid_mod = (uuid_le *)mconfig->guid;
 
-		if (mconfig->is_loadable && ctx->dsp->fw_ops.unload_mod &&
+		if (mconfig->module->loadable && ctx->dsp->fw_ops.unload_mod &&
 			mconfig->m_state > SKL_MODULE_UNINIT) {
 			ret = ctx->dsp->fw_ops.unload_mod(ctx->dsp,
 						mconfig->id.module_id);
@@ -654,6 +679,65 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 	return ret;
 }
 
+/*
+ * Here, we select pipe format based on the pipe type and pipe
+ * direction to determine the current config index for the pipeline.
+ * The config index is then used to select proper module resources.
+ * Intermediate pipes currently have a fixed format hence we select the
+ * 0th configuratation by default for such pipes.
+ */
+static int
+skl_tplg_get_pipe_config(struct skl *skl, struct skl_module_cfg *mconfig)
+{
+	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_pipe *pipe = mconfig->pipe;
+	struct skl_pipe_params *params = pipe->p_params;
+	struct skl_path_config *pconfig = &pipe->configs[0];
+	struct skl_pipe_fmt *fmt = NULL;
+	bool in_fmt = false;
+	int i;
+
+	if (pipe->nr_cfgs == 0) {
+		pipe->cur_config_idx = 0;
+		return 0;
+	}
+
+	if (pipe->conn_type == SKL_PIPE_CONN_TYPE_NONE) {
+		dev_dbg(ctx->dev, "No conn_type detected, take 0th config\n");
+		pipe->cur_config_idx = 0;
+		pipe->memory_pages = pconfig->mem_pages;
+
+		return 0;
+	}
+
+	if ((pipe->conn_type == SKL_PIPE_CONN_TYPE_FE &&
+	     pipe->direction == SNDRV_PCM_STREAM_PLAYBACK) ||
+	     (pipe->conn_type == SKL_PIPE_CONN_TYPE_BE &&
+	     pipe->direction == SNDRV_PCM_STREAM_CAPTURE))
+		in_fmt = true;
+
+	for (i = 0; i < pipe->nr_cfgs; i++) {
+		pconfig = &pipe->configs[i];
+		if (in_fmt)
+			fmt = &pconfig->in_fmt;
+		else
+			fmt = &pconfig->out_fmt;
+
+		if (CHECK_HW_PARAMS(params->ch, params->s_freq, params->s_fmt,
+				    fmt->channels, fmt->freq, fmt->bps)) {
+			pipe->cur_config_idx = i;
+			pipe->memory_pages = pconfig->mem_pages;
+			dev_dbg(ctx->dev, "Using pipe config: %d\n", i);
+
+			return 0;
+		}
+	}
+
+	dev_err(ctx->dev, "Invalid pipe config: %d %d %d for pipe: %d\n",
+		params->ch, params->s_freq, params->s_fmt, pipe->ppl_id);
+	return -EINVAL;
+}
+
 /*
  * Mixer module represents a pipeline. So in the Pre-PMU event of mixer we
  * need create the pipeline. So we do following:
@@ -673,6 +757,10 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_deferred_bind *modules;
 
+	ret = skl_tplg_get_pipe_config(skl, mconfig);
+	if (ret < 0)
+		return ret;
+
 	/* check resource available */
 	if (!skl_is_pipe_mcps_avail(skl, mconfig))
 		return -EBUSY;
@@ -776,12 +864,12 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 	 * check all out/in pins are in bind state.
 	 * if so set the module param
 	 */
-	for (i = 0; i < mcfg->max_out_queue; i++) {
+	for (i = 0; i < mcfg->module->max_output_pins; i++) {
 		if (mcfg->m_out_pin[i].pin_state != SKL_PIN_BIND_DONE)
 			return 0;
 	}
 
-	for (i = 0; i < mcfg->max_in_queue; i++) {
+	for (i = 0; i < mcfg->module->max_input_pins; i++) {
 		if (mcfg->m_in_pin[i].pin_state != SKL_PIN_BIND_DONE)
 			return 0;
 	}
@@ -832,7 +920,7 @@ static int skl_tplg_module_add_deferred_bind(struct skl *skl,
 	int i;
 
 	/* only supported for module with static pin connection */
-	for (i = 0; i < dst->max_in_queue; i++) {
+	for (i = 0; i < dst->module->max_input_pins; i++) {
 		struct skl_module_pin *pin = &dst->m_in_pin[i];
 
 		if (pin->is_dynamic)
@@ -1092,7 +1180,7 @@ static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < sink_mconfig->max_in_queue; i++) {
+	for (i = 0; i < sink_mconfig->module->max_input_pins; i++) {
 		if (sink_mconfig->m_in_pin[i].pin_state == SKL_PIN_BIND_DONE) {
 			src_mconfig = sink_mconfig->m_in_pin[i].tgt_mcfg;
 			if (!src_mconfig)
@@ -1203,7 +1291,7 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < src_mconfig->max_out_queue; i++) {
+	for (i = 0; i < src_mconfig->module->max_output_pins; i++) {
 		if (src_mconfig->m_out_pin[i].pin_state == SKL_PIN_BIND_DONE) {
 			sink_mconfig = src_mconfig->m_out_pin[i].tgt_mcfg;
 			if (!sink_mconfig)
@@ -1497,14 +1585,22 @@ int skl_tplg_update_pipe_params(struct device *dev,
 			struct skl_module_cfg *mconfig,
 			struct skl_pipe_params *params)
 {
+	struct skl_module_res *res = &mconfig->module->resources[0];
+	struct skl *skl = get_skl_ctx(dev);
 	struct skl_module_fmt *format = NULL;
+	u8 cfg_idx = mconfig->pipe->cur_config_idx;
 
 	skl_tplg_fill_dma_id(mconfig, params);
+	mconfig->fmt_idx = mconfig->mod_cfg[cfg_idx].fmt_idx;
+	mconfig->res_idx = mconfig->mod_cfg[cfg_idx].res_idx;
+
+	if (skl->nr_modules)
+		return 0;
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		format = &mconfig->in_fmt[0];
+		format = &mconfig->module->formats[0].inputs[0].fmt;
 	else
-		format = &mconfig->out_fmt[0];
+		format = &mconfig->module->formats[0].outputs[0].fmt;
 
 	/* set the hw_params */
 	format->s_freq = params->s_freq;
@@ -1532,11 +1628,11 @@ int skl_tplg_update_pipe_params(struct device *dev,
 	}
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mconfig->ibs = (format->s_freq / 1000) *
+		res->ibs = (format->s_freq / 1000) *
 				(format->channels) *
 				(format->bit_depth >> 3);
 	} else {
-		mconfig->obs = (format->s_freq / 1000) *
+		res->obs = (format->s_freq / 1000) *
 				(format->channels) *
 				(format->bit_depth >> 3);
 	}
@@ -1810,6 +1906,54 @@ static const struct snd_soc_tplg_kcontrol_ops skl_tplg_kcontrol_ops[] = {
 	},
 };
 
+static int skl_tplg_fill_pipe_cfg(struct device *dev,
+			struct skl_pipe *pipe, u32 tkn,
+			u32 tkn_val, int conf_idx, int dir)
+{
+	struct skl_pipe_fmt *fmt;
+	struct skl_path_config *config;
+
+	switch (dir) {
+	case SKL_DIR_IN:
+		fmt = &pipe->configs[conf_idx].in_fmt;
+		break;
+
+	case SKL_DIR_OUT:
+		fmt = &pipe->configs[conf_idx].out_fmt;
+		break;
+
+	default:
+		dev_err(dev, "Invalid direction: %d\n", dir);
+		return -EINVAL;
+	}
+
+	config = &pipe->configs[conf_idx];
+
+	switch (tkn) {
+	case SKL_TKN_U32_CFG_FREQ:
+		fmt->freq = tkn_val;
+		break;
+
+	case SKL_TKN_U8_CFG_CHAN:
+		fmt->channels = tkn_val;
+		break;
+
+	case SKL_TKN_U8_CFG_BPS:
+		fmt->bps = tkn_val;
+		break;
+
+	case SKL_TKN_U32_PATH_MEM_PGS:
+		config->mem_pages = tkn_val;
+		break;
+
+	default:
+		dev_err(dev, "Invalid token config: %d\n", tkn);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int skl_tplg_fill_pipe_tkn(struct device *dev,
 			struct skl_pipe *pipe, u32 tkn,
 			u32 tkn_val)
@@ -1832,6 +1976,14 @@ static int skl_tplg_fill_pipe_tkn(struct device *dev,
 		pipe->lp_mode = tkn_val;
 		break;
 
+	case SKL_TKN_U32_PIPE_DIRECTION:
+		pipe->direction = tkn_val;
+		break;
+
+	case SKL_TKN_U32_NUM_CONFIGS:
+		pipe->nr_cfgs = tkn_val;
+		break;
+
 	default:
 		dev_err(dev, "Token not handled %d\n", tkn);
 		return -EINVAL;
@@ -1993,18 +2145,21 @@ static int skl_tplg_fill_fmt(struct device *dev,
 }
 
 static int skl_tplg_widget_fill_fmt(struct device *dev,
-		struct skl_module_cfg *mconfig,
+		struct skl_module_iface *fmt,
 		u32 tkn, u32 val, u32 dir, int fmt_idx)
 {
 	struct skl_module_fmt *dst_fmt;
 
+	if (!fmt)
+		return -EINVAL;
+
 	switch (dir) {
 	case SKL_DIR_IN:
-		dst_fmt = &mconfig->in_fmt[fmt_idx];
+		dst_fmt = &fmt->inputs[fmt_idx].fmt;
 		break;
 
 	case SKL_DIR_OUT:
-		dst_fmt = &mconfig->out_fmt[fmt_idx];
+		dst_fmt = &fmt->outputs[fmt_idx].fmt;
 		break;
 
 	default:
@@ -2117,6 +2272,10 @@ static int skl_tplg_fill_res_tkn(struct device *dev,
 		res->ibs = tkn_elem->value;
 		break;
 
+	case SKL_TKN_U32_MAX_MCPS:
+		res->cps = tkn_elem->value;
+		break;
+
 	case SKL_TKN_MM_U32_RES_PIN_ID:
 	case SKL_TKN_MM_U32_PIN_BUF:
 		ret = skl_tplg_manifest_pin_res_tkn(dev, tkn_elem, res,
@@ -2145,49 +2304,54 @@ static int skl_tplg_get_token(struct device *dev,
 	int tkn_count = 0;
 	int ret;
 	static int is_pipe_exists;
-	static int pin_index, dir;
+	static int pin_index, dir, conf_idx;
+	struct skl_module_iface *iface = NULL;
+	struct skl_module_res *res = NULL;
+	int res_idx = mconfig->res_idx;
+	int fmt_idx = mconfig->fmt_idx;
+
+	/*
+	 * If the manifest structure contains no modules, fill all
+	 * the module data to 0th index.
+	 * res_idx and fmt_idx are default set to 0.
+	 */
+	if (skl->nr_modules == 0) {
+		res = &mconfig->module->resources[res_idx];
+		iface = &mconfig->module->formats[fmt_idx];
+	}
 
 	if (tkn_elem->token > SKL_TKN_MAX)
 		return -EINVAL;
 
 	switch (tkn_elem->token) {
 	case SKL_TKN_U8_IN_QUEUE_COUNT:
-		mconfig->max_in_queue = tkn_elem->value;
-		mconfig->m_in_pin = devm_kzalloc(dev, mconfig->max_in_queue *
-					sizeof(*mconfig->m_in_pin),
-					GFP_KERNEL);
-		if (!mconfig->m_in_pin)
-			return -ENOMEM;
-
+		mconfig->module->max_input_pins = tkn_elem->value;
 		break;
 
 	case SKL_TKN_U8_OUT_QUEUE_COUNT:
-		mconfig->max_out_queue = tkn_elem->value;
-		mconfig->m_out_pin = devm_kzalloc(dev, mconfig->max_out_queue *
-					sizeof(*mconfig->m_out_pin),
-					GFP_KERNEL);
-
-		if (!mconfig->m_out_pin)
-			return -ENOMEM;
-
+		mconfig->module->max_output_pins = tkn_elem->value;
 		break;
 
 	case SKL_TKN_U8_DYN_IN_PIN:
+		if (!mconfig->m_in_pin)
+			mconfig->m_in_pin = devm_kzalloc(dev, MAX_IN_QUEUE *
+					sizeof(*mconfig->m_in_pin), GFP_KERNEL);
 		if (!mconfig->m_in_pin)
 			return -ENOMEM;
 
-		skl_tplg_fill_pin_dynamic_val(mconfig->m_in_pin,
-			mconfig->max_in_queue, tkn_elem->value);
-
+		skl_tplg_fill_pin_dynamic_val(mconfig->m_in_pin, MAX_IN_QUEUE,
+					      tkn_elem->value);
 		break;
 
 	case SKL_TKN_U8_DYN_OUT_PIN:
+		if (!mconfig->m_out_pin)
+			mconfig->m_out_pin = devm_kzalloc(dev, MAX_IN_QUEUE *
+					sizeof(*mconfig->m_in_pin), GFP_KERNEL);
 		if (!mconfig->m_out_pin)
 			return -ENOMEM;
 
-		skl_tplg_fill_pin_dynamic_val(mconfig->m_out_pin,
-			mconfig->max_out_queue, tkn_elem->value);
-
+		skl_tplg_fill_pin_dynamic_val(mconfig->m_out_pin, MAX_OUT_QUEUE,
+					      tkn_elem->value);
 		break;
 
 	case SKL_TKN_U8_TIME_SLOT:
@@ -2215,19 +2379,13 @@ static int skl_tplg_get_token(struct device *dev,
 		break;
 
 	case SKL_TKN_U32_MEM_PAGES:
-		mconfig->mem_pages = tkn_elem->value;
-		break;
-
 	case SKL_TKN_U32_MAX_MCPS:
-		mconfig->mcps = tkn_elem->value;
-		break;
-
 	case SKL_TKN_U32_OBS:
-		mconfig->obs = tkn_elem->value;
-		break;
-
 	case SKL_TKN_U32_IBS:
-		mconfig->ibs = tkn_elem->value;
+		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, dir, pin_index);
+		if (ret < 0)
+			return ret;
+
 		break;
 
 	case SKL_TKN_U32_VBUS_ID:
@@ -2260,10 +2418,16 @@ static int skl_tplg_get_token(struct device *dev,
 
 		break;
 
+	case SKL_TKN_U32_PIPE_CONFIG_ID:
+		conf_idx = tkn_elem->value;
+		break;
+
 	case SKL_TKN_U32_PIPE_CONN_TYPE:
 	case SKL_TKN_U32_PIPE_PRIORITY:
 	case SKL_TKN_U32_PIPE_MEM_PGS:
 	case SKL_TKN_U32_PMODE:
+	case SKL_TKN_U32_PIPE_DIRECTION:
+	case SKL_TKN_U32_NUM_CONFIGS:
 		if (is_pipe_exists) {
 			ret = skl_tplg_fill_pipe_tkn(dev, mconfig->pipe,
 					tkn_elem->token, tkn_elem->value);
@@ -2273,6 +2437,27 @@ static int skl_tplg_get_token(struct device *dev,
 
 		break;
 
+	case SKL_TKN_U32_PATH_MEM_PGS:
+	case SKL_TKN_U32_CFG_FREQ:
+	case SKL_TKN_U8_CFG_CHAN:
+	case SKL_TKN_U8_CFG_BPS:
+		if (mconfig->pipe->nr_cfgs) {
+			ret = skl_tplg_fill_pipe_cfg(dev, mconfig->pipe,
+					tkn_elem->token, tkn_elem->value,
+					conf_idx, dir);
+			if (ret < 0)
+				return ret;
+		}
+		break;
+
+	case SKL_TKN_CFG_MOD_RES_ID:
+		mconfig->mod_cfg[conf_idx].res_idx = tkn_elem->value;
+		break;
+
+	case SKL_TKN_CFG_MOD_FMT_ID:
+		mconfig->mod_cfg[conf_idx].fmt_idx = tkn_elem->value;
+		break;
+
 	/*
 	 * SKL_TKN_U32_DIR_PIN_COUNT token has the value for both
 	 * direction and the pin count. The first four bits represent
@@ -2293,7 +2478,7 @@ static int skl_tplg_get_token(struct device *dev,
 	case SKL_TKN_U32_FMT_INTERLEAVE:
 	case SKL_TKN_U32_FMT_SAMPLE_TYPE:
 	case SKL_TKN_U32_FMT_CH_MAP:
-		ret = skl_tplg_widget_fill_fmt(dev, mconfig, tkn_elem->token,
+		ret = skl_tplg_widget_fill_fmt(dev, iface, tkn_elem->token,
 				tkn_elem->value, dir, pin_index);
 
 		if (ret < 0)
@@ -2518,11 +2703,11 @@ static void skl_clear_pin_config(struct snd_soc_platform *platform,
 					strlen(platform->component.name))) {
 		mconfig = w->priv;
 		pipe = mconfig->pipe;
-		for (i = 0; i < mconfig->max_in_queue; i++) {
+		for (i = 0; i < mconfig->module->max_input_pins; i++) {
 			mconfig->m_in_pin[i].in_use = false;
 			mconfig->m_in_pin[i].pin_state = SKL_PIN_UNBIND;
 		}
-		for (i = 0; i < mconfig->max_out_queue; i++) {
+		for (i = 0; i < mconfig->module->max_output_pins; i++) {
 			mconfig->m_out_pin[i].in_use = false;
 			mconfig->m_out_pin[i].pin_state = SKL_PIN_UNBIND;
 		}
@@ -2581,6 +2766,13 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	if (!mconfig)
 		return -ENOMEM;
 
+	if (skl->nr_modules == 0) {
+		mconfig->module = devm_kzalloc(bus->dev,
+				sizeof(*mconfig->module), GFP_KERNEL);
+		if (!mconfig->module)
+			return -ENOMEM;
+	}
+
 	w->priv = mconfig;
 
 	/*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 9324f5eec69f..25e719243be3 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -274,6 +274,23 @@ struct skl_pipe_params {
 	unsigned int link_bps;
 };
 
+struct skl_pipe_fmt {
+	u32 freq;
+	u8 channels;
+	u8 bps;
+};
+
+struct skl_pipe_mcfg {
+	u8 res_idx;
+	u8 fmt_idx;
+};
+
+struct skl_path_config {
+	u8 mem_pages;
+	struct skl_pipe_fmt in_fmt;
+	struct skl_pipe_fmt out_fmt;
+};
+
 struct skl_pipe {
 	u8 ppl_id;
 	u8 pipe_priority;
@@ -282,6 +299,10 @@ struct skl_pipe {
 	u8 lp_mode;
 	struct skl_pipe_params *p_params;
 	enum skl_pipe_state state;
+	u8 direction;
+	u8 cur_config_idx;
+	u8 nr_cfgs;
+	struct skl_path_config configs[SKL_MAX_PATH_CONFIGS];
 	struct list_head w_list;
 	bool passthru;
 };
@@ -349,6 +370,9 @@ struct skl_module {
 struct skl_module_cfg {
 	u8 guid[16];
 	struct skl_module_inst_id id;
+	struct skl_module *module;
+	int res_idx;
+	int fmt_idx;
 	u8 domain;
 	bool homogenous_inputs;
 	bool homogenous_outputs;
@@ -383,6 +407,7 @@ struct skl_module_cfg {
 	enum skl_module_state m_state;
 	struct skl_pipe *pipe;
 	struct skl_specific_cfg formats_config;
+	struct skl_pipe_mcfg mod_cfg[SKL_MAX_MODULES_IN_PIPE];
 };
 
 struct skl_algo_data {
-- 
2.14.1
