From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/53] ALSA: x86: Remove v1 ops and structs
Date: Thu,  2 Feb 2017 18:02:16 +0100
Message-ID: <20170202170307.24484-4-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C377266832
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:14 +0100 (CET)
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

The v1 code refers to Medfield/Clovertrail, and it's not used at all
in the current driver, and probably won't be ever.  Let's clean this
up, then we can go further cleaning up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 206 +--------------------------------------
 sound/x86/intel_hdmi_lpe_audio.h |  29 ------
 2 files changed, 1 insertion(+), 234 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5ce139c1b21d..1e0bc72a8f63 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -280,23 +280,12 @@ static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 	return had_read_modify(AUD_CONFIG, data, mask);
 }
 
-static void snd_intelhad_enable_audio_v1(struct snd_pcm_substream *substream,
-					u8 enable)
-{
-	had_read_modify(AUD_CONFIG, enable, BIT(0));
-}
-
 static void snd_intelhad_enable_audio_v2(struct snd_pcm_substream *substream,
 					u8 enable)
 {
 	had_read_modify_aud_config_v2(substream, enable, BIT(0));
 }
 
-static void snd_intelhad_reset_audio_v1(u8 reset)
-{
-	had_write_register(AUD_HDMI_STATUS, reset);
-}
-
 static void snd_intelhad_reset_audio_v2(u8 reset)
 {
 	had_write_register(AUD_HDMI_STATUS_v2, reset);
@@ -320,7 +309,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 						IEC958_AES0_NONAUDIO)>>1;
 	ch_stat0.status_0_regx.clk_acc = (intelhaddata->aes_bits &
 						IEC958_AES3_CON_CLOCK)>>4;
