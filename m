From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/53] ALSA: x86: Pass snd_intelhad object to
	helpers
Date: Thu,  2 Feb 2017 18:02:21 +0100
Message-ID: <20170202170307.24484-9-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5293A266838
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

For reducing the global variable reference, keep snd_intelhad object
in the context and pass it to each helper.  It's a preliminary change
for further cleanup.

This also includes the simplification of the probe procedure: the LPE
platform driver directly gets the created snd_intelhad object by
hdmi_audio_probe(), and passes it to each helper and destructor,
hdmi_audio_remove().  The hdmi_audio_probe() function doesn't call the
back-registration any longer, which is fairly useless.  The LPE
platform driver initializes the stuff instead at the right place, and
calls the wq after the object creation in the probe function itself.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 143 ++++++++++++++++++++-------------------
 sound/x86/intel_hdmi_audio.h     |  24 ++++---
 sound/x86/intel_hdmi_audio_if.c  |  44 ++++++------
 sound/x86/intel_hdmi_lpe_audio.c |  49 +++++---------
 sound/x86/intel_hdmi_lpe_audio.h |   1 -
 5 files changed, 131 insertions(+), 130 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index bff46061e5c5..45ba16e27323 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -42,7 +42,6 @@ static DEFINE_MUTEX(had_mutex);
 /*standard module options for ALSA. This module supports only one card*/
 static int hdmi_card_index = SNDRV_DEFAULT_IDX1;
 static char *hdmi_card_id = SNDRV_DEFAULT_STR1;
-static struct snd_intelhad *had_data;
 static int underrun_count;
 
 module_param_named(index, hdmi_card_index, int, 0444);
@@ -172,10 +171,10 @@ int had_get_hwstate(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
-int had_get_caps(enum had_caps_list query, void *caps)
+int had_get_caps(struct snd_intelhad *intelhaddata,
+		 enum had_caps_list query, void *caps)
 {
 	int retval;
-	struct snd_intelhad *intelhaddata = had_data;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
@@ -184,10 +183,10 @@ int had_get_caps(enum had_caps_list query, void *caps)
 	return retval;
 }
 
-int had_set_caps(enum had_caps_list set_element, void *caps)
+int had_set_caps(struct snd_intelhad *intelhaddata,
+		 enum had_caps_list set_element, void *caps)
 {
 	int retval;
-	struct snd_intelhad *intelhaddata = had_data;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
@@ -196,10 +195,9 @@ int had_set_caps(enum had_caps_list set_element, void *caps)
 	return retval;
 }
 
-int had_read_register(u32 offset, u32 *data)
+int had_read_register(struct snd_intelhad *intelhaddata, u32 offset, u32 *data)
 {
 	int retval;
-	struct snd_intelhad *intelhaddata = had_data;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
@@ -208,10 +206,9 @@ int had_read_register(u32 offset, u32 *data)
 	return retval;
 }
 
-int had_write_register(u32 offset, u32 data)
+int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
 {
 	int retval;
-	struct snd_intelhad *intelhaddata = had_data;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
@@ -220,10 +217,10 @@ int had_write_register(u32 offset, u32 data)
 	return retval;
 }
 
-int had_read_modify(u32 offset, u32 data, u32 mask)
+int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
+		    u32 data, u32 mask)
 {
 	int retval;
-	struct snd_intelhad *intelhaddata = had_data;
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
@@ -253,6 +250,7 @@ int had_read_modify(u32 offset, u32 data, u32 mask)
 static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 					u32 data, u32 mask)
 {
+	struct snd_intelhad *intelhaddata = snd_pcm_substream_chip(substream);
 	union aud_cfg cfg_val = {.cfg_regval = 0};
 	u8 channels;
 
@@ -271,7 +269,7 @@ static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 
 	pr_debug("%s : data = %x, mask =%x\n", __func__, data, mask);
 
-	return had_read_modify(AUD_CONFIG, data, mask);
+	return had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
 }
 
 void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable)
