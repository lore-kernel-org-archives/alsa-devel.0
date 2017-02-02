From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 34/53] ALSA: x86: Tidy up codes
Date: Thu,  2 Feb 2017 18:02:48 +0100
Message-ID: <20170202170307.24484-36-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E1299266925
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
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

Clean up codes, fix indentations, correct comments, etc.
No functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 148 +++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 89 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 7c6549a10c1c..46db4883f0b5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -285,7 +285,7 @@ static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
 	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, reset);
 }
 
-/**
+/*
  * initialize audio channel status registers
  * This function is called in the prepare callback
  */
@@ -298,9 +298,9 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	int format;
 
 	ch_stat0.status_0_regx.lpcm_id = (intelhaddata->aes_bits &
-						IEC958_AES0_NONAUDIO)>>1;
+					  IEC958_AES0_NONAUDIO) >> 1;
 	ch_stat0.status_0_regx.clk_acc = (intelhaddata->aes_bits &
-						IEC958_AES3_CON_CLOCK)>>4;
+					  IEC958_AES3_CON_CLOCK) >> 4;
 	cfg_val.cfg_regx_v2.val_bit = ch_stat0.status_0_regx.lpcm_id;
 
 	switch (substream->runtime->rate) {
@@ -330,9 +330,8 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	default:
 		/* control should never come here */
 		return -EINVAL;
-	break;
-
 	}
+
 	had_write_register(intelhaddata,
 			   AUD_CH_STATUS_0, ch_stat0.status_0_regval);
 
@@ -348,6 +347,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 		ch_stat1.status_1_regx.max_wrd_len = 0;
 		ch_stat1.status_1_regx.wrd_len = 0;
 	}
+
 	had_write_register(intelhaddata,
 			   AUD_CH_STATUS_1, ch_stat1.status_1_regval);
 	return 0;
@@ -466,14 +466,14 @@ static int spk_to_chmap(int spk)
 
 static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 {
-	int i = 0, c = 0;
+	int i, c;
 	int spk_mask = 0;
 	struct snd_pcm_chmap_elem *chmap;
 	u8 eld_high, eld_high_mask = 0xF0;
 	u8 high_msb;
 
 	chmap = kzalloc(sizeof(*chmap), GFP_KERNEL);
-	if (chmap == NULL) {
+	if (!chmap) {
 		intelhaddata->chmap->chmap = NULL;
 		return;
 	}
@@ -514,7 +514,7 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 			for (c = 0; c < channel_allocations[i].channels; c++) {
 				chmap->map[c] = spk_to_chmap(
 					channel_allocations[i].speakers[
-						(MAX_SPEAKERS - 1)-c]);
+						(MAX_SPEAKERS - 1) - c]);
 			}
 			chmap->channels = channel_allocations[i].channels;
 			intelhaddata->chmap->chmap = chmap;
@@ -550,12 +550,12 @@ static int had_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct snd_intelhad *intelhaddata = info->private_data;
-	int i = 0;
+	int i;
 	const struct snd_pcm_chmap_elem *chmap;
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
 		return -ENODEV;
-	if (intelhaddata->chmap->chmap ==  NULL)
+	if (!intelhaddata->chmap->chmap)
 		return -ENODATA;
 	chmap = intelhaddata->chmap->chmap;
 	for (i = 0; i < chmap->channels; i++)
@@ -567,7 +567,7 @@ static int had_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 						struct snd_pcm *pcm)
 {
-	int err = 0;
+	int err;
 
 	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			NULL, 0, (unsigned long)intelhaddata,
@@ -615,7 +615,7 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 		frame3.fr3_regx.chnl_alloc = snd_intelhad_channel_allocation(
 			intelhaddata, channels);
 
-		/*Calculte the byte wide checksum for all valid DIP words*/
+		/* Calculte the byte wide checksum for all valid DIP words */
 		for (i = 0; i < BYTES_PER_WORD; i++)
 			checksum += (info_frame >> i*BITS_PER_BYTE) & MASK_BYTE0;
 		for (i = 0; i < BYTES_PER_WORD; i++)
@@ -639,10 +639,8 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.ctrl_val);
 }
 
