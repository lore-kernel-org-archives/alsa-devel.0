From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 47/53] ALSA: x86: Reduce redundant register
	field names
Date: Thu,  2 Feb 2017 18:03:01 +0100
Message-ID: <20170202170307.24484-49-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 324E32675B1
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:19 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Currently each register definition contains the own prefix in the
union struct itself; for example, union aud_ch_status_0 has
status_0_regx and status_0_regval fields.  These are simply
superfluous, since usually the type of the variable is seen in its
declaration or in its name.

In this patch, we cut off these prefixes.  Now all register
definitions have regx and regval fields consistently, instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 102 ++++++++++++-------------
 sound/x86/intel_hdmi_audio.h     |   1 -
 sound/x86/intel_hdmi_lpe_audio.h | 156 ++++++++++-----------------------------
 3 files changed, 90 insertions(+), 169 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 496d3e92b2a8..f825d514500e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -263,7 +263,7 @@ static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
 				      struct snd_intelhad *intelhaddata,
 				      bool enable)
 {
-	union aud_cfg cfg_val = {.cfg_regval = 0};
+	union aud_cfg cfg_val = {.regval = 0};
 	u8 channels, data, mask;
 
 	/*
@@ -271,9 +271,9 @@ static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
 	 * In this case just set channels to 2
 	 */
 	channels = substream ? substream->runtime->channels : 2;
-	cfg_val.cfg_regx.num_ch = channels - 2;
+	cfg_val.regx.num_ch = channels - 2;
 
-	data = cfg_val.cfg_regval;
+	data = cfg_val.regval;
 	if (enable)
 		data |= 1;
 	mask = AUD_CONFIG_CH_MASK | 1;
@@ -310,39 +310,39 @@ static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
 static int had_prog_status_reg(struct snd_pcm_substream *substream,
 			struct snd_intelhad *intelhaddata)
 {
-	union aud_cfg cfg_val = {.cfg_regval = 0};
-	union aud_ch_status_0 ch_stat0 = {.status_0_regval = 0};
-	union aud_ch_status_1 ch_stat1 = {.status_1_regval = 0};
+	union aud_cfg cfg_val = {.regval = 0};
+	union aud_ch_status_0 ch_stat0 = {.regval = 0};
+	union aud_ch_status_1 ch_stat1 = {.regval = 0};
 	int format;
 
-	ch_stat0.status_0_regx.lpcm_id = (intelhaddata->aes_bits &
+	ch_stat0.regx.lpcm_id = (intelhaddata->aes_bits &
 					  IEC958_AES0_NONAUDIO) >> 1;
-	ch_stat0.status_0_regx.clk_acc = (intelhaddata->aes_bits &
+	ch_stat0.regx.clk_acc = (intelhaddata->aes_bits &
 					  IEC958_AES3_CON_CLOCK) >> 4;
-	cfg_val.cfg_regx.val_bit = ch_stat0.status_0_regx.lpcm_id;
+	cfg_val.regx.val_bit = ch_stat0.regx.lpcm_id;
 
 	switch (substream->runtime->rate) {
 	case AUD_SAMPLE_RATE_32:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_32KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_32KHZ;
 		break;
 
 	case AUD_SAMPLE_RATE_44_1:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_44KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_44KHZ;
 		break;
 	case AUD_SAMPLE_RATE_48:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_48KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_48KHZ;
 		break;
 	case AUD_SAMPLE_RATE_88_2:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_88KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_88KHZ;
 		break;
 	case AUD_SAMPLE_RATE_96:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_96KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_96KHZ;
 		break;
 	case AUD_SAMPLE_RATE_176_4:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_176KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_176KHZ;
 		break;
 	case AUD_SAMPLE_RATE_192:
-		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_192KHZ;
+		ch_stat0.regx.samp_freq = CH_STATUS_MAP_192KHZ;
 		break;
 
 	default:
@@ -351,23 +351,23 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	}
 
 	had_write_register(intelhaddata,
-			   AUD_CH_STATUS_0, ch_stat0.status_0_regval);
+			   AUD_CH_STATUS_0, ch_stat0.regval);
 
 	format = substream->runtime->format;
 
 	if (format == SNDRV_PCM_FORMAT_S16_LE) {
-		ch_stat1.status_1_regx.max_wrd_len = MAX_SMPL_WIDTH_20;
-		ch_stat1.status_1_regx.wrd_len = SMPL_WIDTH_16BITS;
+		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_20;
+		ch_stat1.regx.wrd_len = SMPL_WIDTH_16BITS;
 	} else if (format == SNDRV_PCM_FORMAT_S24_LE) {
-		ch_stat1.status_1_regx.max_wrd_len = MAX_SMPL_WIDTH_24;
-		ch_stat1.status_1_regx.wrd_len = SMPL_WIDTH_24BITS;
+		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_24;
+		ch_stat1.regx.wrd_len = SMPL_WIDTH_24BITS;
 	} else {
-		ch_stat1.status_1_regx.max_wrd_len = 0;
-		ch_stat1.status_1_regx.wrd_len = 0;
+		ch_stat1.regx.max_wrd_len = 0;
+		ch_stat1.regx.wrd_len = 0;
 	}
 
 	had_write_register(intelhaddata,
-			   AUD_CH_STATUS_1, ch_stat1.status_1_regval);
+			   AUD_CH_STATUS_1, ch_stat1.regval);
 	return 0;
 }
 
@@ -379,26 +379,26 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
 				   struct snd_intelhad *intelhaddata)
 {
-	union aud_cfg cfg_val = {.cfg_regval = 0};
-	union aud_buf_config buf_cfg = {.buf_cfgval = 0};
+	union aud_cfg cfg_val = {.regval = 0};
+	union aud_buf_config buf_cfg = {.regval = 0};
 	u8 channels;
 
 	had_prog_status_reg(substream, intelhaddata);
 
-	buf_cfg.buf_cfg_regx.audio_fifo_watermark = FIFO_THRESHOLD;
-	buf_cfg.buf_cfg_regx.dma_fifo_watermark = DMA_FIFO_THRESHOLD;
-	buf_cfg.buf_cfg_regx.aud_delay = 0;
-	had_write_register(intelhaddata, AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
+	buf_cfg.regx.audio_fifo_watermark = FIFO_THRESHOLD;
+	buf_cfg.regx.dma_fifo_watermark = DMA_FIFO_THRESHOLD;
+	buf_cfg.regx.aud_delay = 0;
+	had_write_register(intelhaddata, AUD_BUF_CONFIG, buf_cfg.regval);
 
 	channels = substream->runtime->channels;
-	cfg_val.cfg_regx.num_ch = channels - 2;
+	cfg_val.regx.num_ch = channels - 2;
 	if (channels <= 2)
-		cfg_val.cfg_regx.layout = LAYOUT0;
+		cfg_val.regx.layout = LAYOUT0;
 	else
-		cfg_val.cfg_regx.layout = LAYOUT1;
+		cfg_val.regx.layout = LAYOUT1;
 
-	cfg_val.cfg_regx.val_bit = 1;
-	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.cfg_regval);
+	cfg_val.regx.val_bit = 1;
+	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.regval);
 	return 0;
 }
 