@@ -279,9 +277,10 @@ void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable)
 	had_read_modify_aud_config_v2(substream, enable, BIT(0));
 }
 
-static void snd_intelhad_reset_audio(u8 reset)
+static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
+				     u8 reset)
 {
-	had_write_register(AUD_HDMI_STATUS_v2, reset);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, reset);
 }
 
 /**
@@ -334,7 +333,8 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	break;
 
 	}
-	had_write_register(AUD_CH_STATUS_0, ch_stat0.status_0_regval);
+	had_write_register(intelhaddata,
+			   AUD_CH_STATUS_0, ch_stat0.status_0_regval);
 
 	format = substream->runtime->format;
 
@@ -348,7 +348,8 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 		ch_stat1.status_1_regx.max_wrd_len = 0;
 		ch_stat1.status_1_regx.wrd_len = 0;
 	}
-	had_write_register(AUD_CH_STATUS_1, ch_stat1.status_1_regval);
+	had_write_register(intelhaddata,
+			   AUD_CH_STATUS_1, ch_stat1.status_1_regval);
 	return 0;
 }
 
@@ -369,7 +370,7 @@ static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
 	buf_cfg.buf_cfg_regx_v2.audio_fifo_watermark = FIFO_THRESHOLD;
 	buf_cfg.buf_cfg_regx_v2.dma_fifo_watermark = DMA_FIFO_THRESHOLD;
 	buf_cfg.buf_cfg_regx_v2.aud_delay = 0;
-	had_write_register(AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
+	had_write_register(intelhaddata, AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
 
 	channels = substream->runtime->channels;
 	cfg_val.cfg_regx_v2.num_ch = channels - 2;
@@ -379,7 +380,7 @@ static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
 		cfg_val.cfg_regx_v2.layout = LAYOUT1;
 
 	cfg_val.cfg_regx_v2.val_bit = 1;
-	had_write_register(AUD_CONFIG, cfg_val.cfg_regval);
+	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.cfg_regval);
 	return 0;
 }
 
@@ -479,8 +480,8 @@ void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 		return;
 	}
 
-	had_get_caps(HAD_GET_ELD, &intelhaddata->eeld);
-	had_get_caps(HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
+	had_get_caps(intelhaddata, HAD_GET_ELD, &intelhaddata->eeld);
+	had_get_caps(intelhaddata, HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
 
 	pr_debug("eeld.speaker_allocation_block = %x\n",
 			intelhaddata->eeld.speaker_allocation_block);
@@ -610,7 +611,7 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 
 	channels = substream->runtime->channels;
 
-	had_write_register(AUD_CNTL_ST, ctrl_state.ctrl_val);
+	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.ctrl_val);
 
 	if (intelhaddata->dp_output) {
 		info_frame = DP_INFO_FRAME_WORD1;
@@ -633,17 +634,17 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 		frame2.fr2_regx.chksum = -(checksum);
 	}
 
-	had_write_register(AUD_HDMIW_INFOFR_v2, info_frame);
-	had_write_register(AUD_HDMIW_INFOFR_v2, frame2.fr2_val);
-	had_write_register(AUD_HDMIW_INFOFR_v2, frame3.fr3_val);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, info_frame);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, frame2.fr2_val);
+	had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, frame3.fr3_val);
 
 	/* program remaining DIP words with zero */
 	for (i = 0; i < HAD_MAX_DIP_WORDS-VALID_DIP_WORDS; i++)
-		had_write_register(AUD_HDMIW_INFOFR_v2, 0x0);
+		had_write_register(intelhaddata, AUD_HDMIW_INFOFR_v2, 0x0);
 
 	ctrl_state.ctrl_regx.dip_freq = 1;
 	ctrl_state.ctrl_regx.dip_en_sta = 1;