-/**
- * snd_intelhad_prog_buffer - programs buffer
- * address and length registers
- *
+/*
+ * snd_intelhad_prog_buffer - programs buffer address and length registers
  * @substream:substream for which the prepare function is called
  * @intelhaddata:substream private data
  *
@@ -684,7 +682,7 @@ static int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
 			intelhaddata->buf_info[i].buf_size = period_bytes;
 		else
 			intelhaddata->buf_info[i].buf_size = ring_buf_size -
-							(period_bytes*i);
+							(i * period_bytes);
 
 		had_write_register(intelhaddata,
 				   AUD_BUF_A_ADDR + (i * HAD_REG_WIDTH),
@@ -728,7 +726,7 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
 {
 	u32 maud_val;
 
-	/* Select maud according to DP 1.2 spec*/
+	/* Select maud according to DP 1.2 spec */
 	if (link_rate == DP_2_7_GHZ) {
 		switch (aud_samp_freq) {
 		case AUD_SAMPLE_RATE_32:
@@ -836,41 +834,41 @@ static void snd_intelhad_prog_cts(u32 aud_samp_freq, u32 tmds,
 
 static int had_calculate_n_value(u32 aud_samp_freq)
 {
-	s32 n_val;
+	int n_val;
 
 	/* Select N according to HDMI 1.3a spec*/
 	switch (aud_samp_freq) {
 	case AUD_SAMPLE_RATE_32:
 		n_val = 4096;
-	break;
+		break;
 
 	case AUD_SAMPLE_RATE_44_1:
 		n_val = 6272;
-	break;
+		break;
 
 	case AUD_SAMPLE_RATE_48:
 		n_val = 6144;
-	break;
+		break;
 
 	case AUD_SAMPLE_RATE_88_2:
 		n_val = 12544;
-	break;
+		break;
 
 	case AUD_SAMPLE_RATE_96:
 		n_val = 12288;
-	break;
+		break;
 
 	case AUD_SAMPLE_RATE_176_4:
 		n_val = 25088;
-	break;
+		break;
 
 	case HAD_MAX_RATE:
 		n_val = 24576;
-	break;
+		break;
 
 	default:
 		n_val = -EINVAL;
-	break;
+		break;
 	}
 	return n_val;
 }
@@ -888,7 +886,7 @@ static int had_calculate_n_value(u32 aud_samp_freq)
 static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 			       struct snd_intelhad *intelhaddata)
 {
-	s32 n_val;
+	int n_val;
 
 	if (intelhaddata->dp_output) {
 		/*
@@ -920,7 +918,7 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 	/* Reset buffer pointers */
 	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 1);
 	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 0);
-	/**
+	/*
 	 * The interrupt status 'sticky' bits might not be cleared by
 	 * setting '1' to that bit once...
 	 */
@@ -939,7 +937,7 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 		dev_err(intelhaddata->dev, "Unable to clear UNDERRUN bits\n");
 }
 
-/**
+/*
  * snd_intelhad_open - stream initializations are done here
  * @substream:substream for which the stream function is called
  *
@@ -1029,25 +1027,8 @@ static void had_period_elapsed(struct snd_pcm_substream *substream)
 	snd_pcm_period_elapsed(substream);
 }
 
-/**
- * snd_intelhad_init_stream - internal function to initialize stream info
- * @substream:substream for which the stream function is called
- *
- */
-static int snd_intelhad_init_stream(struct snd_pcm_substream *substream)
-{
-	struct snd_intelhad *intelhaddata = snd_pcm_substream_chip(substream);
-
-	intelhaddata->stream_info.had_substream = substream;
-	intelhaddata->stream_info.buffer_ptr = 0;
-	intelhaddata->stream_info.buffer_rendered = 0;
-	intelhaddata->stream_info.sfreq = substream->runtime->rate;
-	return 0;
-}
-
-/**
- * snd_intelhad_close- to free parameteres when stream is stopped
- *
+/*
+ * snd_intelhad_close - to free parameteres when stream is stopped
  * @substream:  substream for which the function is called
  *
  * This function is called by ALSA framework when stream is stopped
@@ -1081,11 +1062,10 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/**
- * snd_intelhad_hw_params- to setup the hardware parameters
- * like allocating the buffers
- *
- * @substream:  substream for which the function is called
+/*
+ * snd_intelhad_hw_params - to setup the hardware parameters
+ *   like allocating the buffers
+ * @substream: substream for which the function is called
  * @hw_params: hardware parameters
  *
  * This function is called by ALSA framework when hardware params are set
@@ -1121,14 +1101,12 @@ static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
 	return retval;
 }
 
-/**
- * snd_intelhad_hw_free- to release the resources allocated during
- * hardware params setup
- *
+/*
+ * snd_intelhad_hw_free - to release the resources allocated during
+ *   hardware params setup
  * @substream:  substream for which the function is called
  *
  * This function is called by ALSA framework before close callback.
- *
  */
 static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 {
@@ -1146,10 +1124,11 @@ static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/**
+/*
  * snd_intelhad_pcm_trigger - stream activities are handled here
- * @substream:substream for which the stream function is called
- * @cmd:the stream commamd thats requested from upper layer
+ * @substream: substream for which the stream function is called
+ * @cmd: the stream commamd thats requested from upper layer
+ *
  * This function is called whenever an a stream activity is invoked
  */
 static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
@@ -1208,10 +1187,9 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 	return retval;
 }
 
-/**
- * snd_intelhad_pcm_prepare- internal preparation before starting a stream
- *
- * @substream:  substream for which the function is called
+/*
+ * snd_intelhad_pcm_prepare - internal preparation before starting a stream
+ * @substream: substream for which the function is called
  *
  * This function is called when a stream is started for internal preparation.
  */
@@ -1252,10 +1230,10 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 		return retval;
 	}
 
