From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 4/4] ASoC: Intel: add support for mrfld DPCM
	platform
Date: Mon,  5 May 2014 23:31:48 +0530
Message-ID: <1399312908-20744-5-git-send-email-vinod.koul@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE68261A60
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 20:19:27 +0200 (CEST)
In-Reply-To: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds DPCM based supprt for managing mrfld platform

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig                          |    3 +
 sound/soc/intel/platform-libs/controls_v2.h      |  754 +++++++++++++
 sound/soc/intel/platform-libs/controls_v2_dpcm.c | 1315 ++++++++++++++++++++++
 sound/soc/intel/platform-libs/sst_widgets.h      |  378 +++++++
 sound/soc/intel/platform_ipc_v2.h                |  694 ++++++++++++
 sound/soc/intel/sst-mfld-platform-compress.c     |    8 +-
 sound/soc/intel/sst-mfld-platform-pcm.c          |  384 ++++++-
 sound/soc/intel/sst-mfld-platform.h              |    2 +
 8 files changed, 3480 insertions(+), 58 deletions(-)
 create mode 100644 sound/soc/intel/platform-libs/controls_v2.h
 create mode 100644 sound/soc/intel/platform-libs/controls_v2_dpcm.c
 create mode 100644 sound/soc/intel/platform-libs/sst_widgets.h
 create mode 100644 sound/soc/intel/platform_ipc_v2.h

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 422c32d..1254eb8 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -66,3 +66,6 @@ config SND_SOC_INTEL_MRFLD_WM8958_MACH
           used as alsa device in audio substem in Intel(R) MID devices
           Say Y if you have such a device
           If unsure select "N".