-	had_write_register(AUD_CNTL_ST, ctrl_state.ctrl_val);
+	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.ctrl_val);
 }
 
 /**
@@ -696,10 +697,12 @@ int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
 			intelhaddata->buf_info[i].buf_size = ring_buf_size -
 							(period_bytes*i);
 
-		had_write_register(AUD_BUF_A_ADDR + (i * HAD_REG_WIDTH),
+		had_write_register(intelhaddata,
+				   AUD_BUF_A_ADDR + (i * HAD_REG_WIDTH),
 					intelhaddata->buf_info[i].buf_addr |
 					BIT(0) | BIT(1));
-		had_write_register(AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
+		had_write_register(intelhaddata,
+				   AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
 					period_bytes);
 		intelhaddata->buf_info[i].is_valid = true;
 	}
@@ -716,8 +719,9 @@ int snd_intelhad_read_len(struct snd_intelhad *intelhaddata)
 	u32 len[4];
 
 	for (i = 0; i < 4 ; i++) {
-		had_read_register(AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
-					&len[i]);
+		had_read_register(intelhaddata,
+				  AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
+				  &len[i]);
 		if (!len[i])
 			retval++;
 	}
@@ -836,7 +840,7 @@ static void snd_intelhad_prog_cts(u32 aud_samp_freq, u32 tmds,
 	}
 	pr_debug("TMDS value=%d, N value=%d, CTS Value=%d\n",
 		 tmds, n_param, cts_val);
-	had_write_register(AUD_HDMI_CTS, (BIT(24) | cts_val));
+	had_write_register(intelhaddata, AUD_HDMI_CTS, (BIT(24) | cts_val));
 }
 
 static int had_calculate_n_value(u32 aud_samp_freq)
@@ -911,7 +915,7 @@ static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 	if (n_val < 0)
 		return n_val;
 
-	had_write_register(AUD_N_ENABLE, (BIT(24) | n_val));
+	had_write_register(intelhaddata, AUD_N_ENABLE, (BIT(24) | n_val));
 	*n_param = n_val;
 	return 0;
 }
@@ -921,20 +925,22 @@ void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 	u32 hdmi_status, i = 0;
 
 	/* Handle Underrun interrupt within Audio Unit */
-	had_write_register(AUD_CONFIG, 0);
+	had_write_register(intelhaddata, AUD_CONFIG, 0);
 	/* Reset buffer pointers */
-	had_write_register(AUD_HDMI_STATUS_v2, 1);
-	had_write_register(AUD_HDMI_STATUS_v2, 0);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 1);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS_v2, 0);
 	/**
 	 * The interrupt status 'sticky' bits might not be cleared by
 	 * setting '1' to that bit once...
 	 */
 	do { /* clear bit30, 31 AUD_HDMI_STATUS */
-		had_read_register(AUD_HDMI_STATUS_v2, &hdmi_status);
+		had_read_register(intelhaddata, AUD_HDMI_STATUS_v2,
+				  &hdmi_status);
 		pr_debug("HDMI status =0x%x\n", hdmi_status);
 		if (hdmi_status & AUD_CONFIG_MASK_UNDERRUN) {
 			i++;
-			had_write_register(AUD_HDMI_STATUS_v2, hdmi_status);
+			had_write_register(intelhaddata,
+					   AUD_HDMI_STATUS_v2, hdmi_status);
 		} else
 			break;
 	} while (i < MAX_CNT);
@@ -1200,8 +1206,9 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		 *   caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
 		 */
 		caps = HDMI_AUDIO_BUFFER_DONE;
-		retval = had_set_caps(HAD_SET_ENABLE_AUDIO_INT, &caps);
-		retval = had_set_caps(HAD_SET_ENABLE_AUDIO, NULL);
+		retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO_INT,
+				      &caps);
+		retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO, NULL);
 		snd_intelhad_enable_audio(substream, 1);
 
 		pr_debug("Processed _Start\n");
@@ -1224,13 +1231,13 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		 *   caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
 		 */
 		caps = HDMI_AUDIO_BUFFER_DONE;
-		had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
+		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
 		snd_intelhad_enable_audio(substream, 0);
 		/* Reset buffer pointers */