-	retval = snd_intelhad_init_stream(substream);
-	if (retval)
-		goto prep_end;
-
+	intelhaddata->stream_info.had_substream = substream;
+	intelhaddata->stream_info.buffer_ptr = 0;
+	intelhaddata->stream_info.buffer_rendered = 0;
+	intelhaddata->stream_info.sfreq = substream->runtime->rate;
 
 	/* Get N value in KHz */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
@@ -1294,10 +1272,9 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	return retval;
 }
 
-/**
+/*
  * snd_intelhad_pcm_pointer- to send the current buffer pointerprocessed by hw
- *
- * @substream:  substream for which the function is called
+ * @substream: substream for which the function is called
  *
  * This function is called by ALSA framework to get the current hw buffer ptr
  * when a period is elapsed
@@ -1359,11 +1336,10 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 	return intelhaddata->stream_info.buffer_ptr;
 }
 
-/**
+/*
  * snd_intelhad_pcm_mmap- mmaps a kernel buffer to user space for copying data
- *
- * @substream:  substream for which the function is called
- * @vma:		struct instance of memory VMM memory area
+ * @substream: substream for which the function is called
+ * @vma: struct instance of memory VMM memory area
  *
  * This function is called by OS when a user space component
  * tries to get mmap memory from driver
@@ -1418,11 +1394,9 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 
 /*
  * hdmi_lpe_audio_suspend - power management suspend function
- *
  * @pdev: platform device
  *
- * This function is called by client driver to suspend the
- * hdmi audio.
+ * This function is called to suspend the hdmi audio.
  */
 static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 				  pm_message_t state)
@@ -1465,11 +1439,9 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 
 /*
  * hdmi_lpe_audio_resume - power management resume function
+ * @pdev: platform device
  *
- *@pdev: platform device
- *
- * This function is called by client driver to resume the
- * hdmi audio.
+ * This function is called to resume the hdmi audio.
  */
 static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 {
@@ -1605,7 +1577,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 		return 0;
 	}
 
-	/*Reprogram the registers with addr and length*/
+	/* Reprogram the registers with addr and length */
 	had_write_register(intelhaddata,
 			   AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
 			   buf_size);
@@ -1939,8 +1911,7 @@ static void hdmi_lpe_audio_free(struct snd_card *card)
  * hdmi_lpe_audio_probe - start bridge with i915
  *
  * This function is called when the i915 driver creates the
- * hdmi-lpe-audio platform device. Card creation is deferred until a
- * hot plug event is received
+ * hdmi-lpe-audio platform device.
  */
 static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 {
@@ -2084,8 +2055,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 /*
  * hdmi_lpe_audio_remove - stop bridge with i915
  *
- * This function is called when the platform device is destroyed. The sound
- * card should have been removed on hot plug event.
+ * This function is called when the platform device is destroyed.
  */
 static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
-- 
2.11.0
