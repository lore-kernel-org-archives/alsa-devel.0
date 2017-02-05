From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: x86: Unify local function prefix
Date: Sun,  5 Feb 2017 09:04:57 +0100
Message-ID: <20170205080458.15927-3-tiwai@suse.de>
References: <20170205080458.15927-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F66426690B
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 09:05:00 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B5727AB1D
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 08:04:59 +0000 (UTC)
In-Reply-To: <20170205080458.15927-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Use had_ prefix consistently to all local helper functions, as well as
had_pcm_ for PCM ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 127 ++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 0a9c82aca05f..57042ef3a480 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -130,7 +130,7 @@ static const struct channel_map_table map_tables[] = {
 };
 
 /* hardware capability structure */
-static const struct snd_pcm_hardware snd_intel_hadstream = {
+static const struct snd_pcm_hardware had_pcm_hardware = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_DOUBLE |
 		SNDRV_PCM_INFO_MMAP|
@@ -213,9 +213,9 @@ static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
  * bad audio. The fix is to always write the AUD_CONFIG[6:4] with
  * appropriate value when doing read-modify of AUD_CONFIG register.
  */
-static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
-				      struct snd_intelhad *intelhaddata,
-				      bool enable)
+static void had_enable_audio(struct snd_pcm_substream *substream,
+			     struct snd_intelhad *intelhaddata,
+			     bool enable)
 {
 	union aud_cfg cfg_val = {.regval = 0};
 	u8 channels;
@@ -240,7 +240,7 @@ static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
 }
 
 /* enable / disable the audio interface */
-static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
+static void had_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 {
 	u32 status_reg;
 
@@ -332,8 +332,8 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
  * registers and buffer confgiuration registers
  * This function is called in the prepare callback
  */
-static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
-				   struct snd_intelhad *intelhaddata)
+static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
+			       struct snd_intelhad *intelhaddata)
 {
 	union aud_cfg cfg_val = {.regval = 0};
 	union aud_buf_config buf_cfg = {.regval = 0};
@@ -393,8 +393,8 @@ static void init_channel_allocations(void)
  *
  * TODO: it could select the wrong CA from multiple candidates.
  */
-static int snd_intelhad_channel_allocation(struct snd_intelhad *intelhaddata,
-					int channels)
+static int had_channel_allocation(struct snd_intelhad *intelhaddata,
+				  int channels)
 {
 	int i;
 	int ca = 0;
@@ -573,8 +573,8 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
  * Initialize Data Island Packets registers
  * This function is called in the prepare callback
  */
-static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
-				  struct snd_intelhad *intelhaddata)
+static void had_prog_dip(struct snd_pcm_substream *substream,
+			 struct snd_intelhad *intelhaddata)
 {
 	int i;
 	union aud_ctrl_st ctrl_state = {.regval = 0};
@@ -589,7 +589,7 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 
 	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.regval);
 
-	ca = snd_intelhad_channel_allocation(intelhaddata, channels);
+	ca = had_channel_allocation(intelhaddata, channels);
 	if (intelhaddata->dp_output) {
 		info_frame = DP_INFO_FRAME_WORD1;
 		frame2.regval = (substream->runtime->channels - 1) | (ca << 24);
@@ -782,14 +782,14 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @tmds: sampling frequency of the display data
+ * @link_rate: DP link rate
  * @n_param: N value, depends on aud_samp_freq
- * @intelhaddata:substream private data
+ * @intelhaddata: substream private data
  *
  * Program CTS register based on the audio and display sampling frequency
  */
-static void snd_intelhad_prog_cts(u32 aud_samp_freq, u32 tmds,
-				  u32 link_rate, u32 n_param,
-				  struct snd_intelhad *intelhaddata)
+static void had_prog_cts(u32 aud_samp_freq, u32 tmds, u32 link_rate,
+			 u32 n_param, struct snd_intelhad *intelhaddata)
 {
 	u32 cts_val;
 	u64 dividend, divisor;
@@ -854,13 +854,13 @@ static int had_calculate_n_value(u32 aud_samp_freq)
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @n_param: N value, depends on aud_samp_freq
- * @intelhaddata:substream private data
+ * @intelhaddata: substream private data
  *
  * This function is called in the prepare callback.
  * It programs based on the audio and display sampling frequency
  */
-static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
-			       struct snd_intelhad *intelhaddata)
+static int had_prog_n(u32 aud_samp_freq, u32 *n_param,
+		      struct snd_intelhad *intelhaddata)
 {
 	int n_val;
 
@@ -917,7 +917,7 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 /*
  * ALSA PCM open callback
  */
-static int snd_intelhad_open(struct snd_pcm_substream *substream)
+static int had_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
@@ -936,7 +936,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	}
 
 	/* set the runtime hw parameter with local snd_pcm_hardware struct */
-	runtime->hw = snd_intel_hadstream;
+	runtime->hw = had_pcm_hardware;
 
 	retval = snd_pcm_hw_constraint_integer(runtime,
 			 SNDRV_PCM_HW_PARAM_PERIODS);
@@ -971,7 +971,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 /*
  * ALSA PCM close callback
  */
-static int snd_intelhad_close(struct snd_pcm_substream *substream)
+static int had_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 
@@ -995,8 +995,8 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 /*
  * ALSA PCM hw_params callback
  */
-static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *hw_params)
+static int had_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_intelhad *intelhaddata;
 	unsigned long addr;
@@ -1026,7 +1026,7 @@ static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
 /*
  * ALSA PCM hw_free callback
  */
-static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
+static int had_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	unsigned long addr;
 	u32 pages;
@@ -1045,8 +1045,7 @@ static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 /*
  * ALSA PCM trigger callback
  */
-static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
-					int cmd)
+static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int retval = 0;
 	struct snd_intelhad *intelhaddata;