-		snd_intelhad_reset_audio(1);
-		snd_intelhad_reset_audio(0);
+		snd_intelhad_reset_audio(intelhaddata, 1);
+		snd_intelhad_reset_audio(intelhaddata, 0);
 		stream->stream_status = STREAM_DROPPED;
-		had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
+		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
 		break;
 
 	default:
@@ -1288,14 +1295,15 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 
 
 	/* Get N value in KHz */
-	retval = had_get_caps(HAD_GET_DISPLAY_RATE, &disp_samp_freq);
+	retval = had_get_caps(intelhaddata, HAD_GET_DISPLAY_RATE,
+			      &disp_samp_freq);
 	if (retval) {
 		pr_err("querying display sampling freq failed %#x\n", retval);
 		goto prep_end;
 	}
 
-	had_get_caps(HAD_GET_ELD, &intelhaddata->eeld);
-	had_get_caps(HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
+	had_get_caps(intelhaddata, HAD_GET_ELD, &intelhaddata->eeld);
+	had_get_caps(intelhaddata, HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
 
 	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
 				     intelhaddata);
@@ -1305,7 +1313,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (intelhaddata->dp_output)
-		had_get_caps(HAD_GET_LINK_RATE, &link_rate);
+		had_get_caps(intelhaddata, HAD_GET_LINK_RATE, &link_rate);
 
 
 	snd_intelhad_prog_cts(substream->runtime->rate,
@@ -1325,7 +1333,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	 * FL, FR, C, LFE, RL, RR
 	 */
 
-	had_write_register(AUD_BUF_CH_SWAP, SWAP_LFE_CENTER);
+	had_write_register(intelhaddata, AUD_BUF_CH_SWAP, SWAP_LFE_CENTER);
 
 prep_end:
 	return retval;
@@ -1361,7 +1369,8 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 	 */
 
 	buf_id = intelhaddata->curr_buf % 4;
-	had_read_register(AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH), &t);
+	had_read_register(intelhaddata,
+			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH), &t);
 
 	if ((t == 0) || (t == ((u32)-1L))) {
 		underrun_count++;
@@ -1427,7 +1436,8 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 	snd_intelhad_enable_audio(substream, 0);
 
 	/* Update CTS value */
-	retval = had_get_caps(HAD_GET_DISPLAY_RATE, &disp_samp_freq);
+	retval = had_get_caps(intelhaddata, HAD_GET_DISPLAY_RATE,
+			      &disp_samp_freq);
 	if (retval) {
 		pr_err("querying display sampling freq failed %#x\n", retval);
 		goto out;
@@ -1441,7 +1451,7 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 	}
 
 	if (intelhaddata->dp_output)
-		had_get_caps(HAD_GET_LINK_RATE, &link_rate);
+		had_get_caps(intelhaddata, HAD_GET_LINK_RATE, &link_rate);
 
 	snd_intelhad_prog_cts(substream->runtime->rate,
 			      disp_samp_freq, link_rate,
@@ -1568,16 +1578,17 @@ static struct snd_kcontrol_new had_control_iec958 = {
 	.put =          had_iec958_put
 };
 
-/**
+/*
  * hdmi_audio_probe - to create sound card instance for HDMI audio playabck
  *
- *@haddata: pointer to HAD private data
- *@card_id: card for which probe is called
+ * @devptr: platform device
+ * @had_ret: pointer to store the created snd_intelhad object
  *
- * This function is called when the hdmi cable is plugged in. This function
+ * This function is called when the platform device is probed. This function
  * creates and registers the sound card with ALSA
  */
-int hdmi_audio_probe(void *deviceptr)
+int hdmi_audio_probe(struct platform_device *devptr,
+		     struct snd_intelhad **had_ret)
 {
 	int retval;
 	struct snd_pcm *pcm;
@@ -1585,7 +1596,6 @@ int hdmi_audio_probe(void *deviceptr)
 	struct had_callback_ops ops_cb;
 	struct snd_intelhad *intelhaddata;
 	struct had_pvt_data *had_stream;
-	struct platform_device *devptr = deviceptr;
 
 	pr_debug("Enter %s\n", __func__);
 
@@ -1602,7 +1612,6 @@ int hdmi_audio_probe(void *deviceptr)
 		goto free_haddata;
 	}
 
-	had_data = intelhaddata;
 	ops_cb.intel_had_event_call_back = had_event_handler;
 
 	/* registering with display driver to get access to display APIs */
@@ -1697,16 +1706,11 @@ int hdmi_audio_probe(void *deviceptr)
 	pm_runtime_enable(intelhaddata->dev);
 
 	mutex_unlock(&had_mutex);
-	retval = mid_hdmi_audio_register(intelhaddata);
-	if (retval) {
-		pr_err("registering with display driver failed %#x\n", retval);
-		snd_card_free(card);
-		goto free_hadstream;
-	}
 
 	intelhaddata->hw_silence = 1;
+	*had_ret = intelhaddata;
 
-	return retval;
+	return 0;
 err:
 	snd_card_free(card);
 unlock_mutex:
@@ -1722,7 +1726,7 @@ int hdmi_audio_probe(void *deviceptr)
 	return retval;
 }
 
-/**
+/*
  * hdmi_audio_remove - removes the alsa card
  *
  *@haddata: pointer to HAD private data
@@ -1730,9 +1734,8 @@ int hdmi_audio_probe(void *deviceptr)
  * This function is called when the hdmi cable is un-plugged. This function
  * free the sound card.
  */
-int hdmi_audio_remove(void *pdevptr)
+int hdmi_audio_remove(struct snd_intelhad *intelhaddata)
 {
-	struct snd_intelhad *intelhaddata = had_data;
 	int caps;
 
 	pr_debug("Enter %s\n", __func__);
@@ -1742,8 +1745,8 @@ int hdmi_audio_remove(void *pdevptr)
 
 	if (intelhaddata->drv_status != HAD_DRV_DISCONNECTED) {
 		caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-		had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
-		had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
+		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
+		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
 	}
 	snd_card_free(intelhaddata->card);
 	kfree(intelhaddata->private_data);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index ba13ae63bea3..5a82a3f429d7 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -39,6 +39,8 @@
 #include <sound/pcm.h>
 #include "intel_hdmi_lpe_audio.h"
 
+struct platform_device;
+
 #define PCM_INDEX		0
 #define MAX_PB_STREAMS		1
 #define MAX_CAP_STREAMS		0
@@ -168,13 +170,19 @@ void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata);
 
 /* Register access functions */
 int had_get_hwstate(struct snd_intelhad *intelhaddata);
-int had_get_caps(enum had_caps_list query_element, void *capabilties);
-int had_set_caps(enum had_caps_list set_element, void *capabilties);
-int had_read_register(u32 reg_addr, u32 *data);
-int had_write_register(u32 reg_addr, u32 data);
-int had_read_modify(u32 reg_addr, u32 data, u32 mask);
-
-int hdmi_audio_probe(void *devptr);
-int hdmi_audio_remove(void *pdev);
+int had_get_caps(struct snd_intelhad *intelhaddata,
+		 enum had_caps_list query_element, void *capabilties);
+int had_set_caps(struct snd_intelhad *intelhaddata,
+		 enum had_caps_list set_element, void *capabilties);
+int had_read_register(struct snd_intelhad *intelhaddata,
+		      u32 reg_addr, u32 *data);
+int had_write_register(struct snd_intelhad *intelhaddata,
+		       u32 reg_addr, u32 data);
+int had_read_modify(struct snd_intelhad *intelhaddata,
+		    u32 reg_addr, u32 data, u32 mask);
+
+int hdmi_audio_probe(struct platform_device *devptr,
+		     struct snd_intelhad **had_ret);
+int hdmi_audio_remove(struct snd_intelhad *intelhaddata);
 
 #endif /* _INTEL_HDMI_AUDIO_ */
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 88ebcb5f7388..8e3a0943332b 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -137,8 +137,8 @@ int hdmi_audio_suspend(void *haddata)
 	 *  caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
 	 */
 	caps = HDMI_AUDIO_BUFFER_DONE;
-	had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
-	had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
+	had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
+	had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
 	pr_debug("Exit:%s", __func__);
 	return retval;
 }
