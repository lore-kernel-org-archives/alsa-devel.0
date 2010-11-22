From: ramesh.babu@intel.com
Subject: [PATCH 4/5] [RFC]intel_hdmi_audio:driver module-hdmi
	hw interface
Date: Mon, 22 Nov 2010 19:09:45 +0530
Message-ID: <1290433186-31628-4-git-send-email-ramesh.babu@intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 37A201039D0
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:34:27 +0100 (CET)
In-Reply-To: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
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

This patch programs hdmi audio hw registers whenever
ALSA _prepare function is invoked.  It calculates N and CTS
values according HDMI 1.3a spec and programs it.
It also programs hw buffer pointer and length registers.

Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
---
 .../drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c  |  281 ++++++++++++++++++++
 1 files changed, 281 insertions(+), 0 deletions(-)

diff --git a/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c
index 3ef4d48..6701a88 100644
--- a/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c
+++ b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c
@@ -99,6 +99,287 @@ static const struct snd_pcm_hardware snd_intel_hadstream = {
 struct snd_intelhad *intelhaddata;
 
 /**
+ * snd_intelhad_init_audio_ctrl - to initialize audio channel status
+ * registers and confgiuration registers
+ *
+ * @substream:substream for which the prepare function is called
+ *
+ * This function is called in the prepare callback
+ */
+static int snd_intelhad_init_audio_ctrl(struct snd_pcm_substream *substream)
+{
+	int retval;
+	union aud_cfg cfg_val = {.cfg_regval = 0};
+	union aud_ch_status_0 ch_stat0 = {.status_0_regval = 0};
+	union aud_ch_status_1 ch_stat1 = {.status_1_regval = 0};
+	union aud_buf_config buf_cfg = {.buf_cfgval = 0};
+	u8 channels;
+
+	/* Currently only PCM stream is supported */
+	ch_stat0.status_0_regx.lpcm_id = 0;
+
+	switch (substream->runtime->rate) {
+	case AUD_SAMPLE_RATE_32:
+		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_32KHZ;
+	break;
+	case AUD_SAMPLE_RATE_44_1:
+	case AUD_SAMPLE_RATE_88_2:
+	case AUD_SAMPLE_RATE_176_4:
+		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_44KHZ;
+	break;
+	case AUD_SAMPLE_RATE_48:
+	case AUD_SAMPLE_RATE_96:
+	case HAD_MAX_RATE:
+		ch_stat0.status_0_regx.samp_freq = CH_STATUS_MAP_48KHZ;
+	break;
+	default:
+		retval = -EINVAL;
+	break;
+	}
+	ch_stat0.status_0_regx.clk_acc = 0;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_CH_STATUS_0, ch_stat0.status_0_regval);
+	if (retval)
+		return retval;
+
+	if (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE) {
+		ch_stat1.status_1_regx.max_wrd_len = MAX_SMPL_WIDTH_20;
+		ch_stat1.status_1_regx.wrd_len = SMPL_WIDTH_16BITS;
+	} else if (substream->runtime->format == SNDRV_PCM_FORMAT_S24_LE) {
+		ch_stat1.status_1_regx.max_wrd_len = MAX_SMPL_WIDTH_24;
+		ch_stat1.status_1_regx.wrd_len = SMPL_WIDTH_24BITS;
+	} else {
+		ch_stat1.status_1_regx.max_wrd_len = 0;
+		ch_stat1.status_1_regx.wrd_len = 0;
+	}
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_CH_STATUS_1, ch_stat1.status_1_regval);
+	if (retval)
+		return retval;
+
+	buf_cfg.buf_cfg_regx.fifo_width	 = FIFO_THRESHOLD;
+	buf_cfg.buf_cfg_regx.aud_delay	 = 0; /* TODO: Read from EDID */
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_BUF_CONFIG, buf_cfg.buf_cfgval);
+	if (retval)
+		return retval;
+
+	channels = substream->runtime->channels;
+	switch (channels) {
+	case 1:
+	case 2:
+		cfg_val.cfg_regx.num_ch = CH_STEREO;
+		cfg_val.cfg_regx.layout = LAYOUT0;
+		break;
+	case 3:
+	case 4:
+		cfg_val.cfg_regx.num_ch = CH_THREE_FOUR;
+		cfg_val.cfg_regx.layout = LAYOUT1;
+		break;
+	case 5:
+	case 6:
+		cfg_val.cfg_regx.num_ch = CH_FIVE_SIX;
+		cfg_val.cfg_regx.layout = LAYOUT1;
+		break;
+	case 7:
+	case 8:
+		cfg_val.cfg_regx.num_ch = CH_SEVEN_EIGHT;
+		cfg_val.cfg_regx.layout = LAYOUT1;
+		break;
+	}
+	cfg_val.cfg_regx.val_bit = 1;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+						AUD_CONFIG, cfg_val.cfg_regval);
+	if (retval)
+		return retval;
+	return 0;
+}
+
+/**
+ * snd_intelhad_prog_DIP - to initialize Data Island Packets registers
+ *
+ * @substream:substream for which the prepare function is called
+ *
+ * This function is called in the prepare callback
+ */
+static int snd_intelhad_prog_DIP(struct snd_pcm_substream *substream)
+{
+	int retval, i;
+	union aud_ctrl_st ctrl_state = {.ctrl_val = 0};
+	union aud_info_frame2 frame2 = {.fr2_val = 0};
+	union aud_info_frame3 frame3 = {.fr3_val = 0};
+	u8 checksum = 0;
+
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_CNTL_ST, ctrl_state.ctrl_val);
+	if (retval)
+		return retval;
+
+	frame2.fr2_regx.chnl_cnt = substream->runtime->channels - 1;
+
+	/*TODO: Read from intelhaddata->eeld.speaker_allocation_block;*/
+	frame3.fr3_regx.chnl_alloc = CHANNEL_ALLOCATION;
+
+	/*Calculte the byte wide checksum for all valid DIP words*/
+	for (i = 0; i < BYTES_PER_WORD; i++)
+		checksum += (INFO_FRAME_WORD1 >> i*BITS_PER_BYTE) & SET_BYTE0;
+	for (i = 0; i < BYTES_PER_WORD; i++)
+		checksum += (frame2.fr2_val >> i*BITS_PER_BYTE) & SET_BYTE0;
+	for (i = 0; i < BYTES_PER_WORD; i++)
+		checksum += (frame3.fr3_val >> i*BITS_PER_BYTE) & SET_BYTE0;
+
+	frame2.fr2_regx.chksum = ~(checksum)+1;
+
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_HDMIW_INFOFR, INFO_FRAME_WORD1);
+	if (retval)
+		return retval;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_HDMIW_INFOFR, frame2.fr2_val);
+	if (retval)
+		return retval;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_HDMIW_INFOFR, frame3.fr3_val);
+	/* program remaining DIP words with zero */
+	for (i = 0; i < MAX_DIP_WORDS-VALID_DIP_WORDS; i++) {
+		retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_HDMIW_INFOFR, 0x0);
+		if (retval)
+			return retval;
+	}
+
+	ctrl_state.ctrl_regx.dip_freq = SET_BIT0;
+	ctrl_state.ctrl_regx.dip_en_sta = SET_BIT0;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_CNTL_ST, ctrl_state.ctrl_val);
+	return retval;
+}
+
+/**
+ * snd_intelhad_prog_ring_buf - programs A , B, C and D
+ * address and length registers
+ *
+ * @substream:substream for which the prepare function is called
+ *
+ * This function programs ring buffer address and length into registers.
+ */
+static int snd_intelhad_prog_ring_buf(struct snd_pcm_substream *substream)
+{
+	int retval;
+	u32 ring_buf_addr, ring_buf_size, period_bytes;
+	u8 i, num_periods;
+	struct snd_intelhad *intelhaddata =  snd_pcm_substream_chip(substream);
+
+	ring_buf_addr = virt_to_phys(substream->runtime->dma_area);
+	pr_debug("had: Ring buffer address = %#x\n", ring_buf_addr);
+	ring_buf_size = snd_pcm_lib_buffer_bytes(substream);
+	pr_debug("had: Ring buffer size = %#x\n", ring_buf_size);
+	intelhaddata->stream_info.ring_buf_size = ring_buf_size;
+
+	period_bytes = frames_to_bytes(substream->runtime,
+				substream->runtime->period_size);
+	pr_debug("had: period size in bytes = %d\n", period_bytes);
+	num_periods = substream->runtime->periods;
+
+	/* Hardware supports MAX_PERIODS buffers */
+	if (num_periods > MAX_PERIODS)
+		return -EINVAL;
+
+	for (i = 0; i < num_periods; i++) {
+		/* Program the buf registers with addr and len */
+		intelhaddata->buf_info[i].buf_addr = ring_buf_addr  +
+							 (i * period_bytes);
+		intelhaddata->buf_info[i].buf_size = period_bytes;
+		retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_BUF_A_ADDR + (i * REG_WIDTH),
+					intelhaddata->buf_info[i].buf_addr |
+					REG_BIT_0 | REG_BIT_1);
+		if (retval)
+			return retval;
+		retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+					AUD_BUF_A_LENGTH + (i * REG_WIDTH),
+					period_bytes);
+		if (retval)
+			return retval;
+		intelhaddata->buf_info[i].is_valid = true;
+	}
+	intelhaddata->valid_buf_cnt = num_periods;
+	intelhaddata->curr_buf = HAD_BUF_TYPE_A;
+	return 0;
+}
+
+/**
+ * snd_intelhad_prog_cts - Program HDMI audio CTS value
+ *
+ * @aud_samp_freq: sampling frequency of audio data
+ * @tmds: sampling frequency of the display data
+ * @n_param: N value, depends on aud_samp_freq
+ *
+ * Program CTS register based on the audio and display sampling frequency
+ */
+static int snd_intelhad_prog_cts(u32 aud_samp_freq, u32 tmds, u32 n_param)
+{
+	u32 cts_val;
+	int retval = 0;
+
+	/* Calculate CTS according to HDMI 1.3a spec*/
+	cts_val = (tmds * n_param)/(128 * aud_samp_freq);
+	pr_debug("had:CTS Value=%d\n", cts_val);
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_HDMI_CTS, (REG_BIT_20 | cts_val));
+	return retval;
+}
+
+/**
+ * snd_intelhad_prog_n - Program HDMI audio N value
+ *
+ * @aud_samp_freq: sampling frequency of audio data
+ * @n_param: N value, depends on aud_samp_freq
+ *
+ * This function is called in the prepare callback.
+ * It programs based on the audio and display sampling frequency
+ */
+static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param)
+{
+	u32 n_val;
+	int retval = 0;
+
+	/* Select N according to HDMI 1.3a spec*/
+	switch (aud_samp_freq) {
+	case AUD_SAMPLE_RATE_32:
+		n_val = 4096;
+	break;
+	case AUD_SAMPLE_RATE_44_1:
+		n_val = 6272;
+	break;
+	case AUD_SAMPLE_RATE_48:
+		n_val = 6144;
+	break;
+	case AUD_SAMPLE_RATE_88_2:
+		n_val = 12544;
+	break;
+	case AUD_SAMPLE_RATE_96:
+		n_val = 12288;
+	break;
+	case AUD_SAMPLE_RATE_176_4:
+		n_val = 25088;
+	break;
+	case HAD_MAX_RATE:
+		n_val = 24576;
+	break;
+	default:
+		retval = -EINVAL;
+	break;
+	}
+	if (retval)
+		return retval;
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_N_ENABLE, (REG_BIT_20 | n_val));
+	*n_param = n_val;
+	return retval;
+}
+
+/**
 * snd_intelhad_open - stream initializations are done here
 * @substream:substream for which the stream function is called
 *
-- 
1.6.2.5
