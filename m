From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 03/10] ALSA: add AXD Audio Processing IP alsa driver
Date: Mon, 24 Aug 2015 13:39:12 +0100
Message-ID: <1440419959-14315-4-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

AXD is Audio Processing IP by Imagination Technologies that can
decode multiple file formats and play them back.
We use alsa compress offload API to represent our audio driver.

This patch adds defs and initialisation files.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/img/axd/axd_api.h    | 649 +++++++++++++++++++++++++++++++++++
 sound/soc/img/axd/axd_module.c | 742 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/img/axd/axd_module.h |  83 +++++
 3 files changed, 1474 insertions(+)
 create mode 100644 sound/soc/img/axd/axd_api.h
 create mode 100644 sound/soc/img/axd/axd_module.c
 create mode 100644 sound/soc/img/axd/axd_module.h

diff --git a/sound/soc/img/axd/axd_api.h b/sound/soc/img/axd/axd_api.h
new file mode 100644
index 000000000000..316b7bcf8626
--- /dev/null
+++ b/sound/soc/img/axd/axd_api.h
@@ -0,0 +1,649 @@
+/*
+ *  Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *  Main API to the AXD for access from the host.
+ */
+#ifndef AXD_API_H_
+#define AXD_API_H_
+
+#include <linux/types.h>
+
+
+#define THREAD_COUNT 4
+#define AXD_MAX_PIPES 3
+
+
+#define AXD_DESCRIPTOR_READY_BIT	0x80000000
+#define AXD_DESCRIPTOR_INUSE_BIT	0x40000000
+#define AXD_DESCRIPTOR_EOS_BIT		0x20000000
+#define AXD_DESCRIPTOR_SIZE_MASK	0x0000FFFF
+
+struct axd_buffer_desc {
+	uint32_t status_size;
+	uint32_t data_ptr;
+	uint32_t pts_high;
+	uint32_t pts_low;
+};
+
+#define AXD_INPUT_DESCRIPTORS 10
+struct axd_input {
+	struct axd_buffer_desc descriptors[AXD_INPUT_DESCRIPTORS];
+};
+
+#define AXD_OUTPUT_DESCRIPTORS 10
+struct axd_output {
+	struct axd_buffer_desc descriptors[AXD_OUTPUT_DESCRIPTORS];
+};
+
+struct axd_ctrlbuf_item {
+	uint32_t reg;
+	uint32_t val;
+};
+
+/**
+ * struct axd_memory_map - axd memory mapped region
+ * @kick:		kick register holds the type of kick to process
+ * @int_status:		interrupt status register
+ * @int_mask:		interrupt mask register
+ * @in_kick_count:	array of number of input kicks to process
+ * @in_int_count:	array of number of input interrupts to process
+ * @out_kick_count:	array of number of output kicks to process
+ * @out_int_count:	array of number of output interrupts to process
+ * @control_command:	this register contains the command type to process
+ * @control_data:	this register contains the command data to process
+ * @pc:			starting pc value of each hardware thread
+ * @error:		last error value
+ * @gic_irq:		which gic irqs to use for host and axd in this format:
+ *			host_gic_irq[31:16]:axd_gic_irq[15:0]
+ * @freq:		count/compare clock frequency in MHz
+ * @input:		array of struct axd_input which holds the descriptors
+ * @output:		array of struct axd_output which holds the descriptors
+ * @ctrlbuf_size:	size of control buffer used to group multiple
+ *			configurations changes into a single request
+ * @ctrlbuf_ctrl:	position of ctrlbuf requests
+ * @ctrlbuf:		the actual control buffer used to group requests
+ *			size of which is defined by the firmware
+ */
+struct axd_memory_map {
+	uint32_t kick;
+	uint32_t int_status;
+	uint32_t int_mask;
+	uint32_t in_kick_count[AXD_MAX_PIPES];
+	uint32_t in_int_count[AXD_MAX_PIPES];
+	uint32_t out_kick_count[AXD_MAX_PIPES];
+	uint32_t out_int_count[AXD_MAX_PIPES];
+	uint32_t control_command;
+	uint32_t control_data;
+	uint32_t pc[THREAD_COUNT];
+	uint32_t error;
+	uint32_t gic_irq;
+	uint32_t freq;
+	uint32_t reserved01[0x04];
+	struct axd_input input[AXD_MAX_PIPES];
+	struct axd_output output[AXD_MAX_PIPES];
+	uint32_t reserved02[40];
+	uint32_t reserved03[12];
+	uint32_t ctrlbuf_size;
+	uint32_t ctrlbuf_ctrl;
+	struct axd_ctrlbuf_item ctrlbuf[];
+};
+
+#define AXD_ANY_KICK_BIT	0x80000000
+#define AXD_KICK_MASK		0x0000000F
+#define AXD_KICK_CTRL_BIT	0x00000001
+#define AXD_KICK_DATA_IN_BIT	0x00000002
+#define AXD_KICK_DATA_OUT_BIT	0x00000004
+
+#define AXD_INT_KICK_DONE	0x00000001
+#define AXD_INT_DATAIN		0x00000002
+#define AXD_INT_DATAOUT		0x00000004
+#define AXD_INT_CTRL		0x00000008
+#define AXD_INT_ERROR		0x00000010
+
+enum axd_ctrl_cmd {
+	AXD_CTRL_CMD_NONE = 0,
+	AXD_CTRL_CMD_BUSY,
+	AXD_CTRL_CMD_READY,
+	AXD_CTRL_CMD_FLUSH,
+	AXD_CTRL_CMD_RESET_BD,
+	AXD_CTRL_CMD_RESET_PIPE,
+	AXD_CTRL_CMD_CTRLBUF_FLUSH,
+	AXD_CTRL_CMD_READ_REGISTER = 0x80000000, /* lower 16bits are address */
+	AXD_CTRL_CMD_WRITE_REGISTER = 0xC0000000, /* lower 16bits are address */
+};
+
+struct axd_hdr {
+	uint32_t axd_magic;
+	uint32_t hdr_size;
+	uint32_t thread_pc[THREAD_COUNT];
+	uint32_t cmd_block_offset;
+	uint32_t cmd_block_size;
+	char build_str[64];
+	uint32_t log_offset;
+};
+
+/* Register I/F */
+#define AXD_REG_VERSION							0x0000
+#define AXD_REG_CONFIG0							0x0004
+#define AXD_REG_CONFIG1							0x0008
+#define AXD_REG_CONFIG2							0x000C
+#define AXD_REG_CONFIG3							0x0010
+#define AXD_REG_BUFFER_BASE						0x0014
+#define AXD_REG_DEBUG_MASK						0x0018
+/* 0x1c reserved */
+#define AXD_REG_INPUT0_CONTROL						0x0020
+#define AXD_REG_INPUT0_GAIN						0x0024
+#define AXD_REG_INPUT0_UPMIX						0x0028
+#define AXD_REG_INPUT1_CONTROL						0x0030
+#define AXD_REG_INPUT1_GAIN						0x0034
+#define AXD_REG_INPUT1_UPMIX						0x0038
+#define AXD_REG_INPUT2_CONTROL						0x0040
+#define AXD_REG_INPUT2_GAIN						0x0044
+#define AXD_REG_INPUT2_UPMIX						0x0048
+#define AXD_REG_INPUT0_MUTE						0x0050
+#define AXD_REG_INPUT1_MUTE						0x0054
+#define AXD_REG_INPUT2_MUTE						0x0058
+#define AXD_REG_MIXER_CONTROL						0x0080
+#define AXD_REG_EQ_CTRL_GAIN						0x0084
+#define AXD_REG_EQ_BAND0						0x0088
+#define AXD_REG_EQ_BAND1						0x008C
+#define AXD_REG_EQ_BAND2						0x0090
+#define AXD_REG_EQ_BAND3						0x0094
+#define AXD_REG_EQ_BAND4						0x0098
+#define AXD_REG_MUX0							0x00B0
+#define AXD_REG_MUX1							0x00B4
+#define AXD_REG_MUX2							0x00B8
+#define AXD_REG_OUTPUT0_CONTROL						0x00D0
+#define AXD_REG_OUTPUT0_DOWNMIX						0x00D4
+#define AXD_REG_OUTPUT0_EQCTRL						0x00D8
+#define AXD_REG_OUTPUT0_EQBAND0						0x00DC
+#define AXD_REG_OUTPUT0_EQBAND1						0x00E0
+#define AXD_REG_OUTPUT0_EQBAND2						0x00E4
+#define AXD_REG_OUTPUT0_EQBAND3						0x00E8
+#define AXD_REG_OUTPUT0_EQBAND4						0x00EC
+#define AXD_REG_OUTPUT1_CONTROL						0x00F0
+#define AXD_REG_OUTPUT1_DOWNMIX						0x00F4
+#define AXD_REG_OUTPUT1_EQCTRL						0x00F8
+#define AXD_REG_OUTPUT1_EQBAND0						0x00FC
+#define AXD_REG_OUTPUT1_EQBAND1						0x0100
+#define AXD_REG_OUTPUT1_EQBAND2						0x0104
+#define AXD_REG_OUTPUT1_EQBAND3						0x0108
+#define AXD_REG_OUTPUT1_EQBAND4						0x010C
+#define AXD_REG_OUTPUT2_CONTROL						0x0110
+#define AXD_REG_OUTPUT2_DOWNMIX						0x0114
+#define AXD_REG_OUTPUT2_EQCTRL						0x0118
+#define AXD_REG_OUTPUT2_EQBAND0						0x011C
+#define AXD_REG_OUTPUT2_EQBAND1						0x0120
+#define AXD_REG_OUTPUT2_EQBAND2						0x0124
+#define AXD_REG_OUTPUT2_EQBAND3						0x0128
+#define AXD_REG_OUTPUT2_EQBAND4						0x012c
+#define AXD_REG_DEC0_AAC_VERSION					0x0200
+#define AXD_REG_DEC0_AAC_CHANNELS					0x0204
+#define AXD_REG_DEC0_AAC_PROFILE					0x0208
+#define AXD_REG_DEC0_AAC_STREAM_TYPE					0x020C
+#define AXD_REG_DEC0_AAC_SAMPLERATE					0x0210
+#define AXD_REG_DEC1_AAC_VERSION					0x0220
+#define AXD_REG_DEC1_AAC_CHANNELS					0x0224
+#define AXD_REG_DEC1_AAC_PROFILE					0x0228
+#define AXD_REG_DEC1_AAC_STREAM_TYPE					0x022C
+#define AXD_REG_DEC1_AAC_SAMPLERATE					0x0230
+#define AXD_REG_DEC2_AAC_VERSION					0x0240
+#define AXD_REG_DEC2_AAC_CHANNELS					0x0244
+#define AXD_REG_DEC2_AAC_PROFILE					0x0248
+#define AXD_REG_DEC2_AAC_STREAM_TYPE					0x024C
+#define AXD_REG_DEC2_AAC_SAMPLERATE					0x0250
+#define AXD_REG_DEC0_COOK_FLAVOUR					0x0260
+#define AXD_REG_DEC1_COOK_FLAVOUR					0x0264
+#define AXD_REG_DEC2_COOK_FLAVOUR					0x0268
+#define AXD_REG_DEC0_FLAC_CHANNELS					0x0270
+#define AXD_REG_DEC0_FLAC_SAMPLERATE					0x0274
+#define AXD_REG_DEC0_FLAC_BITS_PER_SAMPLE				0x0278
+#define AXD_REG_DEC0_FLAC_MD5_CHECKING					0x027C
+#define AXD_REG_DEC1_FLAC_CHANNELS					0x0280
+#define AXD_REG_DEC1_FLAC_SAMPLERATE					0x0284
+#define AXD_REG_DEC1_FLAC_BITS_PER_SAMPLE				0x0288
+#define AXD_REG_DEC1_FLAC_MD5_CHECKING					0x028C
+#define AXD_REG_DEC2_FLAC_CHANNELS					0x0290
+#define AXD_REG_DEC2_FLAC_SAMPLERATE					0x0294
+#define AXD_REG_DEC2_FLAC_BITS_PER_SAMPLE				0x0298
+#define AXD_REG_DEC2_FLAC_MD5_CHECKING					0x029C
+#define AXD_REG_DEC0_MPEG_CHANNELS					0x02A0
+#define AXD_REG_DEC0_MPEG_MLCHANNEL					0x02A4
+#define AXD_REG_DEC1_MPEG_CHANNELS					0x02A8
+#define AXD_REG_DEC1_MPEG_MLCHANNEL					0x02AC
+#define AXD_REG_DEC2_MPEG_CHANNELS					0x02B0
+#define AXD_REG_DEC2_MPEG_MLCHANNEL					0x02B4
+#define AXD_REG_DEC0_WMA_PLAYER_OPT					0x02D0
+#define AXD_REG_DEC0_WMA_DRC_SETTING					0x02D4
+#define AXD_REG_DEC0_WMA_PEAK_AMP_REF					0x02D8
+#define AXD_REG_DEC0_WMA_RMS_AMP_REF					0x02DC
+#define AXD_REG_DEC0_WMA_PEAK_AMP_TARGET				0x02E0
+#define AXD_REG_DEC0_WMA_RMS_AMP_TARGET					0x02E4
+#define AXD_REG_DEC0_WMA_PCM_VAL_BITS_PER_SAMPLE			0x02F4
+#define AXD_REG_DEC0_WMA_PCM_CONTAINER_SIZE				0x02F8
+#define AXD_REG_DEC0_WMA_WMA_FORMAT_TAG					0x02FC
+#define AXD_REG_DEC0_WMA_WMA_CHANNELS					0x0300
+#define AXD_REG_DEC0_WMA_WMA_SAMPLES_PER_SEC				0x0304
+#define AXD_REG_DEC0_WMA_WMA_AVG_BYTES_PER_SEC				0x0308
+#define AXD_REG_DEC0_WMA_WMA_BLOCK_ALIGN				0x030C
+#define AXD_REG_DEC0_WMA_WMA_VAL_BITS_PER_SAMPLE			0x0310
+#define AXD_REG_DEC0_WMA_WMA_CHANNEL_MASK				0x0314
+#define AXD_REG_DEC0_WMA_WMA_ENCODE_OPTS				0x0318
+#define AXD_REG_DEC1_WMA_PLAYER_OPT					0x0320
+#define AXD_REG_DEC1_WMA_DRC_SETTING					0x0324
+#define AXD_REG_DEC1_WMA_PEAK_AMP_REF					0x0328
+#define AXD_REG_DEC1_WMA_RMS_AMP_REF					0x032C
+#define AXD_REG_DEC1_WMA_PEAK_AMP_TARGET				0x0330
+#define AXD_REG_DEC1_WMA_RMS_AMP_TARGET					0x0334
+#define AXD_REG_DEC1_WMA_PCM_VAL_BITS_PER_SAMPLE			0x0344
+#define AXD_REG_DEC1_WMA_PCM_CONTAINER_SIZE				0x0348
+#define AXD_REG_DEC1_WMA_WMA_FORMAT_TAG					0x034C
+#define AXD_REG_DEC1_WMA_WMA_CHANNELS					0x0350
+#define AXD_REG_DEC1_WMA_WMA_SAMPLES_PER_SEC				0x0354
+#define AXD_REG_DEC1_WMA_WMA_AVG_BYTES_PER_SEC				0x0358
+#define AXD_REG_DEC1_WMA_WMA_BLOCK_ALIGN				0x035C
+#define AXD_REG_DEC1_WMA_WMA_VAL_BITS_PER_SAMPLE			0x0360
+#define AXD_REG_DEC1_WMA_WMA_CHANNEL_MASK				0x0364
+#define AXD_REG_DEC1_WMA_WMA_ENCODE_OPTS				0x0368
+#define AXD_REG_DEC2_WMA_PLAYER_OPT					0x0370
+#define AXD_REG_DEC2_WMA_DRC_SETTING					0x0374
+#define AXD_REG_DEC2_WMA_PEAK_AMP_REF					0x0378
+#define AXD_REG_DEC2_WMA_RMS_AMP_REF					0x037C
+#define AXD_REG_DEC2_WMA_PEAK_AMP_TARGET				0x0380
+#define AXD_REG_DEC2_WMA_RMS_AMP_TARGET					0x0384
+#define AXD_REG_DEC2_WMA_PCM_VAL_BITS_PER_SAMPLE			0x0394
+#define AXD_REG_DEC2_WMA_PCM_CONTAINER_SIZE				0x0398
+#define AXD_REG_DEC2_WMA_WMA_FORMAT_TAG					0x039C
+#define AXD_REG_DEC2_WMA_WMA_CHANNELS					0x03A0
+#define AXD_REG_DEC2_WMA_WMA_SAMPLES_PER_SEC				0x03A4
+#define AXD_REG_DEC2_WMA_WMA_AVG_BYTES_PER_SEC				0x03A8
+#define AXD_REG_DEC2_WMA_WMA_BLOCK_ALIGN				0x03AC
+#define AXD_REG_DEC2_WMA_WMA_VAL_BITS_PER_SAMPLE			0x03B0
+#define AXD_REG_DEC2_WMA_WMA_CHANNEL_MASK				0x03B4
+#define AXD_REG_DEC2_WMA_WMA_ENCODE_OPTS				0x03B8
+#define AXD_REG_PCMIN0_SAMPLE_RATE					0x3C0
+#define AXD_REG_PCMIN0_CHANNELS						0x3C4
+#define AXD_REG_PCMIN0_BITS_PER_SAMPLE					0x3C8
+#define AXD_REG_PCMIN0_JUSTIFICATION					0x3CC
+#define AXD_REG_PCMIN1_SAMPLE_RATE					0x3D0
+#define AXD_REG_PCMIN1_CHANNELS						0x3D4
+#define AXD_REG_PCMIN1_BITS_PER_SAMPLE					0x3D8
+#define AXD_REG_PCMIN1_JUSTIFICATION					0x3DC
+#define AXD_REG_PCMIN2_SAMPLE_RATE					0x3E0
+#define AXD_REG_PCMIN2_CHANNELS						0x3E4
+#define AXD_REG_PCMIN2_BITS_PER_SAMPLE					0x3E8
+#define AXD_REG_PCMIN2_JUSTIFICATION					0x3EC
+#define AXD_REG_PCMOUT0_BITS_PER_SAMPLE					0x3F0
+#define AXD_REG_PCMOUT0_JUSTIFICATION					0x3F4
+#define AXD_REG_PCMOUT1_BITS_PER_SAMPLE					0x3F8
+#define AXD_REG_PCMOUT1_JUSTIFICATION					0x3FC
+#define AXD_REG_PCMOUT2_BITS_PER_SAMPLE					0x400
+#define AXD_REG_PCMOUT2_JUSTIFICATION					0x404
+#define AXD_REG_DEC0_AC3_CHANNELS					0x410
+#define AXD_REG_DEC0_AC3_CHANNEL_ORDER					0x414
+#define AXD_REG_DEC0_AC3_MODE						0x418
+#define AXD_REG_DEC1_AC3_CHANNELS					0x420
+#define AXD_REG_DEC1_AC3_CHANNEL_ORDER					0x424
+#define AXD_REG_DEC1_AC3_MODE						0x428
+#define AXD_REG_DEC2_AC3_CHANNELS					0x430
+#define AXD_REG_DEC2_AC3_CHANNEL_ORDER					0x434
+#define AXD_REG_DEC2_AC3_MODE						0x438
+#define AXD_REG_DEC0_DDPLUS_CONFIG					0x440
+#define AXD_REG_DEC0_DDPLUS_CHANNEL_ORDER				0x444
+#define AXD_REG_DEC1_DDPLUS_CONFIG					0x448
+#define AXD_REG_DEC1_DDPLUS_CHANNEL_ORDER				0x44C
+#define AXD_REG_DEC2_DDPLUS_CONFIG					0x450
+#define AXD_REG_DEC2_DDPLUS_CHANNEL_ORDER				0x454
+#define AXD_REG_EQ_OUT0_POWER_B0_C0_C3					0x460
+#define AXD_REG_EQ_OUT0_POWER_B0_C4_C7					0x464
+#define AXD_REG_EQ_OUT0_POWER_B1_C0_C3					0x468
+#define AXD_REG_EQ_OUT0_POWER_B1_C4_C7					0x46C
+#define AXD_REG_EQ_OUT0_POWER_B2_C0_C3					0x470
+#define AXD_REG_EQ_OUT0_POWER_B2_C4_C7					0x474
+#define AXD_REG_EQ_OUT0_POWER_B3_C0_C3					0x478
+#define AXD_REG_EQ_OUT0_POWER_B3_C4_C7					0x47C
+#define AXD_REG_EQ_OUT0_POWER_B4_C0_C3					0x480
+#define AXD_REG_EQ_OUT0_POWER_B4_C4_C7					0x484
+#define AXD_REG_EQ_OUT1_POWER_B0_C0_C3					0x488
+#define AXD_REG_EQ_OUT1_POWER_B0_C4_C7					0x48C
+#define AXD_REG_EQ_OUT1_POWER_B1_C0_C3					0x490
+#define AXD_REG_EQ_OUT1_POWER_B1_C4_C7					0x494
+#define AXD_REG_EQ_OUT1_POWER_B2_C0_C3					0x498
+#define AXD_REG_EQ_OUT1_POWER_B2_C4_C7					0x49C
+#define AXD_REG_EQ_OUT1_POWER_B3_C0_C3					0x4A0
+#define AXD_REG_EQ_OUT1_POWER_B3_C4_C7					0x4A4
+#define AXD_REG_EQ_OUT1_POWER_B4_C0_C3					0x4A8
+#define AXD_REG_EQ_OUT1_POWER_B4_C4_C7					0x4AC
+#define AXD_REG_EQ_OUT2_POWER_B0_C0_C3					0x4B0
+#define AXD_REG_EQ_OUT2_POWER_B0_C4_C7					0x4B4
+#define AXD_REG_EQ_OUT2_POWER_B1_C0_C3					0x4B8
+#define AXD_REG_EQ_OUT2_POWER_B1_C4_C7					0x4BC
+#define AXD_REG_EQ_OUT2_POWER_B2_C0_C3					0x4C0
+#define AXD_REG_EQ_OUT2_POWER_B2_C4_C7					0x4C4
+#define AXD_REG_EQ_OUT2_POWER_B3_C0_C3					0x4C8
+#define AXD_REG_EQ_OUT2_POWER_B3_C4_C7					0x4CC
+#define AXD_REG_EQ_OUT2_POWER_B4_C0_C3					0x4D0
+#define AXD_REG_EQ_OUT2_POWER_B4_C4_C7					0x4D4
+#define AXD_REG_RESAMPLER0_FIN						0x4E0
+#define AXD_REG_RESAMPLER0_FOUT						0x4E4
+#define AXD_REG_RESAMPLER1_FIN						0x4E8
+#define AXD_REG_RESAMPLER1_FOUT						0x4EC
+#define AXD_REG_RESAMPLER2_FIN						0x4F0
+#define AXD_REG_RESAMPLER2_FOUT						0x4f4
+#define AXD_REG_DEC0_ALAC_CHANNELS					0x500
+#define AXD_REG_DEC0_ALAC_DEPTH						0x504
+#define AXD_REG_DEC0_ALAC_SAMPLE_RATE					0x508
+#define AXD_REG_DEC0_ALAC_FRAME_LENGTH					0x50C
+#define AXD_REG_DEC0_ALAC_MAX_FRAME_BYTES				0x510
+#define AXD_REG_DEC0_ALAC_AVG_BIT_RATE					0x514
+#define AXD_REG_DEC1_ALAC_CHANNELS					0x520
+#define AXD_REG_DEC1_ALAC_DEPTH						0x524
+#define AXD_REG_DEC1_ALAC_SAMPLE_RATE					0x528
+#define AXD_REG_DEC1_ALAC_FRAME_LENGTH					0x52C
+#define AXD_REG_DEC1_ALAC_MAX_FRAME_BYTES				0x530
+#define AXD_REG_DEC1_ALAC_AVG_BIT_RATE					0x534
+#define AXD_REG_DEC2_ALAC_CHANNELS					0x540
+#define AXD_REG_DEC2_ALAC_DEPTH						0x544
+#define AXD_REG_DEC2_ALAC_SAMPLE_RATE					0x548
+#define AXD_REG_DEC2_ALAC_FRAME_LENGTH					0x54C
+#define AXD_REG_DEC2_ALAC_MAX_FRAME_BYTES				0x550
+#define AXD_REG_DEC2_ALAC_AVG_BIT_RATE					0x554
+/* 0x558 to 0x55C reserved */
+#define AXD_REG_ENC0_FLAC_CHANNELS					0x560
+#define AXD_REG_ENC0_FLAC_BITS_PER_SAMPLE				0x564
+#define AXD_REG_ENC0_FLAC_SAMPLE_RATE					0x568
+#define AXD_REG_ENC0_FLAC_TOTAL_SAMPLES					0x56C
+#define AXD_REG_ENC0_FLAC_DO_MID_SIDE_STEREO				0x570
+#define AXD_REG_ENC0_FLAC_LOOSE_MID_SIDE_STEREO				0x574
+#define AXD_REG_ENC0_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH			0x578
+#define AXD_REG_ENC0_FLAC_MIN_RESIDUAL_PARTITION_ORDER			0x57C
+#define AXD_REG_ENC0_FLAC_MAX_RESIDUAL_PARTITION_ORDER			0x580
+#define AXD_REG_ENC0_FLAC_BLOCK_SIZE					0x584
+#define AXD_REG_ENC0_FLAC_BYTE_COUNT					0x588
+#define AXD_REG_ENC0_FLAC_SAMPLE_COUNT					0x58C
+#define AXD_REG_ENC0_FLAC_FRAME_COUNT					0x590
+#define AXD_REG_ENC0_FLAC_FRAME_BYTES					0x594
+/* 0x598 to 0x59C reserved */
+#define AXD_REG_ENC1_FLAC_CHANNELS					0x5A0
+#define AXD_REG_ENC1_FLAC_BITS_PER_SAMPLE				0x5A4
+#define AXD_REG_ENC1_FLAC_SAMPLE_RATE					0x5A8
+#define AXD_REG_ENC1_FLAC_TOTAL_SAMPLES					0x5AC
+#define AXD_REG_ENC1_FLAC_DO_MID_SIDE_STEREO				0x5B0
+#define AXD_REG_ENC1_FLAC_LOOSE_MID_SIDE_STEREO				0x5B4
+#define AXD_REG_ENC1_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH			0x5B8
+#define AXD_REG_ENC1_FLAC_MIN_RESIDUAL_PARTITION_ORDER			0x5BC
+#define AXD_REG_ENC1_FLAC_MAX_RESIDUAL_PARTITION_ORDER			0x5C0
+#define AXD_REG_ENC1_FLAC_BLOCK_SIZE					0x5C4
+#define AXD_REG_ENC1_FLAC_BYTE_COUNT					0x5C8
+#define AXD_REG_ENC1_FLAC_SAMPLE_COUNT					0x5CC
+#define AXD_REG_ENC1_FLAC_FRAME_COUNT					0x5D0
+#define AXD_REG_ENC1_FLAC_FRAME_BYTES					0x5D4
+/* 0x5D8 to 0x5DC reserved */
+#define AXD_REG_ENC2_FLAC_CHANNELS					0x5E0
+#define AXD_REG_ENC2_FLAC_BITS_PER_SAMPLE				0x5E4
+#define AXD_REG_ENC2_FLAC_SAMPLE_RATE					0x5E8
+#define AXD_REG_ENC2_FLAC_TOTAL_SAMPLES					0x5EC
+#define AXD_REG_ENC2_FLAC_DO_MID_SIDE_STEREO				0x5F0
+#define AXD_REG_ENC2_FLAC_LOOSE_MID_SIDE_STEREO				0x5F4
+#define AXD_REG_ENC2_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH			0x5F8
+#define AXD_REG_ENC2_FLAC_MIN_RESIDUAL_PARTITION_ORDER			0x5FC
+#define AXD_REG_ENC2_FLAC_MAX_RESIDUAL_PARTITION_ORDER			0x600
+#define AXD_REG_ENC2_FLAC_BLOCK_SIZE					0x604
+#define AXD_REG_ENC2_FLAC_BYTE_COUNT					0x608
+#define AXD_REG_ENC2_FLAC_SAMPLE_COUNT					0x60C
+#define AXD_REG_ENC2_FLAC_FRAME_COUNT					0x610
+#define AXD_REG_ENC2_FLAC_FRAME_BYTES					0x614
+/* 0x618 to 0x61C reserved */
+#define AXD_REG_ENC0_ALAC_CHANNELS					0x620
+#define AXD_REG_ENC0_ALAC_DEPTH						0x624
+#define AXD_REG_ENC0_ALAC_SAMPLE_RATE					0x628
+#define AXD_REG_ENC0_ALAC_FRAME_LENGTH					0x62C
+#define AXD_REG_ENC0_ALAC_MAX_FRAME_BYTES				0x630
+#define AXD_REG_ENC0_ALAC_AVG_BIT_RATE					0x634
+#define AXD_REG_ENC0_ALAC_FAST_MODE					0x638
+/* 0x63C to 0x64C reserved */
+#define AXD_REG_ENC1_ALAC_CHANNELS					0x650
+#define AXD_REG_ENC1_ALAC_DEPTH						0x654
+#define AXD_REG_ENC1_ALAC_SAMPLE_RATE					0x658
+#define AXD_REG_ENC1_ALAC_FRAME_LENGTH					0x65C
+#define AXD_REG_ENC1_ALAC_MAX_FRAME_BYTES				0x660
+#define AXD_REG_ENC1_ALAC_AVG_BIT_RATE					0x664
+#define AXD_REG_ENC1_ALAC_FAST_MODE					0x668
+/* 0x66C to 0x67C reserved */
+#define AXD_REG_ENC2_ALAC_CHANNELS					0x680
+#define AXD_REG_ENC2_ALAC_DEPTH						0x684
+#define AXD_REG_ENC2_ALAC_SAMPLE_RATE					0x688
+#define AXD_REG_ENC2_ALAC_FRAME_LENGTH					0x68C
+#define AXD_REG_ENC2_ALAC_MAX_FRAME_BYTES				0x690
+#define AXD_REG_ENC2_ALAC_AVG_BIT_RATE					0x694
+#define AXD_REG_ENC2_ALAC_FAST_MODE					0x698
+/* 0x69C to 0x6AC reserved */
+#define AXD_REG_MS11_MODE						0x6B0
+#define AXD_REG_MS11_COMMON_CONFIG0					0x6B4
+#define AXD_REG_MS11_COMMON_CONFIG1					0x6B8
+#define AXD_REG_MS11_DDT_CONFIG0					0x6Bc
+#define AXD_REG_MS11_DDC_CONFIG0					0x6C0
+#define AXD_REG_MS11_EXT_PCM_CONFIG0					0x6C4
+/* 0x6C8 and 0x6CC reserved */
+#define AXD_REG_OUTPUT0_DCPP_CONTROL					0x6D0
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_CONTROL				0x6D4
+#define AXD_REG_OUTPUT0_DCPP_BAND_CONTROL				0x6D8
+#define AXD_REG_OUTPUT0_DCPP_MAX_DELAY_SAMPLES				0x6DC
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_DELAY_SAMPLES			0x6E0
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_SHIFT			0x6E4
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A0			0x6E8
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A1			0x6EC
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A2			0x6F0
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_B0			0x6F4
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_B1			0x6F8
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_SHIFT			0x6FC
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A0			0x700
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A1			0x704
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A2			0x708
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_B0			0x70C
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_B1			0x710
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_OUTPUT_VOLUME			0x714
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN		0x718
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN	0x71C
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_GAIN			0x720
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A0				0x724
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A1				0x728
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A2				0x72C
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_B0				0x730
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_B1				0x734
+#define AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_SHIFT			0x738
+#define AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A0			0x73C
+#define AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A1			0x740
+#define AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A2			0x744
+#define AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_B0			0x748
+#define AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_B1			0x74C
+/* 0x750 to 0x764 reserved */
+#define AXD_REG_OUTPUT1_DCPP_CONTROL					0x768
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_CONTROL				0x76C
+#define AXD_REG_OUTPUT1_DCPP_BAND_CONTROL				0x770
+#define AXD_REG_OUTPUT1_DCPP_MAX_DELAY_SAMPLES				0x774
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_DELAY_SAMPLES			0x778
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_SHIFT			0x77C
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A0			0x780
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A1			0x784
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A2			0x788
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_B0			0x78C
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_B1			0x790
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_SHIFT			0x794
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A0			0x798
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A1			0x79C
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A2			0x7A0
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_B0			0x7A4
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_B1			0x7A8
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_OUTPUT_VOLUME			0x7AC
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN		0x7B0
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN	0x7B4
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_GAIN			0x7B8
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A0				0x7BC
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A1				0x7C0
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A2				0x7C4
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_B0				0x7C8
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_B1				0x7CC
+#define AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_SHIFT			0x7D0
+#define AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A0			0x7D4
+#define AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A1			0x7D8
+#define AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A2			0x7DC
+#define AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_B0			0x7E0
+#define AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_B1			0x7E4
+/* 0x7E8 to 0x7FC reserved */
+#define AXD_REG_OUTPUT2_DCPP_CONTROL					0x800
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_CONTROL				0x804
+#define AXD_REG_OUTPUT2_DCPP_BAND_CONTROL				0x808
+#define AXD_REG_OUTPUT2_DCPP_MAX_DELAY_SAMPLES				0x80C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_DELAY_SAMPLES			0x810
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_SHIFT			0x814
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A0			0x818
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A1			0x81C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A2			0x820
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_B0			0x824
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_B1			0x828
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_SHIFT			0x82C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A0			0x830
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A1			0x834
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A2			0x838
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_B0			0x83C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_B1			0x840
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_OUTPUT_VOLUME			0x844
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN		0x848
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN	0x84C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_GAIN			0x850
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A0				0x854
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A1				0x858
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A2				0x85C
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_B0				0x860
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_B1				0x864
+#define AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_SHIFT			0x868
+#define AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A0			0x86C
+#define AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A1			0x870
+#define AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A2			0x874
+#define AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_B0			0x878
+#define AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_B1			0x87C
+/* 0x880 to 0x89C reserved */
+#define AXD_REG_DEC0_SBC_SAMPLE_RATE					0x8A0
+#define AXD_REG_DEC0_SBC_AUDIO_MODE					0x8A4
+#define AXD_REG_DEC0_SBC_BLOCKS						0x8A8
+#define AXD_REG_DEC0_SBC_SUBBANDS					0x8AC
+#define AXD_REG_DEC0_SBC_BITPOOL					0x8B0
+#define AXD_REG_DEC0_SBC_ALLOCATION_MODE				0x8B4
+#define AXD_REG_DEC1_SBC_SAMPLE_RATE					0x8B8
+#define AXD_REG_DEC1_SBC_AUDIO_MODE					0x8BC
+#define AXD_REG_DEC1_SBC_BLOCKS						0x8C0
+#define AXD_REG_DEC1_SBC_SUBBANDS					0x8C4
+#define AXD_REG_DEC1_SBC_BITPOOL					0x8C8
+#define AXD_REG_DEC1_SBC_ALLOCATION_MODE				0x8CC
+#define AXD_REG_DEC2_SBC_SAMPLE_RATE					0x8D0
+#define AXD_REG_DEC2_SBC_AUDIO_MODE					0x8D4
+#define AXD_REG_DEC2_SBC_BLOCKS						0x8D8
+#define AXD_REG_DEC2_SBC_SUBBANDS					0x8DC
+#define AXD_REG_DEC2_SBC_BITPOOL					0x8E0
+#define AXD_REG_DEC2_SBC_ALLOCATION_MODE				0x8E4
+/* 0x8E8 to 0x8EC reserved */
+#define AXD_REG_SYNC_MODE						0x8F0
+/* 0x8F4 to 0x8FC reserved */
+#define AXD_REG_INPUT0_BUFFER_OCCUPANCY					0x900
+#define AXD_REG_INPUT1_BUFFER_OCCUPANCY					0x904
+#define AXD_REG_INPUT2_BUFFER_OCCUPANCY					0x908
+/* 0x90C reserved */
+#define AXD_REG_OUTPUT0_EVENT						0x910
+#define AXD_REG_OUTPUT1_EVENT						0x914
+#define AXD_REG_OUTPUT2_EVENT						0x918
+/* 0x91C reserved */
+
+/* Register masks */
+#define AXD_INCTRL_ENABLE_MASK		0x1
+#define AXD_INCTRL_ENABLE_SHIFT		31
+#define AXD_INCTRL_ENABLE_BITS		\
+	(AXD_INCTRL_ENABLE_MASK << AXD_INCTRL_ENABLE_SHIFT)
+#define AXD_INCTRL_SOURCE_MASK		0x3
+#define AXD_INCTRL_SOURCE_SHIFT		8
+#define AXD_INCTRL_SOURCE_BITS		\
+	(AXD_INCTRL_SOURCE_MASK << AXD_INCTRL_SOURCE_SHIFT)
+#define AXD_INCTRL_CODEC_MASK		0x7FF
+#define AXD_INCTRL_CODEC_SHIFT		0
+#define AXD_INCTRL_CODEC_BITS		\
+	(AXD_INCTRL_CODEC_MASK << AXD_INCTRL_CODEC_SHIFT)
+
+#define AXD_OUTCTRL_ENABLE_MASK		0x1
+#define AXD_OUTCTRL_ENABLE_SHIFT	31
+#define AXD_OUTCTRL_ENABLE_BITS		\
+	(AXD_OUTCTRL_ENABLE_MASK << AXD_OUTCTRL_ENABLE_SHIFT)
+#define AXD_OUTCTRL_SINK_MASK		0x3
+#define AXD_OUTCTRL_SINK_SHIFT		0
+#define AXD_OUTCTRL_SINK_BITS		\
+	(AXD_OUTCTRL_SINK_MASK << AXD_OUTCTRL_SINK_SHIFT)
+#define AXD_OUTCTRL_CODEC_MASK		0xFF
+#define AXD_OUTCTRL_CODEC_SHIFT		2
+#define AXD_OUTCTRL_CODEC_BITS		\
+	(AXD_OUTCTRL_CODEC_MASK << AXD_OUTCTRL_CODEC_SHIFT)
+
+#define AXD_EQCTRL_ENABLE_MASK		0x1
+#define AXD_EQCTRL_ENABLE_SHIFT		31
+#define AXD_EQCTRL_ENABLE_BITS		\
+	(AXD_EQCTRL_ENABLE_MASK << AXD_EQCTRL_ENABLE_SHIFT)
+#define AXD_EQCTRL_GAIN_MASK		0x7F
+#define AXD_EQCTRL_GAIN_SHIFT		0
+#define AXD_EQCTRL_GAIN_BITS		\
+	(AXD_EQCTRL_GAIN_MASK << AXD_EQCTRL_GAIN_SHIFT)
+
+#define AXD_EQBANDX_GAIN_MASK		0xFF
+#define AXD_EQBANDX_GAIN_SHIFT		0
+#define AXD_EQBANDX_GAIN_BITS		\
+	(AXD_EQBANDX_GAIN_MASK << AXD_EQBANDX_GAIN_SHIFT)
+
+#define AXD_DCPP_CTRL_ENABLE_MASK			0x1
+#define AXD_DCPP_CTRL_ENABLE_SHIFT			31
+#define AXD_DCPP_CTRL_ENABLE_BITS			\
+	(AXD_DCPP_CTRL_ENABLE_MASK << AXD_DCPP_CTRL_ENABLE_SHIFT)
+#define AXD_DCPP_CTRL_CHANNELS_MASK			0xF
+#define AXD_DCPP_CTRL_CHANNELS_SHIFT			27
+#define AXD_DCPP_CTRL_CHANNELS_BITS			\
+	(AXD_DCPP_CTRL_CHANNELS_MASK << AXD_DCPP_CTRL_CHANNELS_SHIFT)
+#define AXD_DCPP_CTRL_MODE_MASK				0x1
+#define AXD_DCPP_CTRL_MODE_SHIFT			26
+#define AXD_DCPP_CTRL_MODE_BITS				\
+	(AXD_DCPP_CTRL_MODE_MASK << AXD_DCPP_CTRL_MODE_SHIFT)
+#define AXD_DCPP_CTRL_EQ_MODE_MASK			0x1
+#define AXD_DCPP_CTRL_EQ_MODE_SHIFT			25
+#define AXD_DCPP_CTRL_EQ_MODE_BITS			\
+	(AXD_DCPP_CTRL_EQ_MODE_MASK << AXD_DCPP_CTRL_EQ_MODE_SHIFT)
+#define AXD_DCPP_CTRL_EQ_BANDS_MASK			0xFF
+#define AXD_DCPP_CTRL_EQ_BANDS_SHIFT			17
+#define AXD_DCPP_CTRL_EQ_BANDS_BITS			\
+	(AXD_DCPP_CTRL_EQ_BANDS_MASK << AXD_DCPP_CTRL_EQ_BANDS_SHIFT)
+#define AXD_DCPP_CTRL_SUBBAND_ENABLE_MASK		0x1
+#define AXD_DCPP_CTRL_SUBBAND_ENABLE_SHIFT		16
+#define AXD_DCPP_CTRL_SUBBAND_ENABLE_BITS		\
+	(AXD_DCPP_CTRL_SUBBAND_ENABLE_MASK << AXD_DCPP_CTRL_SUBBAND_ENABLE_SHIFT)
+#define AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_MASK		0xFF
+#define AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_SHIFT	8
+#define AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_BITS		\
+	(AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_MASK << AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_SHIFT)
+#define AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_MASK		0xFF
+#define AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_SHIFT		0
+#define AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_BITS		\
+	(AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_MASK << AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_SHIFT)
+
+#define AXD_DCPP_CHANNEL_CTRL_CHANNEL_MASK	0xFF
+#define AXD_DCPP_CHANNEL_CTRL_CHANNEL_SHIFT	24
+#define AXD_DCPP_CHANNEL_CTRL_CHANNEL_BITS	\
+	(AXD_DCPP_CHANNEL_CTRL_CHANNEL_MASK << AXD_DCPP_CHANNEL_CTRL_CHANNEL_SHIFT)
+#define AXD_DCPP_CHANNEL_CTRL_SUBBAND_MASK	0x1
+#define AXD_DCPP_CHANNEL_CTRL_SUBBAND_SHIFT	23
+#define AXD_DCPP_CHANNEL_CTRL_SUBBAND_BITS	\
+	(AXD_DCPP_CHANNEL_CTRL_SUBBAND_MASK << AXD_DCPP_CHANNEL_CTRL_SUBBAND_SHIFT)
+
+#endif /* AXD_API_H_ */
diff --git a/sound/soc/img/axd/axd_module.c b/sound/soc/img/axd/axd_module.c
new file mode 100644
index 000000000000..b4929fc12292
--- /dev/null
+++ b/sound/soc/img/axd/axd_module.c
@@ -0,0 +1,742 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD is a hardware IP that provides various audio processing capabilities for
+ * user applications, offloading the core on which the application is running
+ * and saving its valuable MIPS.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <sound/compress_driver.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+
+/* this is required by MIPS ioremap_cachable() */
+#include <asm/pgtable.h>
+
+#include "axd_cmds.h"
+#include "axd_cmds_internal.h"
+#include "axd_hdr.h"
+#include "axd_module.h"
+#include "axd_platform.h"
+
+#define AXD_MGCNUM		0x66445841	/* AXDf */
+#define LZO_MGCNUM		0x4f5a4c89	/* .LZO */
+
+#define DEFAULT_INBUF_SIZE	0x7800
+#define DEFAULT_OUTBUF_SIZE	0x3c000
+
+#define AXD_LDFW_RETRIES	400
+
+#define WATCHDOG_TIMEOUT	(3*HZ)
+
+#define AXD_BASE_VADDR		0xD0000000
+
+enum axd_devtype {
+	AXD_UNKNOWN = 0,
+	AXD_CTRL,
+	AXD_INPUT,
+	AXD_OUTPUT,
+};
+
+extern struct snd_compr_ops axd_compr_ops;
+
+static struct snd_soc_platform_driver axd_platform = {
+	.compr_ops	= &axd_compr_ops,
+};
+
+static const struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_AIF_IN("AXD IN", "AXD Playback", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_component_driver axd_component = {
+	.name		= "AXD",
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+};
+
+static struct snd_soc_dai_driver axd_dai[] = {
+	{
+		.name = "AXD Playback",
+		.compress_dai = 1,
+		.playback = {
+			.stream_name = "AXD Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+	},
+};
+
+#ifdef CONFIG_SND_SOC_IMG_AXD_DEBUGFS
+static ssize_t axd_read_log(struct file *filep,
+				char __user *buff, size_t count, loff_t *offp)
+{
+	struct axd_dev *axd = filep->f_inode->i_private;
+	void __iomem *log_addr;
+	unsigned int log_size;
+	int ret;
+
+	log_addr = axd->fw_base_m + axd_hdr_get_log_offset();
+	log_size = ioread32(log_addr + 4);
+
+	if (!axd->log_rbuf) {
+		/*
+		 * first time we run, initialise
+		 */
+		dev_dbg(axd->dev,
+			"allocating %u bytes for log buffer\n", log_size);
+		axd->log_rbuf = devm_kzalloc(axd->dev, log_size, GFP_KERNEL);
+		if (!axd->log_rbuf)
+			return -ENOMEM;
+	}
+
+	if (!*offp) {
+		unsigned int flags = axd_platform_lock();
+		unsigned int log_offset = ioread32(log_addr);
+		unsigned int log_wrapped = ioread32(log_addr + 8);
+		char __iomem *log_buff = (char __iomem *)(log_addr + 12);
+
+		/* new read from beginning, fill up our internal buffer */
+		if (!log_wrapped) {
+			memcpy_fromio(axd->log_rbuf, log_buff, log_offset);
+			axd->log_rbuf_rem = log_offset;
+		} else {
+			char __iomem *pos = log_buff + log_offset;
+			unsigned int rem = log_size - log_offset;
+
+			memcpy_fromio(axd->log_rbuf, pos, rem);
+			memcpy_fromio(axd->log_rbuf + rem, log_buff, log_offset);
+			axd->log_rbuf_rem = log_size;
+		}
+		axd_platform_unlock(flags);
+	}
+
+	if (count > axd->log_rbuf_rem)
+		count = axd->log_rbuf_rem;
+
+	ret = copy_to_user(buff, axd->log_rbuf + *offp, count);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(axd->dev, "read %d bytes from %d\n", count, (int)*offp);
+	*offp += count;
+	axd->log_rbuf_rem -= count;
+
+	return count;
+}
+
+static ssize_t axd_read_mask(struct file *filep,
+				char __user *buff, size_t count, loff_t *offp)
+{
+	struct axd_dev *axd = filep->f_inode->i_private;
+	unsigned int mask;
+	char buffer[32];
+	int ret;
+
+	if (!*offp) {
+		axd_read_reg(&axd->cmd, AXD_REG_DEBUG_MASK, &mask);
+
+		count = sprintf(buffer, "0x%08x\n", mask);
+
+		ret = copy_to_user(buff, buffer, count);
+		if (ret < 0)
+			return ret;
+
+		*offp += count;
+		return count;
+	}
+
+	return 0;
+}
+
+static ssize_t axd_write_mask(struct file *filep,
+				const char __user *buff, size_t count, loff_t *offp)
+{
+	struct axd_dev *axd = filep->f_inode->i_private;
+	unsigned int mask;
+	char buffer[32] = {};
+	int ret;
+
+	/* ensure we always have null at the end */
+	ret = copy_from_user(buffer, buff, min(31u, count));
+	if (ret < 0)
+		return ret;
+
+	if (!kstrtouint(buffer, 0, &mask))
+		axd_write_reg(&axd->cmd, AXD_REG_DEBUG_MASK, mask);
+
+	return count;
+}
+
+const struct file_operations dfslogfops = {
+	.read = axd_read_log,
+	.llseek = no_llseek,
+};
+
+const struct file_operations dfsmaskfops = {
+	.read = axd_read_mask,
+	.write = axd_write_mask,
+	.llseek = no_llseek,
+};
+
+static void axd_debugfs_create(struct axd_dev *axd)
+{
+	axd->debugfs = debugfs_create_dir(dev_name(axd->dev), NULL);
+	if (IS_ERR_OR_NULL(axd->debugfs)) {
+		dev_err(axd->dev, "failed to create debugfs node\n");
+		return;
+	}
+	axd->dfslog = debugfs_create_file("log", S_IRUGO | S_IWUSR,
+						axd->debugfs, axd, &dfslogfops);
+	if (IS_ERR_OR_NULL(axd->dfslog))
+		dev_err(axd->dev, "failed to create debugfs log file\n");
+	axd->dfsmask = debugfs_create_file("mask", S_IRUGO | S_IWUSR,
+						axd->debugfs, axd, &dfsmaskfops);
+	if (IS_ERR_OR_NULL(axd->dfsmask))
+		dev_err(axd->dev, "failed to create debugfs mask file\n");
+	axd->dfswatchdog = debugfs_create_bool("watchdog", S_IRUGO | S_IWUSR,
+						axd->debugfs, &axd->cmd.watchdogenabled);
+	if (IS_ERR_OR_NULL(axd->dfswatchdog))
+		dev_err(axd->dev, "failed to create debugfs watchdog file\n");
+}
+
+static void axd_debugfs_destroy(struct axd_dev *axd)
+{
+	debugfs_remove_recursive(axd->debugfs);
+}
+#else
+#define axd_debugfs_create(x)
+#define axd_debugfs_destroy(x)
+#endif /* CONFIG_SND_SOC_IMG_AXD_DEBUGFS */
+
+#ifdef CONFIG_CRYPTO_LZO
+#include <linux/crypto.h>
+static int decompress_fw(struct axd_dev *axd, const struct firmware *fw)
+{
+	struct crypto_comp *tfm;
+	unsigned int size;
+	char *cached_fw_base;
+	int ret;
+
+	tfm = crypto_alloc_comp("lzo", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	/* allocate bigger memory for uncompressed fw */
+	dma_free_coherent(axd->dev, axd->fw_size,
+				axd->fw_base_m, axd->fw_base_p);
+	axd->fw_size = *(int *)(fw->data + 4);
+	axd->fw_base_m = dma_alloc_coherent(axd->dev, axd->fw_size,
+					&axd->fw_base_p, GFP_KERNEL);
+	if (!axd->fw_base_m) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* first 8 bytes contain lzo magic number and raw file size, skip them */
+	size = axd->fw_size;
+	cached_fw_base = (char *)CAC_ADDR((int)axd->fw_base_m);
+	ret = crypto_comp_decompress(tfm, fw->data + 8,
+				fw->size - 8, cached_fw_base, &size);
+	if (ret)
+		dev_err(axd->dev, "Failed to decompress the firmware\n");
+
+	if (size != axd->fw_size) {
+		dev_err(axd->dev, "Uncompressed file size doesn't match reported file size\n");
+		ret = -EINVAL;
+	}
+
+out:
+	crypto_free_comp(tfm);
+	return ret;
+}
+#else /* !CONFIG_CRYPTO_LZO */
+static int decompress_fw(struct axd_dev *axd, const struct firmware *fw)
+{
+	dev_err(axd->dev, "The firmware must be lzo decompressed first, compile driver again with CONFIG_CRYPTO_LZO enabled in kernel or do the decompression in user space.\n");
+	return -EIO;
+}
+#endif /* CONFIG_CRYPTO_LZO */
+
+static int copy_fw(struct axd_dev *axd, const struct firmware *fw)
+{
+	int mgcnum = *(int *)fw->data;
+	int cached_fw_base = CAC_ADDR((int)axd->fw_base_m);
+
+	if (mgcnum != AXD_MGCNUM) {
+		if (mgcnum == LZO_MGCNUM)
+			return decompress_fw(axd, fw);
+
+		dev_err(axd->dev, "Not a valid firmware binary.\n");
+		return -EIO;
+	}
+	/*
+	 * We copy through the cache, fw will do the necessary cache
+	 * flushes and syncing at startup.
+	 * Copying from uncached makes it more difficult for the
+	 * firmware to keep the caches coherent with memory when it sets
+	 * tlbs and start running.
+	 */
+	memcpy_toio((void *)cached_fw_base, fw->data, fw->size);
+
+	/* TODO: do MD5 checksum verification */
+	return 0;
+}
+
+static void axd_free(struct axd_dev *axd)
+{
+	if (axd->buf_base_m) {
+		dma_free_noncoherent(axd->dev, axd->inbuf_size+axd->outbuf_size,
+					axd->buf_base_m, axd->buf_base_p);
+		axd->buf_base_m = NULL;
+	}
+	if (axd->fw_base_m) {
+		dma_free_coherent(axd->dev, axd->fw_size,
+					axd->fw_base_m, axd->fw_base_p);
+		axd->fw_base_m = NULL;
+	}
+}
+
+static int axd_alloc(struct axd_dev *axd)
+{
+	/* do the allocation once, return immediately if fw_base_m is set */
+	if (axd->fw_base_m)
+		return 0;
+
+	axd->fw_base_m = dma_alloc_coherent(axd->dev, axd->fw_size,
+						&axd->fw_base_p, GFP_KERNEL);
+	if (!axd->fw_base_m)
+		return -ENOMEM;
+
+	axd->buf_base_m = dma_alloc_noncoherent(axd->dev,
+			axd->inbuf_size+axd->outbuf_size,
+			&axd->buf_base_p, GFP_KERNEL);
+	if (!axd->buf_base_m) {
+		axd_free(axd);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int axd_fw_start(struct axd_dev *axd)
+{
+	unsigned long t0_new_pc;
+	unsigned int num_threads = axd_platform_num_threads();
+	struct axd_cmd *axd_cmd = &axd->cmd;
+	const struct firmware *fw;
+	int ret = 0, i;
+	unsigned int gic_irq;
+
+	/* request the firmware */
+	ret = request_firmware(&fw, "img/axd_firmware.bin", axd->dev);
+	if (ret) {
+		dev_err(axd->dev, "Failed to load firmware, check that firmware loading is setup correctly in userspace and kernel and that axd_firmware.bin is present in the FS\n");
+		goto out;
+	}
+
+	axd->fw_size = fw->size;
+	if (!axd->inbuf_size)
+		axd->inbuf_size = DEFAULT_INBUF_SIZE;
+	if (!axd->outbuf_size)
+		axd->outbuf_size = DEFAULT_OUTBUF_SIZE;
+
+	ret = axd_alloc(axd);
+	if (ret) {
+		dev_err(axd->dev, "Failed to allocate memory for AXD f/w and buffers\n");
+		release_firmware(fw);
+		goto out;
+	}
+
+	dev_info(axd->dev, "Loading firmware at 0x%p ...\n", axd->fw_base_m);
+
+	ret = copy_fw(axd, fw);
+	release_firmware(fw);
+	if (ret)
+		goto out;
+
+	/* setup hdr and memmapped regs */
+	axd_hdr_init((unsigned long)axd->fw_base_m);
+	/* initialize the cmd structure and the buffers */
+	axd_cmd_init(axd_cmd,
+		axd_hdr_get_cmdblock_offset()+(unsigned long)axd->fw_base_m,
+		(unsigned long)axd->buf_base_m, axd->buf_base_p);
+
+	/*
+	 * Tell AXD the count/compare frequency and the IRQs it must use
+	 */
+	gic_irq = (axd->host_irq << 16) | axd->axd_irq;
+	iowrite32(gic_irq, &axd_cmd->message->gic_irq);
+	iowrite32(clk_get_rate(axd->clk)/2000000, &axd_cmd->message->freq);
+
+	axd_platform_init(axd);
+	for (i = 0; i < num_threads; i++) {
+		ret = axd_cmd_set_pc(axd_cmd, i, axd_hdr_get_pc(i));
+		if (ret == -1) {
+			dev_err(axd->dev, "Failed to set PC of T%d\n", i);
+			goto out;
+		}
+	}
+	/* setup and start master thread */
+	t0_new_pc = axd_hdr_get_pc(0);
+	if (t0_new_pc == -1UL) {
+		ret = -1;
+		goto out;
+	}
+	t0_new_pc = (unsigned long) axd->fw_base_m + (t0_new_pc - AXD_BASE_VADDR);
+	axd_platform_set_pc(t0_new_pc);
+	ret = axd_platform_start();
+	if (ret)
+		goto out;
+
+	/* install the IRQ */
+	ret = axd_cmd_install_irq(&axd->cmd, axd->irqnum);
+	if (ret) {
+		dev_err(axd->dev, "Failed to install IRQ %d, error %d\n",
+							axd->irqnum, ret);
+		goto out;
+	}
+
+	for (i = 0; i < AXD_LDFW_RETRIES; i++) {
+		ret = axd_wait_ready(axd_cmd->message);
+		if (!ret) {
+			/*
+			 * Let the firmware know the address of the buffer
+			 * region
+			 */
+			ret = axd_write_reg(axd_cmd,
+					AXD_REG_BUFFER_BASE, axd->buf_base_p);
+			if (ret) {
+				dev_err(axd->dev,
+					"Failed to setup buffers base address\n");
+				goto out;
+			}
+			return 0;
+
+		}
+	}
+out:
+	axd_free(axd);
+	return ret;
+}
+
+static void axd_fw_stop(struct axd_dev *axd)
+{
+	axd_cmd_free_irq(&axd->cmd, axd->irqnum);
+	axd_platform_stop();
+}
+
+/*
+ * Stops the firmware, reload it, and start it back again to recover from a
+ * fatal error.
+ */
+static void axd_reset(struct work_struct *work)
+{
+	unsigned int major, minor, patch;
+	int i;
+
+	struct axd_dev *axd = container_of(work, struct axd_dev, watchdogwork);
+
+
+	/* if we got a fatal error, don't reset if watchdog is disabled */
+	if (unlikely(!axd->cmd.watchdogenabled))
+		return;
+
+	/* stop the watchdog timer until we restart */
+	del_timer(&axd->watchdogtimer);
+
+	if (!axd_get_flag(&axd->cmd.fw_stopped_flg)) {
+		/* ping the firmware by requesting its version info */
+		axd_cmd_get_version(&axd->cmd, &major, &minor, &patch);
+		if (!major && !minor && !patch) {
+			dev_warn(axd->dev, "Firmware stopped responding...\n");
+			axd_set_flag(&axd->cmd.fw_stopped_flg, 1);
+		} else {
+			goto out;
+		}
+	}
+
+	axd_platform_print_regs();
+	dev_warn(axd->dev, "Reloading AXD firmware...\n");
+
+	axd_fw_stop(axd);
+
+	/* Signal to any active tasks first */
+	for (i = 0; i < axd->num_inputs; i++)
+		axd_cmd_send_buffer_abort(&axd->cmd, i);
+
+	for (i = 0; i < axd->num_outputs; i++)
+		axd_cmd_recv_buffer_abort(&axd->cmd, i);
+
+	/* wake up any task sleeping on command response */
+	wake_up(&axd->cmd.wait);
+	/* give chance to user land tasks to react to the crash */
+	ssleep(2);
+
+	axd_fw_start(axd);
+
+	for (i = 0; i < axd->num_inputs; i++)
+		axd_cmd_inpipe_reset(&axd->cmd, i);
+
+	for (i = 0; i < axd->num_outputs; i++)
+		axd_cmd_outpipe_reset(&axd->cmd, i);
+
+	axd_set_flag(&axd->cmd.fw_stopped_flg, 0);
+out:
+	axd->watchdogtimer.expires = jiffies + WATCHDOG_TIMEOUT;
+	add_timer(&axd->watchdogtimer);
+}
+
+/*
+ * Schedule to perform a reset.
+ * We don't perform the reset directly because the request comes from atomic
+ * context, and resetting must be done from process context.
+ */
+void axd_schedule_reset(struct axd_cmd *cmd)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+
+	axd_set_flag(&axd->cmd.fw_stopped_flg, 1);
+	schedule_work(&axd->watchdogwork);
+}
+
+/*
+ * Verifies that the firmware is still running by reading the version every few
+ * seconds.
+ */
+static void axd_watchdog_timer(unsigned long arg)
+{
+	struct axd_dev *axd = (struct axd_dev *)arg;
+
+	/* skip if watchdog is not enabled */
+	if (unlikely(!axd->cmd.watchdogenabled))
+		goto out;
+
+	schedule_work(&axd->watchdogwork);
+	return;
+out:
+	mod_timer(&axd->watchdogtimer, jiffies + WATCHDOG_TIMEOUT);
+}
+
+static void axd_start_watchdog(struct axd_dev *axd)
+{
+	INIT_WORK(&axd->watchdogwork, axd_reset);
+	init_timer(&axd->watchdogtimer);
+	axd->watchdogtimer.function = axd_watchdog_timer;
+	axd->watchdogtimer.data = (unsigned long)axd;
+	axd->watchdogtimer.expires = jiffies + HZ;
+	add_timer(&axd->watchdogtimer);
+}
+
+static void axd_stop_watchdog(struct axd_dev *axd)
+{
+	del_timer(&axd->watchdogtimer);
+}
+
+static int axd_create(struct axd_dev *axd)
+{
+	int ret = 0, i = 0;
+	unsigned int major, minor, patch;
+
+	axd_set_flag(&axd->timestamps_out_flg, 0);
+
+	/* Setup and start the threads */
+	ret = axd_fw_start(axd);
+	if (ret) {
+		dev_err(axd->dev, "Failed to start\n");
+		return -EIO;
+	}
+
+	/*
+	 * Verify that the firmware is ready. In normal cases the firmware
+	 * should start immediately, but to be more robust we do this
+	 * verification and give the firmware a chance of 3 seconds to be ready
+	 * otherwise we exit in failure.
+	 */
+	for (i = 0; i < AXD_LDFW_RETRIES; i++) {
+		axd_cmd_get_version(&axd->cmd, &major, &minor, &patch);
+		if (major || minor || patch) {
+			/* firmware is ready */
+			break;
+		}
+		/* if we couldn't read the version after 3 tries, error */
+		if (i == AXD_LDFW_RETRIES - 1) {
+			dev_err(axd->dev, "Failed to communicate with the firmware\n");
+			ret = -EIO;
+			goto error;
+		}
+		/* wait for 10 ms for the firmware to start */
+		msleep(10);
+	}
+	dev_info(axd->dev, "Running firmware version %u.%u.%u %s\n",
+				major, minor, patch, axd_hdr_get_build_str());
+
+	/* Get num of input/output pipes */
+	ret = axd_cmd_get_num_pipes(&axd->cmd,
+					&axd->num_inputs, &axd->num_outputs);
+	if (ret) {
+		dev_err(axd->dev, "Failed to get numer of supported pipes\n");
+		ret = -EIO;
+		goto error;
+	}
+	axd->cmd.num_inputs = axd->num_inputs;
+	axd->cmd.num_outputs = axd->num_outputs;
+
+	/* Invalidate DCPP selector caches */
+	for (i = 0; i < axd->cmd.num_outputs; i++) {
+		axd->cmd.dcpp_channel_ctrl_cache[i] = -1;
+		axd->cmd.dcpp_band_ctrl_cache[i] = -1;
+	}
+
+	ret = snd_soc_register_platform(axd->dev, &axd_platform);
+	if (ret) {
+		dev_err(axd->dev, "Failed to register platform, %d\n", ret);
+		goto error;
+	}
+
+	ret = snd_soc_register_component(axd->dev, &axd_component, axd_dai, ARRAY_SIZE(axd_dai));
+	if (ret) {
+		snd_soc_unregister_platform(axd->dev);
+		dev_err(axd->dev, "Failed to register DAI, %d\n", ret);
+		goto error;
+	}
+
+	axd_start_watchdog(axd);
+	axd_debugfs_create(axd);
+
+	return 0;
+
+error:
+	axd_fw_stop(axd);
+
+	return ret;
+}
+
+static void axd_destroy(struct axd_dev *axd)
+{
+	axd_stop_watchdog(axd);
+	axd_fw_stop(axd);
+	axd_debugfs_destroy(axd);
+	snd_soc_unregister_component(axd->dev);
+	snd_soc_unregister_platform(axd->dev);
+}
+
+static int axd_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node = pdev->dev.of_node;
+	struct axd_dev *axd;
+	int ret;
+	u32 val[2] = {0, 0};
+
+	axd = devm_kzalloc(&pdev->dev, sizeof(struct axd_dev), GFP_KERNEL);
+	if (!axd)
+		return -ENOMEM;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't get parameter: 'irq'\n");
+		return ret;
+	}
+	axd->irqnum = ret;
+
+	ret = of_property_read_u32_array(of_node, "gic-irq", val, 2);
+	if (ret) {
+		dev_err(&pdev->dev,
+				"'gic-irq' parameter must be set\n");
+		return ret;
+	}
+	axd->host_irq = val[0];
+	axd->axd_irq = val[1];
+
+	ret = of_property_read_u32(of_node, "vpe", val);
+	if (ret) {
+		dev_err(&pdev->dev, "'vpe' parameter must be set\n");
+		return ret;
+	}
+
+	if (!val[0]) {
+		dev_err(&pdev->dev, "'vpe' parameter can't be 0\n");
+		return -EINVAL;
+	}
+	axd->vpe = val[0];
+
+	axd->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(axd->clk)) {
+		dev_err(&pdev->dev, "Couldn't get parameter: 'clocks'\n");
+		return PTR_ERR(axd->clk);
+	}
+
+	of_property_read_u32(of_node, "inbuf-size", &axd->inbuf_size);
+	of_property_read_u32(of_node, "outbuf-size", &axd->outbuf_size);
+
+	ret = clk_prepare_enable(axd->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable the clock\n");
+		return ret;
+	}
+
+	axd->dev = &pdev->dev;
+	dev_set_drvdata(axd->dev, axd);
+	ret = axd_create(axd);
+	if (ret) {
+		clk_disable_unprepare(axd->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int axd_remove(struct platform_device *pdev)
+{
+	struct axd_dev *axd = dev_get_drvdata(&pdev->dev);
+
+	clk_disable_unprepare(axd->clk);
+	axd_destroy(axd);
+	axd_free(axd);
+
+	return 0;
+}
+
+static const struct of_device_id axd_match[] = {
+	{ .compatible = "img,axd" },
+	{}
+};
+
+static struct platform_driver axd_driver = {
+	.driver = {
+		.name		= "axd",
+		.of_match_table	= axd_match,
+	},
+	.probe = axd_probe,
+	.remove = axd_remove,
+};
+
+module_platform_driver(axd_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Imagination Technologies Ltd.");
+MODULE_DESCRIPTION("AXD Audio Processing IP Driver");
diff --git a/sound/soc/img/axd/axd_module.h b/sound/soc/img/axd/axd_module.h
new file mode 100644
index 000000000000..8dbc20dff63f
--- /dev/null
+++ b/sound/soc/img/axd/axd_module.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD is a hardware IP that provides various audio decoding capabilities for
+ * user applications, offloading the core on which the application is running
+ * and saving its valuable MIPS.
+ */
+#ifndef AXD_MODULE_H_
+#define AXD_MODULE_H_
+#include <linux/cdev.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+
+#include "axd_api.h"
+#include "axd_cmds.h"
+
+
+void axd_schedule_reset(struct axd_cmd *cmd);
+
+
+/**
+ * struct axd_dev - axd device structure
+ * @dev:		pointer to struct device from platform_device
+ * @num_inputs:		number of inputs AXD hardware reported it can handle
+ * @num_outputs:	number of outputs AXD hardware reported it provides
+ * @axd_cmd:		axd_cmd structure
+ * @fw_base_m:		pointer to mapped fw base address
+ * @fw_base_p:		physical address of fw base
+ * @fw_size:		size of reserved fw region
+ * @buf_base_m:		pointer to mapped buffers base address
+ * @buf_base_p:		physical address of buffers base
+ * @inbuf_size:		size of reserved input buffers region
+ * @outbuf_size:	size of reserved output buffers region
+ * @host_irq:		gic irq of the host
+ * @axd_irq:		gic irq of axd
+ * @irqnum:		linux linear irq number for request_irq()
+ * @clk:		pointer to clock structure for AXD
+ * @vpe:		vpe number AXD is running on
+ * @watchdogtimer:	software watchdogtimer to check if axd is alive
+ * @watchdogwork:	the work to execute to check if firwmare is still alive
+ *			and restart if it discovers the firmware stopped
+ *			responding.
+ * @timestamps_out_flg:	a flag that indicates whether we should pass output
+ *			timestamps or not
+ */
+struct axd_dev {
+	struct device *dev;
+	int num_inputs;
+	int num_outputs;
+	struct axd_cmd cmd;
+	void __iomem *fw_base_m;
+	dma_addr_t fw_base_p;
+	unsigned int fw_size;
+	void __iomem *buf_base_m;
+	dma_addr_t buf_base_p;
+	unsigned int inbuf_size;
+	unsigned int outbuf_size;
+	int host_irq;
+	int axd_irq;
+	int irqnum;
+	struct clk *clk;
+	unsigned int vpe;
+	struct timer_list watchdogtimer;
+	struct work_struct watchdogwork;
+	int timestamps_out_flg;
+	/* debugfs related */
+	struct dentry *debugfs;
+	struct dentry *dfslog;
+	struct dentry *dfsmask;
+	struct dentry *dfswatchdog;
+	char *log_rbuf;
+	int log_rbuf_rem;
+};
+#endif /* AXD_MODULE_H_ */
-- 
2.1.0