@@ -187,8 +187,8 @@ int hdmi_audio_resume(void *haddata)
 	 * caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
 	 */
 	caps = HDMI_AUDIO_BUFFER_DONE;
-	retval = had_set_caps(HAD_SET_ENABLE_AUDIO_INT, &caps);
-	retval = had_set_caps(HAD_SET_ENABLE_AUDIO, NULL);
+	retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO_INT, &caps);
+	retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO, NULL);
 	pr_debug("Exit:%s", __func__);
 	return retval;
 }
@@ -221,11 +221,12 @@ static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 
 			buf_size = intelhaddata->buf_info[j].buf_size;
 			buf_addr = intelhaddata->buf_info[j].buf_addr;
-			had_write_register(AUD_BUF_A_LENGTH +
-					(j * HAD_REG_WIDTH), buf_size);
-			had_write_register(
-					AUD_BUF_A_ADDR+(j * HAD_REG_WIDTH),
-					(buf_addr | BIT(0) | BIT(1)));
+			had_write_register(intelhaddata,
+					   AUD_BUF_A_LENGTH +
+					   (j * HAD_REG_WIDTH), buf_size);
+			had_write_register(intelhaddata,
+					   AUD_BUF_A_ADDR+(j * HAD_REG_WIDTH),
+					   (buf_addr | BIT(0) | BIT(1)));
 		}
 		buf_id = buf_id % 4;
 		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