-	cfg_val.cfg_regx.val_bit = ch_stat0.status_0_regx.lpcm_id;
+	cfg_val.cfg_regx_v2.val_bit = ch_stat0.status_0_regx.lpcm_id;
 
 	switch (substream->runtime->rate) {
 	case AUD_SAMPLE_RATE_32:
@@ -401,58 +390,6 @@ static int snd_intelhad_prog_audio_ctrl_v2(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
- * function to initialize audio
- * registers and buffer confgiuration registers
- * This function is called in the prepare callback
- */
-static int snd_intelhad_prog_audio_ctrl_v1(struct snd_pcm_substream *substream,
-					struct snd_intelhad *intelhaddata)
-{
-	union aud_cfg cfg_val = {.cfg_regval = 0};
-	union aud_buf_config buf_cfg = {.buf_cfgval = 0};
-	u8 channels;
-
-	had_prog_status_reg(substream, intelhaddata);
-
-	buf_cfg.buf_cfg_regx.fifo_width = FIFO_THRESHOLD;
-	buf_cfg.buf_cfg_regx.aud_delay = 0;
-	had_write_register(AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
-
-	channels = substream->runtime->channels;
-
-	switch (channels) {
-	case 1:
-	case 2:
-		cfg_val.cfg_regx.num_ch = CH_STEREO;
-		cfg_val.cfg_regx.layout = LAYOUT0;
-	break;
-
-	case 3:
-	case 4:
-		cfg_val.cfg_regx.num_ch = CH_THREE_FOUR;
-		cfg_val.cfg_regx.layout = LAYOUT1;
-	break;
-
-	case 5:
-	case 6:
-		cfg_val.cfg_regx.num_ch = CH_FIVE_SIX;
-		cfg_val.cfg_regx.layout = LAYOUT1;
-	break;
-
-	case 7:
-	case 8:
-		cfg_val.cfg_regx.num_ch = CH_SEVEN_EIGHT;
-		cfg_val.cfg_regx.layout = LAYOUT1;
-	break;
-
-	}
-
-	cfg_val.cfg_regx.val_bit = 1;
-	had_write_register(AUD_CONFIG, cfg_val.cfg_regval);
-	return 0;
-}
-
 /*
  * Compute derived values in channel_allocations[].
  */
@@ -660,56 +597,6 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 }
 
 /**
- * snd_intelhad_prog_dip_v1 - to initialize Data Island Packets registers
- *
- * @substream:substream for which the prepare function is called
- * @intelhaddata:substream private data
- *
- * This function is called in the prepare callback
- */
-static void snd_intelhad_prog_dip_v1(struct snd_pcm_substream *substream,
-				struct snd_intelhad *intelhaddata)
-{
-	int i;
-	union aud_ctrl_st ctrl_state = {.ctrl_val = 0};
-	union aud_info_frame2 frame2 = {.fr2_val = 0};
-	union aud_info_frame3 frame3 = {.fr3_val = 0};
-	u8 checksum = 0;
-	int channels;
-
-	channels = substream->runtime->channels;
-
-	had_write_register(AUD_CNTL_ST, ctrl_state.ctrl_val);
-
-	frame2.fr2_regx.chnl_cnt = substream->runtime->channels - 1;
-
-	frame3.fr3_regx.chnl_alloc = snd_intelhad_channel_allocation(
-					intelhaddata, channels);
-
-	/*Calculte the byte wide checksum for all valid DIP words*/
-	for (i = 0; i < BYTES_PER_WORD; i++)
-		checksum += (HDMI_INFO_FRAME_WORD1 >> i*BITS_PER_BYTE) & MASK_BYTE0;
-	for (i = 0; i < BYTES_PER_WORD; i++)
-		checksum += (frame2.fr2_val >> i*BITS_PER_BYTE) & MASK_BYTE0;
-	for (i = 0; i < BYTES_PER_WORD; i++)
-		checksum += (frame3.fr3_val >> i*BITS_PER_BYTE) & MASK_BYTE0;
-
-	frame2.fr2_regx.chksum = -(checksum);
-
-	had_write_register(AUD_HDMIW_INFOFR, HDMI_INFO_FRAME_WORD1);
-	had_write_register(AUD_HDMIW_INFOFR, frame2.fr2_val);
-	had_write_register(AUD_HDMIW_INFOFR, frame3.fr3_val);
-
-	/* program remaining DIP words with zero */
-	for (i = 0; i < HAD_MAX_DIP_WORDS-VALID_DIP_WORDS; i++)
-		had_write_register(AUD_HDMIW_INFOFR, 0x0);
-
-	ctrl_state.ctrl_regx.dip_freq = 1;
-	ctrl_state.ctrl_regx.dip_en_sta = 1;
-	had_write_register(AUD_CNTL_ST, ctrl_state.ctrl_val);
-}
-
-/**
  * snd_intelhad_prog_dip_v2 - to initialize Data Island Packets registers
  *
  * @substream:substream for which the prepare function is called
@@ -929,32 +816,6 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
 }
 
 /**
- * snd_intelhad_prog_cts_v1 - Program HDMI audio CTS value
- *
- * @aud_samp_freq: sampling frequency of audio data
- * @tmds: sampling frequency of the display data
- * @n_param: N value, depends on aud_samp_freq
- * @intelhaddata:substream private data
- *
- * Program CTS register based on the audio and display sampling frequency
- */
-static void snd_intelhad_prog_cts_v1(u32 aud_samp_freq, u32 tmds,
-				     u32 link_rate, u32 n_param,
-				     struct snd_intelhad *intelhaddata)
-{
-	u32 cts_val;
-	u64 dividend, divisor;
-
-	/* Calculate CTS according to HDMI 1.3a spec*/
-	dividend = (u64)tmds * n_param*1000;
-	divisor = 128 * aud_samp_freq;
-	cts_val = div64_u64(dividend, divisor);
-	pr_debug("TMDS value=%d, N value=%d, CTS Value=%d\n",
-			tmds, n_param, cts_val);
-	had_write_register(AUD_HDMI_CTS, (BIT(20) | cts_val));
-}
-
-/**
  * snd_intelhad_prog_cts_v2 - Program HDMI audio CTS value
  *
  * @aud_samp_freq: sampling frequency of audio data
@@ -1027,31 +888,6 @@ static int had_calculate_n_value(u32 aud_samp_freq)
 }
 
 /**
- * snd_intelhad_prog_n_v1 - Program HDMI audio N value
- *
- * @aud_samp_freq: sampling frequency of audio data
- * @n_param: N value, depends on aud_samp_freq
- * @intelhaddata:substream private data
- *
- * This function is called in the prepare callback.
- * It programs based on the audio and display sampling frequency
- */
-static int snd_intelhad_prog_n_v1(u32 aud_samp_freq, u32 *n_param,
-				struct snd_intelhad *intelhaddata)
-{
-	s32 n_val;
-
-	n_val =	had_calculate_n_value(aud_samp_freq);
-
-	if (n_val < 0)
-		return n_val;
-
-	had_write_register(AUD_N_ENABLE, (BIT(20) | n_val));
-	*n_param = n_val;
-	return 0;
-}
-
-/**
  * snd_intelhad_prog_n_v2 - Program HDMI audio N value
  *
  * @aud_samp_freq: sampling frequency of audio data
@@ -1087,35 +923,6 @@ static int snd_intelhad_prog_n_v2(u32 aud_samp_freq, u32 *n_param,
 	return 0;
 }
 
-static void had_clear_underrun_intr_v1(struct snd_intelhad *intelhaddata)
-{
-	u32 hdmi_status, i = 0;
-
-	/* Handle Underrun interrupt within Audio Unit */
-	had_write_register(AUD_CONFIG, 0);
-	/* Reset buffer pointers */
-	had_write_register(AUD_HDMI_STATUS, 1);
-	had_write_register(AUD_HDMI_STATUS, 0);
-	/**
-	 * The interrupt status 'sticky' bits might not be cleared by
-	 * setting '1' to that bit once...
-	 */
-	do { /* clear bit30, 31 AUD_HDMI_STATUS */
-		had_read_register(AUD_HDMI_STATUS, &hdmi_status);
-		pr_debug("HDMI status =0x%x\n", hdmi_status);
-		if (hdmi_status & AUD_CONFIG_MASK_UNDERRUN) {
-			i++;
-			hdmi_status &= (AUD_CONFIG_MASK_SRDBG |
-					AUD_CONFIG_MASK_FUNCRST);
-			hdmi_status |= ~AUD_CONFIG_MASK_UNDERRUN;
-			had_write_register(AUD_HDMI_STATUS, hdmi_status);
-		} else
-			break;
-	} while (i < MAX_CNT);
-	if (i >= MAX_CNT)
-		pr_err("Unable to clear UNDERRUN bits\n");
-}
-
 static void had_clear_underrun_intr_v2(struct snd_intelhad *intelhaddata)
 {
 	u32 hdmi_status, i = 0;
@@ -1775,16 +1582,6 @@ static struct snd_intel_had_interface had_interface = {
 	.resume =       hdmi_audio_resume,
 };
 
-static struct had_ops had_ops_v1 = {
-	.enable_audio = snd_intelhad_enable_audio_v1,
-	.reset_audio = snd_intelhad_reset_audio_v1,
-	.prog_n =	snd_intelhad_prog_n_v1,
-	.prog_cts =	snd_intelhad_prog_cts_v1,
-	.audio_ctrl =	snd_intelhad_prog_audio_ctrl_v1,
-	.prog_dip =	snd_intelhad_prog_dip_v1,
-	.handle_underrun =  had_clear_underrun_intr_v1,
-};
-
 static struct had_ops had_ops_v2 = {
 	.enable_audio = snd_intelhad_enable_audio_v2,
 	.reset_audio = snd_intelhad_reset_audio_v2,
@@ -1934,7 +1731,6 @@ int hdmi_audio_probe(void *deviceptr)
 	}
 
 	intelhaddata->hw_silence = 1;
-	had_ops_v1 = had_ops_v1;	/* unused */
 	intelhaddata->ops = &had_ops_v2;
 
 	return retval;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 3aed89af5b45..5d94aaf0b980 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -362,19 +362,6 @@ union aud_cfg {
 		u32 aud_en:1;
 		u32 layout:1;
 		u32 fmt:2;
-		u32 num_ch:2;
-		u32 rsvd0:1;
-		u32 set:1;
-		u32 flat:1;
-		u32 val_bit:1;
-		u32 user_bit:1;
-		u32 underrun:1;
-		u32 rsvd1:20;
-	} cfg_regx;
-	struct {
-		u32 aud_en:1;
-		u32 layout:1;
-		u32 fmt:2;
 		u32 num_ch:3;
 		u32 set:1;
 		u32 flat:1;
@@ -439,11 +426,6 @@ union aud_ch_status_1 {
  */
 union aud_hdmi_cts {
 	struct {
-		u32 cts_val:20;
-		u32 en_cts_prog:1;
-		u32 rsvd:11;
-	} cts_regx;
-	struct {
 		u32 cts_val:24;
 		u32 en_cts_prog:1;
 		u32 rsvd:7;
@@ -460,11 +442,6 @@ union aud_hdmi_cts {
  */
 union aud_hdmi_n_enable {
 	struct {
-		u32 n_val:20;
-		u32 en_n_prog:1;
-		u32 rsvd:11;
-	} n_regx;
-	struct {
 		u32 n_val:24;
 		u32 en_n_prog:1;
 		u32 rsvd:7;
@@ -481,12 +458,6 @@ union aud_hdmi_n_enable {
  */
 union aud_buf_config {
 	struct {
-		u32 fifo_width:8;
-		u32 rsvd0:8;
-		u32 aud_delay:8;
-		u32 rsvd1:8;
-	} buf_cfg_regx;
-	struct {
 		u32 audio_fifo_watermark:8;
 		u32 dma_fifo_watermark:3;
 		u32 rsvd0:5;
-- 
2.11.0
