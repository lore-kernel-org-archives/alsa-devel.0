From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 2/7] ASoC: hda: add helper to configure module
	params
Date: Sun, 19 Apr 2015 02:27:28 +0530
Message-ID: <1429390653-8194-3-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 20CA826512F
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:45 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This add helper functions to create module
parameter for module IPC msg

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/hda_dsp_controls.h |  338 ++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_soc_dsp.c      |  395 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 733 insertions(+)
 create mode 100644 sound/soc/hda/hda_dsp_controls.h

diff --git a/sound/soc/hda/hda_dsp_controls.h b/sound/soc/hda/hda_dsp_controls.h
new file mode 100644
index 000000000000..6bd83db94009
--- /dev/null
+++ b/sound/soc/hda/hda_dsp_controls.h
@@ -0,0 +1,338 @@
+/*
+ *  soc-hda-controls.h - Intel HDA Platform controls header file
+ *
+ *  Copyright (C) 2014-15 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef __SOC_HDA_DSP_CONTROLS_H__
+#define __SOC_HDA_DSP_CONTROLS_H__
+
+#include <linux/types.h>
+
+#define BITS_PER_BYTE 8
+
+/* Maximum number of coefficients up down mixer module */
+#define UP_DOWN_MIXER_MAX_COEFF		6
+
+enum ssth_channel_index {
+	SSTH_CHANNEL_LEFT = 0,
+	SSTH_CHANNEL_CENTER = 1,
+	SSTH_CHANNEL_RIGHT = 2,
+	SSTH_CHANNEL_LEFT_SURROUND = 3,
+	SSTH_CHANNEL_CENTER_SURROUND = 3,
+	SSTH_CHANNEL_RIGHT_SURROUND = 4,
+	SSTH_CHANNEL_LFE = 7,
+	SSTH_CHANNEL_INVALID = 0xF,
+};
+
+enum ssth_channel_config {
+	SSTH_CHANNEL_CONFIG_MONO = 0, /* One channel only. */
+	SSTH_CHANNEL_CONFIG_STEREO = 1, /* L & R. */
+	SSTH_CHANNEL_CONFIG_2_1 = 2, /* L, R & LFE; PCM only. */
+	SSTH_CHANNEL_CONFIG_3_0 = 3, /* L, C & R; MP3 & AAC only. */
+	SSTH_CHANNEL_CONFIG_3_1 = 4, /* L, C, R & LFE; PCM only. */
+	SSTH_CHANNEL_CONFIG_QUATRO = 5, /* L, R, Ls & Rs; PCM only. */
+	SSTH_CHANNEL_CONFIG_4_0 = 6, /* L, C, R & Cs; MP3 & AAC only. */
+	SSTH_CHANNEL_CONFIG_5_0 = 7, /* L, C, R, Ls & Rs. */
+	SSTH_CHANNEL_CONFIG_5_1 = 8, /* L, C, R, Ls, Rs & LFE. */
+	SSTH_CHANNEL_CONFIG_DUAL_MONO = 9, /* One channel replicated in two. */
+	SSTH_CHANNEL_CONFIG_I2S_DUAL_STEREO_0 = 10, /* Stereo(L,R) in 4 slots,
+						    1st stream:[ L, R, -, - ]
+						    */
+	SSTH_CHANNEL_CONFIG_I2S_DUAL_STEREO_1 = 11, /* Stereo(L,R) in 4 slots,
+						    2nd stream:[ -, -, L, R ]
+						    */
+	SSTH_CHANNEL_CONFIG_INVALID
+};
+
+enum ssth_bitdepth {
+	SSTH_DEPTH_8BIT = 8,
+	SSTH_DEPTH_16BIT = 16,
+	SSTH_DEPTH_24BIT = 24, /**< Default. */
+	SSTH_DEPTH_32BIT = 32,
+	SSTH_DEPTH_INVALID
+};
+
+enum ssth_interleaving_style {
+	SSTH_INTERLEAVING_PER_CHANNEL = 0, /* [s1_ch1...s1_chN,...,sM_ch1...sM_chN] */
+	SSTH_INTERLEAVING_PER_SAMPLE = 1, /* [s1_ch1...sM_ch1,...,s1_chN...sM_chN] */
+};
+
+enum ssth_sampling_frequency {
+	SSTH_FS_8000HZ = 8000,
+	SSTH_FS_11025HZ = 11025,
+	SSTH_FS_12000HZ = 12000, /** Mp3, AAC, SRC only. */
+	SSTH_FS_16000HZ = 16000,
+	SSTH_FS_22050HZ = 22050,
+	SSTH_FS_24000HZ = 24000, /** Mp3, AAC, SRC only. */
+	SSTH_FS_32000HZ = 32000,
+	SSTH_FS_44100HZ = 44100,
+	SSTH_FS_48000HZ = 48000, /**< Default. */
+	SSTH_FS_64000HZ = 64000, /** AAC, SRC only. */
+	SSTH_FS_88200HZ = 88200, /** AAC, SRC only. */
+	SSTH_FS_96000HZ = 96000, /** AAC, SRC only. */
+	SSTH_FS_128000HZ = 128000, /** SRC only. */
+	SSTH_FS_176400HZ = 176400, /** SRC only. */
+	SSTH_FS_192000HZ = 192000, /** SRC only. */
+	SSTH_FS_INVALID
+};
+
+enum ssth_widget_type {
+	SSTH_WIDGET_VMIXER = 1,
+	SSTH_WIDGET_MIXER = 2,
+	SSTH_WIDGET_PGA = 3,
+	SSTH_WIDGET_MUX = 4
+};
+
+struct ssth_audio_data_format {
+	enum ssth_sampling_frequency sampling_frequency;
+	enum ssth_bitdepth bit_depth;
+	u32 channel_map;
+	enum ssth_channel_config channel_config;
+	enum ssth_interleaving_style interleaving_style;
+	u8 number_of_channels;
+	u8 valid_bit_depth;
+	u8 sample_type;
+	u8 reserved[1];
+} __packed;
+
+struct ssth_base_module_config {
+	u32 cps;
+	u32 ibs;
+	u32 obs;
+	u32 is_pages;
+	struct ssth_audio_data_format audio_fmt;
+};
+
+struct ssth_copiergateway_cfg {
+	u32 node_id;
+	u32 dma_buffer_size;
+	u32 config_length;
+	u32 config_data[1]; /*not mandatory; required only for DMIC/I2S */
+} __packed;
+
+struct ssth_copier_module_config {
+	struct ssth_base_module_config base_module_config;
+	struct ssth_audio_data_format out_fmt;
+	u32 cpr_feature_mask;
+	struct ssth_copiergateway_cfg gtw_cfg;
+} __packed;
+
+struct ssth_src_config {
+	enum ssth_sampling_frequency s_freq;
+} __packed;
+
+struct ssth_src_module_config {
+	struct ssth_base_module_config base_module_config;
+	struct ssth_src_config src_config;
+} __packed;
+
+struct ssth_up_down_mixer_module_config {
+	struct ssth_base_module_config base_module_config;
+	enum ssth_channel_config out_channel_config;
+	/* This should be set to 1 if user coefficients are required */
+	u32 coeff_sel;
+	/* Pass the user coeff in this array */
+	s32 coeff[UP_DOWN_MIXER_MAX_COEFF];
+} __packed;
+
+enum ssth_dma_type {
+	SSTH_DMA_TYPE_HDA_HOST_OUTPUT_CLASS = 0,
+	SSTH_DMA_TYPE_HDA_HOST_INPUT_CLASS = 1,
+	SSTH_DMA_TYPE_HDA_HOST_INOUT_CLASS = 2,
+	SSTH_DMA_TYPE_HDA_LINK_OUTPUT_CLASS = 8,
+	SSTH_DMA_TYPE_HDA_LINK_INPUT_CLASS = 9,
+	SSTH_DMA_TYPE_HDA_LINK_INOUT_CLASS = 0xA,
+	SSTH_DMA_TYPE_DMIC_LINK_INPUT_CLASS = 0xB,
+	SSTH_DMA_TYPE_I2S_LINK_OUTPUT_CLASS = 0xC,
+	SSTH_DMA_TYPE_I2S_LINK_INPUT_CLASS = 0xD,
+};
+
+union ssth_ssp_dma_node {
+	u8 val;
+	struct {
+		u8 dual_mono:1;
+		u8 time_slot:3;
+		u8 i2s_instance:4;
+	} dma_node;
+};
+
+union ssth_connector_node_id {
+	u32 val;
+	struct {
+		u32 dma_id:8; /* DMA engine ID */
+		u32 dma_type:4;
+		u32 rsvd:20;
+	} node;
+};
+
+enum ssth_fw_pipeline_type {
+	SSTH_PIPELINE_TYPE_DECODE = 0,
+	SSTH_PIPELINE_TYPE_MIXER = 1,
+	SSTH_PIPELINE_TYPE_REFERENCE = 2,
+	SSTH_PIPELINE_TYPE_CAPTURE = 3
+};
+
+enum ssth_core_affinity {
+	SSTH_AFFINITY_CORE_0 = 0,
+	SSTH_AFFINITY_CORE_1,
+	SSTH_AFFINITY_CORE_MAX
+};
+
+struct ssth_module_format {
+	u32 channels;
+	u32 sampling_freq;
+	u32 bit_depth;
+	u32 valid_bit_depth;
+	u32 channel_config;
+};
+
+struct ssth_module_instance_id {
+	u32 module_id;
+	u32 instance_id;
+};
+
+struct ssth_specific_config {
+	u32 caps_size;
+	u32 *caps;
+};
+
+enum ssth_pipe_state {
+	SSTH_PIPE_STATE_INVALID = 0,
+	SSTH_PIPE_STATE_CREATED = 1,
+	SSTH_PIPE_STATE_PAUSED = 2,
+	SSTH_PIPE_STATE_STARTED = 3
+};
+
+struct ssth_pipe_module {
+	struct snd_soc_dapm_widget *w;
+	struct list_head node;
+};
+
+struct ssth_pipe {
+	u8 ppl_id;
+	u8 pipe_priority;
+	u16 conn_type;
+	u32 memory_pages;
+	enum ssth_pipe_state state;
+	struct list_head w_list;
+};
+
+enum ssth_module_state {
+	SSTH_MODULE_STATE_UNINIT = 0,
+	SSTH_MODULE_STATE_INIT_DONE = 1,
+	SSTH_MODULE_STATE_LOADED = 2,
+	SSTH_MODULE_STATE_UNLOADED = 3,
+	SSTH_MODULE_STATE_BIND_DONE = 4
+};
+
+enum ssth_module_type {
+	SSTH_BASE_FW_MODULE = 0,
+	SSTH_BASE_MIX_IN_MODULE,
+	SSTH_BASE_MIX_OUT_MODULE,
+	SSTH_COPIER_MODULE,
+	SSTH_UPDWMIX_MODULE,
+	SSTH_SRCINT_MODULE,
+	SSTH_MAX_MODULE
+};
+
+enum ssth_dev_type {
+	SSTH_DEVICE_BT = 0x0,
+	SSTH_DEVICE_DMIC = 0x1,
+	SSTH_DEVICE_I2S = 0x2,
+	SSTH_DEVICE_SLIMBUS = 0x3,
+	SSTH_DEVICE_HDALINK = 0x4,
+	SSTH_DEVICE_NONE
+};
+
+enum ssth_pipe_conn_type {
+	SSTH_PIPE_CONN_TYPE_NONE = 0,
+	SSTH_PIPE_CONN_TYPE_FE,
+	SSTH_PIPE_CONN_TYPE_BE
+};
+
+enum ssth_module_conn_type {
+	SSTH_CONN_NONE = 0,
+	SSTH_CONN_SOURCE = 1,
+	SSTH_CONN_SINK = 2
+};
+
+struct ssth_sink_module {
+	struct list_head node;
+	struct ssth_module_instance_id id;
+	u8 in_queue;
+};
+
+struct ssth_module_config {
+	struct ssth_module_instance_id id;
+	struct ssth_module_format in_fmt;
+	struct ssth_module_format out_fmt;
+	u8 max_in_queue;
+	u8 max_out_queue;
+	u8 in_queue_mask;
+	u8 out_queue_mask;
+	u8 in_queue;
+	u8 out_queue;
+	u32 mcps;
+	u32 ibs;
+	u32 obs;
+	u8 is_loadable;
+	u8 core_id;
+	u8 conn_type;
+	u8 dev_type;
+	u8 dma_id;
+	u8 time_slot;
+	u32 params_fixup;
+	u32 converter;
+	struct list_head sink_list;
+	enum ssth_module_conn_type  hw_conn_type;
+	enum ssth_module_state m_state;
+	struct ssth_pipe *pipe;
+	struct ssth_specific_config formats_config;
+};
+
+/* Event types goes here */
+/* Reserve event type 0 for no event handlers */
+enum ssth_event_types {
+	HDA_SST_EVENT_TYPE_NONE = 0,
+	HDA_SST_SET_MIXER,
+	HDA_SST_SET_MUX,
+	HDA_SST_SET_VMIXER,
+	HDA_SST_SET_PGA
+};
+
+struct hda_sst_algo_data {
+	u32 max;
+	char *params;
+};
+
+struct ssth_pipeline {
+	struct ssth_pipe *pipe;
+	struct list_head node;
+};
+
+int ssth_create_pipeline(struct ssth_lib *ctx, struct ssth_pipe *pipe);
+int ssth_run_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe);
+int ssth_pause_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe);
+int ssth_delete_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe);
+int ssth_stop_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe);
+int ssth_init_module(struct ssth_lib *ctx, struct ssth_module_config *module_config,
+	struct hda_sst_algo_data *ac);
+int ssth_bind_unbind_modules(struct ssth_lib *ctx, struct ssth_module_config
+	*src_module, struct ssth_module_config *dst_module, bool bind);
+enum ssth_bitdepth ssth_get_bit_depth(struct snd_pcm_hw_params *params);
+#endif
diff --git a/sound/soc/hda/hda_soc_dsp.c b/sound/soc/hda/hda_soc_dsp.c
index 3fa033ecaa90..fea47645368e 100644
--- a/sound/soc/hda/hda_soc_dsp.c
+++ b/sound/soc/hda/hda_soc_dsp.c
@@ -28,6 +28,7 @@
 #include <sound/soc-hda-sst-dsp.h>
 #include <sound/soc-hda-sst-ipc.h>
 #include "hda_skl.h"