@@ -300,14 +301,17 @@ int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	}
 
 	/*Reprogram the registers with addr and length*/
-	had_write_register(AUD_BUF_A_LENGTH +
-			(buf_id * HAD_REG_WIDTH), buf_size);
-	had_write_register(AUD_BUF_A_ADDR+(buf_id * HAD_REG_WIDTH),
-			intelhaddata->buf_info[buf_id].buf_addr|
-			BIT(0) | BIT(1));
-
-	had_read_register(AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
-					&len);
+	had_write_register(intelhaddata,
+			   AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
+			   buf_size);
+	had_write_register(intelhaddata,
+			   AUD_BUF_A_ADDR + (buf_id * HAD_REG_WIDTH),
+			   intelhaddata->buf_info[buf_id].buf_addr |
+			   BIT(0) | BIT(1));
+
+	had_read_register(intelhaddata,
+			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
+			  &len);
 	pr_debug("%s:Enabled buf[%d]\n", __func__, buf_id);
 
 	/* In case of actual data,
@@ -427,8 +431,10 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	} else {
 		/* Disable Audio */
 		caps = HDMI_AUDIO_BUFFER_DONE;
-		retval = had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
-		retval = had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
+		retval = had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT,
+				      &caps);
+		retval = had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO,
+				      NULL);
 		snd_intelhad_enable_audio(
 			intelhaddata->stream_info.had_substream, 0);
 	}
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 51ba3493ff30..18a2ae6796b8 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -45,7 +45,7 @@ struct hdmi_lpe_audio_ctx {
 	int irq;
 	void __iomem *mmio_start;
 	had_event_call_back had_event_callbacks;
-	void *had_pvt_data;
+	struct snd_intelhad *had;
 	int tmds_clock_speed;
 	bool dp_output;
 	int link_rate;
@@ -103,7 +103,7 @@ bool mid_hdmi_audio_is_busy(void *ddev)
 	}
 
 	hdmi_audio_event.type = HAD_EVENT_QUERY_IS_AUDIO_BUSY;
-	hdmi_audio_busy = hdmi_audio_query(ctx->had_pvt_data, hdmi_audio_event);
+	hdmi_audio_busy = hdmi_audio_query(ctx->had, hdmi_audio_event);
 	return hdmi_audio_busy != 0;
 }
 