@@ -618,49 +618,49 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 				  struct snd_intelhad *intelhaddata)
 {
 	int i;
-	union aud_ctrl_st ctrl_state = {.ctrl_val = 0};
-	union aud_info_frame2 frame2 = {.fr2_val = 0};
-	union aud_info_frame3 frame3 = {.fr3_val = 0};
+	union aud_ctrl_st ctrl_state = {.regval = 0};
+	union aud_info_frame2 frame2 = {.regval = 0};
+	union aud_info_frame3 frame3 = {.regval = 0};
 	u8 checksum = 0;
 	u32 info_frame;
 	int channels;
 
 	channels = substream->runtime->channels;
 
-	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.ctrl_val);
+	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.regval);
 
 	if (intelhaddata->dp_output) {
 		info_frame = DP_INFO_FRAME_WORD1;
-		frame2.fr2_val = 1;
+		frame2.regval = 1;
 	} else {
 		info_frame = HDMI_INFO_FRAME_WORD1;
-		frame2.fr2_regx.chnl_cnt = substream->runtime->channels - 1;
+		frame2.regx.chnl_cnt = substream->runtime->channels - 1;
 
-		frame3.fr3_regx.chnl_alloc = snd_intelhad_channel_allocation(
+		frame3.regx.chnl_alloc = snd_intelhad_channel_allocation(
 			intelhaddata, channels);
 
 		/* Calculte the byte wide checksum for all valid DIP words */
 		for (i = 0; i < BYTES_PER_WORD; i++)
-			checksum += (info_frame >> i*BITS_PER_BYTE) & MASK_BYTE0;
+			checksum += (info_frame >> (i * 8)) & 0xff;
 		for (i = 0; i < BYTES_PER_WORD; i++)
-			checksum += (frame2.fr2_val >> i*BITS_PER_BYTE) & MASK_BYTE0;
+			checksum += (frame2.regval >> (i * 8)) & 0xff;
 		for (i = 0; i < BYTES_PER_WORD; i++)
-			checksum += (frame3.fr3_val >> i*BITS_PER_BYTE) & MASK_BYTE0;
+			checksum += (frame3.regval >> (i * 8)) & 0xff;
 
-		frame2.fr2_regx.chksum = -(checksum);
+		frame2.regx.chksum = -(checksum);
 	}
 
 	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, info_frame);
