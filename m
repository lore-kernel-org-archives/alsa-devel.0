From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/53] ALSA: x86: Drop indirect calls of had_ops
Date: Thu,  2 Feb 2017 18:02:17 +0100
Message-ID: <20170202170307.24484-5-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A9C0266819
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

We have only a single implementation of had_ops, hence there is no
merit to use the indirect calls at all.  Let's replace it with the
direct calls -- which allows the compiler more optimizations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c    | 85 ++++++++++++++++++-----------------------
 sound/x86/intel_hdmi_audio.h    | 21 ++--------
 sound/x86/intel_hdmi_audio_if.c |  4 +-
 3 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 1e0bc72a8f63..84ce4e09ada5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -280,13 +280,12 @@ static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 	return had_read_modify(AUD_CONFIG, data, mask);
 }
 
-static void snd_intelhad_enable_audio_v2(struct snd_pcm_substream *substream,
-					u8 enable)
+void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable)
 {
 	had_read_modify_aud_config_v2(substream, enable, BIT(0));
 }
 
-static void snd_intelhad_reset_audio_v2(u8 reset)
+static void snd_intelhad_reset_audio(u8 reset)
 {
 	had_write_register(AUD_HDMI_STATUS_v2, reset);
 }
@@ -359,13 +358,13 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
+/*
  * function to initialize audio
  * registers and buffer confgiuration registers
  * This function is called in the prepare callback
  */
-static int snd_intelhad_prog_audio_ctrl_v2(struct snd_pcm_substream *substream,
-					struct snd_intelhad *intelhaddata)
+static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
+				   struct snd_intelhad *intelhaddata)
 {
 	union aud_cfg cfg_val = {.cfg_regval = 0};
 	union aud_buf_config buf_cfg = {.buf_cfgval = 0};
@@ -596,16 +595,16 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 	return 0;
 }
 
-/**
- * snd_intelhad_prog_dip_v2 - to initialize Data Island Packets registers
+/*
+ * snd_intelhad_prog_dip - to initialize Data Island Packets registers
  *
  * @substream:substream for which the prepare function is called
  * @intelhaddata:substream private data
  *
  * This function is called in the prepare callback
  */
-static void snd_intelhad_prog_dip_v2(struct snd_pcm_substream *substream,
-				struct snd_intelhad *intelhaddata)
+static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
+				  struct snd_intelhad *intelhaddata)
 {
 	int i;
 	union aud_ctrl_st ctrl_state = {.ctrl_val = 0};
@@ -815,8 +814,8 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
 	return maud_val;
 }
 
-/**
- * snd_intelhad_prog_cts_v2 - Program HDMI audio CTS value
+/*
+ * snd_intelhad_prog_cts - Program HDMI audio CTS value
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @tmds: sampling frequency of the display data
@@ -825,9 +824,9 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
  *
  * Program CTS register based on the audio and display sampling frequency
  */
-static void snd_intelhad_prog_cts_v2(u32 aud_samp_freq, u32 tmds,
-				     u32 link_rate, u32 n_param,
-				     struct snd_intelhad *intelhaddata)
+static void snd_intelhad_prog_cts(u32 aud_samp_freq, u32 tmds,
+				  u32 link_rate, u32 n_param,
+				  struct snd_intelhad *intelhaddata)
 {
 	u32 cts_val;
 	u64 dividend, divisor;
@@ -887,8 +886,8 @@ static int had_calculate_n_value(u32 aud_samp_freq)
 	return n_val;
 }
 
-/**
- * snd_intelhad_prog_n_v2 - Program HDMI audio N value
+/*
+ * snd_intelhad_prog_n - Program HDMI audio N value
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @n_param: N value, depends on aud_samp_freq
@@ -897,8 +896,8 @@ static int had_calculate_n_value(u32 aud_samp_freq)
  * This function is called in the prepare callback.
  * It programs based on the audio and display sampling frequency
  */
