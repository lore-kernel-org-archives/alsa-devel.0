From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 35/53] ALSA: x86: Remove _v[12] suffices
Date: Thu,  2 Feb 2017 18:02:49 +0100
Message-ID: <20170202170307.24484-37-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 81B12267589
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:17 +0100 (CET)
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

Although we dropped the most of the obsoleted *_v1 definitions and
codes, some codes still keep the _v1 or _v2 suffices.  Now they are
ripped off.

The only thing to be done carefully here is the definition of control
offsets.  The original code defines enum hdmi_ctrl_reg_offset_v1 and
a few new elements just for v2 on its top.  After this cleanup, we
remove the old AUD_HDMI_STATUS and AUD_HDMIW_INFOFR definitions and
replace with the v2 values.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 46 ++++++++++++++++++++--------------------
 sound/x86/intel_hdmi_audio.h     |  2 +-
 sound/x86/intel_hdmi_lpe_audio.h | 24 ++++++---------------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 46db4883f0b5..84b374cc183f 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -249,10 +249,10 @@ static int had_read_modify_aud_config_v2(struct snd_intelhad *intelhaddata,
 		channels = substream->runtime->channels;
 	else
 		channels = 2;
-	cfg_val.cfg_regx_v2.num_ch = channels - 2;
+	cfg_val.cfg_regx.num_ch = channels - 2;
 
 	data = data | cfg_val.cfg_regval;
-	mask = mask | AUD_CONFIG_CH_MASK_V2;
+	mask = mask | AUD_CONFIG_CH_MASK;
 
 	dev_dbg(intelhaddata->dev, "%s : data = %x, mask =%x\n",
 		__func__, data, mask);
@@ -265,10 +265,10 @@ static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 	u32 status_reg;
 
 	if (enable) {
-		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS_v2, &status_reg);
+		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS, &status_reg);
 		status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-		mid_hdmi_audio_write(ctx, AUD_HDMI_STATUS_v2, status_reg);
-		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS_v2, &status_reg);
+		mid_hdmi_audio_write(ctx, AUD_HDMI_STATUS, status_reg);
+		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS, &status_reg);
 	}
 }
 
@@ -282,7 +282,7 @@ static void snd_intelhad_enable_audio(struct snd_intelhad *intelhaddata,
 static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
 				     u8 reset)
 {
-	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, reset);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS, reset);
 }
 
 /*
@@ -301,7 +301,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 					  IEC958_AES0_NONAUDIO) >> 1;
 	ch_stat0.status_0_regx.clk_acc = (intelhaddata->aes_bits &
 					  IEC958_AES3_CON_CLOCK) >> 4;
-	cfg_val.cfg_regx_v2.val_bit = ch_stat0.status_0_regx.lpcm_id;
+	cfg_val.cfg_regx.val_bit = ch_stat0.status_0_regx.lpcm_id;
 
 	switch (substream->runtime->rate) {
 	case AUD_SAMPLE_RATE_32:
@@ -367,19 +367,19 @@ static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
 
 	had_prog_status_reg(substream, intelhaddata);
 
-	buf_cfg.buf_cfg_regx_v2.audio_fifo_watermark = FIFO_THRESHOLD;
-	buf_cfg.buf_cfg_regx_v2.dma_fifo_watermark = DMA_FIFO_THRESHOLD;
-	buf_cfg.buf_cfg_regx_v2.aud_delay = 0;
+	buf_cfg.buf_cfg_regx.audio_fifo_watermark = FIFO_THRESHOLD;
+	buf_cfg.buf_cfg_regx.dma_fifo_watermark = DMA_FIFO_THRESHOLD;
+	buf_cfg.buf_cfg_regx.aud_delay = 0;
 	had_write_register(intelhaddata, AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
 
 	channels = substream->runtime->channels;
-	cfg_val.cfg_regx_v2.num_ch = channels - 2;
+	cfg_val.cfg_regx.num_ch = channels - 2;
 	if (channels <= 2)
-		cfg_val.cfg_regx_v2.layout = LAYOUT0;
+		cfg_val.cfg_regx.layout = LAYOUT0;
 	else
-		cfg_val.cfg_regx_v2.layout = LAYOUT1;
+		cfg_val.cfg_regx.layout = LAYOUT1;
 
-	cfg_val.cfg_regx_v2.val_bit = 1;
+	cfg_val.cfg_regx.val_bit = 1;
 	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.cfg_regval);
 	return 0;
 }
@@ -626,13 +626,13 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 		frame2.fr2_regx.chksum = -(checksum);
 	}
 
-	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, info_frame);
-	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, frame2.fr2_val);
-	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, frame3.fr3_val);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, info_frame);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame2.fr2_val);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR, frame3.fr3_val);
 
 	/* program remaining DIP words with zero */
 	for (i = 0; i < HAD_MAX_DIP_WORDS-VALID_DIP_WORDS; i++)