-	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame2.fr2_val);
-	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame3.fr3_val);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame2.regval);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame3.regval);
 
 	/* program remaining DIP words with zero */
 	for (i = 0; i < HAD_MAX_DIP_WORDS-VALID_DIP_WORDS; i++)
 		had_write_register(intelhaddata, AUD_HDMIW_INFOFR, 0x0);
 
-	ctrl_state.ctrl_regx.dip_freq = 1;
-	ctrl_state.ctrl_regx.dip_en_sta = 1;
-	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.ctrl_val);
+	ctrl_state.regx.dip_freq = 1;
+	ctrl_state.regx.dip_en_sta = 1;
+	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.regval);
 }
 
 /*
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 4ccaa8b18566..9dc0da474f05 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -65,7 +65,6 @@
 #define SMPL_WIDTH_16BITS	0x1
 #define SMPL_WIDTH_24BITS	0x5
 #define CHANNEL_ALLOCATION	0x1F
-#define MASK_BYTE0		0x000000FF
 #define VALID_DIP_WORDS		3
 #define LAYOUT0			0
 #define LAYOUT1			1
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index f9c184960b34..0e8397970e4a 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -199,13 +199,7 @@ struct channel_map_table {
 	int spk_mask;                   /* speaker position bit mask */
 };
 