-static int snd_intelhad_prog_n_v2(u32 aud_samp_freq, u32 *n_param,
-				struct snd_intelhad *intelhaddata)
+static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
+			       struct snd_intelhad *intelhaddata)
 {
 	s32 n_val;
 
@@ -923,7 +922,7 @@ static int snd_intelhad_prog_n_v2(u32 aud_samp_freq, u32 *n_param,
 	return 0;
 }
 
-static void had_clear_underrun_intr_v2(struct snd_intelhad *intelhaddata)
+void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 {
 	u32 hdmi_status, i = 0;
 
@@ -1209,7 +1208,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		caps = HDMI_AUDIO_BUFFER_DONE;
 		retval = had_set_caps(HAD_SET_ENABLE_AUDIO_INT, &caps);
 		retval = had_set_caps(HAD_SET_ENABLE_AUDIO, NULL);
-		intelhaddata->ops->enable_audio(substream, 1);
+		snd_intelhad_enable_audio(substream, 1);
 
 		pr_debug("Processed _Start\n");
 
@@ -1232,10 +1231,10 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		 */
 		caps = HDMI_AUDIO_BUFFER_DONE;
 		had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
-		intelhaddata->ops->enable_audio(substream, 0);
+		snd_intelhad_enable_audio(substream, 0);
 		/* Reset buffer pointers */
-		intelhaddata->ops->reset_audio(1);
-		intelhaddata->ops->reset_audio(0);
+		snd_intelhad_reset_audio(1);
+		snd_intelhad_reset_audio(0);
 		stream->stream_status = STREAM_DROPPED;
 		had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
 		break;
@@ -1304,8 +1303,8 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	had_get_caps(HAD_GET_ELD, &intelhaddata->eeld);
 	had_get_caps(HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
 
-	retval = intelhaddata->ops->prog_n(substream->runtime->rate, &n_param,
-								intelhaddata);
+	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
+				     intelhaddata);
 	if (retval) {
 		pr_err("programming N value failed %#x\n", retval);
 		goto prep_end;
@@ -1315,13 +1314,13 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 		had_get_caps(HAD_GET_LINK_RATE, &link_rate);
 
 
-	intelhaddata->ops->prog_cts(substream->runtime->rate,
-				    disp_samp_freq, link_rate,
-				    n_param, intelhaddata);
+	snd_intelhad_prog_cts(substream->runtime->rate,
+			      disp_samp_freq, link_rate,
+			      n_param, intelhaddata);
 
-	intelhaddata->ops->prog_dip(substream, intelhaddata);
+	snd_intelhad_prog_dip(substream, intelhaddata);
 
-	retval = intelhaddata->ops->audio_ctrl(substream, intelhaddata);
+	retval = snd_intelhad_audio_ctrl(substream, intelhaddata);
 
 	/* Prog buffer address */
 	retval = snd_intelhad_prog_buffer(intelhaddata,
@@ -1431,7 +1430,7 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 
 	/* Disable Audio */
-	intelhaddata->ops->enable_audio(substream, 0);
+	snd_intelhad_enable_audio(substream, 0);
 
 	/* Update CTS value */
 	retval = had_get_caps(HAD_GET_DISPLAY_RATE, &disp_samp_freq);
@@ -1440,8 +1439,8 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 		goto out;
 	}
 
-	retval = intelhaddata->ops->prog_n(substream->runtime->rate, &n_param,
-								intelhaddata);
+	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
+				     intelhaddata);
 	if (retval) {
 		pr_err("programming N value failed %#x\n", retval);
 		goto out;
@@ -1450,12 +1449,12 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 	if (intelhaddata->dp_output)
 		had_get_caps(HAD_GET_LINK_RATE, &link_rate);
 
-	intelhaddata->ops->prog_cts(substream->runtime->rate,
-				    disp_samp_freq, link_rate,
-				    n_param, intelhaddata);
+	snd_intelhad_prog_cts(substream->runtime->rate,
+			      disp_samp_freq, link_rate,
+			      n_param, intelhaddata);
 
 	/* Enable Audio */
-	intelhaddata->ops->enable_audio(substream, 1);
+	snd_intelhad_enable_audio(substream, 1);
 
 out:
 	return retval;
@@ -1582,15 +1581,6 @@ static struct snd_intel_had_interface had_interface = {
 	.resume =       hdmi_audio_resume,
 };
 
-static struct had_ops had_ops_v2 = {
-	.enable_audio = snd_intelhad_enable_audio_v2,
-	.reset_audio = snd_intelhad_reset_audio_v2,
-	.prog_n =	snd_intelhad_prog_n_v2,
-	.prog_cts =	snd_intelhad_prog_cts_v2,
-	.audio_ctrl =	snd_intelhad_prog_audio_ctrl_v2,
-	.prog_dip =	snd_intelhad_prog_dip_v2,
-	.handle_underrun = had_clear_underrun_intr_v2,
-};
 /**
  * hdmi_audio_probe - to create sound card instance for HDMI audio playabck
  *
@@ -1731,7 +1721,6 @@ int hdmi_audio_probe(void *deviceptr)
 	}
 
 	intelhaddata->hw_silence = 1;
-	intelhaddata->ops = &had_ops_v2;
 
 	return retval;
 err:
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 034b3873ffa1..394959f0bd2e 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -123,7 +123,6 @@ struct had_callback_ops {
  * @chmap: holds channel map info
  * @audio_reg_base: hdmi audio register base offset
  * @hw_silence: flag indicates SoC support for HW silence/Keep alive
- * @ops: holds ops functions based on platform
  */
 struct snd_intelhad {
 	struct snd_card	*card;
@@ -149,25 +148,8 @@ struct snd_intelhad {
 	unsigned int	*audio_reg_base;
 	unsigned int	audio_cfg_offset;
 	bool		hw_silence;
-	struct had_ops	*ops;
 };
 
-struct had_ops {
-	void (*enable_audio)(struct snd_pcm_substream *substream,
-			u8 enable);
-	void (*reset_audio)(u8 reset);
-	int (*prog_n)(u32 aud_samp_freq, u32 *n_param,
-			struct snd_intelhad *intelhaddata);
-	void (*prog_cts)(u32 aud_samp_freq, u32 tmds, u32 link_rate,
-			 u32 n_param, struct snd_intelhad *intelhaddata);
-	int (*audio_ctrl)(struct snd_pcm_substream *substream,
-				struct snd_intelhad *intelhaddata);
-	void (*prog_dip)(struct snd_pcm_substream *substream,
-				struct snd_intelhad *intelhaddata);
-	void (*handle_underrun)(struct snd_intelhad *intelhaddata);
-};
-
-
 int had_event_handler(enum had_event_type event_type, void *data);
 
 int hdmi_audio_query(void *drv_data, struct hdmi_audio_event event);
@@ -185,6 +167,9 @@ int snd_intelhad_invd_buffer(int start, int end);
 int snd_intelhad_read_len(struct snd_intelhad *intelhaddata);
 void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata);
 
+void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable);
+void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata);
+
 /* Register access functions */
 int had_get_hwstate(struct snd_intelhad *intelhaddata);
 int had_get_caps(enum had_caps_list query_element, void *capabilties);
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 30b4b25acb24..d92fe48d916b 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -349,7 +349,7 @@ int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	pr_debug("Enter:%s buf_id=%d, stream_type=%d\n",
 			__func__, buf_id, stream_type);
 
-	intelhaddata->ops->handle_underrun(intelhaddata);
+	snd_intelhad_handle_underrun(intelhaddata);
 
 	if (drv_status == HAD_DRV_DISCONNECTED) {
 		pr_err("%s:Device already disconnected\n", __func__);
@@ -451,7 +451,7 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 		caps = HDMI_AUDIO_BUFFER_DONE;
 		retval = had_set_caps(HAD_SET_DISABLE_AUDIO_INT, &caps);
 		retval = had_set_caps(HAD_SET_DISABLE_AUDIO, NULL);
-		intelhaddata->ops->enable_audio(
+		snd_intelhad_enable_audio(
 			intelhaddata->stream_info.had_substream, 0);
 	}
 
-- 
2.11.0
