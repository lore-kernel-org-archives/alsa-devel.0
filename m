From: ramesh.babu@intel.com
Subject: [PATCH 1/5] [RFC]intel_hdmi_audio:include header
Date: Mon, 22 Nov 2010 19:09:42 +0530
Message-ID: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C6B201039C3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:34:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>, Ramesh Babu K V <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu K V <ramesh.babu@intel.com>

This patch creates intel_mid_hdmi_audio.h file. This file contains
Intel MID platform specific HDMI Audio register definitions, enums
and structure definitions used in this driver.  This also exposes
interface function.

Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Sailaja Bandarupalli	<sailaja.bandarupalli@intel.com>
---
 .../drivers/intel_mid_hdmi/intel_mid_hdmi_audio.h  |  424 ++++++++++++++++++++
 1 files changed, 424 insertions(+), 0 deletions(-)
 create mode 100644 sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.h

diff --git a/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.h b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.h
new file mode 100644
index 0000000..19e47ee
--- /dev/null
+++ b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.h
@@ -0,0 +1,424 @@
+/*
+ *   intel_mid_hdmi_audio.h - Intel HDMI audio driver for MID
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Authors:	Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
+ *		Ramesh Babu K V	<ramesh.babu@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * ALSA driver for Intel MID HDMI audio controller
+ */
+#ifndef __INTEL_MID_HDMI_AUDIO_H
+#define __INTEL_MID_HDMI_AUDIO_H
+
+#include <linux/types.h>
+#include <sound/initval.h>
+#include "../../../drivers/staging/mrst/drv/mdfld_hdmi_audio_if.h"
+#include "../../../drivers/staging/mrst/drv/psb_intel_hdmi.h"
+
+#define HAD_DRIVER_VERSION	"0.01.002"
+#define HAD_MAX_DEVICES		1
+#define HAD_MIN_CHANNEL		1
+#define HAD_MAX_CHANNEL		8
+#define HAD_NUM_OF_RING_BUFS	4
+#define HAD_MIN_RATE		32000
+#define HAD_MAX_RATE		192000
+#define HAD_MAX_BUFFER		(800*1024)
+#define HAD_MIN_BUFFER		(800*1024)
+#define HAD_MAX_PERIODS		4
+#define HAD_MIN_PERIODS		1
+#define HAD_MAX_PERIOD_BYTES	HAD_MAX_BUFFER
+#define HAD_MIN_PERIOD_BYTES	32
+#define HAD_FIFO_SIZE		0 /* fifo not being used */
+
+#define AUD_SAMPLE_RATE_32	HAD_MIN_RATE
+#define AUD_SAMPLE_RATE_44_1	44100
+#define AUD_SAMPLE_RATE_48	48000
+#define AUD_SAMPLE_RATE_88_2	88200
+#define AUD_SAMPLE_RATE_96	96000
+#define AUD_SAMPLE_RATE_176_4	176400
+#define AUD_SAMPLE_RATE_192	HAD_MAX_RATE
+
+#define DRIVER_NAME		"intelmid_hdmi_audio"
+#define DIS_SAMPLE_RATE_25_2	25200
+#define DIS_SAMPLE_RATE_27	27000
+#define DIS_SAMPLE_RATE_54	54000
+#define DIS_SAMPLE_RATE_74_25	74250
+#define DIS_SAMPLE_RATE_148_5	148500
+#define REG_BIT_0		0x1
+#define REG_BIT_1		0x2
+#define REG_BIT_2		0x4
+#define REG_BIT_3		0x8
+#define REG_BIT_20		0x100000
+#define SET_BIT0		1
+#define CLEAR_BIT0		0
+#define REG_WIDTH		0x08
+#define MAX_HW_BUFS		0x04
+#define MAX_DIP_WORDS		16
+#define MAX_PERIODS		4
+#define INTEL_HAD		"INTEL_HAD"
+
+/**
+ * enum had_status - Audio stream states
+ *
+ * @STREAM_INIT: Stream initialized
+ * @STREAM_RUNNING: Stream running
+ * @STREAM_PAUSED: Stream paused
+ * @STREAM_DROPPED: Stream dropped
+ * */
+enum had_stream_status {
+	STREAM_INIT = 0,
+	STREAM_RUNNING = 1,
+	STREAM_PAUSED = 2,
+	STREAM_DROPPED = 3
+};
+
+/**
+ * enum intel_had_aud_buf_type - HDMI controller ring buffer types
+ *
+ * @HAD_BUF_TYPE_A: ring buffer A
+ * @HAD_BUF_TYPE_B: ring buffer B
+ * @HAD_BUF_TYPE_C: ring buffer C
+ * @HAD_BUF_TYPE_D: ring buffer D
+ */
+enum intel_had_aud_buf_type {
+	HAD_BUF_TYPE_A = 0,
+	HAD_BUF_TYPE_B = 1,
+	HAD_BUF_TYPE_C = 2,
+	HAD_BUF_TYPE_D = 3,
+};
+
+enum num_aud_ch {
+	CH_STEREO = 0,
+	CH_THREE_FOUR = 1,
+	CH_FIVE_SIX = 2,
+	CH_SEVEN_EIGHT = 3
+};
+
+/*HDMI controller register offsets*/
+enum hdmi_ctrl_reg {
+	AUD_CONFIG		= 0x69000,
+	AUD_CH_STATUS_0		= 0x69008,
+	AUD_CH_STATUS_1		= 0x6900C,
+	AUD_HDMI_CTS		= 0x69010,
+	AUD_N_ENABLE		= 0x69014,
+	AUD_SAMPLE_RATE		= 0x69018,
+	AUD_BUF_CONFIG		= 0x69020,
+	AUD_BUF_CH_SWAP		= 0x69024,
+	AUD_BUF_A_ADDR		= 0x69040,
+	AUD_BUF_A_LENGTH	= 0x69044,
+	AUD_BUF_B_ADDR		= 0x69048,
+	AUD_BUF_B_LENGTH	= 0x6904c,
+	AUD_BUF_C_ADDR		= 0x69050,
+	AUD_BUF_C_LENGTH	= 0x69054,
+	AUD_BUF_D_ADDR		= 0x69058,
+	AUD_BUF_D_LENGTH	= 0x6905c,
+	AUD_CNTL_ST		= 0x69060,
+	AUD_HDMI_STATUS		= 0x69068,
+	AUD_HDMIW_INFOFR	= 0x69114,
+};
+/**
+ * union aud_cfg - Audio configuration offset - 69000
+ *
+ * @cfg_regx: individual register bits
+ * @cfg_regval: full register value
+ *
+ * */
+union aud_cfg {
+	struct {
+		u32 aud_en:1;
+		u32 layout:1;
+		u32 fmt:2;
+		u32 num_ch:2;
+		u32 rsvd0:1;
+		u32 set:1;
+		u32 flat:1;
+		u32 val_bit:1;
+		u32 user_bit:1;
+		u32 underrun:1;
+		u32 rsvd1:20;
+	} cfg_regx;
+	u32 cfg_regval;
+};
+/**
+ * union aud_ch_status_0 - Audio Channel Status 0 Attributes offset - 0x69008
+ *
+ * @status_0_regx:individual register bits
+ * @status_0_regval:full register value
+ *
+ * */
+union aud_ch_status_0 {
+	struct {
+		u32 ch_status:1;
+		u32 lpcm_id:1;
+		u32 cp_info:1;
+		u32 format:3;
+		u32 mode:2;
+		u32 ctg_code:8;
+		u32 src_num:4;
+		u32 ch_num:4;
+		u32 samp_freq:4;
+		u32 clk_acc:2;
+		u32 rsvd:2;
+	} status_0_regx;
+	u32 status_0_regval;
+};
+
+/**
+ * union aud_ch_status_1 - Audio Channel Status 1 Attributes offset - 0x6900c
+ *
+ * @status_1_regx: individual register bits
+ * @status_1_regval: full register value
+ *
+ **/
+union aud_ch_status_1 {
+	struct {
+		u32 max_wrd_len:1;
+		u32 wrd_len:3;
+		u32 rsvd:28;
+		} status_1_regx;
+	u32 status_1_regval;
+};
+
+/**
+ * union aud_hdmi_cts - CTS register offset -0x69010
+ *
+ * @cts_regx: individual register bits
+ * @cts_regval: full register value
+ *
+ * */
+union aud_hdmi_cts {
+	struct {
+		u32 cts_val:20;
+		u32 en_cts_prog:1;
+		u32 rsvd:11;
+	} cts_regx;
+	u32 cts_regval;
+};
+
+/**
+ * union aud_hdmi_n_enable - N register offset -0x69014
+ *
+ * @n_regx: individual register bits
+ * @n_regval: full register value
+ *
+*/
+union aud_hdmi_n_enable {
+	struct {
+		u32 n_val:20;
+		u32 en_n_prog:1;
+		u32 rsvd:11;
+	} n_regx;
+	u32 n_regval;
+};
+
+/**
+ * union aud_buf_config -  Audio Buffer configurations offset -0x69020
+ *
+ * @buf_cfg_regx: individual register bits
+ * @buf_cfgval: full register value
+ *
+*/
+union aud_buf_config {
+	struct {
+		u32 fifo_width:8;
+		u32 rsvd0:8;
+		u32 aud_delay:8;
+		u32 rsvd1:8;
+	} buf_cfg_regx;
+	u32 buf_cfgval;
+};
+
+/**
+ * union aud_buf_ch_swap - Audio Sample Swapping offset - 0x69024
+ *
+ * @buf_ch_swap_regx: individual register bits
+ * @buf_ch_swap_val: full register value
+ *
+ * */
+union aud_buf_ch_swap {
+	struct {
+		u32 first_0:3;
+		u32 second_0:3;
+		u32 first_1:3;
+		u32 second_1:3;
+		u32 first_2:3;
+		u32 second_2:3;
+		u32 first_3:3;
+		u32 second_3:3;
+		u32 rsvd:8;
+	} buf_ch_swap_regx;
+	u32 buf_ch_swap_val;
+};
+
+/**
+ * union aud_buf_addr - Address for Audio Buffer
+ *
+ * @buf_addr_regx: individual register bits
+ * @buf_addr_val: full register value
+ *
+ * */
+union aud_buf_addr {
+	struct {
+		u32 valid:1;
+		u32 intr_en:1;
+		u32 rsvd:4;
+		u32 addr:26;
+	} buf_addr_regx;
+	u32 buf_addr_val;
+};
+/**
+ * union aud_buf_len - Length of Audio Buffer
+ *
+ * @buf_len_regx: individual register bits
+ * @buf_len_val: full register value
+ *
+ * */
+union aud_buf_len {
+	struct {
+		u32 buf_len:20;
+		u32 rsvd:12;
+	} buf_len_regx;
+	u32 buf_len_val;
+};
+
+/**
+ * union aud_ctrl_st - Audio Control State Register offset 0x69060
+ *
+ * @ctrl_regx: individual register bits
+ * @ctrl_val: full register value
+ *
+ * */
+union aud_ctrl_st {
+	struct {
+		u32 ram_addr:4;
+		u32 eld_ack:1;
+		u32 eld_addr:4;
+		u32 eld_buf_size:5;
+		u32 eld_valid:1;
+		u32 cp_ready:1;
+		u32 dip_freq:2;
+		u32 dip_idx:3;
+		u32 dip_en_sta:4;
+		u32 rsvd:7;
+	} ctrl_regx;
+	u32 ctrl_val;
+};
+/**
+ * union aud_info_frame1 - Audio HDMI Widget Data Island Packet offset 0x69114
+ *
+ * @fr1_regx: individual register bits
+ * @fr1_val: full register value
+ *
+ * */
+union aud_info_frame1 {
+	struct {
+		u32 pkt_type:8;
+		u32 ver_num:8;
+		u32 len:5;
+		u32 rsvd:11;
+	} fr1_regx;
+	u32 fr1_val;
+};
+/**
+ * union aud_info_frame2 - DIP frame 2
+ *
+ * @fr2_regx: individual register bits
+ * @fr2_val: full register value
+ *
+ */
+union aud_info_frame2 {
+	struct {
+		u32 chksum:8;
+		u32 chnl_cnt:3;
+		u32 rsvd0:1;
+		u32 coding_type:4;
+		u32 smpl_size:2;
+		u32 smpl_freq:3;
+		u32 rsvd1:3;
+		u32 format:8;
+	} fr2_regx;
+	u32 fr2_val;
+};
+/**
+ * union aud_info_frame3 - DIP frame 3
+ *
+ * @fr3_regx: individual register bits
+ * @fr3_val: full register value
+ *
+ */
+union aud_info_frame3 {
+	struct {
+		u32 chnl_alloc:8;
+		u32 rsvd0:3;
+		u32 lsv:4;
+		u32 dm_inh:1;
+		u32 rsvd1:16;
+	} fr3_regx;
+	u32 fr3_val;
+};
+
+
+struct pcm_stream_info {
+	int str_id;
+	void *had_substream;
+	void (*period_elapsed) (void *had_substream);
+	u32 buffer_ptr;
+	u64 buffer_rendered;
+	u32 ring_buf_size;
+	int sfreq;
+};
+
+struct ring_buf_info {
+	uint32_t buf_addr;
+	uint32_t buf_size;
+	uint8_t	 is_valid;
+};
+
+struct had_stream_pvt {
+	enum had_stream_status	stream_status;
+	int	stream_ops;
+	struct snd_pcm_substream *substream;
+	ssize_t	dbg_cum_bytes;
+};
+
+struct had_callback_ops {
+	had_event_call_back intel_had_event_call_back;
+};
+
+/*HAD Driver context*/
+struct snd_intelhad {
+	struct snd_card	*card; /*holds details of snd_card*/
+	int		card_index; /*card index in alsa*/
+	char		*card_id; /*name of card*/
+	/*holds regsiters read/write callbacks*/
+	struct hdmi_audio_registers_ops *reg_ops;
+	/*holds caps get/set callbacks*/
+	struct hdmi_audio_query_set_ops *query_ops;
+	int		playback_cnt;
+	struct ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
+	struct pcm_stream_info stream_info;
+	hdmi_eeld_t	eeld;
+	enum intel_had_aud_buf_type curr_buf;
+	int	valid_buf_cnt;
+};
+int had_event_handler(enum had_event_type event_type, void *data);
+extern struct snd_intelhad *intelhaddata;
+extern struct snd_pcm_ops snd_intelhad_playback_ops;
+extern int hdmi_card_index;
+extern char *hdmi_card_id;
+#endif
-- 
1.6.2.5