-/**
- * union aud_cfg - Audio configuration
- *
- * @cfg_regx: individual register bits
- * @cfg_regval: full register value
- *
- */
+/* Audio configuration */
 union aud_cfg {
 	struct {
 		u32 aud_en:1;
@@ -222,17 +216,11 @@ union aud_cfg {
 		u32 bogus_sample:1;
 		u32 dp_modei:1;
 		u32 rsvd:16;
-	} cfg_regx;
-	u32 cfg_regval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_ch_status_0 - Audio Channel Status 0 Attributes
- *
- * @status_0_regx:individual register bits
- * @status_0_regval:full register value
- *
- */
+/* Audio Channel Status 0 Attributes */
 union aud_ch_status_0 {
 	struct {
 		u32 ch_status:1;
@@ -246,65 +234,41 @@ union aud_ch_status_0 {
 		u32 samp_freq:4;
 		u32 clk_acc:2;
 		u32 rsvd:2;
-	} status_0_regx;
-	u32 status_0_regval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_ch_status_1 - Audio Channel Status 1 Attributes
- *
- * @status_1_regx: individual register bits
- * @status_1_regval: full register value
- *
- */
+/* Audio Channel Status 1 Attributes */
 union aud_ch_status_1 {
 	struct {
 		u32 max_wrd_len:1;
 		u32 wrd_len:3;
 		u32 rsvd:28;
-		} status_1_regx;
-	u32 status_1_regval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_hdmi_cts - CTS register
- *
- * @cts_regx: individual register bits
- * @cts_regval: full register value
- *
- */
+/* CTS register */
 union aud_hdmi_cts {
 	struct {
 		u32 cts_val:24;
 		u32 en_cts_prog:1;
 		u32 rsvd:7;
-	} cts_regx;
-	u32 cts_regval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_hdmi_n_enable - N register
- *
- * @n_regx: individual register bits
- * @n_regval: full register value
- *
- */
+/* N register */
 union aud_hdmi_n_enable {
 	struct {
 		u32 n_val:24;
 		u32 en_n_prog:1;
 		u32 rsvd:7;
-	} n_regx;
-	u32 n_regval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_buf_config -  Audio Buffer configurations
- *
- * @buf_cfg_regx: individual register bits
- * @buf_cfgval: full register value
- *
- */
+/* Audio Buffer configurations */
 union aud_buf_config {
 	struct {
 		u32 audio_fifo_watermark:8;
@@ -312,17 +276,11 @@ union aud_buf_config {
 		u32 rsvd0:5;
 		u32 aud_delay:8;
 		u32 rsvd1:8;
-	} buf_cfg_regx;
-	u32 buf_cfgval;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_buf_ch_swap - Audio Sample Swapping offset
- *
- * @buf_ch_swap_regx: individual register bits
- * @buf_ch_swap_val: full register value
- *
- */
+/* Audio Sample Swapping offset */
 union aud_buf_ch_swap {
 	struct {
 		u32 first_0:3;
@@ -334,49 +292,31 @@ union aud_buf_ch_swap {
 		u32 first_3:3;
 		u32 second_3:3;
 		u32 rsvd:8;
-	} buf_ch_swap_regx;
-	u32 buf_ch_swap_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_buf_addr - Address for Audio Buffer
- *
- * @buf_addr_regx: individual register bits
- * @buf_addr_val: full register value
- *
- */
+/* Address for Audio Buffer */
 union aud_buf_addr {
 	struct {
 		u32 valid:1;
 		u32 intr_en:1;
 		u32 rsvd:4;
 		u32 addr:26;
-	} buf_addr_regx;
-	u32 buf_addr_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_buf_len - Length of Audio Buffer
- *
- * @buf_len_regx: individual register bits
- * @buf_len_val: full register value
- *
- */
+/* Length of Audio Buffer */
 union aud_buf_len {
 	struct {
 		u32 buf_len:20;
 		u32 rsvd:12;
-	} buf_len_regx;
-	u32 buf_len_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_ctrl_st - Audio Control State Register offset
- *
- * @ctrl_regx: individual register bits
- * @ctrl_val: full register value
- *
- */
+/* Audio Control State Register offset */
 union aud_ctrl_st {
 	struct {
 		u32 ram_addr:4;
@@ -389,34 +329,22 @@ union aud_ctrl_st {
 		u32 dip_idx:3;
 		u32 dip_en_sta:4;
 		u32 rsvd:7;
-	} ctrl_regx;
-	u32 ctrl_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_info_frame1 - Audio HDMI Widget Data Island Packet offset
- *
- * @fr1_regx: individual register bits
- * @fr1_val: full register value
- *
- */
+/* Audio HDMI Widget Data Island Packet offset */
 union aud_info_frame1 {
 	struct {
 		u32 pkt_type:8;
 		u32 ver_num:8;
 		u32 len:5;
 		u32 rsvd:11;
-	} fr1_regx;
-	u32 fr1_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_info_frame2 - DIP frame 2
- *
- * @fr2_regx: individual register bits
- * @fr2_val: full register value
- *
- */
+/* DIP frame 2 */
 union aud_info_frame2 {
 	struct {
 		u32 chksum:8;
@@ -427,17 +355,11 @@ union aud_info_frame2 {
 		u32 smpl_freq:3;
 		u32 rsvd1:3;
 		u32 format:8;
-	} fr2_regx;
-	u32 fr2_val;
+	} regx;
+	u32 regval;
 };
 
-/**
- * union aud_info_frame3 - DIP frame 3
- *
- * @fr3_regx: individual register bits
- * @fr3_val: full register value
- *
- */
+/* DIP frame 3 */
 union aud_info_frame3 {
 	struct {
 		u32 chnl_alloc:8;
@@ -445,8 +367,8 @@ union aud_info_frame3 {
 		u32 lsv:4;
 		u32 dm_inh:1;
 		u32 rsvd1:16;
-	} fr3_regx;
-	u32 fr3_val;
+	} regx;
+	u32 regval;
 };
 
 #define HDMI_AUDIO_UNDERRUN     (1UL<<31)
-- 
2.11.0