+
+config SND_INTEL_SST
+       tristate
diff --git a/sound/soc/intel/platform-libs/controls_v2.h b/sound/soc/intel/platform-libs/controls_v2.h
new file mode 100644
index 0000000..7988d81
--- /dev/null
+++ b/sound/soc/intel/platform-libs/controls_v2.h
@@ -0,0 +1,754 @@
+/*
+ *  controls_v2.h - Intel MID Platform driver header file
+ *
+ *  Copyright (C) 2013-14 Intel Corp
+ *  Author: Ramesh Babu <ramesh.babu.koul@intel.com>
+ *  	Omair M Abdullah <omair.m.abdullah@intel.com>
+ *  	Samreen Nilofer <samreen.nilofer@intel.com>
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
+#ifndef __SST_CONTROLS_V2_H__
+#define __SST_CONTROLS_V2_H__
+
+enum {
+	MERR_DPCM_AUDIO = 0,
+	MERR_DPCM_COMPR,
+};
+/*
+ * This section defines the map for the mixer widgets.
+ *
+ * Each mixer will be represented by single value and that value will have each
+ * bit corresponding to one input
+ *
+ * Each out_id will correspond to one mixer and one path. Each input will be
+ * represented by single bit in the register.
+ */
+
+/* mixer register ids here */
+#define SST_MIX(x)		(x)
+
+#define SST_MIX_MODEM		SST_MIX(0)
+#define SST_MIX_BT		SST_MIX(1)
+#define SST_MIX_CODEC0		SST_MIX(2)
+#define SST_MIX_CODEC1		SST_MIX(3)
+#define SST_MIX_LOOP0		SST_MIX(4)
+#define SST_MIX_LOOP1		SST_MIX(5)
+#define SST_MIX_LOOP2		SST_MIX(6)
+#define SST_MIX_PROBE		SST_MIX(7)
+#define SST_MIX_HF_SNS		SST_MIX(8)
+#define SST_MIX_HF		SST_MIX(9)
+#define SST_MIX_SPEECH		SST_MIX(10)
+#define SST_MIX_RXSPEECH	SST_MIX(11)
+#define SST_MIX_VOIP		SST_MIX(12)
+#define SST_MIX_PCM0		SST_MIX(13)
+#define SST_MIX_PCM1		SST_MIX(14)
+#define SST_MIX_PCM2		SST_MIX(15)
+#define SST_MIX_AWARE		SST_MIX(16)
+#define SST_MIX_VAD		SST_MIX(17)
+#define SST_MIX_FM		SST_MIX(18)
+
+#define SST_MIX_MEDIA0		SST_MIX(19)
+#define SST_MIX_MEDIA1		SST_MIX(20)
+
+#define SST_NUM_MIX		(SST_MIX_MEDIA1 + 1)
+
+#define SST_MIX_SWITCH		(SST_NUM_MIX + 1)
+#define SST_OUT_SWITCH		(SST_NUM_MIX + 2)
+#define SST_IN_SWITCH		(SST_NUM_MIX + 3)
+#define SST_MUX_REG		(SST_NUM_MIX + 4)
+#define SST_REG_LAST		(SST_MUX_REG)
+
+/* last entry defines array size */
+#define SST_NUM_WIDGETS		(SST_REG_LAST + 1)
+
+#define SST_BT_FM_MUX_SHIFT	0
+#define SST_VOICE_MODE_SHIFT	1
+#define SST_BT_MODE_SHIFT	2
+
+/* in each mixer register we will define one bit for each input */
+#define SST_MIX_IP(x)		(x)
+
+#define SST_IP_MODEM		SST_MIX_IP(0)
+#define SST_IP_BT		SST_MIX_IP(1)
+#define SST_IP_CODEC0		SST_MIX_IP(2)
+#define SST_IP_CODEC1		SST_MIX_IP(3)
+#define SST_IP_LOOP0		SST_MIX_IP(4)
+#define SST_IP_LOOP1		SST_MIX_IP(5)
+#define SST_IP_LOOP2		SST_MIX_IP(6)
+#define SST_IP_PROBE		SST_MIX_IP(7)
+#define SST_IP_SIDETONE		SST_MIX_IP(8)
+#define SST_IP_TXSPEECH		SST_MIX_IP(9)
+#define SST_IP_SPEECH		SST_MIX_IP(10)
+#define SST_IP_TONE		SST_MIX_IP(11)
+#define SST_IP_VOIP		SST_MIX_IP(12)
+#define SST_IP_PCM0		SST_MIX_IP(13)
+#define SST_IP_PCM1		SST_MIX_IP(14)
+#define SST_IP_LOW_PCM0		SST_MIX_IP(15)
+#define SST_IP_FM		SST_MIX_IP(16)
+#define SST_IP_MEDIA0		SST_MIX_IP(17)
+#define SST_IP_MEDIA1		SST_MIX_IP(18)
+#define SST_IP_MEDIA2		SST_MIX_IP(19)
+#define SST_IP_MEDIA3		SST_MIX_IP(20)
+
+#define SST_IP_LAST		SST_IP_MEDIA3
+
+#define SST_SWM_INPUT_COUNT	(SST_IP_LAST + 1)
+#define SST_CMD_SWM_MAX_INPUTS	6
+
+#define SST_PATH_ID_SHIFT	8
+#define SST_DEFAULT_LOCATION_ID	0xFFFF
+#define SST_DEFAULT_CELL_NBR	0xFF
+#define SST_DEFAULT_MODULE_ID	0xFFFF
+
+/*
+ * Audio DSP Path Ids. Specified by the audio DSP FW
+ */
+enum sst_path_index {
+	SST_PATH_INDEX_MODEM_OUT                = (0x00 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_BT_OUT                   = (0x01 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_OUT0               = (0x02 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_OUT1               = (0x03 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SPROT_LOOP_OUT           = (0x04 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP1_OUT          = (0x05 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP2_OUT          = (0x06 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE_OUT                = (0x07 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_HF_SNS_OUT               = (0x08 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VOICE_UPLINK_REF2	= (0x08 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_HF_OUT                   = (0x09 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VOICE_UPLINK_REF1	= (0x09 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SPEECH_OUT               = (0x0A << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VOICE_UPLINK		= (0x0A << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_RX_SPEECH_OUT            = (0x0B << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VOICE_DOWNLINK		= (0x0B << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_VOIP_OUT                 = (0x0C << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM0_OUT                 = (0x0D << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM1_OUT                 = (0x0E << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM2_OUT                 = (0x0F << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_AWARE_OUT                = (0x10 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VAD_OUT                  = (0x11 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA0_OUT               = (0x12 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA1_OUT               = (0x13 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_FM_OUT                   = (0x14 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_PROBE1_PIPE_OUT		= (0x15 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE2_PIPE_OUT		= (0x16 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE3_PIPE_OUT		= (0x17 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE4_PIPE_OUT		= (0x18 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE5_PIPE_OUT		= (0x19 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE6_PIPE_OUT		= (0x1A << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE7_PIPE_OUT		= (0x1B << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE8_PIPE_OUT		= (0x1C << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SIDETONE_OUT		= (0x1D << SST_PATH_ID_SHIFT),
+
+	/* Start of input paths */
+	SST_PATH_INDEX_MODEM_IN                 = (0x80 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_BT_IN                    = (0x81 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_IN0                = (0x82 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_IN1                = (0x83 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SPROT_LOOP_IN            = (0x84 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP1_IN           = (0x85 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP2_IN           = (0x86 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_PROBE_IN                 = (0x87 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_SIDETONE_IN              = (0x88 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_TX_SPEECH_IN             = (0x89 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_SPEECH_IN                = (0x8A << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_TONE_IN                  = (0x8B << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_VOIP_IN                  = (0x8C << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_PCM0_IN                  = (0x8D << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM1_IN                  = (0x8E << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA0_IN                = (0x8F << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA1_IN                = (0x90 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA2_IN                = (0x91 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_FM_IN                    = (0x92 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_PROBE1_PIPE_IN           = (0x93 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE2_PIPE_IN           = (0x94 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE3_PIPE_IN           = (0x95 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE4_PIPE_IN           = (0x96 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE5_PIPE_IN           = (0x97 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE6_PIPE_IN           = (0x98 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE7_PIPE_IN           = (0x99 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PROBE8_PIPE_IN           = (0x9A << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA3_IN		= (0x9C << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_LOW_PCM0_IN		= (0x9D << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_RESERVED                 = (0xFF << SST_PATH_ID_SHIFT),
+};
+
+/*
+ * switch matrix input path IDs
+ */
+enum sst_swm_inputs {
+	SST_SWM_IN_MODEM	= (SST_PATH_INDEX_MODEM_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_BT		= (SST_PATH_INDEX_BT_IN		  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_CODEC0	= (SST_PATH_INDEX_CODEC_IN0	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_CODEC1	= (SST_PATH_INDEX_CODEC_IN1	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA_LOOP1	= (SST_PATH_INDEX_MEDIA_LOOP1_IN  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA_LOOP2	= (SST_PATH_INDEX_MEDIA_LOOP2_IN  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_PROBE	= (SST_PATH_INDEX_PROBE_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_SIDETONE	= (SST_PATH_INDEX_SIDETONE_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_TXSPEECH	= (SST_PATH_INDEX_TX_SPEECH_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_SPEECH	= (SST_PATH_INDEX_SPEECH_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_TONE		= (SST_PATH_INDEX_TONE_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_VOIP		= (SST_PATH_INDEX_VOIP_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_PCM0		= (SST_PATH_INDEX_PCM0_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_PCM1		= (SST_PATH_INDEX_PCM1_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA0	= (SST_PATH_INDEX_MEDIA0_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_MEDIA1	= (SST_PATH_INDEX_MEDIA1_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_MEDIA2	= (SST_PATH_INDEX_MEDIA2_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_FM		= (SST_PATH_INDEX_FM_IN		  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA3	= (SST_PATH_INDEX_MEDIA3_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_LOW_PCM0	= (SST_PATH_INDEX_LOW_PCM0_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_END		= (SST_PATH_INDEX_RESERVED	  | SST_DEFAULT_CELL_NBR)
+};
+
+/*
+ * switch matrix output path IDs
+ */
+enum sst_swm_outputs {
+	SST_SWM_OUT_MODEM	= (SST_PATH_INDEX_MODEM_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_BT		= (SST_PATH_INDEX_BT_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_CODEC0	= (SST_PATH_INDEX_CODEC_OUT0	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_CODEC1	= (SST_PATH_INDEX_CODEC_OUT1	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_OUT  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA_LOOP1	= (SST_PATH_INDEX_MEDIA_LOOP1_OUT | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA_LOOP2	= (SST_PATH_INDEX_MEDIA_LOOP2_OUT | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PROBE	= (SST_PATH_INDEX_PROBE_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_HF_SNS	= (SST_PATH_INDEX_HF_SNS_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_HF		= (SST_PATH_INDEX_HF_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_SPEECH	= (SST_PATH_INDEX_SPEECH_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_RXSPEECH	= (SST_PATH_INDEX_RX_SPEECH_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_VOIP	= (SST_PATH_INDEX_VOIP_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM0	= (SST_PATH_INDEX_PCM0_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM1	= (SST_PATH_INDEX_PCM1_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM2	= (SST_PATH_INDEX_PCM2_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_AWARE	= (SST_PATH_INDEX_AWARE_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_VAD		= (SST_PATH_INDEX_VAD_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA0	= (SST_PATH_INDEX_MEDIA0_OUT	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_OUT_MEDIA1	= (SST_PATH_INDEX_MEDIA1_OUT	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_OUT_FM		= (SST_PATH_INDEX_FM_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_END		= (SST_PATH_INDEX_RESERVED	  | SST_DEFAULT_CELL_NBR),
+};
+
+enum sst_ipc_msg {
+	SST_IPC_IA_CMD = 1,
+	SST_IPC_IA_SET_PARAMS,
+	SST_IPC_IA_GET_PARAMS,
+};
+
+enum sst_cmd_type {
+	SST_CMD_BYTES_SET = 1,
+	SST_CMD_BYTES_GET = 2,
+};
+
+enum sst_task {
+	SST_TASK_SBA = 1,
+	SST_TASK_FBA_UL,
+	SST_TASK_MMX,
+	SST_TASK_AWARE,
+	SST_TASK_FBA_DL,
+};
+
+enum sst_type {
+	SST_TYPE_CMD = 1,
+	SST_TYPE_PARAMS,
+};
+
+enum sst_flag {
+	SST_FLAG_BLOCKED = 1,
+	SST_FLAG_NONBLOCK,
+};
+
+/*
+ * Enumeration for indexing the gain cells in VB_SET_GAIN DSP command
+ */
+enum sst_gain_index {
+	/* GAIN IDs for SB task start here */
+	SST_GAIN_INDEX_MODEM_OUT,
+	SST_GAIN_INDEX_MODEM_IN,
+	SST_GAIN_INDEX_BT_OUT,
+	SST_GAIN_INDEX_BT_IN,
+	SST_GAIN_INDEX_FM_OUT,
+
+	SST_GAIN_INDEX_FM_IN,
+	SST_GAIN_INDEX_CODEC_OUT0,
+	SST_GAIN_INDEX_CODEC_OUT1,
+	SST_GAIN_INDEX_CODEC_IN0,
+	SST_GAIN_INDEX_CODEC_IN1,
+
+	SST_GAIN_INDEX_SPROT_LOOP_OUT,
+	SST_GAIN_INDEX_MEDIA_LOOP1_OUT,
+	SST_GAIN_INDEX_MEDIA_LOOP2_OUT,
+	SST_GAIN_INDEX_RX_SPEECH_OUT,
+	SST_GAIN_INDEX_TX_SPEECH_IN,
+
+	SST_GAIN_INDEX_SPEECH_OUT,
+	SST_GAIN_INDEX_SPEECH_IN,
+	SST_GAIN_INDEX_HF_OUT,
+	SST_GAIN_INDEX_HF_SNS_OUT,
+	SST_GAIN_INDEX_TONE_IN,
+
+	SST_GAIN_INDEX_SIDETONE_IN,
+	SST_GAIN_INDEX_PROBE_OUT,
+	SST_GAIN_INDEX_PROBE_IN,
+	SST_GAIN_INDEX_PCM0_IN_LEFT,
+	SST_GAIN_INDEX_PCM0_IN_RIGHT,
+
+	SST_GAIN_INDEX_PCM1_OUT_LEFT,
+	SST_GAIN_INDEX_PCM1_OUT_RIGHT,
+	SST_GAIN_INDEX_PCM1_IN_LEFT,
+	SST_GAIN_INDEX_PCM1_IN_RIGHT,
+	SST_GAIN_INDEX_PCM2_OUT_LEFT,
+
+	SST_GAIN_INDEX_PCM2_OUT_RIGHT,
+	SST_GAIN_INDEX_VOIP_OUT,
+	SST_GAIN_INDEX_VOIP_IN,
+	SST_GAIN_INDEX_AWARE_OUT,
+	SST_GAIN_INDEX_VAD_OUT,
+
+	/* Gain IDs for FBA task start here */
+	SST_GAIN_INDEX_VOICE_UL,
+
+	/* Gain IDs for MMX task start here */
+	SST_GAIN_INDEX_MEDIA0_IN_LEFT,
+	SST_GAIN_INDEX_MEDIA0_IN_RIGHT,
+	SST_GAIN_INDEX_MEDIA1_IN_LEFT,
+	SST_GAIN_INDEX_MEDIA1_IN_RIGHT,
+
+	SST_GAIN_INDEX_MEDIA2_IN_LEFT,
+	SST_GAIN_INDEX_MEDIA2_IN_RIGHT,
+
+	SST_GAIN_INDEX_GAIN_END
+};
+
+/*
+ * Audio DSP module IDs specified by FW spec
+ * TODO: Update with all modules
+ */
+enum sst_module_id {
+	SST_MODULE_ID_PCM		  = 0x0001,
+	SST_MODULE_ID_MP3		  = 0x0002,
+	SST_MODULE_ID_MP24		  = 0x0003,
+	SST_MODULE_ID_AAC		  = 0x0004,
+	SST_MODULE_ID_AACP		  = 0x0005,
+	SST_MODULE_ID_EAACP		  = 0x0006,
+	SST_MODULE_ID_WMA9		  = 0x0007,
+	SST_MODULE_ID_WMA10		  = 0x0008,
+	SST_MODULE_ID_WMA10P		  = 0x0009,
+	SST_MODULE_ID_RA		  = 0x000A,
+	SST_MODULE_ID_DDAC3		  = 0x000B,
+	SST_MODULE_ID_TRUE_HD		  = 0x000C,
+	SST_MODULE_ID_HD_PLUS		  = 0x000D,
+
+	SST_MODULE_ID_SRC		  = 0x0064,
+	SST_MODULE_ID_DOWNMIX		  = 0x0066,
+	SST_MODULE_ID_GAIN_CELL		  = 0x0067,
+	SST_MODULE_ID_SPROT		  = 0x006D,
+	SST_MODULE_ID_BASS_BOOST	  = 0x006E,
+	SST_MODULE_ID_STEREO_WDNG	  = 0x006F,
+	SST_MODULE_ID_AV_REMOVAL	  = 0x0070,
+	SST_MODULE_ID_MIC_EQ		  = 0x0071,
+	SST_MODULE_ID_SPL		  = 0x0072,
+	SST_MODULE_ID_ALGO_VTSV           = 0x0073,
+	SST_MODULE_ID_NR		  = 0x0076,
+	SST_MODULE_ID_BWX		  = 0x0077,
+	SST_MODULE_ID_DRP		  = 0x0078,
+	SST_MODULE_ID_MDRP		  = 0x0079,
+
+	SST_MODULE_ID_ANA		  = 0x007A,
+	SST_MODULE_ID_AEC		  = 0x007B,
+	SST_MODULE_ID_NR_SNS		  = 0x007C,
+	SST_MODULE_ID_SER		  = 0x007D,
+	SST_MODULE_ID_AGC		  = 0x007E,
+
+	SST_MODULE_ID_CNI		  = 0x007F,
+	SST_MODULE_ID_CONTEXT_ALGO_AWARE  = 0x0080,
+	SST_MODULE_ID_FIR_24		  = 0x0081,
+	SST_MODULE_ID_IIR_24		  = 0x0082,
+
+	SST_MODULE_ID_ASRC		  = 0x0083,
+	SST_MODULE_ID_TONE_GEN		  = 0x0084,
+	SST_MODULE_ID_BMF		  = 0x0086,
+	SST_MODULE_ID_EDL		  = 0x0087,
+	SST_MODULE_ID_GLC		  = 0x0088,
+
+	SST_MODULE_ID_FIR_16		  = 0x0089,
+	SST_MODULE_ID_IIR_16		  = 0x008A,
+	SST_MODULE_ID_DNR		  = 0x008B,
+
+	SST_MODULE_ID_VIRTUALIZER	  = 0x008C,
+	SST_MODULE_ID_VISUALIZATION	  = 0x008D,
+	SST_MODULE_ID_LOUDNESS_OPTIMIZER  = 0x008E,
+	SST_MODULE_ID_REVERBERATION	  = 0x008F,
+
+	SST_MODULE_ID_CNI_TX		  = 0x0090,
+	SST_MODULE_ID_REF_LINE		  = 0x0091,
+	SST_MODULE_ID_VOLUME		  = 0x0092,
+	SST_MODULE_ID_FILT_DCR		  = 0x0094,
+	SST_MODULE_ID_SLV		  = 0x009A,
+	SST_MODULE_ID_NLF		  = 0x009B,
+	SST_MODULE_ID_TNR		  = 0x009C,
+	SST_MODULE_ID_WNR		  = 0x009D,
+
+	SST_MODULE_ID_LOG		  = 0xFF00,
+
+	SST_MODULE_ID_TASK		  = 0xFFFF,
+};
+
+enum sst_cmd {
+	SBA_IDLE		= 14,
+	SBA_VB_SET_SPEECH_PATH	= 26,
+	MMX_SET_GAIN		= 33,
+	SBA_VB_SET_GAIN		= 33,
+	FBA_VB_RX_CNI		= 35,
+	MMX_SET_GAIN_TIMECONST	= 36,
+	SBA_VB_SET_TIMECONST	= 36,
+	FBA_VB_ANA		= 37,
+	FBA_VB_SET_FIR		= 38,
+	FBA_VB_SET_IIR		= 39,
+	SBA_VB_START_TONE	= 41,
+	SBA_VB_STOP_TONE	= 42,
+	FBA_VB_AEC		= 47,
+	FBA_VB_NR_UL		= 48,
+	FBA_VB_AGC		= 49,
+	FBA_VB_WNR		= 52,
+	FBA_VB_SLV		= 53,
+	FBA_VB_NR_DL		= 55,
+	SBA_PROBE		= 66,
+	MMX_PROBE		= 66,
+	FBA_VB_SET_BIQUAD_D_C	= 69,
+	FBA_VB_DUAL_BAND_COMP	= 70,
+	FBA_VB_SNS		= 72,
+	FBA_VB_SER		= 78,
+	FBA_VB_TX_CNI		= 80,
+	SBA_VB_START		= 85,
+	FBA_VB_SET_REF_LINE	= 94,
+	FBA_VB_SET_DELAY_LINE	= 95,
+	FBA_VB_BWX		= 104,
+	FBA_VB_GMM		= 105,
+	FBA_VB_GLC		= 107,
+	FBA_VB_BMF		= 111,
+	FBA_VB_DNR		= 113,
+	MMX_SET_SWM		= 114,
+	SBA_SET_SWM		= 114,
+	SBA_SET_MDRP            = 116,
+	SBA_HW_SET_SSP		= 117,
+	SBA_SET_MEDIA_LOOP_MAP	= 118,
+	SBA_SET_MEDIA_PATH	= 119,
+	MMX_SET_MEDIA_PATH	= 119,
+	FBA_VB_TNR_UL		= 119,
+	FBA_VB_TNR_DL		= 121,
+	FBA_VB_NLF		= 125,
+	SBA_VB_LPRO		= 126,
+	FBA_VB_MDRP		= 127,
+	SBA_VB_SET_FIR          = 128,
+	SBA_VB_SET_IIR          = 129,
+	SBA_SET_SSP_SLOT_MAP	= 130,
+	AWARE_ENV_CLASS_PARAMS	= 130,
+	VAD_ENV_CLASS_PARAMS	= 2049,
+};
+
+enum sst_dsp_switch {
+	SST_SWITCH_OFF = 0,
+	SST_SWITCH_ON = 3,
+};
+
+enum sst_path_switch {
+	SST_PATH_OFF = 0,
+	SST_PATH_ON = 1,
+};
+
+enum sst_swm_state {
+	SST_SWM_OFF = 0,
+	SST_SWM_ON = 3,
+};
+
+#define SST_FILL_LOCATION_IDS(dst, cell_idx, pipe_id)		do {	\
+		dst.location_id.p.cell_nbr_idx = (cell_idx);		\
+		dst.location_id.p.path_id = (pipe_id);			\
+	} while (0)
+#define SST_FILL_LOCATION_ID(dst, loc_id)				(\
+	dst.location_id.f = (loc_id))
+#define SST_FILL_MODULE_ID(dst, mod_id)					(\
+	dst.module_id = (mod_id))
+
+#define SST_FILL_DESTINATION1(dst, id)				do {	\
+		SST_FILL_LOCATION_ID(dst, (id) & 0xFFFF);		\
+		SST_FILL_MODULE_ID(dst, ((id) & 0xFFFF0000) >> 16);	\
+	} while (0)
+#define SST_FILL_DESTINATION2(dst, loc_id, mod_id)		do {	\
+		SST_FILL_LOCATION_ID(dst, loc_id);			\
+		SST_FILL_MODULE_ID(dst, mod_id);			\
+	} while (0)
+#define SST_FILL_DESTINATION3(dst, cell_idx, path_id, mod_id)	do {	\
+		SST_FILL_LOCATION_IDS(dst, cell_idx, path_id);		\
+		SST_FILL_MODULE_ID(dst, mod_id);			\
+	} while (0)
+
+#define SST_FILL_DESTINATION(level, dst, ...)				\
+	SST_FILL_DESTINATION##level(dst, __VA_ARGS__)
+#define SST_FILL_DEFAULT_DESTINATION(dst)				\
+	SST_FILL_DESTINATION(2, dst, SST_DEFAULT_LOCATION_ID, SST_DEFAULT_MODULE_ID)
+
+struct sst_destination_id {
+	union sst_location_id {
+		struct {
+			u8 cell_nbr_idx;	/* module index */
+			u8 path_id;		/* pipe_id */
+		} __packed	p;		/* part */
+		u16		f;		/* full */
+	} __packed location_id;
+	u16	   module_id;
+} __packed;
+
+struct sst_dsp_header {
+	struct sst_destination_id dst;
+	u16 command_id;
+	u16 length;
+} __packed;
+
+/*
+ *
+ * Common Commands
+ *
+ */
+struct sst_cmd_generic {
+	struct sst_dsp_header header;
+} __packed;
+
+struct swm_input_ids {
+	struct sst_destination_id input_id;
+} __packed;
+
+struct sst_cmd_set_swm {
+	struct sst_dsp_header header;
+	struct sst_destination_id output_id;
+	u16    switch_state;
+	u16    nb_inputs;
+	struct swm_input_ids input[SST_CMD_SWM_MAX_INPUTS];
+} __packed;
+
+struct sst_cmd_set_media_path {
+	struct sst_dsp_header header;
+	u16    switch_state;
+} __packed;
+
+struct pcm_cfg {
+		u8 s_length:2;
+		u8 rate:3;
+		u8 format:3;
+} __packed;
+
+struct sst_cmd_set_speech_path {
+	struct sst_dsp_header header;
+	u16    switch_state;
+	struct {
+		u16 rsvd:8;
+		struct pcm_cfg cfg;
+	} config;
+} __packed;
+
+struct gain_cell {
+	struct sst_destination_id dest;
+	s16 cell_gain_left;
+	s16 cell_gain_right;
+	u16 gain_time_constant;
+} __packed;
+
+#define NUM_GAIN_CELLS 1
+struct sst_cmd_set_gain_dual {
+	struct sst_dsp_header header;
+	u16    gain_cell_num;
+	struct gain_cell cell_gains[NUM_GAIN_CELLS];
+} __packed;
+
+struct sst_cmd_set_params {
+	struct sst_destination_id dst;
+	u16 command_id;
+	char params[0];
+} __packed;
+
+/*
+ *
+ * Media (MMX) commands
+ *
+ */
+
+/*
+ *
+ * SBA commands
+ *
+ */
+struct sst_cmd_sba_vb_start {
+	struct sst_dsp_header header;
+} __packed;
+
+union sba_media_loop_params {
+	struct {
+		u16 rsvd:8;
+		struct pcm_cfg cfg;
+	} part;
+	u16 full;
+} __packed;
+
+struct sst_cmd_sba_set_media_loop_map {
+	struct	sst_dsp_header header;
+	u16	switch_state;
+	union	sba_media_loop_params param;
+	u16	map;
+} __packed;
+
+struct sst_cmd_tone_stop {
+	struct	sst_dsp_header header;
+	u16	switch_state;
+} __packed;
+
+enum sst_ssp_mode {
+	SSP_MODE_MASTER = 0,
+	SSP_MODE_SLAVE = 1,
+};
+
+enum sst_ssp_pcm_mode {
+	SSP_PCM_MODE_NORMAL = 0,
+	SSP_PCM_MODE_NETWORK = 1,
+};
+
+enum sst_ssp_duplex {
+	SSP_DUPLEX = 0,
+	SSP_RX = 1,
+	SSP_TX = 2,
+};
+
+enum sst_ssp_fs_frequency {
+	SSP_FS_8_KHZ = 0,
+	SSP_FS_16_KHZ = 1,
+	SSP_FS_44_1_KHZ = 2,
+	SSP_FS_48_KHZ = 3,
+};
+
+enum sst_ssp_fs_polarity {
+	SSP_FS_ACTIVE_LOW = 0,
+	SSP_FS_ACTIVE_HIGH = 1,
+};
+
+enum sst_ssp_protocol {
+	SSP_MODE_PCM = 0,
+	SSP_MODE_I2S = 1,
+};
+
+enum sst_ssp_port_id {
+	SSP_MODEM = 0,
+	SSP_BT = 1,
+	SSP_FM = 2,
+	SSP_CODEC = 3,
+};
+
+struct sst_cmd_sba_hw_set_ssp {
+	struct sst_dsp_header header;
+	u16 selection;			/* 0:SSP0(def), 1:SSP1, 2:SSP2 */
+
+	u16 switch_state;
+
+	u16 nb_bits_per_slots:6;        /* 0-32 bits, 24 (def) */
+	u16 nb_slots:4;			/* 0-8: slots per frame  */
+	u16 mode:3;			/* 0:Master, 1: Slave  */
+	u16 duplex:3;
+
+	u16 active_tx_slot_map:8;       /* Bit map, 0:off, 1:on */
+	u16 reserved1:8;
+
+	u16 active_rx_slot_map:8;       /* Bit map 0: Off, 1:On */
+	u16 reserved2:8;
+
+	u16 frame_sync_frequency;
+
+	u16 frame_sync_polarity:8;
+	u16 data_polarity:8;
+
+	u16 frame_sync_width;           /* 1 to N clocks */
+	u16 ssp_protocol:8;
+	u16 start_delay:8;		/* Start delay in terms of clock ticks */
+} __packed;
+
+#define SST_MAX_TDM_SLOTS 8
+
+struct sst_param_sba_ssp_slot_map {
+	struct sst_dsp_header header;
+
+	u16 param_id;
+	u16 param_len;
+	u16 ssp_index;
+
+	u8 rx_slot_map[SST_MAX_TDM_SLOTS];
+	u8 tx_slot_map[SST_MAX_TDM_SLOTS];
+} __packed;
+
+enum {
+	SST_PROBE_EXTRACTOR = 0,
+	SST_PROBE_INJECTOR = 1,
+};
+
+struct sst_cmd_probe {
+	struct sst_dsp_header header;
+
+	u16 switch_state;
+	struct sst_destination_id probe_dst;
+
+	u16 shared_mem:1;
+	u16 probe_in:1;
+	u16 probe_out:1;
+	u16 rsvd_1:13;
+
+	u16 rsvd_2:5;
+	u16 probe_mode:2;
+	u16 rsvd_3:1;
+	struct pcm_cfg cfg;
+
+	u16 sm_buf_id;
+
+	u16 gain[6];
+	u16 rsvd_4[9];
+} __packed;
+
+struct sst_probe_config {
+	const char *name;
+	u16 loc_id;
+	u16 mod_id;
+	u8 task_id;
+	struct pcm_cfg cfg;
+};
+
+int sst_mix_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int sst_mix_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int sst_vtsv_enroll_set(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int sst_vtsv_enroll_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+#endif
diff --git a/sound/soc/intel/platform-libs/controls_v2_dpcm.c b/sound/soc/intel/platform-libs/controls_v2_dpcm.c
new file mode 100644
index 0000000..12facc3
--- /dev/null
+++ b/sound/soc/intel/platform-libs/controls_v2_dpcm.c
@@ -0,0 +1,1315 @@
+/*
+ *  controls_v2_dpcm.c - Intel MID Platform driver DPCM ALSA controls for Mrfld
+ *
+ *  Copyright (C) 2013-14 Intel Corp
+ *  Author: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
+ *  	Vinod Koul <vinod.koul@intel.com>
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
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "../platform_ipc_v2.h"
+#include "../sst_platform.h"
+#include "../sst_platform_pvt.h"
+#include "controls_v2.h"
+#include "sst_widgets.h"
+
+static inline void sst_fill_byte_control(char *param,
+					 u8 ipc_msg, u8 block,
+					 u8 task_id, u8 pipe_id,
+					 u16 len, void *cmd_data)
+{
+
+	struct snd_sst_bytes_v2 *byte_data = (struct snd_sst_bytes_v2 *)param;
+	byte_data->type = SST_CMD_BYTES_SET;
+	byte_data->ipc_msg = ipc_msg;
+	byte_data->block = block;
+	byte_data->task_id = task_id;
+	byte_data->pipe_id = pipe_id;
+
+	if (len > SST_MAX_BIN_BYTES - sizeof(*byte_data)) {
+		pr_err("%s: command length too big (%u)", __func__, len);
+		len = SST_MAX_BIN_BYTES - sizeof(*byte_data);
+		WARN_ON(1); /* this happens only if code is wrong */
+	}
+	byte_data->len = len;
+	memcpy(byte_data->bytes, cmd_data, len);
+	print_hex_dump_bytes("writing to lpe: ", DUMP_PREFIX_OFFSET,
+			     byte_data, len + sizeof(*byte_data));
+}
+
+static int sst_fill_and_send_cmd_unlocked(struct sst_data *sst,
+				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
+				 void *cmd_data, u16 len)
+{
+	sst_fill_byte_control(sst->byte_stream, ipc_msg, block, task_id, pipe_id,
+			      len, cmd_data);
+	return sst_dsp->ops->set_generic_params(SST_SET_BYTE_STREAM,
+						sst->byte_stream);
+}
+
+/**
+ * sst_fill_and_send_cmd - generate the IPC message and send it to the FW
+ * @ipc_msg:	type of IPC (CMD, SET_PARAMS, GET_PARAMS)
+ * @cmd_data:	the IPC payload
+ */
+static int sst_fill_and_send_cmd(struct sst_data *sst,
+				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
+				 void *cmd_data, u16 len)
+{
+	int ret;
+
+	mutex_lock(&sst->lock);
+	ret = sst_fill_and_send_cmd_unlocked(sst, ipc_msg, block, task_id, pipe_id,
+					     cmd_data, len);
+	mutex_unlock(&sst->lock);
+
+	return ret;
+}
+
+/*
+ * slot map value is a bitfield where each bit represents a FW channel
+ *
+ *			3 2 1 0		# 0 = codec0, 1 = codec1
+ *			RLRLRLRL	# 3, 4 = reserved
+ *
+ * e.g. slot 0 rx map =	00001100b -> data from slot 0 goes into codec_in1 L,R
+ */
+static u8 sst_ssp_slot_map[SST_MAX_TDM_SLOTS] = {
+	0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, /* default rx map */
+};
+
+/*
+ * channel map value is a bitfield where each bit represents a slot
+ *
+ *			  76543210	# 0 = slot 0, 1 = slot 1
+ *
+ * e.g. codec1_0 tx map = 00000101b -> data from codec_out1_0 goes into slot 0, 2
+ */
+static u8 sst_ssp_channel_map[SST_MAX_TDM_SLOTS] = {
+	0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, /* default tx map */
+};
+
+static void sst_send_slot_map(struct sst_data *sst)
+{
+	struct sst_param_sba_ssp_slot_map cmd;
+
+	pr_debug("Enter: %s\n", __func__);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.command_id = SBA_SET_SSP_SLOT_MAP;
+	cmd.header.length = sizeof(struct sst_param_sba_ssp_slot_map)
+				- sizeof(struct sst_dsp_header);
+
+	cmd.param_id = SBA_SET_SSP_SLOT_MAP;
+	cmd.param_len = sizeof(cmd.rx_slot_map) + sizeof(cmd.tx_slot_map) + sizeof(cmd.ssp_index);
+	cmd.ssp_index = SSP_CODEC;
+
+	memcpy(cmd.rx_slot_map, &sst_ssp_slot_map[0], sizeof(cmd.rx_slot_map));
+	memcpy(cmd.tx_slot_map, &sst_ssp_channel_map[0], sizeof(cmd.tx_slot_map));
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_SET_PARAMS, SST_FLAG_BLOCKED,
+			      SST_TASK_SBA, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+}
+
+int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_enum *e = (struct sst_enum *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = e->max;
+
+	if (uinfo->value.enumerated.item > e->max- 1)
+		uinfo->value.enumerated.item = e->max- 1;
+	strcpy(uinfo->value.enumerated.name,
+		e->texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+/**
+ * sst_slot_get - get the status of the interleaver/deinterleaver control
+ *
+ * Searches the map where the control status is stored, and gets the
+ * channel/slot which is currently set for this enumerated control. Since it is
+ * an enumerated control, there is only one possible value.
+ */
+static int sst_slot_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct sst_enum *e = (void *)kcontrol->private_value;
+	unsigned int ctl_no = e->reg;
+	unsigned int is_tx = e->tx;
+	unsigned int val, mux;
+	u8 *map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
+
+	val = 1 << ctl_no;
+	/* search which slot/channel has this bit set - there should be only one */
+	for (mux = e->max; mux > 0;  mux--)
+		if (map[mux - 1] & val)
+			break;
+
+	ucontrol->value.enumerated.item[0] = mux;
+	pr_debug("%s: %s - %s map = %#x\n", __func__, is_tx ? "tx channel" : "rx slot",
+		 e->texts[mux], mux ? map[mux - 1] : -1);
+	return 0;
+}
+
+/**
+ * sst_slot_put - set the status of interleaver/deinterleaver control
+ *
+ * (de)interleaver controls are defined in opposite sense to be user-friendly
+ *
+ * Instead of the enum value being the value written to the register, it is the
+ * register address; and the kcontrol number (register num) is the value written
+ * to the register. This is so that there can be only one value for each
+ * slot/channel since there is only one control for each slot/channel.
+ *
+ * This means that whenever an enum is set, we need to clear the bit
+ * for that kcontrol_no for all the interleaver OR deinterleaver registers
+ */
+static int sst_slot_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_enum *e = (void *)kcontrol->private_value;
+	int i;
+	unsigned int ctl_no = e->reg;
+	unsigned int is_tx = e->tx;
+	unsigned int slot_channel_no;
+	unsigned int val, mux;
+
+	u8 *map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
+
+	val = 1 << ctl_no;
+	mux = ucontrol->value.enumerated.item[0];
+	if (mux > e->max- 1)
+		return -EINVAL;
+
+	/* first clear all registers of this bit */
+	for (i = 0; i < e->max; i++)
+		map[i] &= ~val;
+
+	if (mux == 0) /* kctl set to 'none' */
+		return 0;
+
+	/* offset by one to take "None" into account */
+	slot_channel_no = mux - 1;
+	map[slot_channel_no] |= val;
+
+	pr_debug("%s: %s %s map = %#x\n", __func__, is_tx ? "tx channel" : "rx slot",
+		 e->texts[mux], map[slot_channel_no]);
+
+	if (e->w && e->w->power)
+		sst_send_slot_map(sst);
+	return 0;
+}
+
+/* assumes a boolean mux */
+static inline bool get_mux_state(struct sst_data *sst, unsigned int reg, unsigned int shift)
+{
+	return (sst_reg_read(sst, reg, shift, 1) == 1);
+}
+
+static void sst_send_algo_cmd(struct sst_data *sst,
+			      struct sst_algo_control *bc)
+{
+	int len;
+	struct sst_cmd_set_params *cmd;
+
+	/* bc->max includes sizeof algos + length field */
+	len = sizeof(cmd->dst) + sizeof(cmd->command_id) + bc->max;
+
+	cmd = kzalloc(len, GFP_KERNEL);
+	if (cmd == NULL) {
+		pr_err("Failed to send cmd, kzalloc failed\n");
+		return;
+	}
+
+	SST_FILL_DESTINATION(2, cmd->dst, bc->pipe_id, bc->module_id);
+	cmd->command_id = bc->cmd_id;
+	memcpy(cmd->params, bc->params, bc->max);
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_SET_PARAMS, SST_FLAG_BLOCKED,
+			      bc->task_id, 0, cmd, len);
+	kfree(cmd);
+}
+
+/**
+ * sst_find_and_send_pipe_algo - send all the algo parameters for a pipe
+ *
+ * The algos which are in each pipeline are sent to the firmware one by one
+ */
+static void sst_find_and_send_pipe_algo(struct sst_data *sst,
+					const char *pipe, struct sst_ids *ids)
+{
+	struct sst_algo_control *bc;
+	struct module *algo = NULL;
+
+	pr_debug("Enter: %s, widget=%s\n", __func__, pipe);
+
+	list_for_each_entry(algo, &ids->algo_list, node) {
+		bc = (void *)algo->kctl->private_value;
+
+		pr_debug("Found algo control name=%s pipe=%s\n", algo->kctl->id.name, pipe);
+		sst_send_algo_cmd(sst, bc);
+	}
+}
+
+int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = bc->max;
+
+	/* allocate space to cache the algo parameters in the driver */
+	if (bc->params == NULL) {
+		bc->params = devm_kzalloc(platform->dev, bc->max, GFP_KERNEL);
+		if (bc->params == NULL) {
+			pr_err("kzalloc failed\n");
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static int sst_algo_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+
+	switch (bc->type) {
+	case SST_ALGO_PARAMS:
+		if (bc->params)
+			memcpy(ucontrol->value.bytes.data, bc->params, bc->max);
+		break;
+	case SST_ALGO_BYPASS:
+		ucontrol->value.integer.value[0] = bc->bypass ? 1 : 0;
+		pr_debug("%s: bypass  %d\n", __func__, bc->bypass);
+		break;
+	default:
+		pr_err("Invalid Input- algo type:%d\n", bc->type);
+		return -EINVAL;
+
+	}
+	return 0;
+}
+
+static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+
+	pr_debug("in %s control_name=%s\n", __func__, kcontrol->id.name);
+	switch (bc->type) {
+	case SST_ALGO_PARAMS:
+		if (bc->params)
+			memcpy(bc->params, ucontrol->value.bytes.data, bc->max);
+		break;
+	case SST_ALGO_BYPASS:
+		bc->bypass = !!ucontrol->value.integer.value[0];
+		break;
+	default:
+		pr_err("Invalid Input- algo type:%ld\n", ucontrol->value.integer.value[0]);
+		return -EINVAL;
+	}
+	/*if pipe is enabled, need to send the algo params from here */
+	if (bc->w && bc->w->power)
+		sst_send_algo_cmd(sst, bc);
+
+	return 0;
+}
+
+static int sst_gain_ctl_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = mc->stereo ? 2 : 1;
+	uinfo->value.integer.min = mc->min;
+	uinfo->value.integer.max = mc->max;
+	return 0;
+}
+
+/**
+ * sst_send_gain_cmd - send the gain algorithm IPC to the FW
+ * @gv:		the stored value of gain (also contains rampduration)
+ * @mute:	flag that indicates whether this was called from the
+ *		digital_mute callback or directly. If called from the
+ *		digital_mute callback, module will be muted/unmuted based on this
+ *		flag. The flag is always 0 if called directly.
+ *
+ * The user-set gain value is sent only if the user-controllable 'mute' control
+ * is OFF (indicated by gv->mute). Otherwise, the mute value (MIN value) is
+ * sent.
+ */
+static void sst_send_gain_cmd(struct sst_data *sst, struct sst_gain_value *gv,
+			      u16 task_id, u16 loc_id, u16 module_id, int mute)
+{
+	struct sst_cmd_set_gain_dual cmd;
+	pr_debug("%s\n", __func__);
+
+	cmd.header.command_id = MMX_SET_GAIN;
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.gain_cell_num = 1;
+
+	if (mute || gv->mute) {
+		cmd.cell_gains[0].cell_gain_left = SST_GAIN_MIN_VALUE;
+		cmd.cell_gains[0].cell_gain_right = SST_GAIN_MIN_VALUE;
+	} else {
+		cmd.cell_gains[0].cell_gain_left = gv->l_gain;
+		cmd.cell_gains[0].cell_gain_right = gv->r_gain;
+	}
+	SST_FILL_DESTINATION(2, cmd.cell_gains[0].dest,
+			     loc_id, module_id);
+	cmd.cell_gains[0].gain_time_constant = gv->ramp_duration;
+
+	cmd.header.length = sizeof(struct sst_cmd_set_gain_dual)
+				- sizeof(struct sst_dsp_header);
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_SET_PARAMS, SST_FLAG_BLOCKED,
+			      task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+}
+
+static int sst_gain_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+	struct sst_gain_value *gv = mc->gain_val;
+
+	switch (mc->type) {
+	case SST_GAIN_TLV:
+		ucontrol->value.integer.value[0] = gv->l_gain;
+		ucontrol->value.integer.value[1] = gv->r_gain;
+		break;
+	case SST_GAIN_MUTE:
+		ucontrol->value.integer.value[0] = gv->mute ? 1 : 0;
+		break;
+	case SST_GAIN_RAMP_DURATION:
+		ucontrol->value.integer.value[0] = gv->ramp_duration;
+		break;
+	default:
+		pr_err("Invalid Input- gain type:%d\n", mc->type);
+		return -EINVAL;
+	};
+	return 0;
+}
+
+static int sst_gain_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+	struct sst_gain_value *gv = mc->gain_val;
+
+	switch (mc->type) {
+	case SST_GAIN_TLV:
+		gv->l_gain = ucontrol->value.integer.value[0];
+		gv->r_gain = ucontrol->value.integer.value[1];
+		pr_debug("%s: %s: Volume %d, %d\n", __func__, mc->pname, gv->l_gain, gv->r_gain);
+		break;
+	case SST_GAIN_MUTE:
+		gv->mute = !!ucontrol->value.integer.value[0];
+		pr_debug("%s: %s: Mute %d\n", __func__, mc->pname, gv->mute);
+		break;
+	case SST_GAIN_RAMP_DURATION:
+		gv->ramp_duration = ucontrol->value.integer.value[0];
+		pr_debug("%s: %s: RampDuration %d\n", __func__, mc->pname, gv->ramp_duration);
+		break;
+	default:
+		pr_err("Invalid Input- gain type:%d\n", mc->type);
+		return -EINVAL;
+	};
+
+	if (mc->w && mc->w->power)
+		sst_send_gain_cmd(sst, gv, mc->task_id,
+				mc->pipe_id | mc->instance_id, mc->module_id, 0);
+	return 0;
+}
+
+static void sst_set_pipe_gain(struct sst_ids *ids, struct sst_data *sst, int mute);
+
+static void sst_send_pipe_module_params(struct snd_soc_dapm_widget *w)
+{
+	struct sst_data *sst = snd_soc_platform_get_drvdata(w->platform);
+	struct sst_ids *ids = w->priv;
+
+	sst_find_and_send_pipe_algo(sst, w->name, ids);
+	sst_set_pipe_gain(ids, sst, 0);
+}
+
+static int sst_generic_modules_event(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w);
+	return 0;
+}
+
+static const DECLARE_TLV_DB_SCALE(sst_gain_tlv_common, SST_GAIN_MIN_VALUE * 10, 10, 0);
+
+/* Look up table to convert MIXER SW bit regs to SWM inputs */
+static const uint swm_mixer_input_ids[SST_SWM_INPUT_COUNT] = {
+	[SST_IP_CODEC0]		= SST_SWM_IN_CODEC0,
+	[SST_IP_CODEC1]		= SST_SWM_IN_CODEC1,
+	[SST_IP_LOOP0]		= SST_SWM_IN_SPROT_LOOP,
+	[SST_IP_LOOP1]		= SST_SWM_IN_MEDIA_LOOP1,
+	[SST_IP_LOOP2]		= SST_SWM_IN_MEDIA_LOOP2,
+	[SST_IP_PCM0]		= SST_SWM_IN_PCM0,
+	[SST_IP_PCM1]		= SST_SWM_IN_PCM1,
+	[SST_IP_MEDIA0]		= SST_SWM_IN_MEDIA0,
+	[SST_IP_MEDIA1]		= SST_SWM_IN_MEDIA1,
+	[SST_IP_MEDIA2]		= SST_SWM_IN_MEDIA2,
+	[SST_IP_MEDIA3]		= SST_SWM_IN_MEDIA3,
+};
+
+/**
+ * fill_swm_input - fill in the SWM input ids given the register
+ *
+ * The register value is a bit-field inicated which mixer inputs are ON. Use the
+ * lookup table to get the input-id and fill it in the structure.
+ */
+static int fill_swm_input(struct swm_input_ids *swm_input, unsigned int reg)
+{
+	uint i, is_set, nb_inputs = 0;
+	u16 input_loc_id;
+
+	pr_debug("%s: reg: %#x\n", __func__, reg);
+	for (i = 0; i < SST_SWM_INPUT_COUNT; i++) {
+		is_set = reg & BIT(i);
+		if (!is_set)
+			continue;
+
+		input_loc_id = swm_mixer_input_ids[i];
+		SST_FILL_DESTINATION(2, swm_input->input_id,
+				     input_loc_id, SST_DEFAULT_MODULE_ID);
+		nb_inputs++;
+		swm_input++;
+		pr_debug("input id: %#x, nb_inputs: %d\n", input_loc_id, nb_inputs);
+
+		if (nb_inputs == SST_CMD_SWM_MAX_INPUTS) {
+			pr_warn("%s: SET_SWM cmd max inputs reached", __func__);
+			break;
+		}
+	}
+	return nb_inputs;
+}
+
+static void sst_set_pipe_gain(struct sst_ids *ids, struct sst_data *sst, int mute)
+{
+	struct sst_gain_mixer_control *mc;
+	struct sst_gain_value *gv;
+	struct module *gain = NULL;
+
+	list_for_each_entry(gain, &ids->gain_list, node) {
+		struct snd_kcontrol *kctl = gain->kctl;
+
+		pr_debug("control name=%s\n", kctl->id.name);
+		mc = (void *)kctl->private_value;
+		gv = mc->gain_val;
+
+		sst_send_gain_cmd(sst, gv, mc->task_id,
+				mc->pipe_id | mc->instance_id, mc->module_id, mute);
+	}
+}
+
+static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_set_swm cmd;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(w->platform);
+	struct sst_ids *ids = w->priv;
+	bool set_mixer = false;
+	int val = sst->widget[ids->reg];
+
+	pr_debug("%s: widget = %s\n", __func__, w->name);
+	pr_debug("%s: reg[%d] = %#x\n", __func__, ids->reg, val);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		set_mixer = true;
+		break;
+	case SND_SOC_DAPM_POST_REG:
+		if (w->power)
+			set_mixer = true;
+		break;
+	default:
+		set_mixer = false;
+	}
+
+	if (set_mixer == false)
+		return 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event) ||
+	    event == SND_SOC_DAPM_POST_REG)
+		cmd.switch_state = SST_SWM_ON;
+	else
+		cmd.switch_state = SST_SWM_OFF;
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	/* MMX_SET_SWM == SBA_SET_SWM */
+	cmd.header.command_id = SBA_SET_SWM;
+
+	SST_FILL_DESTINATION(2, cmd.output_id,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+	cmd.nb_inputs =	fill_swm_input(&cmd.input[0], val);
+	cmd.header.length = offsetof(struct sst_cmd_set_swm, input) - sizeof(struct sst_dsp_header)
+				+ (cmd.nb_inputs * sizeof(cmd.input[0]));
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      ids->task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+	return 0;
+}
+
+/* SBA mixers - 16 inputs */
+#define SST_SBA_DECLARE_MIX_CONTROLS(kctl_name, mixer_reg)			\
+	static const struct snd_kcontrol_new kctl_name[] = {			\
+		SOC_SINGLE_EXT("codec_in0", mixer_reg, SST_IP_CODEC0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("codec_in1", mixer_reg, SST_IP_CODEC1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("sprot_loop_in", mixer_reg, SST_IP_LOOP0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media_loop1_in", mixer_reg, SST_IP_LOOP1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media_loop2_in", mixer_reg, SST_IP_LOOP2, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("pcm0_in", mixer_reg, SST_IP_PCM0, 1, 0,		\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("pcm1_in", mixer_reg, SST_IP_PCM1, 1, 0,		\
+				sst_mix_get, sst_mix_put),			\
+	}
+
+#define SST_SBA_MIXER_GRAPH_MAP(mix_name)			\
+	{ mix_name, "codec_in0",	"codec_in0" },		\
+	{ mix_name, "codec_in1",	"codec_in1" },		\
+	{ mix_name, "sprot_loop_in",	"sprot_loop_in" },	\
+	{ mix_name, "media_loop1_in",	"media_loop1_in" },	\
+	{ mix_name, "media_loop2_in",	"media_loop2_in" },	\
+	{ mix_name, "pcm0_in",		"pcm0_in" },		\
+	{ mix_name, "pcm1_in",		"pcm1_in" }
+
+#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name, mixer_reg)			\
+	static const struct snd_kcontrol_new kctl_name[] = {			\
+		SOC_SINGLE_EXT("media0_in", mixer_reg, SST_IP_MEDIA0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media1_in", mixer_reg, SST_IP_MEDIA1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media2_in", mixer_reg, SST_IP_MEDIA2, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media3_in", mixer_reg, SST_IP_MEDIA3, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+	}
+
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media0_controls, SST_MIX_MEDIA0);
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media1_controls, SST_MIX_MEDIA1);
+
+/* 18 SBA mixers */
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm0_controls, SST_MIX_PCM0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm1_controls, SST_MIX_PCM1);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls, SST_MIX_PCM2);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls, SST_MIX_LOOP0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls, SST_MIX_LOOP1);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls, SST_MIX_LOOP2);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls, SST_MIX_VOIP);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_aware_controls, SST_MIX_AWARE);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_vad_controls, SST_MIX_VAD);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_hf_sns_controls, SST_MIX_HF_SNS);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_hf_controls, SST_MIX_HF);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_speech_controls, SST_MIX_SPEECH);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_rxspeech_controls, SST_MIX_RXSPEECH);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls, SST_MIX_CODEC0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls, SST_MIX_CODEC1);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_bt_controls, SST_MIX_BT);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_fm_controls, SST_MIX_FM);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_modem_controls, SST_MIX_MODEM);
+
+void sst_handle_vb_timer(struct snd_soc_platform *p, bool enable)
+{
+	struct sst_cmd_generic cmd;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(p);
+	static int timer_usage;
+
+	if (enable)
+		cmd.header.command_id = SBA_VB_START;
+	else
+		cmd.header.command_id = SBA_IDLE;
+	pr_debug("%s: enable=%u, usage=%d\n", __func__, enable, timer_usage);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.length = 0;
+
+	if (enable)
+		sst_dsp->ops->power(true);
+
+	mutex_lock(&sst->lock);
+	if (enable)
+		timer_usage++;
+	else
+		timer_usage--;
+
+	/* Send the command only if this call is the first enable or last
+	 * disable
+	 */
+	if ((enable && (timer_usage == 1)) ||
+	    (!enable && (timer_usage == 0)))
+		sst_fill_and_send_cmd_unlocked(sst, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+				      SST_TASK_SBA, 0, &cmd,
+				      sizeof(cmd.header) + cmd.header.length);
+	mutex_unlock(&sst->lock);
+
+	if (!enable)
+		sst_dsp->ops->power(false);
+}
+
+#define SST_SSP_CODEC_MUX		0
+#define SST_SSP_CODEC_DOMAIN		0
+
+static const int sst_ssp_mux_shift[SST_NUM_SSPS] = {
+	[SST_SSP2] = -1,
+};
+
+static const int sst_ssp_domain_shift[SST_NUM_SSPS][SST_MAX_SSP_MUX] = {
+	[SST_SSP2][0] = -1,
+};
+
+/**
+ * sst_ssp_config - contains SSP configuration for different UCs
+ *
+ * The 3-D array contains SSP configuration for different SSPs for different
+ * domains (e.g. NB, WB), as well as muxed SSPs.
+ *
+ * The first dimension has SSP number
+ * The second dimension has SSP Muxing (e.g. BT/FM muxed on same SSP)
+ * The third dimension has SSP domains (e.g. NB/WB for BT)
+ */
+static const struct sst_ssp_config
+sst_ssp_configs[SST_NUM_SSPS][SST_MAX_SSP_MUX][SST_MAX_SSP_DOMAINS] = {
+	[SST_SSP2] = {
+		[SST_SSP_CODEC_MUX] = {
+			[SST_SSP_CODEC_DOMAIN] = {
+				.ssp_id = SSP_CODEC,
+				.bits_per_slot = 24,
+				.slots = 4,
+				.ssp_mode = SSP_MODE_MASTER,
+				.pcm_mode = SSP_PCM_MODE_NETWORK,
+				.duplex = SSP_DUPLEX,
+				.ssp_protocol = SSP_MODE_PCM,
+				.fs_width = 1,
+				.fs_frequency = SSP_FS_48_KHZ,
+				.active_slot_map = 0xF,
+				.start_delay = 0,
+			},
+		},
+	},
+};
+
+#define SST_SSP_CFG(wssp_no)                                                            \
+	(const struct sst_ssp_cfg){ .ssp_config = &sst_ssp_configs[wssp_no],            \
+				.ssp_number = wssp_no,                              \
+				.mux_shift = &sst_ssp_mux_shift[wssp_no],           \
+				.domain_shift = &sst_ssp_domain_shift[wssp_no], }
+
+void send_ssp_cmd(struct snd_soc_platform *platform, const char *id, bool enable)
+{
+	struct sst_cmd_sba_hw_set_ssp cmd;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	unsigned int domain, mux;
+	int domain_shift, mux_shift, ssp_no;
+	const struct sst_ssp_config *config;
+	const struct sst_ssp_cfg *ssp;
+
+
+	pr_err("Enter:%s, enable=%d port_name=%s\n", __func__, enable, id);
+
+	if (strcmp(id, "ssp2-port") == 0)
+		ssp_no = SST_SSP2;
+	else
+		return;
+
+	ssp = &SST_SSP_CFG(ssp_no);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.command_id = SBA_HW_SET_SSP;
+	cmd.header.length = sizeof(struct sst_cmd_sba_hw_set_ssp)
+				- sizeof(struct sst_dsp_header);
+	mux_shift = *ssp->mux_shift;
+	mux = (mux_shift == -1) ? 0 : get_mux_state(sst, SST_MUX_REG, mux_shift);
+	domain_shift = (*ssp->domain_shift)[mux];
+	domain = (domain_shift == -1) ? 0 : get_mux_state(sst, SST_MUX_REG, domain_shift);
+
+	config = &(*ssp->ssp_config)[mux][domain];
+	pr_debug("%s: ssp_id: %u, mux: %d, domain: %d\n", __func__,
+		 config->ssp_id, mux, domain);
+
+	if (enable)
+		cmd.switch_state = SST_SWITCH_ON;
+	else
+		cmd.switch_state = SST_SWITCH_OFF;
+
+	cmd.selection = config->ssp_id;
+	cmd.nb_bits_per_slots = config->bits_per_slot;
+	cmd.nb_slots = config->slots;
+	cmd.mode = config->ssp_mode | (config->pcm_mode << 1);
+	cmd.duplex = config->duplex;
+	cmd.active_tx_slot_map = config->active_slot_map;
+	cmd.active_rx_slot_map = config->active_slot_map;
+	cmd.frame_sync_frequency = config->fs_frequency;
+	cmd.frame_sync_polarity = SSP_FS_ACTIVE_HIGH;
+	cmd.data_polarity = 1;
+	cmd.frame_sync_width = config->fs_width;
+	cmd.ssp_protocol = config->ssp_protocol;
+	cmd.start_delay = config->start_delay;
+	cmd.reserved1 = cmd.reserved2 = 0xFF;
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+				SST_TASK_SBA, 0, &cmd,
+				sizeof(cmd.header) + cmd.header.length);
+}
+
+static int sst_set_be_modules(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *k, int event)
+{
+	struct sst_data *sst = snd_soc_platform_get_drvdata(w->platform);
+
+	pr_debug("Enter: %s, widget=%s\n", __func__, w->name);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		sst_send_slot_map(sst);
+		sst_send_pipe_module_params(w);
+	}
+	return 0;
+}
+
+static int sst_set_media_path(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_set_media_path cmd;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(w->platform);
+	struct sst_ids *ids = w->priv;
+
+	pr_debug("%s: widget=%s\n", __func__, w->name);
+	pr_debug("%s: task=%u, location=%#x\n", __func__,
+				ids->task_id, ids->location_id);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		cmd.switch_state = SST_PATH_ON;
+	else
+		cmd.switch_state = SST_PATH_OFF;
+
+	SST_FILL_DESTINATION(2, cmd.header.dst,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+
+	/* MMX_SET_MEDIA_PATH == SBA_SET_MEDIA_PATH */
+	cmd.header.command_id = MMX_SET_MEDIA_PATH;
+	cmd.header.length = sizeof(struct sst_cmd_set_media_path)
+				- sizeof(struct sst_dsp_header);
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      ids->task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w);
+	return 0;
+}
+
+static int sst_set_media_loop(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_sba_set_media_loop_map cmd;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(w->platform);
+	struct sst_ids *ids = w->priv;
+
+	pr_debug("Enter:%s, widget=%s\n", __func__, w->name);
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		cmd.switch_state = SST_SWITCH_ON;
+	else
+		cmd.switch_state = SST_SWITCH_OFF;
+
+	SST_FILL_DESTINATION(2, cmd.header.dst,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+
+	cmd.header.command_id = SBA_SET_MEDIA_LOOP_MAP;
+	cmd.header.length = sizeof(struct sst_cmd_sba_set_media_loop_map)
+				 - sizeof(struct sst_dsp_header);
+	cmd.param.part.cfg.rate = 2; /* 48khz */
+
+	cmd.param.part.cfg.format = ids->format; /* stereo/Mono */
+	cmd.param.part.cfg.s_length = 1; /* 24bit left justified*/
+	cmd.map = 0; /* Algo sequence: Gain - DRP - FIR - IIR  */
+
+	sst_fill_and_send_cmd(sst, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      SST_TASK_SBA, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w);
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
+	SST_AIF_IN("codec_in0", sst_set_be_modules),
+	SST_AIF_IN("codec_in1", sst_set_be_modules),
+	SST_AIF_OUT("codec_out0", sst_set_be_modules),
+	SST_AIF_OUT("codec_out1", sst_set_be_modules),
+
+	/* Media Paths */
+	/* MediaX IN paths are set via ALLOC, so no SET_MEDIA_PATH command */
+	SST_PATH_INPUT("media0_in", SST_TASK_MMX, SST_SWM_IN_MEDIA0, sst_generic_modules_event),
+	SST_PATH_INPUT("media1_in", SST_TASK_MMX, SST_SWM_IN_MEDIA1, NULL),
+	SST_PATH_INPUT("media2_in", SST_TASK_MMX, SST_SWM_IN_MEDIA2, sst_set_media_path),
+	SST_PATH_INPUT("media3_in", SST_TASK_MMX, SST_SWM_IN_MEDIA3, NULL),
+	SST_PATH_OUTPUT("media0_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA0, sst_set_media_path),
+	SST_PATH_OUTPUT("media1_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA1, sst_set_media_path),
+
+	/* SBA PCM Paths */
+	SST_PATH_INPUT("pcm0_in", SST_TASK_SBA, SST_SWM_IN_PCM0, sst_set_media_path),
+	SST_PATH_INPUT("pcm1_in", SST_TASK_SBA, SST_SWM_IN_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm0_out", SST_TASK_SBA, SST_SWM_OUT_PCM0, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm1_out", SST_TASK_SBA, SST_SWM_OUT_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm2_out", SST_TASK_SBA, SST_SWM_OUT_PCM2, sst_set_media_path),
+
+	/* SBA Loops */
+	SST_PATH_INPUT("sprot_loop_in", SST_TASK_SBA, SST_SWM_IN_SPROT_LOOP, NULL),
+	SST_PATH_INPUT("media_loop1_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP1, NULL),
+	SST_PATH_INPUT("media_loop2_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP2, NULL),
+	SST_PATH_MEDIA_LOOP_OUTPUT("sprot_loop_out", SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop1_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop2_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2, SST_FMT_STEREO, sst_set_media_loop),
+
+	/* Media Mixers */
+	SST_SWM_MIXER("media0_out mix 0", SST_MIX_MEDIA0, SST_TASK_MMX, SST_SWM_OUT_MEDIA0,
+		      sst_mix_media0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media1_out mix 0", SST_MIX_MEDIA1, SST_TASK_MMX, SST_SWM_OUT_MEDIA1,
+		      sst_mix_media1_controls, sst_swm_mixer_event),
+
+	/* SBA PCM mixers */
+	SST_SWM_MIXER("pcm0_out mix 0", SST_MIX_PCM0, SST_TASK_SBA, SST_SWM_OUT_PCM0,
+		      sst_mix_pcm0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm1_out mix 0", SST_MIX_PCM1, SST_TASK_SBA, SST_SWM_OUT_PCM1,
+		      sst_mix_pcm1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm2_out mix 0", SST_MIX_PCM2, SST_TASK_SBA, SST_SWM_OUT_PCM2,
+		      sst_mix_pcm2_controls, sst_swm_mixer_event),
+
+	/* SBA Loop mixers */
+	SST_SWM_MIXER("sprot_loop_out mix 0", SST_MIX_LOOP0, SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP,
+		      sst_mix_sprot_l0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop1_out mix 0", SST_MIX_LOOP1, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1,
+		      sst_mix_media_l1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop2_out mix 0", SST_MIX_LOOP2, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2,
+		      sst_mix_media_l2_controls, sst_swm_mixer_event),
+
+	/* SBA Backend mixers */
+	SST_SWM_MIXER("codec_out0 mix 0", SST_MIX_CODEC0, SST_TASK_SBA, SST_SWM_OUT_CODEC0,
+		      sst_mix_codec0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("codec_out1 mix 0", SST_MIX_CODEC1, SST_TASK_SBA, SST_SWM_OUT_CODEC1,
+		      sst_mix_codec1_controls, sst_swm_mixer_event),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"media0_in", NULL, "Compress Playback"},
+	{"media1_in", NULL, "Headset Playback"},
+	{"media2_in", NULL, "pcm0_out"},
+
+	{"media0_out mix 0", "media0_in", "media0_in"},
+	{"media0_out mix 0", "media1_in", "media1_in"},
+	{"media0_out mix 0", "media2_in", "media2_in"},
+	{"media0_out mix 0", "media3_in", "media3_in"},
+	{"media1_out mix 0", "media0_in", "media0_in"},
+	{"media1_out mix 0", "media1_in", "media1_in"},
+	{"media1_out mix 0", "media2_in", "media2_in"},
+	{"media1_out mix 0", "media3_in", "media3_in"},
+
+	{"media0_out", NULL, "media0_out mix 0"},
+	{"media1_out", NULL, "media1_out mix 0"},
+	{"pcm0_in", NULL, "media0_out"},
+	{"pcm1_in", NULL, "media1_out"},
+
+	{"Headset Capture", NULL, "pcm1_out"},
+	{"Headset Capture", NULL, "pcm2_out"},
+	{"pcm0_out", NULL, "pcm0_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm0_out mix 0"),
+	{"pcm1_out", NULL, "pcm1_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm1_out mix 0"),
+	{"pcm2_out", NULL, "pcm2_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm2_out mix 0"),
+
+	{"media_loop1_in", NULL, "media_loop1_out"},
+	{"media_loop1_out", NULL, "media_loop1_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("media_loop1_out mix 0"),
+	{"media_loop2_in", NULL, "media_loop2_out"},
+	{"media_loop2_out", NULL, "media_loop2_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("media_loop2_out mix 0"),
+	{"sprot_loop_in", NULL, "sprot_loop_out"},
+	{"sprot_loop_out", NULL, "sprot_loop_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("sprot_loop_out mix 0"),
+
+	{"codec_out0", NULL, "codec_out0 mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("codec_out0 mix 0"),
+	{"codec_out1", NULL, "codec_out1 mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("codec_out1 mix 0"),
+
+};
+
+static const char * const slot_names[] = {
+	"none",
+	"slot 0", "slot 1", "slot 2", "slot 3",
+	"slot 4", "slot 5", "slot 6", "slot 7", /* not supported by FW */
+};
+
+static const char * const channel_names[] = {
+	"none",
+	"codec_out0_0", "codec_out0_1", "codec_out1_0", "codec_out1_1",
+	"codec_out2_0", "codec_out2_1", "codec_out3_0", "codec_out3_1", /* not supported by FW */
+};
+
+#define SST_INTERLEAVER(xpname, slot_name, slotno) \
+	SST_SSP_SLOT_CTL(xpname, "interleaver", slot_name, slotno, true, \
+			 channel_names, sst_slot_get, sst_slot_put)
+
+#define SST_DEINTERLEAVER(xpname, channel_name, channel_no) \
+	SST_SSP_SLOT_CTL(xpname, "deinterleaver", channel_name, channel_no, false, \
+			 slot_names, sst_slot_get, sst_slot_put)
+
+static const struct snd_kcontrol_new sst_slot_controls[] = {
+	SST_INTERLEAVER("codec_out", "slot 0", 0),
+	SST_INTERLEAVER("codec_out", "slot 1", 1),
+	SST_INTERLEAVER("codec_out", "slot 2", 2),
+	SST_INTERLEAVER("codec_out", "slot 3", 3),
+	SST_DEINTERLEAVER("codec_in", "codec_in0_0", 0),
+	SST_DEINTERLEAVER("codec_in", "codec_in0_1", 1),
+	SST_DEINTERLEAVER("codec_in", "codec_in1_0", 2),
+	SST_DEINTERLEAVER("codec_in", "codec_in1_1", 3),
+};
+
+/* Gain helper with min/max set */
+#define SST_GAIN(name, path_id, task_id, instance, gain_var)				\
+	SST_GAIN_KCONTROLS(name, "gain", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
+		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\
+		sst_gain_get, sst_gain_put,						\
+		SST_MODULE_ID_GAIN_CELL, path_id, instance, task_id,			\
+		sst_gain_tlv_common, gain_var)
+
+#define SST_VOLUME(name, path_id, task_id, instance, gain_var)				\
+	SST_GAIN_KCONTROLS(name, "volume", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
+		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\
+		sst_gain_get, sst_gain_put,						\
+		SST_MODULE_ID_VOLUME, path_id, instance, task_id,			\
+		sst_gain_tlv_common, gain_var)
+
+#define SST_NUM_GAINS 36
+static struct sst_gain_value sst_gains[SST_NUM_GAINS];
+
+static const struct snd_kcontrol_new sst_gain_controls[] = {
+	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),
+	SST_GAIN("media1_in", SST_PATH_INDEX_MEDIA1_IN, SST_TASK_MMX, 0, &sst_gains[1]),
+	SST_GAIN("media2_in", SST_PATH_INDEX_MEDIA2_IN, SST_TASK_MMX, 0, &sst_gains[2]),
+	SST_GAIN("media3_in", SST_PATH_INDEX_MEDIA3_IN, SST_TASK_MMX, 0, &sst_gains[3]),
+
+	SST_GAIN("pcm0_in", SST_PATH_INDEX_PCM0_IN, SST_TASK_SBA, 0, &sst_gains[4]),
+	SST_GAIN("pcm1_in", SST_PATH_INDEX_PCM1_IN, SST_TASK_SBA, 0, &sst_gains[5]),
+	SST_GAIN("pcm1_out", SST_PATH_INDEX_PCM1_OUT, SST_TASK_SBA, 0, &sst_gains[7]),
+	SST_GAIN("pcm2_out", SST_PATH_INDEX_PCM2_OUT, SST_TASK_SBA, 0, &sst_gains[8]),
+
+	SST_GAIN("codec_in0", SST_PATH_INDEX_CODEC_IN0, SST_TASK_SBA, 0, &sst_gains[20]),
+	SST_GAIN("codec_in1", SST_PATH_INDEX_CODEC_IN1, SST_TASK_SBA, 0, &sst_gains[21]),
+	SST_GAIN("codec_out0", SST_PATH_INDEX_CODEC_OUT0, SST_TASK_SBA, 0, &sst_gains[22]),
+	SST_GAIN("codec_out1", SST_PATH_INDEX_CODEC_OUT1, SST_TASK_SBA, 0, &sst_gains[23]),
+	SST_GAIN("media_loop1_out", SST_PATH_INDEX_MEDIA_LOOP1_OUT, SST_TASK_SBA, 0, &sst_gains[30]),
+	SST_GAIN("media_loop2_out", SST_PATH_INDEX_MEDIA_LOOP2_OUT, SST_TASK_SBA, 0, &sst_gains[31]),
+	SST_GAIN("sprot_loop_out", SST_PATH_INDEX_SPROT_LOOP_OUT, SST_TASK_SBA, 0, &sst_gains[32]),
+	SST_VOLUME("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[33]),
+};
+
+static const struct snd_kcontrol_new sst_algo_controls[] = {
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
+		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
+	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
+		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
+	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
+		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
+		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+
+};
+
+static inline bool is_sst_dapm_widget(struct snd_soc_dapm_widget *w)
+{
+	if ((w->id == snd_soc_dapm_pga) ||
+	    (w->id == snd_soc_dapm_aif_in) ||
+	    (w->id == snd_soc_dapm_aif_out) ||
+	    (w->id == snd_soc_dapm_input) ||
+	    (w->id == snd_soc_dapm_output) ||
+	    (w->id == snd_soc_dapm_mixer))
+		return true;
+	else
+		return false;
+}
+
+/**
+ * sst_send_pipe_gains - send gains for the front-end DAIs
+ *
+ * The gains in the pipes connected to the front-ends are muted/unmuted
+ * automatically via the digital_mute() DAPM callback. This function sends the
+ * gains for the front-end pipes.
+ */
+int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
+{
+	struct snd_soc_platform *platform = dai->platform;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_path *p = NULL;
+
+	pr_debug("%s: enter, dai-name=%s dir=%d\n", __func__, dai->name, stream);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		pr_debug("Stream name=%s\n", dai->playback_widget->name);
+		w = dai->playback_widget;
+		list_for_each_entry(p, &w->sinks, list_source) {
+			if (p->connected && !p->connected(w, p->sink))
+				continue;
+
+			if (p->connect && p->sink->power && is_sst_dapm_widget(p->sink)) {
+				struct sst_ids *ids = p->sink->priv;
+
+				pr_debug("send gains for widget=%s\n", p->sink->name);
+				sst_set_pipe_gain(ids, sst, mute);
+			}
+		}
+	} else {
+		pr_debug("Stream name=%s\n", dai->capture_widget->name);
+		w = dai->capture_widget;
+		list_for_each_entry(p, &w->sources, list_sink) {
+			if (p->connected && !p->connected(w, p->sink))
+				continue;
+
+			if (p->connect &&  p->source->power && is_sst_dapm_widget(p->source)) {
+				struct sst_ids *ids = p->source->priv;
+
+				pr_debug("send gain for widget=%s\n", p->source->name);
+				sst_set_pipe_gain(ids, sst, mute);
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * sst_fill_module_list - populate the list of modules/gains for a pipe
+ *
+ *
+ * Fills the widget pointer in the kcontrol private data, and also fills the
+ * kcontrol pointer in the widget private data.
+ *
+ * Widget pointer is used to send the algo/gain in the .put() handler if the
+ * widget is powerd on.
+ *
+ * Kcontrol pointer is used to send the algo/gain in the widget power ON/OFF
+ * event handler. Each widget (pipe) has multiple algos stored in the algo_list.
+ */
+static int sst_fill_module_list(struct snd_kcontrol *kctl,
+	 struct snd_soc_dapm_widget *w, int type)
+{
+	struct module *module = NULL;
+	struct sst_ids *ids = w->priv;
+
+	module = devm_kzalloc(w->platform->dev, sizeof(*module), GFP_KERNEL);
+	if (!module) {
+		pr_err("kzalloc block failed\n");
+		return -ENOMEM;
+	}
+
+	if (type == SST_MODULE_GAIN) {
+		struct sst_gain_mixer_control *mc = (void *)kctl->private_value;
+
+		mc->w = w;
+		module->kctl = kctl;
+		list_add_tail(&module->node, &ids->gain_list);
+	} else if (type == SST_MODULE_ALGO) {
+		struct sst_algo_control *bc = (void *)kctl->private_value;
+
+		bc->w = w;
+		module->kctl = kctl;
+		list_add_tail(&module->node, &ids->algo_list);
+	}
+
+	return 0;
+}
+
+/**
+ * sst_fill_widget_module_info - fill list of gains/algos for the pipe
+ * @widget:	pipe modelled as a DAPM widget
+ *
+ * Fill the list of gains/algos for the widget by looking at all the card
+ * controls and comparing the name of the widget with the first part of control
+ * name. First part of control name contains the pipe name (widget name).
+ */
+static int sst_fill_widget_module_info(struct snd_soc_dapm_widget *w,
+	struct snd_soc_platform *platform)
+{
+	struct snd_kcontrol *kctl;
+	int index, ret = 0;
+	struct snd_card *card = platform->card->snd_card;
+	char *idx;
+
+	down_read(&card->controls_rwsem);
+
+	list_for_each_entry(kctl, &card->controls, list) {
+		idx = strstr(kctl->id.name, " ");
+		if (idx == NULL)
+			continue;
+		index  = strlen(kctl->id.name) - strlen(idx);
+		if (strstr(kctl->id.name, "volume") &&
+		    !strncmp(kctl->id.name, w->name, index))
+			ret = sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
+		else if (strstr(kctl->id.name, "params") &&
+			 !strncmp(kctl->id.name, w->name, index))
+			ret = sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
+		else if (strstr(kctl->id.name, "mute") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+			struct sst_gain_mixer_control *mc = (void *)kctl->private_value;
+			mc->w = w;
+		} else if (strstr(kctl->id.name, "interleaver") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+			struct sst_enum *e = (void *)kctl->private_value;
+			e->w = w;
+		} else if (strstr(kctl->id.name, "deinterleaver") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+			struct sst_enum *e = (void *)kctl->private_value;
+			e->w = w;
+		}
+		if (ret < 0) {
+			up_read(&card->controls_rwsem);
+			return ret;
+		}
+	}
+	up_read(&card->controls_rwsem);
+	return 0;
+}
+
+/**
+ * sst_fill_linked_widgets - fill the parent pointer for the linked widget
+ */
+static void sst_fill_linked_widgets(struct snd_soc_platform *platform,
+						struct sst_ids *ids)
+{
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_context *dapm = &platform->dapm;
+
+	unsigned int len = strlen(ids->parent_wname);
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!strncmp(ids->parent_wname, w->name, len)) {
+			ids->parent_w = w;
+			break;
+		}
+	}
+}
+
+/**
+ * sst_map_modules_to_pipe - fill algo/gains list for all pipes
+ */
+static int sst_map_modules_to_pipe(struct snd_soc_platform *platform)
+{
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_context *dapm = &platform->dapm;
+	int ret = 0;
+
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w->platform && is_sst_dapm_widget(w) && (w->priv)) {
+			struct sst_ids *ids = w->priv;
+
+			pr_debug("widget type=%d name=%s\n", w->id, w->name);
+			INIT_LIST_HEAD(&ids->algo_list);
+			INIT_LIST_HEAD(&ids->gain_list);
+			ret = sst_fill_widget_module_info(w, platform);
+			if (ret < 0)
+				return ret;
+			/* fill linked widgets */
+			if (ids->parent_wname !=  NULL)
+				sst_fill_linked_widgets(platform, ids);
+		}
+	}
+	return 0;
+}
+
+int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
+{
+	int i, ret = 0;
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+
+	sst->byte_stream = devm_kzalloc(platform->dev,
+					SST_MAX_BIN_BYTES, GFP_KERNEL);
+	if (!sst->byte_stream) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+	sst->widget = devm_kzalloc(platform->dev,
+				   SST_NUM_WIDGETS * sizeof(*sst->widget),
+				   GFP_KERNEL);
+	if (!sst->widget) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	snd_soc_dapm_new_controls(&platform->dapm, sst_dapm_widgets,
+			ARRAY_SIZE(sst_dapm_widgets));
+	snd_soc_dapm_add_routes(&platform->dapm, intercon,
+			ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_widgets(platform->dapm.card);
+
+	for (i = 0; i < SST_NUM_GAINS; i++) {
+		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
+		sst_gains[i].l_gain = SST_GAIN_VOLUME_DEFAULT;
+		sst_gains[i].r_gain = SST_GAIN_VOLUME_DEFAULT;
+		sst_gains[i].ramp_duration = SST_GAIN_RAMP_DURATION_DEFAULT;
+	}
+
+	snd_soc_add_platform_controls(platform, sst_gain_controls,
+			ARRAY_SIZE(sst_gain_controls));
+
+	snd_soc_add_platform_controls(platform, sst_algo_controls,
+			ARRAY_SIZE(sst_algo_controls));
+	snd_soc_add_platform_controls(platform, sst_slot_controls,
+			ARRAY_SIZE(sst_slot_controls));
+
+	ret = sst_map_modules_to_pipe(platform);
+
+	return ret;
+}
diff --git a/sound/soc/intel/platform-libs/sst_widgets.h b/sound/soc/intel/platform-libs/sst_widgets.h
new file mode 100644
index 0000000..25deae6
--- /dev/null
+++ b/sound/soc/intel/platform-libs/sst_widgets.h
@@ -0,0 +1,378 @@
+/*
+ *  sst_widgets.h - Intel helpers to generate FW widgets
+ *
+ *  Copyright (C) 2013-14 Intel Corp
+ *  Author: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
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
+ */
+
+#ifndef __SST_WIDGETS_H__
+#define __SST_WIDGETS_H__
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define SST_MODULE_GAIN 1
+#define SST_MODULE_ALGO 2
+
+#define SST_FMT_MONO 0
+#define SST_FMT_STEREO 3
+
+/* physical SSP numbers */
+enum {
+	SST_SSP0 = 0,
+	SST_SSP1,
+	SST_SSP2,
+	SST_SSP_LAST = SST_SSP2,
+};
+
+#define SST_NUM_SSPS		(SST_SSP_LAST + 1)	/* physical SSPs */
+#define SST_MAX_SSP_MUX		2			/* single SSP muxed between pipes */
+#define SST_MAX_SSP_DOMAINS	2			/* domains present in each pipe */
+
+struct module {
+	struct snd_kcontrol *kctl;
+	struct list_head node;
+};
+
+struct sst_ssp_config {
+	u8 ssp_id;
+	u8 bits_per_slot;
+	u8 slots;
+	u8 ssp_mode;
+	u8 pcm_mode;
+	u8 duplex;
+	u8 ssp_protocol;
+	u8 fs_frequency;
+	u8 active_slot_map;
+	u8 start_delay;
+	u16 fs_width;
+};
+
+struct sst_ssp_cfg {
+	const u8 ssp_number;
+	const int *mux_shift;
+	const int (*domain_shift)[SST_MAX_SSP_MUX];
+	const struct sst_ssp_config (*ssp_config)[SST_MAX_SSP_MUX][SST_MAX_SSP_DOMAINS];
+};
+
+struct sst_ids {
+	u16 location_id;
+	u16 module_id;
+	u8  task_id;
+	u8  format;
+	u8  reg;
+	const char *parent_wname;
+	struct snd_soc_dapm_widget *parent_w;
+	struct list_head algo_list;
+	struct list_head gain_list;
+	const struct sst_pcm_format *pcm_fmt;
+};
+
+
+#define SST_AIF_IN(wname, wevent)							\
+{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,					\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_AIF_OUT(wname, wevent)							\
+{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_INPUT(wname, wevent)							\
+{	.id = snd_soc_dapm_input, .name = wname, .sname = NULL,				\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_OUTPUT(wname, wevent)							\
+{	.id = snd_soc_dapm_output, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_DAPM_OUTPUT(wname, wloc_id, wtask_id, wformat, wevent)                      \
+{	.id = snd_soc_dapm_output, .name = wname, .sname = NULL,                        \
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,   \
+	.priv = (void *)&(struct sst_ids) { .location_id = wloc_id, .task_id = wtask_id,\
+						.pcm_fmt = wformat, }			\
+}
+
+#define SST_PATH(wname, wtask, wloc_id, wevent, wflags)					\
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,		\
+	.kcontrol_news = NULL, .num_kcontrols = 0,				\
+	.event = wevent, .event_flags = wflags,						\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id, }	\
+}
+
+#define SST_LINKED_PATH(wname, wtask, wloc_id, linked_wname, wevent, wflags)		\
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,		\
+	.kcontrol_news = NULL, .num_kcontrols = 0,				\
+	.event = wevent, .event_flags = wflags,						\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					.parent_wname = linked_wname}			\
+}
+
+#define SST_PATH_MEDIA_LOOP(wname, wtask, wloc_id, wformat, wevent, wflags)             \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,         \
+	.kcontrol_news = NULL, .num_kcontrols = 0,                         \
+	.event = wevent, .event_flags = wflags,                                         \
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					    .format = wformat,}				\
+}
+
+/* output is triggered before input */
+#define SST_PATH_INPUT(name, task_id, loc_id, event)					\
+	SST_PATH(name, task_id, loc_id, event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
+
+#define SST_PATH_LINKED_INPUT(name, task_id, loc_id, linked_wname, event)		\
+	SST_LINKED_PATH(name, task_id, loc_id, linked_wname, event,			\
+					SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
+
+#define SST_PATH_OUTPUT(name, task_id, loc_id, event)					\
+	SST_PATH(name, task_id, loc_id, event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+#define SST_PATH_LINKED_OUTPUT(name, task_id, loc_id, linked_wname, event)		\
+	SST_LINKED_PATH(name, task_id, loc_id, linked_wname, event,			\
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+#define SST_PATH_MEDIA_LOOP_OUTPUT(name, task_id, loc_id, format, event)		\
+	SST_PATH_MEDIA_LOOP(name, task_id, loc_id, format, event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+
+#define SST_SWM_MIXER(wname, wreg, wtask, wloc_id, wcontrols, wevent)			\
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,	\
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols),\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD |	\
+					SND_SOC_DAPM_POST_REG,				\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					    .reg = wreg }				\
+}
+
+enum sst_gain_kcontrol_type {
+	SST_GAIN_TLV,
+	SST_GAIN_MUTE,
+	SST_GAIN_RAMP_DURATION,
+};
+
+struct sst_gain_mixer_control {
+	bool stereo;
+	enum sst_gain_kcontrol_type type;
+	struct sst_gain_value *gain_val;
+	int max;
+	int min;
+	u16 instance_id;
+	u16 module_id;
+	u16 pipe_id;
+	u16 task_id;
+	char pname[44];
+	struct snd_soc_dapm_widget *w;
+};
+
+struct sst_gain_value {
+	u16 ramp_duration;
+	s16 l_gain;
+	s16 r_gain;
+	bool mute;
+};
+
+#define SST_GAIN_VOLUME_DEFAULT		(-1440)
+#define SST_GAIN_RAMP_DURATION_DEFAULT	5 /* timeconstant */
+#define SST_GAIN_MUTE_DEFAULT		true
+
+#define SST_GAIN_KCONTROL_TLV(xname, xhandler_get, xhandler_put, \
+			      xmod, xpipe, xinstance, xtask, tlv_array, xgain_val, \
+			      xmin, xmax, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = sst_gain_ctl_info,\
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = true, .max = xmax, .min = xmin, .type = SST_GAIN_TLV, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname = xpname}
+
+#define SST_GAIN_KCONTROL_INT(xname, xhandler_get, xhandler_put, \
+			      xmod, xpipe, xinstance, xtask, xtype, xgain_val, \
+			      xmin, xmax, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sst_gain_ctl_info, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = false, .max = xmax, .min = xmin, .type = xtype, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname =  xpname}
+
+#define SST_GAIN_KCONTROL_BOOL(xname, xhandler_get, xhandler_put,\
+			       xmod, xpipe, xinstance, xtask, xgain_val, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_bool_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = false, .type = SST_GAIN_MUTE, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname = xpname}
+
+#define SST_CONTROL_NAME(xpname, xmname, xinstance, xtype) \
+	xpname " " xmname " " #xinstance " " xtype
+
+#define SST_COMBO_CONTROL_NAME(xpname, xmname, xinstance, xtype, xsubmodule) \
+	xpname " " xmname " " #xinstance " " xtype " " xsubmodule
+
+/*
+ * 3 Controls for each Gain module
+ * e.g.	- pcm0_in gain 0 volume
+ *	- pcm0_in gain 0 rampduration
+ *	- pcm0_in gain 0 mute
+ */
+#define SST_GAIN_KCONTROLS(xpname, xmname, xmin_gain, xmax_gain, xmin_tc, xmax_tc, \
+			   xhandler_get, xhandler_put, \
+			   xmod, xpipe, xinstance, xtask, tlv_array, xgain_val) \
+	{ SST_GAIN_KCONTROL_INT(SST_CONTROL_NAME(xpname, xmname, xinstance, "rampduration"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, SST_GAIN_RAMP_DURATION, \
+		xgain_val, xmin_tc, xmax_tc, xpname) }, \
+	{ SST_GAIN_KCONTROL_BOOL(SST_CONTROL_NAME(xpname, xmname, xinstance, "mute"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, \
+		xgain_val, xpname) } ,\
+	{ SST_GAIN_KCONTROL_TLV(SST_CONTROL_NAME(xpname, xmname, xinstance, "volume"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, tlv_array, \
+		xgain_val, xmin_gain, xmax_gain, xpname) }
+
+#define SST_GAIN_TC_MIN		5
+#define SST_GAIN_TC_MAX		5000
+#define SST_GAIN_MIN_VALUE	-1440 /* in 0.1 DB units */
+#define SST_GAIN_MAX_VALUE	360
+
+enum sst_algo_kcontrol_type {
+	SST_ALGO_PARAMS,
+	SST_ALGO_BYPASS,
+};
+
+struct sst_algo_control {
+	enum sst_algo_kcontrol_type type;
+	int max;
+	u16 module_id;
+	u16 pipe_id;
+	u16 task_id;
+	u16 cmd_id;
+	bool bypass;
+	unsigned char *params;
+	struct snd_soc_dapm_widget *w;
+};
+
+/* size of the control = size of params + size of length field */
+#define SST_ALGO_CTL_VALUE(xcount, xtype, xpipe, xmod, xtask, xcmd)			\
+	(struct sst_algo_control){							\
+		.max = xcount + sizeof(u16), .type = xtype, .module_id = xmod,			\
+		.pipe_id = xpipe, .task_id = xtask, .cmd_id = xcmd,			\
+	}
+
+#define SST_ALGO_KCONTROL(xname, xcount, xmod, xpipe,					\
+			  xtask, xcmd, xtype, xinfo, xget, xput)			\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,						\
+	.name =  xname,									\
+	.info = xinfo, .get = xget, .put = xput,					\
+	.private_value = (unsigned long)&						\
+			SST_ALGO_CTL_VALUE(xcount, xtype, xpipe,			\
+					   xmod, xtask, xcmd),				\
+}
+
+#define SST_ALGO_KCONTROL_BYTES(xpname, xmname, xcount, xmod,				\
+				xpipe, xinstance, xtask, xcmd)				\
+	SST_ALGO_KCONTROL(SST_CONTROL_NAME(xpname, xmname, xinstance, "params"),	\
+			  xcount, xmod, xpipe, xtask, xcmd, SST_ALGO_PARAMS,		\
+			  sst_algo_bytes_ctl_info,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+#define SST_ALGO_KCONTROL_BOOL(xpname, xmname, xmod, xpipe, xinstance, xtask)		\
+	SST_ALGO_KCONTROL(SST_CONTROL_NAME(xpname, xmname, xinstance, "bypass"),	\
+			  0, xmod, xpipe, xtask, 0, SST_ALGO_BYPASS,			\
+			  snd_soc_info_bool_ext,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+#define SST_ALGO_BYPASS_PARAMS(xpname, xmname, xcount, xmod, xpipe,			\
+				xinstance, xtask, xcmd)					\
+	SST_ALGO_KCONTROL_BOOL(xpname, xmname, xmod, xpipe, xinstance, xtask),		\
+	SST_ALGO_KCONTROL_BYTES(xpname, xmname, xcount, xmod, xpipe, xinstance, xtask, xcmd)
+
+#define SST_COMBO_ALGO_KCONTROL_BYTES(xpname, xmname, xsubmod, xcount, xmod,		\
+				      xpipe, xinstance, xtask, xcmd)			\
+	SST_ALGO_KCONTROL(SST_COMBO_CONTROL_NAME(xpname, xmname, xinstance, "params",	\
+						 xsubmod),				\
+			  xcount, xmod, xpipe, xtask, xcmd, SST_ALGO_PARAMS,		\
+			  sst_algo_bytes_ctl_info,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+
+struct sst_enum {
+	bool tx;
+	unsigned short reg;
+	unsigned int max;
+	const char * const *texts;
+	struct snd_soc_dapm_widget *w;
+};
+
+/* only 4 slots/channels supported atm */
+#define SST_SSP_SLOT_ENUM(s_ch_no, is_tx, xtexts) \
+	(struct sst_enum){ .reg = s_ch_no, .tx = is_tx, .max = 4+1, .texts = xtexts, }
+
+#define SST_SLOT_CTL_NAME(xpname, xmname, s_ch_name) \
+	xpname " " xmname " " s_ch_name
+
+#define SST_SSP_SLOT_CTL(xpname, xmname, s_ch_name, s_ch_no, is_tx, xtexts, xget, xput) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = SST_SLOT_CTL_NAME(xpname, xmname, s_ch_name), \
+	.info = sst_slot_enum_info, \
+	.get = xget, .put = xput, \
+	.private_value = (unsigned long)&SST_SSP_SLOT_ENUM(s_ch_no, is_tx, xtexts), \
+}
+
+#define SST_MUX_CTL_NAME(xpname, xinstance) \
+	xpname " " #xinstance
+
+#define SST_SSP_MUX_ENUM(xreg, xshift, xtexts) \
+	(struct soc_enum){ .reg = xreg, .texts = xtexts, .shift_l = xshift, \
+			   .shift_r = xshift, .items = ARRAY_SIZE(xtexts), }
+
+#define SST_SSP_MUX_CTL(xpname, xinstance, xreg, xshift, xtexts, xget, xput) \
+	SOC_DAPM_ENUM_EXT(SST_MUX_CTL_NAME(xpname, xinstance), \
+			  SST_SSP_MUX_ENUM(xreg, xshift, xtexts), \
+			  xget, xput)
+
+struct sst_probe_value {
+	unsigned int val;
+	const struct soc_enum *p_enum;
+};
+
+#define SST_PROBE_CTL_NAME(dir, num, type) \
+	dir #num " " type
+
+#define SST_PROBE_ENUM(xname, xenum, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sst_probe_enum_info, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_probe_value) \
+	{ .val = 0, .p_enum = &xenum } }
+
+#endif
diff --git a/sound/soc/intel/platform_ipc_v2.h b/sound/soc/intel/platform_ipc_v2.h
new file mode 100644
index 0000000..a718f9c
--- /dev/null
+++ b/sound/soc/intel/platform_ipc_v2.h
@@ -0,0 +1,694 @@
+/*
+*  platform_ipc_v2.h - Intel MID Platform driver FW IPC definitions
+*
+*  Copyright (C) 2008-10 Intel Corporation
+*  Author:	Vinod Koul <vinod.koul@intel.com>
+*		Harsha Priya <priya.harsha@intel.com>
+*		Dharageswari R <dharageswari.r@intel.com>
+*		KP Jeeja <jeeja.kp@intel.com>
+*  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; version 2 of the License.
+*
+*  This program is distributed in the hope that it will be useful, but
+*  WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+*  General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License along
+*  with this program; if not, write to the Free Software Foundation, Inc.,
+*  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+*
+* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+*
+*  This driver exposes the audio engine functionalities to the ALSA
+*	and middleware.
+*  This file has definitions shared between the firmware and driver
+*/
+#ifndef __PLATFORM_IPC_V2_H__
+#define __PLATFORM_IPC_V2_H__
+
+#define MAX_DBG_RW_BYTES 80
+#define MAX_NUM_SCATTER_BUFFERS 8
+#define MAX_LOOP_BACK_DWORDS 8
+/* IPC base address and mailbox, timestamp offsets */
+#define SST_MAILBOX_SIZE 0x0400
+#define SST_MAILBOX_SEND 0x0000
+#define SST_TIME_STAMP 0x1800
+#define SST_TIME_STAMP_MRFLD 0x680
+#define SST_TIME_STAMP_BYT 0x800
+#define SST_RESERVED_OFFSET 0x1A00
+#define SST_SCU_LPE_MAILBOX 0x1000
+#define SST_LPE_SCU_MAILBOX 0x1400
+#define SST_SCU_LPE_LOG_BUF (SST_SCU_LPE_MAILBOX+16)
+#define PROCESS_MSG 0x80
+
+/* Message ID's for IPC messages */
+/* Bits B7: SST or IA/SC ; B6-B4: Msg Category; B3-B0: Msg Type */
+
+/* I2L Firmware/Codec Download msgs */
+#define IPC_IA_PREP_LIB_DNLD 0x01
+#define IPC_IA_LIB_DNLD_CMPLT 0x02
+#define IPC_IA_GET_FW_VERSION 0x04
+#define IPC_IA_GET_FW_BUILD_INF 0x05
+#define IPC_IA_GET_FW_INFO 0x06
+#define IPC_IA_GET_FW_CTXT 0x07
+#define IPC_IA_SET_FW_CTXT 0x08
+#define IPC_IA_PREPARE_SHUTDOWN 0x31
+/* I2L Codec Config/control msgs */
+#define IPC_PREP_D3 0x10
+#define IPC_IA_SET_CODEC_PARAMS 0x10
+#define IPC_IA_GET_CODEC_PARAMS 0x11
+#define IPC_IA_SET_PPP_PARAMS 0x12
+#define IPC_IA_GET_PPP_PARAMS 0x13
+#define IPC_SST_PERIOD_ELAPSED_MRFLD 0xA
+#define IPC_SST_VB_RESET 0x28
+#define IPC_IA_ALG_PARAMS 0x1A
+#define IPC_IA_TUNING_PARAMS 0x1B
+#define IPC_IA_SET_RUNTIME_PARAMS 0x1C
+#define IPC_IA_SET_PARAMS 0x1
+#define IPC_IA_GET_PARAMS 0x2
+
+#define IPC_EFFECTS_CREATE 0xE
+#define IPC_EFFECTS_DESTROY 0xF
+
+/* I2L Stream config/control msgs */
+#define IPC_IA_ALLOC_STREAM_MRFLD 0x2
+#define IPC_IA_ALLOC_STREAM 0x20 /* Allocate a stream ID */
+#define IPC_IA_FREE_STREAM_MRFLD 0x03
+#define IPC_IA_FREE_STREAM 0x21 /* Free the stream ID */
+#define IPC_IA_SET_STREAM_PARAMS 0x22
+#define IPC_IA_SET_STREAM_PARAMS_MRFLD 0x12
+#define IPC_IA_GET_STREAM_PARAMS 0x23
+#define IPC_IA_PAUSE_STREAM 0x24
+#define IPC_IA_PAUSE_STREAM_MRFLD 0x4
+#define IPC_IA_RESUME_STREAM 0x25
+#define IPC_IA_RESUME_STREAM_MRFLD 0x5
+#define IPC_IA_DROP_STREAM 0x26
+#define IPC_IA_DROP_STREAM_MRFLD 0x07
+#define IPC_IA_DRAIN_STREAM 0x27 /* Short msg with str_id */
+#define IPC_IA_DRAIN_STREAM_MRFLD 0x8
+#define IPC_IA_CONTROL_ROUTING 0x29
+#define IPC_IA_VTSV_UPDATE_MODULES 0x20
+#define IPC_IA_VTSV_DETECTED 0x21
+
+#define IPC_IA_START_STREAM_MRFLD 0X06
+#define IPC_IA_START_STREAM 0x30 /* Short msg with str_id */
+
+#define IPC_IA_SET_GAIN_MRFLD 0x21
+/* Debug msgs */
+#define IPC_IA_DBG_MEM_READ 0x40
+#define IPC_IA_DBG_MEM_WRITE 0x41
+#define IPC_IA_DBG_LOOP_BACK 0x42
+#define IPC_IA_DBG_LOG_ENABLE 0x45
+#define IPC_IA_DBG_SET_PROBE_PARAMS 0x47
+
+/* L2I Firmware/Codec Download msgs */
+#define IPC_IA_FW_INIT_CMPLT 0x81
+#define IPC_IA_FW_INIT_CMPLT_MRFLD 0x01
+#define IPC_IA_FW_ASYNC_ERR_MRFLD 0x11
+
+/* L2I Codec Config/control msgs */
+#define IPC_SST_FRAGMENT_ELPASED 0x90 /* Request IA more data */
+
+#define IPC_SST_BUF_UNDER_RUN 0x92 /* PB Under run and stopped */
+#define IPC_SST_BUF_OVER_RUN 0x93 /* CAP Under run and stopped */
+#define IPC_SST_DRAIN_END 0x94 /* PB Drain complete and stopped */
+#define IPC_SST_CHNGE_SSP_PARAMS 0x95 /* PB SSP parameters changed */
+#define IPC_SST_STREAM_PROCESS_FATAL_ERR 0x96/* error in processing a stream */
+#define IPC_SST_PERIOD_ELAPSED 0x97 /* period elapsed */
+
+#define IPC_SST_ERROR_EVENT 0x99 /* Buffer over run occurred */
+/* L2S messages */
+#define IPC_SC_DDR_LINK_UP 0xC0
+#define IPC_SC_DDR_LINK_DOWN 0xC1
+#define IPC_SC_SET_LPECLK_REQ 0xC2
+#define IPC_SC_SSP_BIT_BANG 0xC3
+
+/* L2I Error reporting msgs */
+#define IPC_IA_MEM_ALLOC_FAIL 0xE0
+#define IPC_IA_PROC_ERR 0xE1 /* error in processing a
+					stream can be used by playback and
+					capture modules */
+
+/* L2I Debug msgs */
+#define IPC_IA_PRINT_STRING 0xF0
+
+/* Buffer under-run */
+#define IPC_IA_BUF_UNDER_RUN_MRFLD 0x0B
+
+/* Mrfld specific defines:
+ * For asynchronous messages(INIT_CMPLT, PERIOD_ELAPSED, ASYNC_ERROR)
+ * received from FW, the format is:
+ *  - IPC High: pvt_id is set to zero. Always short message.
+ *  - msg_id is in lower 16-bits of IPC low payload.
+ *  - pipe_id is in higher 16-bits of IPC low payload for period_elapsed.
+ *  - error id is in higher 16-bits of IPC low payload for async errors.
+ */
+#define SST_ASYNC_DRV_ID 0
+
+/* Command Response or Acknowledge message to any IPC message will have
+ * same message ID and stream ID information which is sent.
+ * There is no specific Ack message ID. The data field is used as response
+ * meaning.
+ */
+
+/* SCU IPC for resetting & power gating the LPE through SCU */
+#define IPC_SCU_LPE_RESET 0xA3
+
+enum ackData {
+	IPC_ACK_SUCCESS = 0,
+	IPC_ACK_FAILURE,
+};
+
+enum ipc_ia_msg_id {
+	IPC_CMD = 1,		/*!< Task Control message ID */
+	IPC_SET_PARAMS = 2,/*!< Task Set param message ID */
+	IPC_GET_PARAMS = 3,	/*!< Task Get param message ID */
+	IPC_INVALID = 0xFF,	/*!<Task Get param message ID */
+};
+
+enum sst_codec_types {
+	/*  AUDIO/MUSIC	CODEC Type Definitions */
+	SST_CODEC_TYPE_UNKNOWN = 0,
+	SST_CODEC_TYPE_PCM,	/* Pass through Audio codec */
+	SST_CODEC_TYPE_MP3,
+	SST_CODEC_TYPE_MP24,
+	SST_CODEC_TYPE_AAC,
+	SST_CODEC_TYPE_AACP,
+	SST_CODEC_TYPE_eAACP,
+	SST_CODEC_TYPE_WMA9,
+	SST_CODEC_TYPE_WMA10,
+	SST_CODEC_TYPE_WMA10P,
+	SST_CODEC_TYPE_RA,
+	SST_CODEC_TYPE_DDAC3,
+	SST_CODEC_TYPE_STEREO_TRUE_HD,
+	SST_CODEC_TYPE_STEREO_HD_PLUS,
+
+	/*  VOICE CODEC Type Definitions */
+	SST_CODEC_TYPE_VOICE_PCM = 0x21, /* Pass through voice codec */
+};
+
+enum sst_algo_types {
+	SST_ALGO_SRC = 0x64,
+	SST_ALGO_MIXER = 0x65,
+	SST_ALGO_DOWN_MIXER = 0x66,
+	SST_ALGO_VTSV = 0x73,
+	SST_ALGO_AUDCLASSIFIER = 0x80,
+	SST_ALGO_VOLUME_CONTROL = 0x92,
+	SST_ALGO_GEQ = 0x99,
+};
+
+enum stream_type {
+	SST_STREAM_TYPE_NONE = 0,
+	SST_STREAM_TYPE_MUSIC = 1,
+	SST_STREAM_TYPE_NORMAL = 2,
+	SST_STREAM_TYPE_PROBE = 3,
+	SST_STREAM_TYPE_LONG_PB = 4,
+	SST_STREAM_TYPE_LOW_LATENCY = 5,
+};
+
+enum sst_error_codes {
+	/* Error code,response to msgId: Description */
+	/* Common error codes */
+	SST_SUCCESS = 0,	/* Success */
+	SST_ERR_INVALID_STREAM_ID = 1,
+	SST_ERR_INVALID_MSG_ID = 2,
+	SST_ERR_INVALID_STREAM_OP = 3,
+	SST_ERR_INVALID_PARAMS = 4,
+	SST_ERR_INVALID_CODEC = 5,
+	SST_ERR_INVALID_MEDIA_TYPE = 6,
+	SST_ERR_STREAM_ERR = 7,
+
+	/* IPC specific error codes */
+	SST_IPC_ERR_CALL_BACK_NOT_REGD = 8,
+	SST_IPC_ERR_STREAM_NOT_ALLOCATED = 9,
+	SST_IPC_ERR_STREAM_ALLOC_FAILED = 10,
+	SST_IPC_ERR_GET_STREAM_FAILED = 11,
+	SST_ERR_MOD_NOT_AVAIL = 12,
+	SST_ERR_MOD_DNLD_RQD = 13,
+	SST_ERR_STREAM_STOPPED = 14,
+	SST_ERR_STREAM_IN_USE = 15,
+
+	/* Capture specific error codes */
+	SST_CAP_ERR_INCMPLTE_CAPTURE_MSG = 16,
+	SST_CAP_ERR_CAPTURE_FAIL = 17,
+	SST_CAP_ERR_GET_DDR_NEW_SGLIST = 18,
+	SST_CAP_ERR_UNDER_RUN = 19,
+	SST_CAP_ERR_OVERFLOW = 20,
+
+	/* Playback specific error codes*/
+	SST_PB_ERR_INCMPLTE_PLAY_MSG = 21,
+	SST_PB_ERR_PLAY_FAIL = 22,
+	SST_PB_ERR_GET_DDR_NEW_SGLIST = 23,
+
+	/* Codec manager specific error codes */
+	SST_LIB_ERR_LIB_DNLD_REQUIRED = 24,
+	SST_LIB_ERR_LIB_NOT_SUPPORTED = 25,
+
+	/* Library manager specific error codes */
+	SST_SCC_ERR_PREP_DNLD_FAILED = 26,
+	SST_SCC_ERR_LIB_DNLD_RES_FAILED = 27,
+	/* Scheduler specific error codes */
+	SST_SCH_ERR_FAIL = 28,
+
+	/* DMA specific error codes */
+	SST_DMA_ERR_NO_CHNL_AVAILABLE = 29,
+	SST_DMA_ERR_INVALID_INPUT_PARAMS = 30,
+	SST_DMA_ERR_CHNL_ALREADY_SUSPENDED = 31,
+	SST_DMA_ERR_CHNL_ALREADY_STARTED = 32,
+	SST_DMA_ERR_CHNL_NOT_ENABLED = 33,
+	SST_DMA_ERR_TRANSFER_FAILED = 34,
+
+	SST_SSP_ERR_ALREADY_ENABLED = 35,
+	SST_SSP_ERR_ALREADY_DISABLED = 36,
+	SST_SSP_ERR_NOT_INITIALIZED = 37,
+	SST_SSP_ERR_SRAM_NO_DMA_DATA = 38,
+
+	/* Other error codes */
+	SST_ERR_MOD_INIT_FAIL = 39,
+
+	/* FW init error codes */
+	SST_RDR_ERR_IO_DEV_SEL_NOT_ALLOWED = 40,
+	SST_RDR_ERR_ROUTE_ALREADY_STARTED = 41,
+	SST_RDR_ERR_IO_DEV_SEL_FAILED = 42,
+	SST_RDR_PREP_CODEC_DNLD_FAILED = 43,
+
+	/* Memory debug error codes */
+	SST_ERR_DBG_MEM_READ_FAIL = 44,
+	SST_ERR_DBG_MEM_WRITE_FAIL = 45,
+	SST_ERR_INSUFFICIENT_INPUT_SG_LIST = 46,
+	SST_ERR_INSUFFICIENT_OUTPUT_SG_LIST = 47,
+
+	SST_ERR_BUFFER_NOT_AVAILABLE = 48,
+	SST_ERR_BUFFER_NOT_ALLOCATED = 49,
+	SST_ERR_INVALID_REGION_TYPE = 50,
+	SST_ERR_NULL_PTR = 51,
+	SST_ERR_INVALID_BUFFER_SIZE = 52,
+	SST_ERR_INVALID_BUFFER_INDEX = 53,
+
+	/*IIPC specific error codes */
+	SST_IIPC_QUEUE_FULL = 54,
+	SST_IIPC_ERR_MSG_SND_FAILED = 55,
+	SST_PB_ERR_UNDERRUN_OCCURED = 56,
+	SST_RDR_INSUFFICIENT_MIXER_BUFFER = 57,
+	SST_INVALID_TIME_SLOTS = 58,
+};
+
+enum dbg_mem_data_type {
+	/* Data type of debug read/write */
+	DATA_TYPE_U32,
+	DATA_TYPE_U16,
+	DATA_TYPE_U8,
+};
+
+enum dbg_type {
+	NO_DEBUG = 0,
+	SRAM_DEBUG,
+	PTI_DEBUG,
+};
+
+struct ipc_dsp_hdr {
+	u16 mod_index_id:8;		/*!< DSP Command ID specific to tasks */
+	u16 pipe_id:8;	/*!< instance of the module in the pipeline */
+	u16 mod_id;		/*!< Pipe_id */
+	u16 cmd_id;		/*!< Module ID = lpe_algo_types_t */
+	u16 length;		/*!< Length of the payload only */
+} __packed;
+
+struct ipc_dsp_effects_info {
+	u16	cmd_id;
+	u16	length;
+	u16	sel_pos;
+	u16	sel_algo_id;
+	u16	cpu_load;       /* CPU load indication */
+	u16	memory_usage;   /* Data Memory usage */
+	u32	flags;         /* effect engine caps/requirements flags */
+} __packed;
+
+struct ipc_effect_dsp_hdr {
+	u16 mod_index_id:8;             /*!< DSP Command ID specific to tasks */
+	u16 pipe_id:8;  /*!< instance of the module in the pipeline */
+	u16 mod_id;             /*!< Pipe_id */
+} __packed;
+
+struct ipc_effect_payload {
+	struct ipc_effect_dsp_hdr dsp_hdr;
+	char *data;
+};
+
+union ipc_header_high {
+	struct {
+		u32  msg_id:8;	    /* Message ID - Max 256 Message Types */
+		u32  task_id:4;	    /* Task ID associated with this comand */
+		u32  drv_id:4;    /* Identifier for the driver to track*/
+		u32  rsvd1:8;	    /* Reserved */
+		u32  result:4;	    /* Reserved */
+		u32  res_rqd:1;	    /* Response rqd */
+		u32  large:1;	    /* Large Message if large = 1 */
+		u32  done:1;	    /* bit 30 - Done bit */
+		u32  busy:1;	    /* bit 31 - busy bit*/
+	} part;
+	u32 full;
+} __packed;
+
+/* IPC header */
+union ipc_header_mrfld {
+	struct {
+		u32 header_low_payload;
+		union ipc_header_high header_high;
+	} p;
+	u64 full;
+} __packed;
+
+/* CAUTION NOTE: All IPC message body must be multiple of 32 bits.*/
+
+/* IPC Header */
+union ipc_header {
+	struct {
+		u32  msg_id:8; /* Message ID - Max 256 Message Types */
+		u32  str_id:5;
+		u32  large:1;	/* Large Message if large = 1 */
+		u32  reserved:2;	/* Reserved for future use */
+		u32  data:14;	/* Ack/Info for msg, size of msg in Mailbox */
+		u32  done:1; /* bit 30 */
+		u32  busy:1; /* bit 31 */
+	} part;
+	u32 full;
+} __packed;
+
+/* Firmware build info */
+struct sst_fw_build_info {
+	unsigned char  date[16]; /* Firmware build date */
+	unsigned char  time[16]; /* Firmware build time */
+} __packed;
+
+/* Firmware Version info */
+struct snd_sst_fw_version {
+	u8 build;	/* build number*/
+	u8 minor;	/* minor number*/
+	u8 major;	/* major number*/
+	u8 type;	/* build type */
+};
+
+struct ipc_header_fw_init {
+	struct snd_sst_fw_version fw_version;/* Firmware version details */
+	struct sst_fw_build_info build_info;
+	u16 result;	/* Fw init result */
+	u8 module_id; /* Module ID in case of error */
+	u8 debug_info; /* Debug info from Module ID in case of fail */
+} __packed;
+
+struct snd_sst_tstamp {
+	u64 ring_buffer_counter;	/* PB/CP: Bytes copied from/to DDR. */
+	u64 hardware_counter;	    /* PB/CP: Bytes DMAed to/from SSP. */
+	u64 frames_decoded;
+	u64 bytes_decoded;
+	u64 bytes_copied;
+	u32 sampling_frequency;
+	u32 channel_peak[8];
+} __packed;
+
+/* SST to IA memory read debug message  */
+struct ipc_sst_ia_dbg_mem_rw  {
+	u16  num_bytes;/* Maximum of MAX_DBG_RW_BYTES */
+	u16  data_type;/* enum: dbg_mem_data_type */
+	u32  address;	/* Memory address of data memory of data_type */
+	u8	rw_bytes[MAX_DBG_RW_BYTES];/* Maximum of 64 bytes can be RW */
+} __packed;
+
+struct ipc_sst_ia_dbg_loop_back {
+	u16 num_dwords; /* Maximum of MAX_DBG_RW_BYTES */
+	u16 increment_val;/* Increments dwords by this value, 0- no increment */
+	u32 lpbk_dwords[MAX_LOOP_BACK_DWORDS];/* Maximum of 8 dwords loopback */
+} __packed;
+
+/* Stream type params struture for Alloc stream */
+struct snd_sst_str_type {
+	u8 codec_type;		/* Codec type */
+	u8 str_type;		/* 1 = voice 2 = music */
+	u8 operation;		/* Playback or Capture */
+	u8 protected_str;	/* 0=Non DRM, 1=DRM */
+	u8 time_slots;
+	u8 reserved;		/* Reserved */
+	u16 result;		/* Result used for acknowledgment */
+} __packed;
+
+/* Library info structure */
+struct module_info {
+	u32 lib_version;
+	u32 lib_type;/*TBD- KLOCKWORK u8 lib_type;*/
+	u32 media_type;
+	u8  lib_name[12];
+	u32 lib_caps;
+	unsigned char  b_date[16]; /* Lib build date */
+	unsigned char  b_time[16]; /* Lib build time */
+} __packed;
+
+/* Library slot info */
+struct lib_slot_info {
+	u8  slot_num; /* 1 or 2 */
+	u8  reserved1;
+	u16 reserved2;
+	u32 iram_size; /* slot size in IRAM */
+	u32 dram_size; /* slot size in DRAM */
+	u32 iram_offset; /* starting offset of slot in IRAM */
+	u32 dram_offset; /* starting offset of slot in DRAM */
+} __packed;
+
+struct snd_ppp_mixer_params {
+	__u32			type; /*Type of the parameter */
+	__u32			size;
+	__u32			input_stream_bitmap; /*Input stream Bit Map*/
+} __packed;
+
+struct snd_sst_lib_download {
+	struct module_info lib_info; /* library info type, capabilities etc */
+	struct lib_slot_info slot_info; /* slot info to be downloaded */
+	u32 mod_entry_pt;
+};
+
+struct snd_sst_lib_download_info {
+	struct snd_sst_lib_download dload_lib;
+	u16 result;	/* Result used for acknowledgment */
+	u8 pvt_id; /* Private ID */
+	u8 reserved;  /* for alignment */
+};
+
+struct snd_pcm_params {
+	u8 num_chan;	/* 1=Mono, 2=Stereo */
+	u8 pcm_wd_sz;	/* 16/24 - bit*/
+	u8 use_offload_path;	/* 0-PCM using period elpased & ALSA interfaces
+				   1-PCM stream via compressed interface  */
+	u8 reserved2;
+	u32 sfreq;    /* Sampling rate in Hz */
+	u8 channel_map[8];
+} __packed;
+
+/* MP3 Music Parameters Message */
+struct snd_mp3_params {
+	u8  num_chan;	/* 1=Mono, 2=Stereo	*/
+	u8  pcm_wd_sz; /* 16/24 - bit*/
+	u8  crc_check; /* crc_check - disable (0) or enable (1) */
+	u8  reserved1; /* unused*/
+};
+
+#define AAC_BIT_STREAM_ADTS		0
+#define AAC_BIT_STREAM_ADIF		1
+#define AAC_BIT_STREAM_RAW		2
+
+/* AAC Music Parameters Message */
+struct snd_aac_params {
+	u8 num_chan; /* 1=Mono, 2=Stereo*/
+	u8 pcm_wd_sz; /* 16/24 - bit*/
+	u8 bdownsample; /*SBR downsampling 0 - disable 1 -enabled AAC+ only */
+	u8 bs_format; /* input bit stream format adts=0, adif=1, raw=2 */
+	u32 externalsr; /*sampling rate of basic AAC raw bit stream*/
+	u8 sbr_signalling;/*disable/enable/set automode the SBR tool.AAC+*/
+	u8 reser1;
+	u16  reser2;
+};
+
+/* WMA Music Parameters Message */
+struct snd_wma_params {
+	u8  num_chan;	/* 1=Mono, 2=Stereo */
+	u8  pcm_wd_sz;	/* 16/24 - bit*/
+	u16 reserved1;
+	u32 brate;	/* Use the hard coded value. */
+	u32 sfreq;	/* Sampling freq eg. 8000, 441000, 48000 */
+	u32 channel_mask;  /* Channel Mask */
+	u16 format_tag;	/* Format Tag */
+	u16 block_align;	/* packet size */
+	u16 wma_encode_opt;/* Encoder option */
+	u8 op_align;	/* op align 0- 16 bit, 1- MSB, 2 LSB */
+	u8 reserved;	/* reserved */
+};
+
+/* Codec params struture */
+union  snd_sst_codec_params {
+	struct snd_pcm_params pcm_params;
+	struct snd_mp3_params mp3_params;
+	struct snd_aac_params aac_params;
+	struct snd_wma_params wma_params;
+};
+
+/* Address and size info of a frame buffer in DDR */
+struct sst_address_info {
+	__u32 addr; /* Address at IA */
+	__u32 size; /* Size of the buffer */
+} __packed;
+
+/* Additional params for Alloc struct*/
+struct snd_sst_alloc_params_ext {
+	__u16 sg_count;
+	__u16 reserved;
+	__u32 frag_size;	/*Number of samples after which period elapsed
+				  message is sent valid only if path  = 0*/
+	struct sst_address_info  ring_buf_info[8];
+};
+
+struct snd_sst_stream_params {
+	union snd_sst_codec_params uc;
+} __packed;
+
+struct snd_sst_params {
+	u32 result;
+	u32 stream_id;
+	u8 codec;
+	u8 ops;
+	u8 stream_type;
+	u8 device_type;
+	u8 task;
+	struct snd_sst_stream_params sparams;
+	struct snd_sst_alloc_params_ext aparams;
+};
+
+struct snd_sst_alloc_mrfld {
+	u16 codec_type;
+	u8 operation;
+	u8 sg_count;
+	struct sst_address_info ring_buf_info[8];
+	u32 frag_size;
+	u32 ts;
+	struct snd_sst_stream_params codec_params;
+} __packed;
+
+/* Alloc stream params structure */
+struct snd_sst_alloc_params {
+	struct snd_sst_str_type str_type;
+	struct snd_sst_stream_params stream_params;
+	struct snd_sst_alloc_params_ext alloc_params;
+} __packed;
+
+/* Alloc stream response message */
+struct snd_sst_alloc_response {
+	struct snd_sst_str_type str_type; /* Stream type for allocation */
+	struct snd_sst_lib_download lib_dnld; /* Valid only for codec dnld */
+};
+
+/* Drop response */
+struct snd_sst_drop_response {
+	u32 result;
+	u32 bytes;
+};
+
+struct snd_sst_async_msg {
+	u32 msg_id; /* Async msg id */
+	u32 payload[0];
+};
+
+struct snd_sst_async_err_msg {
+	u32 fw_resp; /* Firmware Result */
+	u32 lib_resp; /*Library result */
+} __packed;
+
+struct snd_sst_vol {
+	u32	stream_id;
+	s32	volume;
+	u32	ramp_duration;
+	u32	ramp_type;		/* Ramp type, default=0 */
+};
+
+/* Gain library parameters for mrfld
+ * based on DSP command spec v0.82
+ */
+struct snd_sst_gain_v2 {
+	u16 gain_cell_num;  /* num of gain cells to modify*/
+	u8 cell_nbr_idx; /* instance index*/
+	u8 cell_path_idx; /* pipe-id */
+	u16 module_id; /*module id */
+	u16 left_cell_gain; /* left gain value in dB*/
+	u16 right_cell_gain; /* right gain value in dB*/
+	u16 gain_time_const; /* gain time constant*/
+} __packed;
+
+struct snd_sst_mute {
+	u32	stream_id;
+	u32	mute;
+};
+
+struct snd_sst_runtime_params {
+	u8 type;
+	u8 str_id;
+	u8 size;
+	u8 rsvd;
+	void *addr;
+} __packed;
+
+enum stream_param_type {
+	SST_SET_TIME_SLOT = 0,
+	SST_SET_CHANNEL_INFO = 1,
+	OTHERS = 2, /*reserved for future params*/
+};
+
+/* CSV Voice call routing structure */
+struct snd_sst_control_routing {
+	u8 control; /* 0=start, 1=Stop */
+	u8 reserved[3];	/* Reserved- for 32 bit alignment */
+};
+
+struct ipc_post {
+	struct list_head node;
+	union ipc_header header; /* driver specific */
+	bool is_large;
+	bool is_process_reply;
+	union ipc_header_mrfld mrfld_header;
+	char *mailbox_data;
+};
+
+struct snd_sst_ctxt_params {
+	u32 address; /* Physical Address in DDR where the context is stored */
+	u32 size; /* size of the context */
+};
+
+struct snd_sst_lpe_log_params {
+	u8 dbg_type;
+	u8 module_id;
+	u8 log_level;
+	u8 reserved;
+} __packed;
+
+enum snd_sst_bytes_type {
+	SND_SST_BYTES_SET = 0x1,
+	SND_SST_BYTES_GET = 0x2,
+};
+
+struct snd_sst_bytes_v2 {
+	u8 type;
+	u8 ipc_msg;
+	u8 block;
+	u8 task_id;
+	u8 pipe_id;
+	u8 rsvd;
+	u16 len;
+	char bytes[0];
+};
+
+#define MAX_VTSV_FILES 2
+struct snd_sst_vtsv_info {
+	struct sst_address_info vfiles[MAX_VTSV_FILES];
+} __packed;
+
+#endif /* __PLATFORMDRV_IPC_V2_H__ */
diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 02abd19..ca58f4c 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -105,9 +105,11 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 	/* construct fw structure for this*/
 	memset(&str_params, 0, sizeof(str_params));
 
-	str_params.ops = STREAM_OPS_PLAYBACK;
-	str_params.stream_type = SST_STREAM_TYPE_MUSIC;
-	str_params.device_type = SND_SST_DEVICE_COMPRESS;
+	/* fill the device type and stream id to pass to SST driver */
+	retval = sst_fill_stream_params(cstream, ctx, &str_params, true);
+	pr_debug("compr_set_params: fill stream params ret_val = 0x%x\n", retval);
+	if (retval < 0)
+		return retval;
 
 	switch (params->codec.id) {
 	case SND_AUDIOCODEC_MP3: {
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index f4b85e5..836d9a6 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -28,6 +28,7 @@
 #include <sound/soc.h>
 #include <sound/compress_driver.h>
 #include "sst-mfld-platform.h"
+#include "platform-libs/controls_v2.h"
 
 struct sst_device *sst;
 static DEFINE_MUTEX(sst_lock);
@@ -92,6 +93,39 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.fifo_size = SST_FIFO_SIZE,
 };
 
+static struct sst_dev_stream_map dpcm_strm_map[] = {
+	{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, /* Reserved, not in use */
+	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA1_IN, SST_TASK_ID_MEDIA, SST_DEV_MAP_IN_USE},
+	{MERR_DPCM_COMPR, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA0_IN, SST_TASK_ID_MEDIA, SST_DEV_MAP_IN_USE},
+	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, SST_DEV_MAP_IN_USE},
+};
+
+static int sst_platform_media_set_tdm_slot(struct snd_soc_dai *dai,
+			unsigned int tx_mask, unsigned int rx_mask,
+			int slots, int slot_width) {
+	struct snd_sst_runtime_params params_data;
+	int channels = slots;
+
+	/* registering with SST driver to get access to SST APIs to use */
+	if (!sst_dsp) {
+		pr_err("sst: DSP not registered\n");
+		return -EIO;
+	}
+	params_data.type = SST_SET_CHANNEL_INFO;
+	params_data.str_id = SND_SST_DEVICE_IHF;
+	params_data.size = sizeof(channels);
+	params_data.addr = &channels;
+	return sst_dsp->ops->set_generic_params(SST_SET_RUNTIME_PARAMS,
+							(void *)&params_data);
+}
+
+static int sst_media_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+
+	pr_debug("%s: enter, mute=%d dai-name=%s dir=%d\n", __func__, mute, dai->name, stream);
+
+	return sst_send_pipe_gains(dai, stream, mute);
+}
 
 /* helper functions */
 void sst_set_stream_status(struct sst_runtime_stream *stream,
@@ -114,45 +148,163 @@ static inline int sst_get_stream_status(struct sst_runtime_stream *stream)
 	return state;
 }
 
+static void sst_fill_alloc_params(struct snd_pcm_substream *substream,
+				struct snd_sst_alloc_params_ext *alloc_param)
+{
+	unsigned int channels;
+	snd_pcm_uframes_t period_size;
+	ssize_t periodbytes;
+	ssize_t buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+	u32 buffer_addr = virt_to_phys(substream->dma_buffer.area);
+
+	channels = substream->runtime->channels;
+	period_size = substream->runtime->period_size;
+	periodbytes = samples_to_bytes(substream->runtime, period_size);
+	alloc_param->ring_buf_info[0].addr = buffer_addr;
+	alloc_param->ring_buf_info[0].size = buffer_bytes;
+	alloc_param->sg_count = 1;
+	alloc_param->reserved = 0;
+	alloc_param->frag_size = periodbytes * channels;
+
+	pr_debug("period_size = %d\n", alloc_param->frag_size);
+	pr_debug("ring_buf_addr = 0x%x\n", alloc_param->ring_buf_info[0].addr);
+}
 static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
-				struct sst_pcm_params *param)
-{
-
-	param->num_chan = (u8) substream->runtime->channels;
-	param->pcm_wd_sz = substream->runtime->sample_bits;
-	param->reserved = 0;
-	param->sfreq = substream->runtime->rate;
-	param->ring_buffer_size = snd_pcm_lib_buffer_bytes(substream);
-	param->period_count = substream->runtime->period_size;
-	param->ring_buffer_addr = virt_to_phys(substream->dma_buffer.area);
-	pr_debug("period_cnt = %d\n", param->period_count);
-	pr_debug("sfreq= %d, wd_sz = %d\n", param->sfreq, param->pcm_wd_sz);
+				struct snd_sst_stream_params *param)
+{
+	param->uc.pcm_params.num_chan = (u8) substream->runtime->channels;
+	param->uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param->uc.pcm_params.sfreq = substream->runtime->rate;
+
+	/* PCM stream via ALSA interface */
+	param->uc.pcm_params.use_offload_path = 0;
+	param->uc.pcm_params.reserved2 = 0;
+	memset(param->uc.pcm_params.channel_map, 0, sizeof(u8));
+	pr_debug("sfreq= %d, wd_sz = %d\n",
+	param->uc.pcm_params.sfreq, param->uc.pcm_params.pcm_wd_sz);
+
+}
+
+static int sst_get_stream_mapping(int dev, int sdev, int dir,
+	struct sst_dev_stream_map *map, int size, u8 pipe_id,
+	const struct sst_lowlatency_deepbuff *ll_db)
+{
+	int index;
+
+	if (map == NULL)
+		return -EINVAL;
+
+	pr_debug("dev %d sdev %d dir %d\n", dev, sdev, dir);
+
+	/* index 0 is not used in stream map */
+	for (index = 1; index < size; index++) {
+		if ((map[index].dev_num == dev) &&
+		    (map[index].subdev_num == sdev) &&
+		    (map[index].direction == dir)) {
+			if (map[index].status == SST_DEV_MAP_IN_USE) {
+				return index;
+			} else if (map[index].status == SST_DEV_MAP_FREE) {
+				map[index].status = SST_DEV_MAP_IN_USE;
+
+				pr_debug("%s: pipe_id 0%x index %d", __func__,
+						map[index].device_id, index);
+
+				return index;
+			}
+		}
+	}
+	return 0;
 }
 
-static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
+int sst_fill_stream_params(void *substream,
+	const struct sst_data *ctx, struct snd_sst_params *str_params, bool is_compress)
+{
+	int map_size;
+	int index;
+	struct sst_dev_stream_map *map;
+	struct snd_pcm_substream *pstream = NULL;
+	struct snd_compr_stream *cstream = NULL;
+
+	map = ctx->pdata->pdev_strm_map;
+	map_size = ctx->pdata->strm_map_size;
+
+	if (is_compress == true)
+		cstream = (struct snd_compr_stream *)substream;
+	else
+		pstream = (struct snd_pcm_substream *)substream;
+
+	str_params->stream_type = SST_STREAM_TYPE_MUSIC;
+
+	/* For pcm streams */
+	if (pstream) {
+		index = sst_get_stream_mapping(pstream->pcm->device,
+					  pstream->number, pstream->stream,
+					  map, map_size, ctx->pipe_id, &ctx->ll_db);
+		if (index <= 0)
+			return -EINVAL;
+
+		str_params->stream_id = index;
+		str_params->device_type = map[index].device_id;
+		str_params->task = map[index].task_id;
+
+		pr_debug("str_id = %d, device_type = 0x%x, task = %d",
+			 str_params->stream_id, str_params->device_type,
+			 str_params->task);
+
+		str_params->ops = (u8)pstream->stream;
+	}
+
+	if (cstream) {
+		/* FIXME: Add support for subdevice number in
+		 * snd_compr_stream */
+		index = sst_get_stream_mapping(cstream->device->device,
+					       0, cstream->direction,
+					       map, map_size, ctx->pipe_id, &ctx->ll_db);
+		if (index <= 0)
+			return -EINVAL;
+		str_params->stream_id = index;
+		str_params->device_type = map[index].device_id;
+		str_params->task = map[index].task_id;
+		pr_debug("compress str_id = %d, device_type = 0x%x, task = %d",
+			 str_params->stream_id, str_params->device_type,
+			 str_params->task);
+
+		str_params->ops = (u8)cstream->direction;
+	}
+	return 0;
+}
+
+#define CALC_PERIODTIME(period_size, rate) (((period_size) * 1000) / (rate))
+
+static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
+		struct snd_soc_platform *platform)
 {
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
-	struct sst_pcm_params param = {0};
-	struct sst_stream_params str_params = {0};
-	int ret_val;
+	struct snd_sst_stream_params param = {{{0,},},};
+	struct snd_sst_params str_params = {0};
+	struct snd_sst_alloc_params_ext alloc_params = {0};
+	int ret_val = 0;
+	struct sst_data *ctx = snd_soc_platform_get_drvdata(platform);
 
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
 	substream->runtime->dma_area = substream->dma_buffer.area;
 	str_params.sparams = param;
-	str_params.codec =  param.codec;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		str_params.ops = STREAM_OPS_PLAYBACK;
-		str_params.device_type = substream->pcm->device + 1;
-		pr_debug("Playbck stream,Device %d\n",
-					substream->pcm->device);
-	} else {
-		str_params.ops = STREAM_OPS_CAPTURE;
-		str_params.device_type = SND_SST_DEVICE_CAPTURE;
-		pr_debug("Capture stream,Device %d\n",
-					substream->pcm->device);
-	}
+	str_params.aparams = alloc_params;
+	str_params.codec = SST_CODEC_TYPE_PCM;
+
+	ctx->ll_db.period_time = CALC_PERIODTIME(substream->runtime->period_size,
+					substream->runtime->rate);
+
+	/* fill the device type and stream id to pass to SST driver */
+	ret_val = sst_fill_stream_params(substream, ctx, &str_params, false);
+	pr_debug("platform prepare: fill stream params ret_val = 0x%x\n", ret_val);
+	if (ret_val < 0)
+		return ret_val;
+
+	stream->stream_info.str_id = str_params.stream_id;
+
 	ret_val = stream->ops->open(&str_params);
 	pr_debug("SST_SND_PLAY/CAPTURE ret_val = %x\n", ret_val);
 	if (ret_val < 0)
@@ -242,25 +394,55 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
-	return 0;
+static void sst_free_stream_in_use(struct sst_dev_stream_map *map, int str_id)
+{
+	if (map[str_id].dev_num == MERR_DPCM_AUDIO) {
+		/* Do nothing in capture for audio device */
+		if ((map[str_id].dev_num == MERR_DPCM_AUDIO) &&
+				(map[str_id].direction == SNDRV_PCM_STREAM_CAPTURE))
+			return;
+		if ((map[str_id].task_id == SST_TASK_ID_MEDIA) &&
+				(map[str_id].status == SST_DEV_MAP_IN_USE)) {
+			pr_debug("str_id %d device_id 0x%x\n", str_id, map[str_id].device_id);
+			map[str_id].status = SST_DEV_MAP_FREE;
+			map[str_id].device_id = PIPE_RSVD;
+		}
+	}
+	return;
 }
 
 static int sst_platform_close(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
+	struct sst_data *ctx = snd_soc_platform_get_drvdata(dai->platform);
 
 	pr_debug("sst_platform_close called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->ops->close(str_id);
+	sst_free_stream_in_use(ctx->pdata->pdev_strm_map, str_id);
 	module_put(sst->dev->driver->owner);
 	kfree(stream);
-	return ret_val;
+static inline unsigned int get_current_pipe_id(struct snd_soc_platform *platform,
+					       struct snd_pcm_substream *substream)
+{
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_dev_stream_map *map = sst->pdata->pdev_strm_map;
+	struct sst_runtime_stream *stream =
+			substream->runtime->private_data;
+	u32 str_id = stream->stream_info.str_id;
+	unsigned int pipe_id;
+	pipe_id = map[str_id].device_id;
+
+	pr_debug("%s: got pipe_id = %#x for str_id = %d\n",
+		 __func__, pipe_id, str_id);
+	return pipe_id;
 }
 
-static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
+static int sst_media_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
@@ -274,8 +456,8 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 		return ret_val;
 	}
 
-	ret_val = sst_platform_alloc_stream(substream);
-	if (ret_val < 0)
+	ret_val = sst_platform_alloc_stream(substream, dai->platform);
+	if (ret_val <= 0)
 		return ret_val;
 	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
 			"%d", stream->stream_info.str_id);
@@ -287,18 +469,78 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
+static int sst_media_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	pr_debug("%s\n", __func__);
+
+	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
+	return 0;
+}
+
+static int sst_media_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int sst_enable_ssp(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	pr_debug("In %s :dai=%s pb=%d cp= %d dai_active=%d id=%d\n", __func__,
+		dai->name, dai->playback_active, dai->capture_active, dai->active,  dai->id);
+	if (!dai->active) {
+		sst_handle_vb_timer(dai->platform, true);
+		send_ssp_cmd(dai->platform, dai->name, 1);
+	}
+	return 0;
+}
+
+static void sst_disable_ssp(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	pr_debug("In %s :dai=%s pb=%d cp= %d dai_active=%d id=%d\n", __func__,
+		dai->name, dai->playback_active, dai->capture_active, dai->active, dai->id);
+	if (!dai->active) {
+		send_ssp_cmd(dai->platform, dai->name, 0);
+		sst_handle_vb_timer(dai->platform, false);
+	}
+}
+
+static struct snd_soc_dai_ops sst_media_dai_ops = {
+	.startup = sst_media_open,
+	.shutdown = sst_media_close,
+	.prepare = sst_media_prepare,
+	.hw_params = sst_media_hw_params,
+	.hw_free = sst_media_hw_free,
+	.set_tdm_slot = sst_platform_media_set_tdm_slot,
+	.mute_stream = sst_media_digital_mute,
+};
+
+static struct snd_soc_dai_ops sst_compr_dai_ops = {
+	.mute_stream = sst_media_digital_mute,
+};
+
+static struct snd_soc_dai_ops sst_be_dai_ops = {
+	.startup = sst_enable_ssp,
+	.shutdown = sst_disable_ssp,
+};
+
 static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
 	.name = "media-cpu-dai",
+	.ops = &sst_media_dai_ops,
 	.playback = {
-		.stream_name = "Media Playback",
+		.stream_name = "Headset Playback",
 		.channels_min = SST_STEREO,
 		.channels_max = SST_STEREO,
 		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
-		.stream_name = "Media Capture",
+		.stream_name = "Headset Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
@@ -308,6 +550,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
 	.name = "compress-cpu-dai",
 	.compress_dai = 1,
+	.ops = &sst_compr_dai_ops,
 	.playback = {
 		.stream_name = "Compress Playback",
 		.channels_min = SST_STEREO,
@@ -370,6 +613,27 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 },
 };
 
+static int sst_platform_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+	pr_debug("sst_platform_open called:%s\n", dai_link->cpu_dai_name);
+	if (substream->pcm->internal)
+		return 0;
+	runtime = substream->runtime;
+	runtime->hw = sst_platform_pcm_hw;
+	return 0;
+}
+
+static int sst_platform_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	pr_debug("sst_platform_close called:%s\n", dai_link->cpu_dai_name);
+	return 0;
+}
 static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
@@ -377,6 +641,8 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	struct sst_runtime_stream *stream;
 	int str_cmd, status;
 
+	if (substream->pcm->internal)
+		return 0;
 	pr_debug("sst_platform_pcm_trigger called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
@@ -431,32 +697,16 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
 	}
-	return stream->stream_info.buffer_ptr;
-}
-
-static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-
-	return 0;
-}
-
-static int sst_platform_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
+	substream->runtime->delay = str_info->pcm_delay;
+	return str_info->buffer_ptr;
 }
 
 static struct snd_pcm_ops sst_platform_ops = {
 	.open = sst_platform_open,
 	.close = sst_platform_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.prepare = sst_platform_pcm_prepare,
 	.trigger = sst_platform_pcm_trigger,
 	.pointer = sst_platform_pcm_pointer,
-	.hw_params = sst_platform_pcm_hw_params,
-	.hw_free = sst_platform_pcm_hw_free,
 };
 
 static void sst_pcm_free(struct snd_pcm *pcm)
@@ -485,11 +735,21 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
-static struct snd_soc_platform_driver sst_soc_platform_drv = {
+static int sst_soc_probe(struct snd_soc_platform *platform)
+{
+	pr_debug("Enter:%s\n", __func__);
+	return sst_dsp_init_v2_dpcm(platform);
+}
+
+
+static struct snd_soc_platform_driver sst_soc_platform_drv  = {
+	.probe		= sst_soc_probe,
 	.ops		= &sst_platform_ops,
 	.compr_ops	= &sst_platform_compr_ops,
 	.pcm_new	= sst_pcm_new,
 	.pcm_free	= sst_pcm_free,
+	.read		= sst_soc_read,
+	.write		= sst_soc_write,
 };
 
 static const struct snd_soc_component_driver sst_component = {
@@ -499,10 +759,24 @@ static const struct snd_soc_component_driver sst_component = {
 
 static int sst_platform_probe(struct platform_device *pdev)
 {
+	struct sst_data *sst;
 	int ret;
+	struct sst_platform_data *pdata = pdev->dev.platform_data;
 
 	pr_debug("sst_platform_probe called\n");
-	sst = NULL;
+	sst = devm_kzalloc(&pdev->dev, sizeof(*sst), GFP_KERNEL);
+	if (sst == NULL) {
+		pr_err("kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	pdata->pdev_strm_map = dpcm_strm_map;
+	pdata->strm_map_size = ARRAY_SIZE(dpcm_strm_map);
+	sst_pdev = &pdev->dev;
+	sst->pdata = pdata;
+	mutex_init(&sst->lock);
+	dev_set_drvdata(&pdev->dev, sst);
+
 	ret = snd_soc_register_platform(&pdev->dev, &sst_soc_platform_drv);
 	if (ret) {
 		pr_err("registering soc platform failed\n");
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 6c5e7dc..67b375b 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -126,6 +126,7 @@ struct compress_sst_ops {
 struct sst_ops {
 	int (*open) (struct sst_stream_params *str_param);
 	int (*device_control) (int cmd, void *arg);
+	int (*set_generic_params) (enum sst_controls cmd, void *arg);
 	int (*close) (unsigned int str_id);
 };
 
@@ -143,6 +144,7 @@ struct sst_device {
 	char *name;
 	struct device *dev;
 	struct sst_ops *ops;
+	struct platform_device *pdev;
 	struct compress_sst_ops *compr_ops;
 };
 
-- 
1.7.0.4