@@ -119,8 +119,7 @@ void mid_hdmi_audio_signal_event(enum had_event_type event)
 	 * event handlers to avoid races
 	 */
 	if (ctx->had_event_callbacks)
-		(*ctx->had_event_callbacks)(event,
-			ctx->had_pvt_data);
+		(*ctx->had_event_callbacks)(event, ctx->had);
 }
 
 /*
@@ -276,27 +275,6 @@ static void _had_wq(struct work_struct *work)
 	mid_hdmi_audio_signal_event(HAD_EVENT_HOT_PLUG);
 }
 
-int mid_hdmi_audio_register(void *had_data)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	dev_dbg(&hlpe_pdev->dev, "%s: called\n", __func__);
-
-	ctx->had_pvt_data = had_data;
-
-	/* The Audio driver is loading now and we need to notify
-	 * it if there is an HDMI device attached
-	 */
-	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
-	dev_dbg(&hlpe_pdev->dev, "%s: Scheduling HDMI audio work queue\n",
-				__func__);
-	schedule_work(&ctx->hdmi_audio_wq);
-
-	return 0;
-}
-
 static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 {
 	u32 audio_stat, audio_reg;
@@ -460,6 +438,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	dev_dbg(&hlpe_pdev->dev, "hdmi lpe audio: irq num = %d\n", irq);
 	ctx->mmio_start = mmio_start;
 	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
+	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
 
 	if (pci_dev_present(cherryview_ids))
 		dev_dbg(&hlpe_pdev->dev, "%s: Cherrytrail LPE - Detected\n",
@@ -483,9 +462,16 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	ret = hdmi_audio_probe((void *)pdev);
+	ret = hdmi_audio_probe(pdev, &ctx->had);
 	dev_dbg(&hlpe_pdev->dev, "hdmi lpe audio: setting pin eld notify callback\n");
 
+	/* The Audio driver is loading now and we need to notify
+	 * it if there is an HDMI device attached
+	 */
+	dev_dbg(&hlpe_pdev->dev, "%s: Scheduling HDMI audio work queue\n",
+				__func__);
+	schedule_work(&ctx->hdmi_audio_wq);
+
 	spin_lock_irqsave(&pdata->lpe_audio_slock, flag_irq);
 	pdata->notify_audio_lpe = notify_audio_lpe;
 	if (pdata->notify_pending) {
@@ -507,14 +493,13 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
  */
 static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
-	struct hdmi_lpe_audio_ctx *ctx;
+	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
 	dev_dbg(&hlpe_pdev->dev, "Enter %s\n", __func__);
 
-	hdmi_audio_remove(pdev);
+	hdmi_audio_remove(ctx->had);
 
-	/* get context, release resources */
-	ctx = platform_get_drvdata(pdev);
+	/* release resources */
 	iounmap(ctx->mmio_start);
 	free_irq(ctx->irq, NULL);
 	kfree(ctx);
@@ -529,7 +514,7 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
 	/* HDMI is not connected, assuming audio device is suspended already */
 	if (hlpe_state != hdmi_connector_status_disconnected)
-		hdmi_audio_suspend(ctx->had_pvt_data);
+		hdmi_audio_suspend(ctx->had);
 	return 0;
 }
 
@@ -540,7 +525,7 @@ static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
 	/* HDMI is not connected, there is no need to resume audio device */
 	if (hlpe_state != hdmi_connector_status_disconnected)
-		hdmi_audio_resume(ctx->had_pvt_data);
+		hdmi_audio_resume(ctx->had);
 	return 0;
 }
 
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 518d897f1806..0d285ce8d4e6 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -648,7 +648,6 @@ struct hdmi_audio_event {
 bool mid_hdmi_audio_is_busy(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
 int mid_hdmi_audio_setup(had_event_call_back audio_callbacks);
-int mid_hdmi_audio_register(void *had_data);
 
 int mid_hdmi_audio_read(u32 reg, u32 *val);
 int mid_hdmi_audio_write(u32 reg, u32 val);
-- 
2.11.0
