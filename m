From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 3/7] ASoC: Intel: Skylake: Prepare DMA control IPC to enable/disable clock
Date: Mon, 18 Sep 2017 10:26:46 +0530
Message-ID: <1505710610-17952-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>

Add the required structures and create set_dma_control ipc to enable or
disable the clock. To enable sclk without fs, mclk ipc structure is used,
else sclkfs ipc structure is used.

Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 86 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-ssp-clk.h  | 38 +++++++++++++++
 sound/soc/intel/skylake/skl.h          |  8 ++++
 3 files changed, 132 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index f637829833e6..089ea3c03846 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1371,3 +1371,89 @@ int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
 
 	return skl_ipc_get_large_config(&ctx->ipc, &msg, params);
 }
+
+void skl_fill_clk_ipc(struct skl_clk_rate_cfg_table *rcfg, u8 clk_type)
+{
+	struct nhlt_fmt_cfg *fmt_cfg;
+	struct wav_fmt *wfmt;
+	union skl_clk_ctrl_ipc *ipc;
+
+	if (!rcfg)
+		return;
+
+	ipc = &rcfg->dma_ctl_ipc;
+	if (clk_type == SKL_SCLK_FS) {
+		fmt_cfg = (struct nhlt_fmt_cfg *)rcfg->config;
+		wfmt = &fmt_cfg->fmt_ext.fmt;
+
+		/* Remove TLV Header size */
+		ipc->sclk_fs.hdr.size = sizeof(struct skl_dmactrl_sclkfs_cfg) -
+						sizeof(struct skl_tlv_hdr);
+		ipc->sclk_fs.sampling_frequency = wfmt->samples_per_sec;
+		ipc->sclk_fs.bit_depth = wfmt->bits_per_sample;
+		ipc->sclk_fs.valid_bit_depth =
+			fmt_cfg->fmt_ext.sample.valid_bits_per_sample;
+		ipc->sclk_fs.number_of_channels = wfmt->channels;
+	} else {
+		ipc->mclk.hdr.type = DMA_CLK_CONTROLS;
+		/* Remove TLV Header size */
+		ipc->mclk.hdr.size = sizeof(struct skl_dmactrl_mclk_cfg) -
+						sizeof(struct skl_tlv_hdr);
+	}
+}
+
+/* Sends dma control IPC to turn the clock ON/OFF */
+int skl_send_clk_dma_control(struct skl *skl, struct skl_clk_rate_cfg_table
+				*rcfg, u32 vbus_id, u8 clk_type, bool enable)
+{
+	struct nhlt_fmt_cfg *fmt_cfg;
+	struct nhlt_specific_cfg *sp_cfg;
+	union skl_clk_ctrl_ipc *ipc;
+	void *i2s_config = NULL;
+	u8 *data, size;
+	u32 i2s_config_size, node_id = 0;
+	int ret;
+
+	if (!rcfg)
+		return -EIO;
+
+	ipc = &rcfg->dma_ctl_ipc;
+	fmt_cfg = (struct nhlt_fmt_cfg *)rcfg->config;
+	sp_cfg = &fmt_cfg->config;
+	if (clk_type == SKL_SCLK_FS) {
+		ipc->sclk_fs.hdr.type =
+			enable ? DMA_TRANSMITION_START : DMA_TRANSMITION_STOP;
+		data = (u8 *)&ipc->sclk_fs;
+		size = sizeof(struct skl_dmactrl_sclkfs_cfg);
+	} else {
+		/* 1 to enable mclk, 0 to enable sclk */
+		if (clk_type == SKL_SCLK)
+			ipc->mclk.mclk = 0;
+		else
+			ipc->mclk.mclk = 1;
+
+		ipc->mclk.keep_running = enable;
+		ipc->mclk.warm_up_over = enable;
+		ipc->mclk.clk_stop_over = !enable;
+		data = (u8 *)&ipc->mclk;
+		size = sizeof(struct skl_dmactrl_mclk_cfg);
+	}
+
+	i2s_config_size = sp_cfg->size + size;
+	i2s_config = kzalloc(i2s_config_size, GFP_KERNEL);
+	if (!i2s_config)
+		return -ENOMEM;
+
+	/* copy blob */
+	memcpy(i2s_config, sp_cfg->caps, sp_cfg->size);
+
+	/* copy additional dma controls information */
+	memcpy(i2s_config + sp_cfg->size, data, size);
+
+	node_id = ((SKL_DMA_I2S_LINK_INPUT_CLASS << 8) | (vbus_id << 4));
+	ret = skl_dsp_set_dma_control(skl->skl_sst, (u32 *)i2s_config,
+					i2s_config_size, node_id);
+	kfree(i2s_config);
+
+	return ret;
+}
diff --git a/sound/soc/intel/skylake/skl-ssp-clk.h b/sound/soc/intel/skylake/skl-ssp-clk.h
index 9d98f458f08a..150519dbcd90 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.h
+++ b/sound/soc/intel/skylake/skl-ssp-clk.h
@@ -53,8 +53,46 @@ struct skl_clk_parent_src {
 	const char *parent_name;
 };
 
+struct skl_tlv_hdr {
+	u32 type;
+	u32 size;
+};
+
+struct skl_dmactrl_mclk_cfg {
+	struct skl_tlv_hdr hdr;
+	/* DMA Clk TLV params */
+	u32 clk_warm_up:16;
+	u32 mclk:1;
+	u32 warm_up_over:1;
+	u32 rsvd0:14;
+	u32 clk_stop_delay:16;
+	u32 keep_running:1;
+	u32 clk_stop_over:1;
+	u32 rsvd1:14;
+} __packed;
+
+struct skl_dmactrl_sclkfs_cfg {
+	struct skl_tlv_hdr hdr;
+	/* DMA SClk&FS  TLV params */
+	u32 sampling_frequency;
+	u32 bit_depth;
+	u32 channel_map;
+	u32 channel_config;
+	u32 interleaving_style;
+	u32 number_of_channels : 8;
+	u32 valid_bit_depth : 8;
+	u32 sample_type : 8;
+	u32 reserved : 8;
+} __packed;
+
+union skl_clk_ctrl_ipc {
+	struct skl_dmactrl_mclk_cfg mclk;
+	struct skl_dmactrl_sclkfs_cfg sclk_fs;
+};
+
 struct skl_clk_rate_cfg_table {
 	unsigned long rate;
+	union skl_clk_ctrl_ipc dma_ctl_ipc;
 	void *config;
 };
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index ff75de370c45..f06e98962a0b 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -36,6 +36,10 @@
 /* D0I3C Register fields */
 #define AZX_REG_VS_D0I3C_CIP      0x1 /* Command in progress */
 #define AZX_REG_VS_D0I3C_I3       0x4 /* D0i3 enable */
+#define SKL_MAX_DMACTRL_CFG	18
+#define DMA_CLK_CONTROLS	1
+#define DMA_TRANSMITION_START	2
+#define DMA_TRANSMITION_STOP	3
 
 struct skl_dsp_resource {
 	u32 max_mcps;
@@ -124,6 +128,10 @@ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 void skl_update_d0i3c(struct device *dev, bool enable);
 int skl_nhlt_create_sysfs(struct skl *skl);
 void skl_nhlt_remove_sysfs(struct skl *skl);
+void skl_fill_clk_ipc(struct skl_clk_rate_cfg_table *rcfg, u8 clk_type);
+int skl_send_clk_dma_control(struct skl *skl,
+		struct skl_clk_rate_cfg_table *rcfg,
+		u32 vbus_id, u8 clk_type, bool enable);
 void skl_get_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks);
 struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id);
 
-- 
1.9.1