-		had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, 0x0);
+		had_write_register(intelhaddata, AUD_HDMIW_INFOFR, 0x0);
 
 	ctrl_state.ctrl_regx.dip_freq = 1;
 	ctrl_state.ctrl_regx.dip_en_sta = 1;
@@ -916,20 +916,20 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 	/* Handle Underrun interrupt within Audio Unit */
 	had_write_register(intelhaddata, AUD_CONFIG, 0);
 	/* Reset buffer pointers */
-	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 1);
-	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 0);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS, 1);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS, 0);
 	/*
 	 * The interrupt status 'sticky' bits might not be cleared by
 	 * setting '1' to that bit once...
 	 */
 	do { /* clear bit30, 31 AUD_HDMI_STATUS */
-		had_read_register(intelhaddata, AUD_HDMI_STATUS_v2,
+		had_read_register(intelhaddata, AUD_HDMI_STATUS,
 				  &hdmi_status);
 		dev_dbg(intelhaddata->dev, "HDMI status =0x%x\n", hdmi_status);
 		if (hdmi_status & AUD_CONFIG_MASK_UNDERRUN) {
 			i++;
 			had_write_register(intelhaddata,
-					   AUD_HDMI_STATUS_v2, hdmi_status);
+					   AUD_HDMI_STATUS, hdmi_status);
 		} else
 			break;
 	} while (i < MAX_CNT);
@@ -1812,7 +1812,7 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 	struct snd_intelhad *ctx = dev_id;
 	u32 audio_stat, audio_reg;
 
-	audio_reg = AUD_HDMI_STATUS_v2;
+	audio_reg = AUD_HDMI_STATUS;
 	mid_hdmi_audio_read(ctx, audio_reg, &audio_stat);
 
 	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 4549c4d9d650..8b85a5668d83 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -69,7 +69,7 @@
 #define LAYOUT0			0
 #define LAYOUT1			1
 #define SWAP_LFE_CENTER		0x00fac4c8
-#define AUD_CONFIG_CH_MASK_V2	0x70
+#define AUD_CONFIG_CH_MASK	0x70
 
 struct pcm_stream_info {
 	int		str_id;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 8f320b4aa3b7..628c578ecedf 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -277,7 +277,7 @@ enum hdmi_ctrl_reg_offset_common {
 	AUDIO_HDMI_CONFIG_C = 0x900,
 };
 /* HDMI controller register offsets */
-enum hdmi_ctrl_reg_offset_v1 {
+enum hdmi_ctrl_reg_offset {
 	AUD_CONFIG		= 0x0,
 	AUD_CH_STATUS_0		= 0x08,
 	AUD_CH_STATUS_1		= 0x0C,
@@ -295,18 +295,8 @@ enum hdmi_ctrl_reg_offset_v1 {
 	AUD_BUF_D_ADDR		= 0x58,
 	AUD_BUF_D_LENGTH	= 0x5c,
 	AUD_CNTL_ST		= 0x60,
-	AUD_HDMI_STATUS		= 0x68,
-	AUD_HDMIW_INFOFR	= 0x114,
-};
-
-/*
- * Delta changes in HDMI controller register offsets
- * compare to v1 version
- */
-
-enum hdmi_ctrl_reg_offset_v2 {
-	AUD_HDMI_STATUS_v2	= 0x64,
-	AUD_HDMIW_INFOFR_v2	= 0x68,
+	AUD_HDMI_STATUS		= 0x64, /* v2 */
+	AUD_HDMIW_INFOFR	= 0x68, /* v2 */
 };
 
 /*
@@ -374,7 +364,7 @@ union aud_cfg {
 		u32 bogus_sample:1;
 		u32 dp_modei:1;
 		u32 rsvd:16;
-	} cfg_regx_v2;
+	} cfg_regx;
 	u32 cfg_regval;
 };
 
@@ -430,7 +420,7 @@ union aud_hdmi_cts {
 		u32 cts_val:24;
 		u32 en_cts_prog:1;
 		u32 rsvd:7;
-	} cts_regx_v2;
+	} cts_regx;
 	u32 cts_regval;
 };
 
@@ -446,7 +436,7 @@ union aud_hdmi_n_enable {
 		u32 n_val:24;
 		u32 en_n_prog:1;
 		u32 rsvd:7;
-	} n_regx_v2;
+	} n_regx;
 	u32 n_regval;
 };
 
@@ -464,7 +454,7 @@ union aud_buf_config {
 		u32 rsvd0:5;
 		u32 aud_delay:8;
 		u32 rsvd1:8;
-	} buf_cfg_regx_v2;
+	} buf_cfg_regx;
 	u32 buf_cfgval;
 };
 
-- 
2.11.0
