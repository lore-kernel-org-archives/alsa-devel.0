From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/19] ASoC: Intel: add mrfld DSP registers
Date: Fri, 13 Jun 2014 18:03:59 +0530
Message-ID: <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 576142619EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:05 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The add the registers space for MRFLD DSP. The initialization is done in
soc_probe of the platform. This will be used in subsequent patches to add
platform widgets

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Makefile                |    3 +-
 sound/soc/intel/sst-atom-controls.c     |   90 +++++++++
 sound/soc/intel/sst-atom-controls.h     |  318 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c |   10 +-
 sound/soc/intel/sst-mfld-platform.h     |   10 +
 5 files changed, 429 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/intel/sst-atom-controls.c

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 4bfca79..9480b5d 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -2,7 +2,8 @@
 snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o sst-mfld-platform-compress.o
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
+	sst-mfld-platform-compress.o sst-atom-controls.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
new file mode 100644
index 0000000..f710888
--- /dev/null
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -0,0 +1,90 @@
+/*
+ *  sst-atom-controls.c - Intel MID Platform driver DPCM ALSA controls for Mrfld
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
+#include "sst-mfld-platform.h"
+#include "sst-atom-controls.h"
+
+unsigned int sst_soc_read(struct snd_soc_platform *platform,
+			unsigned int reg)
+{
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+
+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, drv->widget[reg]);
+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
+	return drv->widget[reg];
+}
+
+int sst_soc_write(struct snd_soc_platform *platform,
+		  unsigned int reg, unsigned int val)
+{
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+
+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, val);
+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
+	drv->widget[reg] = val;
+	return 0;
+}
+
+unsigned int sst_reg_read(struct sst_data *drv, unsigned int reg,
+			  unsigned int shift, unsigned int max)
+{
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	return (drv->widget[reg] >> shift) & mask;
+}
+
+unsigned int sst_reg_write(struct sst_data *drv, unsigned int reg,
+			   unsigned int shift, unsigned int max, unsigned int val)
+{
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	val &= mask;
+	val <<= shift;
+	drv->widget[reg] &= ~(mask << shift);
+	drv->widget[reg] |= val;
+	return val;
+}
+
+
+int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
+{
+	int ret = 0;
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+
+	drv->byte_stream = devm_kzalloc(platform->dev,
+					SST_MAX_BIN_BYTES, GFP_KERNEL);
+	if (!drv->byte_stream) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+	drv->widget = devm_kzalloc(platform->dev,
+				   SST_NUM_WIDGETS * sizeof(*drv->widget),
+				   GFP_KERNEL);
+	if (!drv->widget) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	return ret;
+}
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
index 14063ab..8c35946 100644
--- a/sound/soc/intel/sst-atom-controls.h
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -1,4 +1,6 @@
 /*
+ *  controls_v2.h - Intel MID Platform driver header file
+ *
  *  Copyright (C) 2013-14 Intel Corp
  *  Author: Ramesh Babu <ramesh.babu.koul@intel.com>
  *  	Omair M Abdullah <omair.m.abdullah@intel.com>
@@ -25,6 +27,322 @@ enum {
 	MERR_DPCM_AUDIO = 0,
 	MERR_DPCM_COMPR,
 };
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
+#define SST_MIX_CODEC0		SST_MIX(2)
+#define SST_MIX_CODEC1		SST_MIX(3)
+#define SST_MIX_LOOP0		SST_MIX(4)
+#define SST_MIX_LOOP1		SST_MIX(5)
+#define SST_MIX_LOOP2		SST_MIX(6)
+#define SST_MIX_VOIP		SST_MIX(12)
+#define SST_MIX_PCM0		SST_MIX(13)
+#define SST_MIX_PCM1		SST_MIX(14)
+#define SST_MIX_PCM2		SST_MIX(15)
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
+/* in each mixer register we will define one bit for each input */
+#define SST_MIX_IP(x)		(x)
+
+#define SST_IP_CODEC0		SST_MIX_IP(2)
+#define SST_IP_CODEC1		SST_MIX_IP(3)
+#define SST_IP_LOOP0		SST_MIX_IP(4)
+#define SST_IP_LOOP1		SST_MIX_IP(5)
+#define SST_IP_LOOP2		SST_MIX_IP(6)
+#define SST_IP_PROBE		SST_MIX_IP(7)
+#define SST_IP_VOIP		SST_MIX_IP(12)
+#define SST_IP_PCM0		SST_MIX_IP(13)
+#define SST_IP_PCM1		SST_MIX_IP(14)
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
+	SST_PATH_INDEX_CODEC_OUT0               = (0x02 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_OUT1               = (0x03 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SPROT_LOOP_OUT           = (0x04 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP1_OUT          = (0x05 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP2_OUT          = (0x06 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_VOIP_OUT                 = (0x0C << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM0_OUT                 = (0x0D << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM1_OUT                 = (0x0E << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM2_OUT                 = (0x0F << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA0_OUT               = (0x12 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA1_OUT               = (0x13 << SST_PATH_ID_SHIFT),
+
+
+	/* Start of input paths */
+	SST_PATH_INDEX_CODEC_IN0                = (0x82 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_CODEC_IN1                = (0x83 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_SPROT_LOOP_IN            = (0x84 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP1_IN           = (0x85 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA_LOOP2_IN           = (0x86 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_VOIP_IN                  = (0x8C << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_PCM0_IN                  = (0x8D << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_PCM1_IN                  = (0x8E << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA0_IN                = (0x8F << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA1_IN                = (0x90 << SST_PATH_ID_SHIFT),
+	SST_PATH_INDEX_MEDIA2_IN                = (0x91 << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_MEDIA3_IN		= (0x9C << SST_PATH_ID_SHIFT),
+
+	SST_PATH_INDEX_RESERVED                 = (0xFF << SST_PATH_ID_SHIFT),
+};
+
+/*
+ * path IDs
+ */
+enum sst_swm_inputs {
+	SST_SWM_IN_CODEC0	= (SST_PATH_INDEX_CODEC_IN0	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_CODEC1	= (SST_PATH_INDEX_CODEC_IN1	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA_LOOP1	= (SST_PATH_INDEX_MEDIA_LOOP1_IN  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA_LOOP2	= (SST_PATH_INDEX_MEDIA_LOOP2_IN  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_VOIP		= (SST_PATH_INDEX_VOIP_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_PCM0		= (SST_PATH_INDEX_PCM0_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_PCM1		= (SST_PATH_INDEX_PCM1_IN	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_IN_MEDIA0	= (SST_PATH_INDEX_MEDIA0_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_MEDIA1	= (SST_PATH_INDEX_MEDIA1_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_MEDIA2	= (SST_PATH_INDEX_MEDIA2_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_MEDIA3	= (SST_PATH_INDEX_MEDIA3_IN	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_IN_END		= (SST_PATH_INDEX_RESERVED	  | SST_DEFAULT_CELL_NBR)
+};
+
+/*
+ * path IDs
+ */
+enum sst_swm_outputs {
+	SST_SWM_OUT_CODEC0	= (SST_PATH_INDEX_CODEC_OUT0	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_CODEC1	= (SST_PATH_INDEX_CODEC_OUT1	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_SPROT_LOOP	= (SST_PATH_INDEX_SPROT_LOOP_OUT  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA_LOOP1	= (SST_PATH_INDEX_MEDIA_LOOP1_OUT | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA_LOOP2	= (SST_PATH_INDEX_MEDIA_LOOP2_OUT | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_VOIP	= (SST_PATH_INDEX_VOIP_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM0	= (SST_PATH_INDEX_PCM0_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM1	= (SST_PATH_INDEX_PCM1_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_PCM2	= (SST_PATH_INDEX_PCM2_OUT	  | SST_DEFAULT_CELL_NBR),
+	SST_SWM_OUT_MEDIA0	= (SST_PATH_INDEX_MEDIA0_OUT	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
+	SST_SWM_OUT_MEDIA1	= (SST_PATH_INDEX_MEDIA1_OUT	  | SST_DEFAULT_CELL_NBR), /* Part of Media Mixer */
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
+	SST_TASK_MMX,
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
+	SST_GAIN_INDEX_CODEC_OUT0,
+	SST_GAIN_INDEX_CODEC_OUT1,
+	SST_GAIN_INDEX_CODEC_IN0,
+	SST_GAIN_INDEX_CODEC_IN1,
+
+	SST_GAIN_INDEX_SPROT_LOOP_OUT,
+	SST_GAIN_INDEX_MEDIA_LOOP1_OUT,
+	SST_GAIN_INDEX_MEDIA_LOOP2_OUT,
+
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
+	SBA_VB_START		= 85,
+	SBA_SET_SWM		= 114,
+	SBA_SET_MDRP            = 116,
+	SBA_HW_SET_SSP		= 117,
+	SBA_SET_MEDIA_LOOP_MAP	= 118,
+	SBA_SET_MEDIA_PATH	= 119,
+	MMX_SET_MEDIA_PATH	= 119,
+	SBA_VB_LPRO             = 126,
+	SBA_VB_SET_FIR          = 128,
+	SBA_VB_SET_IIR          = 129,
+	SBA_SET_SSP_SLOT_MAP	= 130,
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
 
 #endif
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 3fcd35c..8df5aca 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -609,11 +609,19 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
-static struct snd_soc_platform_driver sst_soc_platform_drv = {
+static int sst_soc_probe(struct snd_soc_platform *platform)
+{
+	return sst_dsp_init_v2_dpcm(platform);
+}
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
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 9dc962f..dc60f86 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -149,6 +149,14 @@ struct sst_device {
 };
 
 struct sst_data;
+
+int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform);
+unsigned int sst_soc_read(struct snd_soc_platform *platform, unsigned int reg);
+int sst_soc_write(struct snd_soc_platform *platform, unsigned int reg, unsigned int val);
+unsigned int sst_reg_read(struct sst_data *sst, unsigned int reg,
+			  unsigned int shift, unsigned int max);
+unsigned int sst_reg_write(struct sst_data *sst, unsigned int reg,
+			   unsigned int shift, unsigned int max, unsigned int val);
 void sst_set_stream_status(struct sst_runtime_stream *stream, int state);
 int sst_fill_stream_params(void *substream, const struct sst_data *ctx,
 			   struct snd_sst_params *str_params, bool is_compress);
@@ -163,6 +171,8 @@ struct sst_algo_int_control_v2 {
 struct sst_data {
 	struct platform_device *pdev;
 	struct sst_platform_data *pdata;
+	u32 *widget;
+	char *byte_stream;
 	struct mutex lock;
 };
 int sst_register_dsp(struct sst_device *sst);
-- 
1.7.0.4