@@ -1068,8 +1067,8 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		intelhaddata->stream_info.running = true;
 
 		/* Enable Audio */
-		snd_intelhad_enable_audio_int(intelhaddata, true);
-		snd_intelhad_enable_audio(substream, intelhaddata, true);
+		had_enable_audio_int(intelhaddata, true);
+		had_enable_audio(substream, intelhaddata, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -1082,11 +1081,11 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		intelhaddata->stream_info.running = false;
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
-		snd_intelhad_enable_audio_int(intelhaddata, false);
-		snd_intelhad_enable_audio(substream, intelhaddata, false);
+		had_enable_audio_int(intelhaddata, false);
+		had_enable_audio(substream, intelhaddata, false);
 		/* Reset buffer pointers */
 		had_reset_audio(intelhaddata);
-		snd_intelhad_enable_audio_int(intelhaddata, false);
+		had_enable_audio_int(intelhaddata, false);
 		break;
 
 	default:
@@ -1098,7 +1097,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 /*
  * ALSA PCM prepare callback
  */
-static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
+static int had_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	int retval;
 	u32 disp_samp_freq, n_param;
@@ -1131,8 +1130,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	/* Get N value in KHz */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
-	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
-				     intelhaddata);
+	retval = had_prog_n(substream->runtime->rate, &n_param, intelhaddata);
 	if (retval) {
 		dev_err(intelhaddata->dev,
 			"programming N value failed %#x\n", retval);
@@ -1142,13 +1140,12 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	if (intelhaddata->dp_output)
 		link_rate = intelhaddata->link_rate;
 
-	snd_intelhad_prog_cts(substream->runtime->rate,
-			      disp_samp_freq, link_rate,
-			      n_param, intelhaddata);
+	had_prog_cts(substream->runtime->rate, disp_samp_freq, link_rate,
+		     n_param, intelhaddata);
 
-	snd_intelhad_prog_dip(substream, intelhaddata);
+	had_prog_dip(substream, intelhaddata);
 
-	retval = snd_intelhad_audio_ctrl(substream, intelhaddata);
+	retval = had_init_audio_ctrl(substream, intelhaddata);
 
 	/* Prog buffer address */
 	retval = snd_intelhad_prog_buffer(substream, intelhaddata,
@@ -1168,8 +1165,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 /*
  * ALSA PCM pointer callback
  */
-static snd_pcm_uframes_t
-snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t had_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 	u32 bytes_rendered = 0;
@@ -1219,8 +1215,8 @@ snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
 /*
  * ALSA PCM mmap callback
  */
-static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
+static int had_pcm_mmap(struct snd_pcm_substream *substream,
+			struct vm_area_struct *vma)
 {
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	return remap_pfn_range(vma, vma->vm_start,
@@ -1231,20 +1227,20 @@ static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
 /*
  * ALSA PCM ops
  */
-static const struct snd_pcm_ops snd_intelhad_playback_ops = {
-	.open =		snd_intelhad_open,
-	.close =	snd_intelhad_close,
+static const struct snd_pcm_ops had_pcm_ops = {
+	.open =		had_pcm_open,
+	.close =	had_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_intelhad_hw_params,
-	.hw_free =	snd_intelhad_hw_free,
-	.prepare =	snd_intelhad_pcm_prepare,
-	.trigger =	snd_intelhad_pcm_trigger,
-	.pointer =	snd_intelhad_pcm_pointer,
-	.mmap =	snd_intelhad_pcm_mmap,
+	.hw_params =	had_pcm_hw_params,
+	.hw_free =	had_pcm_hw_free,
+	.prepare =	had_pcm_prepare,
+	.trigger =	had_pcm_trigger,
+	.pointer =	had_pcm_pointer,
+	.mmap =		had_pcm_mmap,
 };
 
 /* process mode change of the running stream; called in mutex */
-static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
+static int had_process_mode_change(struct snd_intelhad *intelhaddata)
 {
 	struct snd_pcm_substream *substream;
 	int retval = 0;
@@ -1256,13 +1252,12 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 		return 0;
 
 	/* Disable Audio */
-	snd_intelhad_enable_audio(substream, intelhaddata, false);
+	had_enable_audio(substream, intelhaddata, false);
 
 	/* Update CTS value */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
-	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
-				     intelhaddata);
+	retval = had_prog_n(substream->runtime->rate, &n_param, intelhaddata);
 	if (retval) {
 		dev_err(intelhaddata->dev,
 			"programming N value failed %#x\n", retval);
@@ -1272,12 +1267,11 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 	if (intelhaddata->dp_output)
 		link_rate = intelhaddata->link_rate;
 
-	snd_intelhad_prog_cts(substream->runtime->rate,
-			      disp_samp_freq, link_rate,
-			      n_param, intelhaddata);
+	had_prog_cts(substream->runtime->rate, disp_samp_freq, link_rate,
+		     n_param, intelhaddata);
 
 	/* Enable Audio */
-	snd_intelhad_enable_audio(substream, intelhaddata, true);
+	had_enable_audio(substream, intelhaddata, true);
 
 out:
 	had_substream_put(intelhaddata);
@@ -1510,8 +1504,8 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	}
 
 	/* Disable Audio */
-	snd_intelhad_enable_audio_int(intelhaddata, false);
-	snd_intelhad_enable_audio(substream, intelhaddata, false);
+	had_enable_audio_int(intelhaddata, false);
+	had_enable_audio(substream, intelhaddata, false);
 
 	intelhaddata->connected = false;
 	dev_dbg(intelhaddata->dev,
@@ -1712,7 +1706,7 @@ static void had_audio_wq(struct work_struct *work)
 		had_process_hot_plug(ctx);
 
 		/* Process mode change if stream is active */
-		hdmi_audio_mode_change(ctx);
+		had_process_mode_change(ctx);
 	}
 	mutex_unlock(&ctx->mutex);
 	pm_runtime_put(ctx->dev);
@@ -1862,8 +1856,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	pcm->info_flags = 0;
 	strncpy(pcm->name, card->shortname, strlen(card->shortname));
 	/* setup the ops for playabck */
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			    &snd_intelhad_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
 	/* only 32bit addressable */
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
@@ -1923,7 +1916,7 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
 
 	if (ctx->connected)
-		snd_intelhad_enable_audio_int(ctx, false);
+		had_enable_audio_int(ctx, false);
 	snd_card_free(ctx->card);
 	return 0;
 }
-- 
2.11.0