+#include "hda_dsp_controls.h"
 
 int ssth_dsp_register(struct hda_soc_bus *schip)
 {
@@ -60,3 +61,397 @@ void ssth_dsp_unregister(struct hda_soc_bus *schip)
 	if (schip->dsp->mmio_base)
 		iounmap(schip->dsp->mmio_base);
 }
+
+enum ssth_bitdepth ssth_get_bit_depth(struct snd_pcm_hw_params *params)
+{
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		return SSTH_DEPTH_8BIT;
+
+	case SNDRV_PCM_FORMAT_S16_LE:
+		return SSTH_DEPTH_16BIT;
+
+	case SNDRV_PCM_FORMAT_S24_LE:
+		return SSTH_DEPTH_24BIT;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		return SSTH_DEPTH_32BIT;
+	default:
+		return SSTH_DEPTH_INVALID;
+	}
+}
+
+static u32 hda_sst_create_channel_map(enum ssth_channel_config channel_config)
+{
+	u32 config;
+
+	switch (channel_config) {
+	case SSTH_CHANNEL_CONFIG_MONO:
+		config =  (0xFFFFFFF0 | SSTH_CHANNEL_CENTER);
+	break;
+
+	case SSTH_CHANNEL_CONFIG_STEREO:
+		config = (0xFFFFFF00 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_RIGHT << 4));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_2_1:
+		config = (0xFFFFF000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_RIGHT << 4)
+			| (SSTH_CHANNEL_LFE << 8));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_3_0:
+		config =  (0xFFFFF000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_CENTER << 4)
+			| (SSTH_CHANNEL_RIGHT << 8));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_3_1:
+		config = (0xFFFF0000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_CENTER << 4)
+			| (SSTH_CHANNEL_RIGHT << 8)
+			| (SSTH_CHANNEL_LFE << 12));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_QUATRO:
+		config = (0xFFFF0000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_RIGHT << 4)
+			| (SSTH_CHANNEL_LEFT_SURROUND << 8)
+			| (SSTH_CHANNEL_RIGHT_SURROUND << 12));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_4_0:
+		config = (0xFFFF0000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_CENTER << 4)
+			| (SSTH_CHANNEL_RIGHT << 8)
+			| (SSTH_CHANNEL_CENTER_SURROUND << 12));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_5_0:
+		config = (0xFFF00000 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_CENTER << 4)
+			| (SSTH_CHANNEL_RIGHT << 8)
+			| (SSTH_CHANNEL_LEFT_SURROUND << 12)
+			| (SSTH_CHANNEL_RIGHT_SURROUND << 16));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_5_1:
+		config = (0xFF000000 | SSTH_CHANNEL_CENTER
+			| (SSTH_CHANNEL_LEFT << 4)
+			| (SSTH_CHANNEL_RIGHT << 8)
+			| (SSTH_CHANNEL_LEFT_SURROUND << 12)
+			| (SSTH_CHANNEL_RIGHT_SURROUND << 16)
+			| (SSTH_CHANNEL_LFE << 20));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_DUAL_MONO:
+		config = (0xFFFFFF00 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_LEFT << 4));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_I2S_DUAL_STEREO_0:
+		config = (0xFFFFFF00 | SSTH_CHANNEL_LEFT
+			| (SSTH_CHANNEL_RIGHT << 4));
+	break;
+
+	case SSTH_CHANNEL_CONFIG_I2S_DUAL_STEREO_1:
+		config = (0xFFFF00FF | (SSTH_CHANNEL_LEFT << 8)
+			| (SSTH_CHANNEL_RIGHT << 12));
+	break;
+	default:
+		config =  0xFFFFFFFF;
+	}
+	return config;
+}
+
+/*
+ * Fills in base_module_config structure .
+ * base_module_config is sent as input buffer with INIT_INSTANCE IPC msg
+ */
+static void ssth_set_base_module_format(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_base_module_config *base_module_config)
+{
+	struct ssth_module_format *format = &mconfig->in_fmt;
+
+	base_module_config->audio_fmt.number_of_channels =
+		(u8)format->channels;
+
+	base_module_config->audio_fmt.sampling_frequency = format->sampling_freq;
+	base_module_config->audio_fmt.bit_depth = format->bit_depth;
+	base_module_config->audio_fmt.valid_bit_depth = format->valid_bit_depth;
+	base_module_config->audio_fmt.channel_config = format->channel_config;
+
+	dev_dbg(ctx->dev, "bit_depth=%x valid_bd=%x ch_config=%x\n", format->bit_depth,
+			format->valid_bit_depth, format->channel_config);
+
+	base_module_config->audio_fmt.channel_map =
+		hda_sst_create_channel_map(
+			base_module_config->audio_fmt.channel_config);
+
+	base_module_config->audio_fmt.interleaving_style =
+		SSTH_INTERLEAVING_PER_CHANNEL;
+
+	base_module_config->cps = mconfig->mcps;
+	base_module_config->ibs = mconfig->ibs;
+	base_module_config->obs = mconfig->obs;
+	base_module_config->is_pages = 0;
+
+}
+
+/*
+ * Copies copier capabilities into copier module and updates copier module
+ * config size.
+ */
+static void ssth_copy_copier_caps(struct ssth_module_config *mconfig,
+	struct ssth_copier_module_config *cpr_mconfig)
+{
+	if (mconfig->formats_config.caps_size == 0)
+		return;
+
+	memcpy(cpr_mconfig->gtw_cfg.config_data,
+		mconfig->formats_config.caps,
+		mconfig->formats_config.caps_size);
+
+	cpr_mconfig->gtw_cfg.config_length =
+		 (mconfig->formats_config.caps_size) / 4;
+}
+
+static void ssth_setup_cpr_gateway_cfg(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_copier_module_config *cpr_mconfig)
+{
+	union ssth_connector_node_id node_id = {0};
+
+	switch (mconfig->dev_type) {
+	case SSTH_DEVICE_BT:
+		node_id.node.dma_type =
+			(SSTH_CONN_SOURCE == mconfig->conn_type) ?
+			SSTH_DMA_TYPE_I2S_LINK_OUTPUT_CLASS :
+			SSTH_DMA_TYPE_I2S_LINK_INPUT_CLASS;
+		node_id.node.dma_id = mconfig->dma_id;
+		break;
+
+	case SSTH_DEVICE_I2S:
+		node_id.node.dma_type =
+			(SSTH_CONN_SOURCE == mconfig->conn_type) ?
+			SSTH_DMA_TYPE_I2S_LINK_OUTPUT_CLASS :
+			SSTH_DMA_TYPE_I2S_LINK_INPUT_CLASS;
+		node_id.node.dma_id = mconfig->dma_id +
+					 (mconfig->time_slot << 1);
+		break;
+
+	case SSTH_DEVICE_DMIC:
+		node_id.node.dma_type = SSTH_DMA_TYPE_DMIC_LINK_INPUT_CLASS;
+		node_id.node.dma_id = mconfig->dma_id +
+					 (mconfig->time_slot);
+		break;
+
+	case SSTH_DEVICE_HDALINK:
+		node_id.node.dma_type =
+			(SSTH_CONN_SOURCE == mconfig->conn_type) ?
+			SSTH_DMA_TYPE_HDA_LINK_OUTPUT_CLASS :
+			SSTH_DMA_TYPE_HDA_LINK_INPUT_CLASS;
+		node_id.node.dma_id = mconfig->dma_id;
+		break;
+	
+	default:
+		node_id.node.dma_type =
+			(SSTH_CONN_SOURCE == mconfig->conn_type) ?
+			SSTH_DMA_TYPE_HDA_HOST_OUTPUT_CLASS :
+			SSTH_DMA_TYPE_HDA_HOST_INPUT_CLASS;
+		node_id.node.dma_id = mconfig->dma_id;
+		break;
+	}
+
+	cpr_mconfig->gtw_cfg.node_id = node_id.val;
+
+	if (SSTH_CONN_SOURCE == mconfig->conn_type)
+		cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->obs;
+	else
+		cpr_mconfig->gtw_cfg.dma_buffer_size = 2 * mconfig->ibs;
+	cpr_mconfig->cpr_feature_mask = 0;
+	cpr_mconfig->gtw_cfg.config_length  = 0;
+
+	ssth_copy_copier_caps(mconfig, cpr_mconfig);
+	dev_dbg(ctx->dev, "Copier module config:\n");
+	dev_dbg(ctx->dev, "length: 0x%x\n", cpr_mconfig->gtw_cfg.config_length);
+}
+
+static void ssth_setup_cpr_out_format(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_copier_module_config *cpr_mconfig)
+{
+	struct ssth_module_format *format = &mconfig->out_fmt;
+
+	cpr_mconfig->out_fmt.number_of_channels =
+		(u8)format->channels;
+
+	cpr_mconfig->out_fmt.sampling_frequency = format->sampling_freq;
+
+	cpr_mconfig->out_fmt.bit_depth = format->bit_depth;
+
+	cpr_mconfig->out_fmt.valid_bit_depth = format->valid_bit_depth;
+
+	cpr_mconfig->out_fmt.channel_config = format->channel_config;
+
+	cpr_mconfig->out_fmt.channel_map =
+		hda_sst_create_channel_map(cpr_mconfig->out_fmt.channel_config);
+	cpr_mconfig->out_fmt.interleaving_style = SSTH_INTERLEAVING_PER_CHANNEL;
+
+
+	dev_dbg(ctx->dev, "copier out format chan=%d fre=%d bitdepth=%d\n",
+		cpr_mconfig->out_fmt.number_of_channels,
+		 format->sampling_freq, format->bit_depth);
+}
+
+static int ssth_set_src_format(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_src_module_config *src_mconfig)
+{
+	struct ssth_module_format *fmt = &mconfig->out_fmt;
+
+	ssth_set_base_module_format(ctx,
+		mconfig,
+		(struct ssth_base_module_config *)src_mconfig);
+
+	src_mconfig->src_config.s_freq = fmt->sampling_freq;
+
+	return 0;
+}
+
+static int ssth_set_updown_mixer_format(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_up_down_mixer_module_config *mixer_mconfig)
+{
+	int i = 0;
+	struct ssth_module_format *fmt = &mconfig->out_fmt;
+
+	ssth_set_base_module_format(ctx,
+		mconfig,
+		(struct ssth_base_module_config *)mixer_mconfig);
+	mixer_mconfig->out_channel_config = fmt->channel_config;
+
+
+	/* Select F/W defatult coefficient */
+	mixer_mconfig->coeff_sel = 0x0;
+
+	/* User coeff, dont care since we are selecting F/W defaults */
+	for (i = 0; i < UP_DOWN_MIXER_MAX_COEFF; i++)
+		mixer_mconfig->coeff[i] = 0xDEADBEEF;
+
+	return 0;
+}
+
+/*
+ * copier_module_config is sent as input buffer with INIT_INSTANCE IPC msg
+ */
+static int ssth_set_copier_format(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig,
+	struct ssth_copier_module_config *cpr_mconfig)
+{
+	int ret = 0;
+
+	ssth_set_base_module_format(ctx,
+		mconfig,
+		(struct ssth_base_module_config *)cpr_mconfig);
+
+	ssth_setup_cpr_out_format(ctx, mconfig, cpr_mconfig);
+	ssth_setup_cpr_gateway_cfg(ctx, mconfig, cpr_mconfig);
+
+	return ret;
+}
+
+static u16 ssth_get_module_param_size(struct ssth_lib *ctx,
+	struct ssth_module_config *mconfig)
+{
+	u16 param_size = 0;
+
+	if (mconfig->id.module_id == SSTH_COPIER_MODULE) {
+		param_size = sizeof(struct ssth_copier_module_config);
+		param_size += mconfig->formats_config.caps_size;
+		return param_size;
+	} else if (mconfig->id.module_id == SSTH_SRCINT_MODULE)
+		return sizeof(struct ssth_src_module_config);
+	else if (mconfig->id.module_id == SSTH_UPDWMIX_MODULE)
+		return sizeof(struct ssth_up_down_mixer_module_config);
+	else
+		return sizeof(struct ssth_base_module_config);
+	return param_size;
+}
+
+static int ssth_set_module_format(struct ssth_lib *ctx,
+	struct ssth_module_config *module_config,
+	u16 *module_config_size,
+	void **param_data)
+{
+	u16 param_size;
+	int i = 0, ret = 0;
+	u32 *byte;
+
+	param_size  = ssth_get_module_param_size(ctx, module_config);
+
+	*param_data = kzalloc(param_size, GFP_KERNEL);
+
+	if (NULL == *param_data)
+		return -ENOMEM;
+
+	memset(*param_data, 0, param_size);
+
+	*module_config_size = param_size;
+
+	if (module_config->id.module_id == SSTH_COPIER_MODULE)
+		ret = ssth_set_copier_format(ctx, module_config,
+			*param_data);
+	else if (module_config->id.module_id == SSTH_SRCINT_MODULE)
+		ret =  ssth_set_src_format(ctx, module_config, *param_data);
+	else if (module_config->id.module_id == SSTH_UPDWMIX_MODULE)
+		ret =  ssth_set_updown_mixer_format(ctx, module_config,
+						 *param_data);
+	else
+		ssth_set_base_module_format(ctx, module_config, *param_data);
+
+	*module_config_size = param_size;
+
+	dev_dbg(ctx->dev, "Module type=%d config size: %d bytes\n",
+			module_config->id.module_id, param_size);
+	for (i = 0, byte = (u32 *) *param_data;
+		i < (param_size)/sizeof(u32);
+		i++, byte++) {
+		dev_dbg(ctx->dev, "0x%x: %08x\n", i, *byte);
+	}
+	return ret;
+}
+
+/*
+ * Allocates queue in the link pipeline (mix in/out module)
+ */
+static u8 ssth_alloc_queue(u8 *queue_mask, u8 max_queue, u8 queue_index)
+{
+	while (*queue_mask & (1llu <<  queue_index)) {
+		queue_index++;
+		if (queue_index  == max_queue) {
+			queue_index = 0;
+			*queue_mask = 0;
+			break;
+		}
+	}
+
+	*queue_mask |= (1llu <<  queue_index);
+
+	return queue_index;
+}
+
+static int ssth_free_queue(u8 *queue_mask, u8 queue_index)
+{
+	if (queue_index > 0)
+		*queue_mask &= ~(queue_index);
+	else
+		 *queue_mask &= queue_index;
+	if (queue_index > 0)
+		return queue_index - 1;
+	else
+		return queue_index;
+}
-- 
1.7.9.5
