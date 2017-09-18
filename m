From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 1/7] ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments
Date: Mon, 18 Sep 2017 10:26:44 +0530
Message-ID: <1505710610-17952-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>

Set dma control ipc can be used to set the M/N divider, enable the clks. It
takes different payload for different configuration. So modify the
skl_dsp_set_dma_control API to take the size and node_id as argument.

Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 23 ++++++++++++++---------
 sound/soc/intel/skylake/skl-topology.h |  4 ++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 89f70133c8e4..f637829833e6 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -613,8 +613,10 @@ static void skl_setup_cpr_gateway_cfg(struct skl_sst *ctx,
 }
 
 #define DMA_CONTROL_ID 5
+#define DMA_I2S_BLOB_SIZE 21
 
-int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
+int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
+				u32 caps_size, u32 node_id)
 {
 	struct skl_dma_control *dma_ctrl;
 	struct skl_ipc_large_config_msg msg = {0};
@@ -624,24 +626,27 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 	/*
 	 * if blob size zero, then return
 	 */
-	if (mconfig->formats_config.caps_size == 0)
+	if (caps_size == 0)
 		return 0;
 
 	msg.large_param_id = DMA_CONTROL_ID;
-	msg.param_data_size = sizeof(struct skl_dma_control) +
-				mconfig->formats_config.caps_size;
+	msg.param_data_size = sizeof(struct skl_dma_control) + caps_size;
 
 	dma_ctrl = kzalloc(msg.param_data_size, GFP_KERNEL);
 	if (dma_ctrl == NULL)
 		return -ENOMEM;
 
-	dma_ctrl->node_id = skl_get_node_id(ctx, mconfig);
+	dma_ctrl->node_id = node_id;
 
-	/* size in dwords */
-	dma_ctrl->config_length = mconfig->formats_config.caps_size / 4;
+	/*
+	 * NHLT blob may contain additional configs along with i2s blob.
+	 * firmware expects only the i2s blob size as the config_length.
+	 * So fix to i2s blob size.
+	 * size in dwords.
+	 */
+	dma_ctrl->config_length = DMA_I2S_BLOB_SIZE;
 
-	memcpy(dma_ctrl->config_data, mconfig->formats_config.caps,
-				mconfig->formats_config.caps_size);
+	memcpy(dma_ctrl->config_data, caps, caps_size);
 
 	err = skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)dma_ctrl);
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 2717db92036b..e11cc1fc0e43 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -455,8 +455,8 @@ static inline struct skl *get_skl_ctx(struct device *dev)
 
 int skl_tplg_be_update_params(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params);
-int skl_dsp_set_dma_control(struct skl_sst *ctx,
-		struct skl_module_cfg *mconfig);
+int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
+			u32 caps_size, u32 node_id);
 void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
 int skl_tplg_init(struct snd_soc_platform *platform,
-- 
1.9.1

