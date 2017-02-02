From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/53] ALSA: x86: Flatten two abstraction layers
Date: Thu,  2 Feb 2017 18:02:38 +0100
Message-ID: <20170202170307.24484-26-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2615226757F
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

This is the final stage for a big clean-up series.  Here we flatten
the two layers into one.  Formerly, the implementation was split to
HDMI "shell" that talks with the platform device, and HDMI audio part
that communicates via caps and other event handlers.  All these would
be good if there were multiple instantiations or if there were data
protection.  But neither are true in our case.  That said, it'll be
easier to have a flat driver structure in the end.

In this patch, the former struct hdmi_lpe_audio_ctx is forged into the
existing struct snd_intelhad.  The latter has already a few members
that are basically the copy from the former.  Only a few new members
for the lowlevel I/O are added by this change.

Then, the had_get_caps() and had_set_caps() are simply replaced with
the direct calls to copy the data in the struct fields.  Also, the
had_event_handler() calls are replaced with the direct call for each
event as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/Makefile               |   3 +-
 sound/x86/intel_hdmi_audio.c     | 476 ++++++++++++++++++++++++++-------------
 sound/x86/intel_hdmi_audio.h     |  37 +--
 sound/x86/intel_hdmi_audio_if.c  | 128 ++---------
 sound/x86/intel_hdmi_lpe_audio.c | 462 -------------------------------------
 sound/x86/intel_hdmi_lpe_audio.h |  23 +-
 6 files changed, 358 insertions(+), 771 deletions(-)
 delete mode 100644 sound/x86/intel_hdmi_lpe_audio.c

diff --git a/sound/x86/Makefile b/sound/x86/Makefile
index 85ea22a2cf28..3c0bf63333e6 100644
--- a/sound/x86/Makefile
+++ b/sound/x86/Makefile
@@ -1,6 +1,5 @@
 snd-hdmi-lpe-audio-objs += \
 	intel_hdmi_audio.o \
-	intel_hdmi_audio_if.o \
-	intel_hdmi_lpe_audio.o
+	intel_hdmi_audio_if.o
 
 obj-$(CONFIG_HDMI_LPE_AUDIO) += snd-hdmi-lpe-audio.o
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 82f42a6c363c..1594f826cf31 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/acpi.h>
 #include <asm/cacheflush.h>
 #include <sound/pcm.h>
@@ -35,6 +36,7 @@
 #include <sound/initval.h>
 #include <sound/control.h>
 #include <sound/initval.h>
+#include <drm/intel_lpe_audio.h>
 #include "intel_hdmi_audio.h"
 
 /*standard module options for ALSA. This module supports only one card*/
@@ -168,72 +170,75 @@ int had_get_hwstate(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
-int had_get_caps(struct snd_intelhad *intelhaddata,
-		 enum had_caps_list query, void *caps)
+static inline void
+mid_hdmi_audio_read(struct snd_intelhad *ctx, u32 reg, u32 *val)
 {
-	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
-	int retval;
-
-	retval = had_get_hwstate(intelhaddata);
-	if (!retval)
-		retval = mid_hdmi_audio_get_caps(pdev, query, caps);
-
-	return retval;
+	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
-int had_set_caps(struct snd_intelhad *intelhaddata,
-		 enum had_caps_list set_element, void *caps)
+static inline void
+mid_hdmi_audio_write(struct snd_intelhad *ctx, u32 reg, u32 val)
 {
-	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
-	int retval;
-
-	retval = had_get_hwstate(intelhaddata);
-	if (!retval)
-		retval = mid_hdmi_audio_set_caps(pdev, set_element, caps);
-
-	return retval;
+	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
 int had_read_register(struct snd_intelhad *intelhaddata, u32 offset, u32 *data)
 {
-	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
-	if (!retval)
-		retval = mid_hdmi_audio_read(pdev, offset, data);
+	if (retval)
+		return retval;
 
-	return retval;
+	mid_hdmi_audio_read(intelhaddata, offset, data);
+	return 0;
+}
+
+static void fixup_dp_config(struct snd_intelhad *intelhaddata,
+			    u32 offset, u32 *data)
+{
+	if (intelhaddata->dp_output) {
+		if (offset == AUD_CONFIG && (*data & AUD_CONFIG_VALID_BIT))
+			*data |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
+	}
 }
 
 int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
 {
-	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
-	if (!retval)
-		retval = mid_hdmi_audio_write(pdev, offset, data);
+	if (retval)
+		return retval;
 
-	return retval;
+	fixup_dp_config(intelhaddata, offset, &data);
+	mid_hdmi_audio_write(intelhaddata, offset, data);
+	return 0;
 }
 
 int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
 		    u32 data, u32 mask)
 {
-	struct platform_device *pdev = to_platform_device(intelhaddata->dev);
+	u32 val_tmp;
 	int retval;
 
 	retval = had_get_hwstate(intelhaddata);
-	if (!retval)
-		retval = mid_hdmi_audio_rmw(pdev, offset, data, mask);
+	if (retval)
+		return retval;
 
-	return retval;
+	mid_hdmi_audio_read(intelhaddata, offset, &val_tmp);
+	val_tmp &= ~mask;
+	val_tmp |= (data & mask);
+
+	fixup_dp_config(intelhaddata, offset, &val_tmp);
+	mid_hdmi_audio_write(intelhaddata, offset, val_tmp);
+	return 0;
 }
-/**
- * function to read-modify
- * AUD_CONFIG register on VLV2.The had_read_modify() function should not
- * directly be used on VLV2 for updating AUD_CONFIG register.
+
+/*
+ * function to read-modify AUD_CONFIG register on VLV2.
+ * The had_read_modify() function should not directly be used on VLV2 for
+ * updating AUD_CONFIG register.
  * This is because:
  * Bit6 of AUD_CONFIG register is writeonly due to a silicon bug on VLV2
  * HDMI IP. As a result a read-modify of AUD_CONFIG regiter will always
@@ -249,10 +254,10 @@ int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
  * @mask : mask
  *
  */
-static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
+static int had_read_modify_aud_config_v2(struct snd_intelhad *intelhaddata,
 					u32 data, u32 mask)
 {
-	struct snd_intelhad *intelhaddata = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *substream;
 	union aud_cfg cfg_val = {.cfg_regval = 0};
 	u8 channels;
 
@@ -260,7 +265,8 @@ static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 	 * If substream is NULL, there is no active stream.
 	 * In this case just set channels to 2
 	 */
-	if (substream)
+	substream = intelhaddata->stream_info.had_substream;
+	if (substream && substream->runtime)
 		channels = substream->runtime->channels;
 	else
 		channels = 2;
@@ -274,9 +280,23 @@ static int had_read_modify_aud_config_v2(struct snd_pcm_substream *substream,
 	return had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
 }
 
-void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable)
+void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
+{
+	u32 status_reg;
+
+	if (enable) {
+		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS_v2, &status_reg);
+		status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
+		mid_hdmi_audio_write(ctx, AUD_HDMI_STATUS_v2, status_reg);
+		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS_v2, &status_reg);
+	}
+}
+
+void snd_intelhad_enable_audio(struct snd_intelhad *intelhaddata,
+			       bool enable)
 {
-	had_read_modify_aud_config_v2(substream, enable, BIT(0));
+	had_read_modify_aud_config_v2(intelhaddata, enable ? BIT(0) : 0,
+				      BIT(0));
 }
 
 static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
@@ -437,7 +457,7 @@ static int snd_intelhad_channel_allocation(struct snd_intelhad *intelhaddata,
 	 */
 
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (intelhaddata->eeld.speaker_allocation_block & (1 << i))
+		if (intelhaddata->eld.speaker_allocation_block & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -482,11 +502,8 @@ void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 		return;
 	}
 
-	had_get_caps(intelhaddata, HAD_GET_ELD, &intelhaddata->eeld);
-	had_get_caps(intelhaddata, HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
-
-	pr_debug("eeld.speaker_allocation_block = %x\n",
-			intelhaddata->eeld.speaker_allocation_block);
+	pr_debug("eld.speaker_allocation_block = %x\n",
+			intelhaddata->eld.speaker_allocation_block);
 
 	/* WA: Fix the max channel supported to 8 */
 
@@ -497,14 +514,14 @@ void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	 */
 
 	/* if 0x2F < eld < 0x4F fall back to 0x2f, else fall back to 0x4F */
-	eld_high = intelhaddata->eeld.speaker_allocation_block & eld_high_mask;
+	eld_high = intelhaddata->eld.speaker_allocation_block & eld_high_mask;
 	if ((eld_high & (eld_high-1)) && (eld_high > 0x1F)) {
 		/* eld_high & (eld_high-1): if more than 1 bit set */
 		/* 0x1F: 7 channels */
 		for (i = 1; i < 4; i++) {
 			high_msb = eld_high & (0x80 >> i);
 			if (high_msb) {
-				intelhaddata->eeld.speaker_allocation_block &=
+				intelhaddata->eld.speaker_allocation_block &=
 					high_msb | 0xF;
 				break;
 			}
@@ -512,7 +529,7 @@ void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (intelhaddata->eeld.speaker_allocation_block & (1 << i))
+		if (intelhaddata->eld.speaker_allocation_block & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -1176,7 +1193,7 @@ static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
-	int caps, retval = 0;
+	int retval = 0;
 	unsigned long flag_irq;
 	struct snd_intelhad *intelhaddata;
 	struct had_stream_pvt *stream;
@@ -1203,15 +1220,8 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		had_stream->stream_type = HAD_RUNNING_STREAM;
 
 		/* Enable Audio */
-		/*
-		 * ToDo: Need to enable UNDERRUN interrupts as well
-		 *   caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-		 */
-		caps = HDMI_AUDIO_BUFFER_DONE;
-		retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO_INT,
-				      &caps);
-		retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO, NULL);
-		snd_intelhad_enable_audio(substream, 1);
+		snd_intelhad_enable_audio_int(intelhaddata, true);
+		snd_intelhad_enable_audio(intelhaddata, true);
 
 		pr_debug("Processed _Start\n");
 
@@ -1228,18 +1238,13 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		had_stream->stream_type = HAD_INIT;
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irq);
 		/* Disable Audio */
-		/*
-		 * ToDo: Need to disable UNDERRUN interrupts as well
-		 *   caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-		 */
-		caps = HDMI_AUDIO_BUFFER_DONE;
-		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
-		snd_intelhad_enable_audio(substream, 0);
+		snd_intelhad_enable_audio_int(intelhaddata, false);
+		snd_intelhad_enable_audio(intelhaddata, false);
 		/* Reset buffer pointers */
 		snd_intelhad_reset_audio(intelhaddata, 1);
 		snd_intelhad_reset_audio(intelhaddata, 0);
 		stream->stream_status = STREAM_DROPPED;
-		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
+		snd_intelhad_enable_audio_int(intelhaddata, false);
 		break;
 
 	default:
@@ -1297,15 +1302,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 
 
 	/* Get N value in KHz */
-	retval = had_get_caps(intelhaddata, HAD_GET_DISPLAY_RATE,
-			      &disp_samp_freq);
-	if (retval) {
-		pr_err("querying display sampling freq failed %#x\n", retval);
-		goto prep_end;
-	}
-
-	had_get_caps(intelhaddata, HAD_GET_ELD, &intelhaddata->eeld);
-	had_get_caps(intelhaddata, HAD_GET_DP_OUTPUT, &intelhaddata->dp_output);
+	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
 	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
 				     intelhaddata);
@@ -1315,8 +1312,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (intelhaddata->dp_output)
-		had_get_caps(intelhaddata, HAD_GET_LINK_RATE, &link_rate);
-
+		link_rate = intelhaddata->link_rate;
 
 	snd_intelhad_prog_cts(substream->runtime->rate,
 			      disp_samp_freq, link_rate,
@@ -1425,25 +1421,22 @@ static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
 			vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
+static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 {
+	struct snd_pcm_substream *substream;
 	int retval = 0;
 	u32 disp_samp_freq, n_param;
 	u32 link_rate = 0;
-	struct snd_intelhad *intelhaddata;
 
-	intelhaddata = snd_pcm_substream_chip(substream);
+	substream = intelhaddata->stream_info.had_substream;
+	if (!substream || !substream->runtime)
+		return 0;
 
 	/* Disable Audio */
-	snd_intelhad_enable_audio(substream, 0);
+	snd_intelhad_enable_audio(intelhaddata, false);
 
 	/* Update CTS value */
-	retval = had_get_caps(intelhaddata, HAD_GET_DISPLAY_RATE,
-			      &disp_samp_freq);
-	if (retval) {
-		pr_err("querying display sampling freq failed %#x\n", retval);
-		goto out;
-	}
+	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
 	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param,
 				     intelhaddata);
@@ -1453,14 +1446,14 @@ int hdmi_audio_mode_change(struct snd_pcm_substream *substream)
 	}
 
 	if (intelhaddata->dp_output)
-		had_get_caps(intelhaddata, HAD_GET_LINK_RATE, &link_rate);
+		link_rate = intelhaddata->link_rate;
 
 	snd_intelhad_prog_cts(substream->runtime->rate,
 			      disp_samp_freq, link_rate,
 			      n_param, intelhaddata);
 
 	/* Enable Audio */
-	snd_intelhad_enable_audio(substream, 1);
+	snd_intelhad_enable_audio(intelhaddata, true);
 
 out:
 	return retval;
@@ -1555,129 +1548,290 @@ static struct snd_kcontrol_new had_control_iec958 = {
 	.put =          had_iec958_put
 };
 
+static void _had_wq(struct work_struct *work)
+{
+	struct snd_intelhad *ctx =
+		container_of(work, struct snd_intelhad, hdmi_audio_wq);
+
+	had_process_hot_plug(ctx);
+}
+
+static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
+{
+	struct snd_intelhad *ctx = dev_id;
+	u32 audio_stat, audio_reg;
+
+	audio_reg = AUD_HDMI_STATUS_v2;
+	mid_hdmi_audio_read(ctx, audio_reg, &audio_stat);
+
+	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
+		mid_hdmi_audio_write(ctx, audio_reg, HDMI_AUDIO_UNDERRUN);
+		had_process_buffer_underrun(ctx);
+	}
+
+	if (audio_stat & HDMI_AUDIO_BUFFER_DONE) {
+		mid_hdmi_audio_write(ctx, audio_reg, HDMI_AUDIO_BUFFER_DONE);
+		had_process_buffer_done(ctx);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void notify_audio_lpe(struct platform_device *pdev)
+{
+	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
+	struct intel_hdmi_lpe_audio_pdata *pdata = pdev->dev.platform_data;
+
+	if (pdata->hdmi_connected != true) {
+
+		dev_dbg(&pdev->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
+			__func__);
+
+		if (ctx->state == hdmi_connector_status_connected) {
+
+			ctx->state = hdmi_connector_status_disconnected;
+
+			had_process_hot_unplug(ctx);
+		} else
+			dev_dbg(&pdev->dev, "%s: Already Unplugged!\n",
+				__func__);
+
+	} else {
+		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
+
+		switch (eld->pipe_id) {
+		case 0:
+			ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
+			break;
+		case 1:
+			ctx->had_config_offset = AUDIO_HDMI_CONFIG_B;
+			break;
+		case 2:
+			ctx->had_config_offset = AUDIO_HDMI_CONFIG_C;
+			break;
+		default:
+			dev_dbg(&pdev->dev, "Invalid pipe %d\n",
+				eld->pipe_id);
+			break;
+		}
+
+		memcpy(&ctx->eld, eld->eld_data, sizeof(ctx->eld));
+
+		had_process_hot_plug(ctx);
+
+		ctx->state = hdmi_connector_status_connected;
+
+		dev_dbg(&pdev->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
+			__func__, eld->port_id,	pdata->tmds_clock_speed);
+
+		if (pdata->tmds_clock_speed) {
+			ctx->tmds_clock_speed = pdata->tmds_clock_speed;
+			ctx->dp_output = pdata->dp_output;
+			ctx->link_rate = pdata->link_rate;
+
+			/* Process mode change if stream is active */
+			if (ctx->stream_data.stream_type == HAD_RUNNING_STREAM)
+				hdmi_audio_mode_change(ctx);
+		}
+	}
+}
+
+/* release resources */
+static void hdmi_lpe_audio_free(struct snd_card *card)
+{
+	struct snd_intelhad *ctx = card->private_data;
+
+	if (ctx->mmio_start)
+		iounmap(ctx->mmio_start);
+	if (ctx->irq >= 0)
+		free_irq(ctx->irq, ctx);
+}
+
 /*
- * hdmi_audio_probe - to create sound card instance for HDMI audio playabck
- *
- * @devptr: platform device
- * @had_ret: pointer to store the created snd_intelhad object
+ * hdmi_lpe_audio_probe - start bridge with i915
  *
- * This function is called when the platform device is probed. This function
- * creates and registers the sound card with ALSA
+ * This function is called when the i915 driver creates the
+ * hdmi-lpe-audio platform device. Card creation is deferred until a
+ * hot plug event is received
  */
-int hdmi_audio_probe(struct platform_device *devptr,
-		     struct snd_intelhad **had_ret)
+static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 {
-	int retval;
-	struct snd_pcm *pcm;
 	struct snd_card *card;
-	struct snd_intelhad *intelhaddata;
+	struct snd_intelhad *ctx;
+	struct snd_pcm *pcm;
+	struct intel_hdmi_lpe_audio_pdata *pdata;
+	int irq;
+	struct resource *res_mmio;
+	int ret;
+	unsigned long flags;
+
+	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
+	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
+		return -EINVAL;
+	}
 
-	pr_debug("Enter %s\n", __func__);
+	/* get resources */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Could not get irq resource\n");
+		return -ENODEV;
+	}
+
+	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mmio) {
+		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
+		return -ENXIO;
+	}
 
 	/* create a card instance with ALSA framework */
-	retval = snd_card_new(&devptr->dev, hdmi_card_index, hdmi_card_id,
-			      THIS_MODULE, sizeof(*intelhaddata), &card);
-	if (retval)
-		return retval;
+	ret = snd_card_new(&pdev->dev, hdmi_card_index, hdmi_card_id,
+			   THIS_MODULE, sizeof(*ctx), &card);
+	if (ret)
+		return ret;
+
+	ctx = card->private_data;
+	spin_lock_init(&ctx->had_spinlock);
+	ctx->drv_status = HAD_DRV_DISCONNECTED;
+	ctx->dev = &pdev->dev;
+	ctx->card = card;
+	ctx->card_id = hdmi_card_id;
+	ctx->card_index = card->number;
+	ctx->flag_underrun = 0;
+	ctx->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
+	strcpy(card->driver, INTEL_HAD);
+	strcpy(card->shortname, INTEL_HAD);
+
+	ctx->irq = -1;
+	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
+	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
+	ctx->state = hdmi_connector_status_disconnected;
+
+	card->private_free = hdmi_lpe_audio_free;
+
+	/* assume pipe A as default */
+	ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
+
+	platform_set_drvdata(pdev, ctx);
+
+	dev_dbg(&pdev->dev, "%s: mmio_start = 0x%x, mmio_end = 0x%x\n",
+		__func__, (unsigned int)res_mmio->start,
+		(unsigned int)res_mmio->end);
+
+	ctx->mmio_start = ioremap_nocache(res_mmio->start,
+					  (size_t)(resource_size(res_mmio)));
+	if (!ctx->mmio_start) {
+		dev_err(&pdev->dev, "Could not get ioremap\n");
+		ret = -EACCES;
+		goto err;
+	}
 
-	intelhaddata = card->private_data;
-	spin_lock_init(&intelhaddata->had_spinlock);
-	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
-	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
-			__func__, __LINE__);
+	/* setup interrupt handler */
+	ret = request_irq(irq, display_pipe_interrupt_handler, 0,
+			  pdev->name, ctx);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto err;
+	}
 
-	intelhaddata->dev = &devptr->dev;
-	intelhaddata->card = card;
-	intelhaddata->card_id = hdmi_card_id;
-	intelhaddata->card_index = card->number;
-	intelhaddata->flag_underrun = 0;
-	intelhaddata->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
-	strncpy(card->driver, INTEL_HAD, strlen(INTEL_HAD));
-	strncpy(card->shortname, INTEL_HAD, strlen(INTEL_HAD));
-
-	retval = snd_pcm_new(card, INTEL_HAD, PCM_INDEX, MAX_PB_STREAMS,
-						MAX_CAP_STREAMS, &pcm);
-	if (retval)
+	ctx->irq = irq;
+
+	ret = snd_pcm_new(card, INTEL_HAD, PCM_INDEX, MAX_PB_STREAMS,
+			  MAX_CAP_STREAMS, &pcm);
+	if (ret)
 		goto err;
 
 	/* setup private data which can be retrieved when required */
-	pcm->private_data = intelhaddata;
+	pcm->private_data = ctx;
 	pcm->private_free = snd_intelhad_pcm_free;
 	pcm->info_flags = 0;
 	strncpy(pcm->name, card->shortname, strlen(card->shortname));
-	/* setup the ops for palyabck */
+	/* setup the ops for playabck */
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			    &snd_intelhad_playback_ops);
 	/* allocate dma pages for ALSA stream operations
 	 * memory allocated is based on size, not max value
 	 * thus using same argument for max & size
 	 */
-	retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_DEV, NULL,
 			HAD_MAX_BUFFER, HAD_MAX_BUFFER);
-	if (retval)
-		goto err;
 
 	/* IEC958 controls */
-	retval = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958_mask,
-						intelhaddata));
-	if (retval < 0)
+	ret = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958_mask, ctx));
+	if (ret < 0)
 		goto err;
-	retval = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958,
-						intelhaddata));
-	if (retval < 0)
+	ret = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958, ctx));
+	if (ret < 0)
 		goto err;
 
 	init_channel_allocations();
 
 	/* Register channel map controls */
-	retval = had_register_chmap_ctls(intelhaddata, pcm);
-	if (retval < 0)
+	ret = had_register_chmap_ctls(ctx, pcm);
+	if (ret < 0)
 		goto err;
 
-	retval = snd_card_register(card);
-	if (retval)
+	ret = snd_card_register(card);
+	if (ret)
 		goto err;
 
-	pm_runtime_set_active(intelhaddata->dev);
-	pm_runtime_enable(intelhaddata->dev);
+	spin_lock_irqsave(&pdata->lpe_audio_slock, flags);
+	pdata->notify_audio_lpe = notify_audio_lpe;
+	if (pdata->notify_pending) {
 
-	*had_ret = intelhaddata;
+		dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
+		notify_audio_lpe(pdev);
+		pdata->notify_pending = false;
+	}
+	spin_unlock_irqrestore(&pdata->lpe_audio_slock, flags);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	schedule_work(&ctx->hdmi_audio_wq);
 
 	return 0;
 
 err:
 	snd_card_free(card);
-	pr_err("Error returned from %s api %#x\n", __func__, retval);
-	return retval;
+	return ret;
 }
 
 /*
- * hdmi_audio_remove - removes the alsa card
+ * hdmi_lpe_audio_remove - stop bridge with i915
  *
- *@haddata: pointer to HAD private data
- *
- * This function is called when the hdmi cable is un-plugged. This function
- * free the sound card.
+ * This function is called when the platform device is destroyed. The sound
+ * card should have been removed on hot plug event.
  */
-int hdmi_audio_remove(struct snd_intelhad *intelhaddata)
+static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
-	int caps;
-
-	pr_debug("Enter %s\n", __func__);
+	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
 
-	if (!intelhaddata)
-		return 0;
+	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 
-	if (intelhaddata->drv_status != HAD_DRV_DISCONNECTED) {
-		caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
-		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
-	}
-	snd_card_free(intelhaddata->card);
+	if (ctx->drv_status != HAD_DRV_DISCONNECTED)
+		snd_intelhad_enable_audio_int(ctx, false);
+	snd_card_free(ctx->card);
 	return 0;
 }
 
+static struct platform_driver hdmi_lpe_audio_driver = {
+	.driver		= {
+		.name  = "hdmi-lpe-audio",
+	},
+	.probe          = hdmi_lpe_audio_probe,
+	.remove		= hdmi_lpe_audio_remove,
+	.suspend	= hdmi_lpe_audio_suspend,
+	.resume		= hdmi_lpe_audio_resume
+};
+
+module_platform_driver(hdmi_lpe_audio_driver);
+MODULE_ALIAS("platform:hdmi_lpe_audio");
+
 MODULE_AUTHOR("Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>");
 MODULE_AUTHOR("Ramesh Babu K V <ramesh.babu@intel.com>");
 MODULE_AUTHOR("Vaibhav Agarwal <vaibhav.agarwal@intel.com>");
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 8415f93e40dc..6efa846f98c9 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -108,7 +108,7 @@ struct had_stream_data {
  * @drv_status: driver status
  * @buf_info: ring buffer info
  * @stream_info: stream information
- * @eeld: holds EELD info
+ * @eld: holds ELD info
  * @curr_buf: pointer to hold current active ring buf
  * @valid_buf_cnt: ring buffer count for stream
  * @had_spinlock: driver lock
@@ -127,7 +127,7 @@ struct snd_intelhad {
 	enum had_drv_status	drv_status;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
-	union otm_hdmi_eld_t	eeld;
+	union otm_hdmi_eld_t	eld;
 	bool dp_output;
 	enum		intel_had_aud_buf_type curr_buf;
 	int		valid_buf_cnt;
@@ -142,15 +142,27 @@ struct snd_intelhad {
 	unsigned int	*audio_reg_base;
 	unsigned int	audio_cfg_offset;
 	int underrun_count;
+	enum hdmi_connector_status state;
+	int tmds_clock_speed;
+	int link_rate;
+
+	/* internal stuff */
+	int irq;
+	void __iomem *mmio_start;
+	unsigned int had_config_offset;
+	int hdmi_audio_interrupt_mask;
+	struct work_struct hdmi_audio_wq;
 };
 
-int had_event_handler(enum had_event_type event_type, void *data);
-
-int hdmi_audio_suspend(void *drv_data);
-int hdmi_audio_resume(void *drv_data);
-int hdmi_audio_mode_change(struct snd_pcm_substream *substream);
+int hdmi_lpe_audio_suspend(struct platform_device *pdev, pm_message_t state);
+int hdmi_lpe_audio_resume(struct platform_device *pdev);
 extern struct snd_pcm_ops snd_intelhad_playback_ops;
 
+int had_process_buffer_done(struct snd_intelhad *intelhaddata);
+int had_process_buffer_underrun(struct snd_intelhad *intelhaddata);
+int had_process_hot_plug(struct snd_intelhad *intelhaddata);
+int had_process_hot_unplug(struct snd_intelhad *intelhaddata);
+
 int snd_intelhad_init_audio_ctrl(struct snd_pcm_substream *substream,
 					struct snd_intelhad *intelhaddata,
 					int flag_silence);
@@ -160,15 +172,12 @@ int snd_intelhad_invd_buffer(int start, int end);
 int snd_intelhad_read_len(struct snd_intelhad *intelhaddata);
 void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata);
 
-void snd_intelhad_enable_audio(struct snd_pcm_substream *substream, u8 enable);
+void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable);
+void snd_intelhad_enable_audio(struct snd_intelhad *ctx, bool enable);
 void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata);
 
 /* Register access functions */
 int had_get_hwstate(struct snd_intelhad *intelhaddata);
-int had_get_caps(struct snd_intelhad *intelhaddata,
-		 enum had_caps_list query_element, void *capabilties);
-int had_set_caps(struct snd_intelhad *intelhaddata,
-		 enum had_caps_list set_element, void *capabilties);
 int had_read_register(struct snd_intelhad *intelhaddata,
 		      u32 reg_addr, u32 *data);
 int had_write_register(struct snd_intelhad *intelhaddata,
@@ -176,8 +185,4 @@ int had_write_register(struct snd_intelhad *intelhaddata,
 int had_read_modify(struct snd_intelhad *intelhaddata,
 		    u32 reg_addr, u32 data, u32 mask);
 
-int hdmi_audio_probe(struct platform_device *devptr,
-		     struct snd_intelhad **had_ret);
-int hdmi_audio_remove(struct snd_intelhad *intelhaddata);
-
 #endif /* _INTEL_HDMI_AUDIO_ */
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 57acefaf930e..327650dd1723 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -33,21 +33,20 @@
 #include "intel_hdmi_audio.h"
 #include "intel_hdmi_lpe_audio.h"
 
-/**
- * hdmi_audio_suspend - power management suspend function
+/*
+ * hdmi_lpe_audio_suspend - power management suspend function
  *
- *@haddata: pointer to HAD private data
+ * @pdev: platform device
  *
  * This function is called by client driver to suspend the
  * hdmi audio.
  */
-int hdmi_audio_suspend(void *haddata)
+int hdmi_lpe_audio_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	int caps, retval = 0;
 	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 	struct snd_pcm_substream *substream;
-	struct snd_intelhad *intelhaddata = (struct snd_intelhad *)haddata;
+	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
 
 	pr_debug("Enter:%s\n", __func__);
 
@@ -64,13 +63,13 @@ int hdmi_audio_suspend(void *haddata)
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 		pr_debug("had not connected\n");
-		return retval;
+		return 0;
 	}
 
 	if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 		pr_debug("had already suspended\n");
-		return retval;
+		return 0;
 	}
 
 	intelhaddata->drv_status = HAD_DRV_SUSPENDED;
@@ -78,29 +77,22 @@ int hdmi_audio_suspend(void *haddata)
 			__func__, __LINE__);
 
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	/*
-	 * ToDo: Need to disable UNDERRUN interrupts as well
-	 *  caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-	 */
-	caps = HDMI_AUDIO_BUFFER_DONE;
-	had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT, &caps);
-	had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
+	snd_intelhad_enable_audio_int(intelhaddata, false);
 	pr_debug("Exit:%s", __func__);
-	return retval;
+	return 0;
 }
 
-/**
- * hdmi_audio_resume - power management resume function
+/*
+ * hdmi_lpe_audio_resume - power management resume function
  *
- *@haddata: pointer to HAD private data
+ *@pdev: platform device
  *
  * This function is called by client driver to resume the
  * hdmi audio.
  */
-int hdmi_audio_resume(void *haddata)
+int hdmi_lpe_audio_resume(struct platform_device *pdev)
 {
-	int caps, retval = 0;
-	struct snd_intelhad *intelhaddata = (struct snd_intelhad *)haddata;
+	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
 	unsigned long flag_irqs;
 
 	pr_debug("Enter:%s\n", __func__);
@@ -128,15 +120,9 @@ int hdmi_audio_resume(void *haddata)
 	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	/*
-	 * ToDo: Need to enable UNDERRUN interrupts as well
-	 * caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
-	 */
-	caps = HDMI_AUDIO_BUFFER_DONE;
-	retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO_INT, &caps);
-	retval = had_set_caps(intelhaddata, HAD_SET_ENABLE_AUDIO, NULL);
+	snd_intelhad_enable_audio_int(intelhaddata, true);
 	pr_debug("Exit:%s", __func__);
-	return retval;
+	return 0;
 }
 
 static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
@@ -357,7 +343,6 @@ int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 
 int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
-	int caps, retval = 0;
 	enum intel_had_aud_buf_type buf_id;
 	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
@@ -372,17 +357,12 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		pr_debug("Device already disconnected\n");
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		return retval;
+		return 0;
 
 	} else {
 		/* Disable Audio */
-		caps = HDMI_AUDIO_BUFFER_DONE;
-		retval = had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO_INT,
-				      &caps);
-		retval = had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO,
-				      NULL);
-		snd_intelhad_enable_audio(
-			intelhaddata->stream_info.had_substream, 0);
+		snd_intelhad_enable_audio_int(intelhaddata, false);
+		snd_intelhad_enable_audio(intelhaddata, false);
 	}
 
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
@@ -405,74 +385,6 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	intelhaddata->audio_reg_base = NULL;
 	pr_debug("%s: unlocked -> returned\n", __func__);
 
-	return retval;
+	return 0;
 }
 
-/**
- * had_event_handler - Call back function to handle events
- *
- * @event_type: Event type to handle
- * @data: data related to the event_type
- *
- * This function is invoked to handle HDMI events from client driver.
- */
-int had_event_handler(enum had_event_type event_type, void *data)
-{
-	int retval = 0;
-	struct snd_intelhad *intelhaddata = data;
-	enum intel_had_aud_buf_type buf_id;
-	struct snd_pcm_substream *substream;
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-
-	buf_id = intelhaddata->curr_buf;
-	had_stream = &intelhaddata->stream_data;
-
-	/* Switching to a function can drop atomicity even in INTR context.
-	 * Thus, a big lock is acquired to maintain atomicity.
-	 * This can be optimized later.
-	 * Currently, only buffer_done/_underrun executes in INTR context.
-	 * Also, locking is implemented separately to avoid real contention
-	 * of data(struct intelhaddata) between IRQ/SOFT_IRQ/PROCESS context.
-	 */
-	substream = intelhaddata->stream_info.had_substream;
-	switch (event_type) {
-	case HAD_EVENT_AUDIO_BUFFER_DONE:
-		retval = had_process_buffer_done(intelhaddata);
-	break;
-
-	case HAD_EVENT_AUDIO_BUFFER_UNDERRUN:
-		retval = had_process_buffer_underrun(intelhaddata);
-	break;
-
-	case HAD_EVENT_HOT_PLUG:
-		retval = had_process_hot_plug(intelhaddata);
-	break;
-
-	case HAD_EVENT_HOT_UNPLUG:
-		retval = had_process_hot_unplug(intelhaddata);
-	break;
-
-	case HAD_EVENT_MODE_CHANGING:
-		pr_debug(" called _event_handler with _MODE_CHANGE event\n");
-		/* Process only if stream is active & cable Plugged-in */
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-		if (intelhaddata->drv_status >= HAD_DRV_DISCONNECTED) {
-			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
-					flag_irqs);
-			break;
-		}
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		if ((had_stream->stream_type == HAD_RUNNING_STREAM)
-				&& substream)
-			retval = hdmi_audio_mode_change(substream);
-	break;
-
-	default:
-		pr_debug("error un-handled event !!\n");
-		retval = -EINVAL;
-	break;
-
-	}
-	return retval;
-}
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
deleted file mode 100644
index 8789f55724da..000000000000
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ /dev/null
@@ -1,462 +0,0 @@
-/*
- *  intel_hdmi_lpe_audio.c - Intel HDMI LPE audio driver for Atom platforms
- *
- *  Copyright (C) 2016 Intel Corp
- *  Authors:
- *		Jerome Anand <jerome.anand@intel.com>
- *		Aravind Siddappaji <aravindx.siddappaji@intel.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-#include <linux/platform_device.h>
-#include <linux/irqreturn.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/control.h>
-#include <sound/initval.h>
-#include <drm/intel_lpe_audio.h>
-#include "intel_hdmi_lpe_audio.h"
-#include "intel_hdmi_audio.h"
-
-struct hdmi_lpe_audio_ctx {
-	struct platform_device *pdev;
-	int irq;
-	void __iomem *mmio_start;
-	struct snd_intelhad *had;
-	int tmds_clock_speed;
-	bool dp_output;
-	int link_rate;
-	unsigned int had_config_offset;
-	int hdmi_audio_interrupt_mask;
-	struct work_struct hdmi_audio_wq;
-	int state; /* connection state */
-	union otm_hdmi_eld_t eld; /* ELD copy */
-};
-
-static void mid_hdmi_audio_signal_event(struct platform_device *pdev,
-					enum had_event_type event)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
-
-	/* The handler is protected in the respective
-	 * event handlers to avoid races
-	 */
-	had_event_handler(event, ctx->had);
-}
-
-/*
- * used to write into display controller HDMI audio registers.
- */
-int mid_hdmi_audio_write(struct platform_device *pdev, u32 reg, u32 val)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, val);
-
-	if (ctx->dp_output) {
-		if (reg == AUD_CONFIG && (val & AUD_CONFIG_VALID_BIT))
-			val |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
-	}
-	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
-
-	return 0;
-}
-
-/*
- * used to get the register value read from
- * display controller HDMI audio registers.
- */
-int mid_hdmi_audio_read(struct platform_device *pdev, u32 reg, u32 *val)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
-	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__, reg, *val);
-	return 0;
-}
-
-/*
- * used to update the masked bits in display controller HDMI
- * audio registers.
- */
-int mid_hdmi_audio_rmw(struct platform_device *pdev,
-		       u32 reg, u32 val, u32 mask)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-	u32 val_tmp = 0;
-
-	val_tmp = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
-	val_tmp &= ~mask;
-	val_tmp |= (val & mask);
-
-	if (ctx->dp_output) {
-		if (reg == AUD_CONFIG && (val_tmp & AUD_CONFIG_VALID_BIT))
-			val_tmp |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
-	}
-
-	iowrite32(val_tmp, ctx->mmio_start + ctx->had_config_offset + reg);
-	dev_dbg(&pdev->dev, "%s: reg[0x%x] = 0x%x\n", __func__,
-				reg, val_tmp);
-
-	return 0;
-}
-
-/*
- * used to return the HDMI audio capabilities.
- * e.g. resolution, frame rate.
- */
-int mid_hdmi_audio_get_caps(struct platform_device *pdev,
-			    enum had_caps_list get_element,
-			    void *capabilities)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-	int ret = 0;
-
-	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
-
-	switch (get_element) {
-	case HAD_GET_ELD:
-		memcpy(capabilities, &ctx->eld, sizeof(ctx->eld));
-		print_hex_dump_bytes("eld: ", DUMP_PREFIX_NONE,
-				     (u8 *)&ctx->eld, sizeof(ctx->eld));
-		break;
-	case HAD_GET_DISPLAY_RATE:
-		/* ToDo: Verify if sampling freq logic is correct */
-		*(u32 *)capabilities = ctx->tmds_clock_speed;
-		dev_dbg(&pdev->dev, "%s: tmds_clock_speed = 0x%x\n",
-			__func__, ctx->tmds_clock_speed);
-		break;
-	case HAD_GET_LINK_RATE:
-		/* ToDo: Verify if sampling freq logic is correct */
-		*(u32 *)capabilities = ctx->link_rate;
-		dev_dbg(&pdev->dev, "%s: link rate = 0x%x\n",
-			__func__, ctx->link_rate);
-		break;
-	case HAD_GET_DP_OUTPUT:
-		*(u32 *)capabilities = ctx->dp_output;
-		dev_dbg(&pdev->dev, "%s: dp_output = %d\n",
-			__func__, ctx->dp_output);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
-/*
- * used to set the HDMI audio capabilities.
- * e.g. Audio INT.
- */
-int mid_hdmi_audio_set_caps(struct platform_device *pdev,
-			    enum had_caps_list set_element,
-			    void *capabilties)
-{
-	dev_dbg(&pdev->dev, "%s: cap_id = 0x%x\n", __func__, set_element);
-
-	switch (set_element) {
-	case HAD_SET_ENABLE_AUDIO_INT:
-		{
-			u32 status_reg;
-
-			mid_hdmi_audio_read(pdev, AUD_HDMI_STATUS_v2,
-					    &status_reg);
-			status_reg |=
-				HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-			mid_hdmi_audio_write(pdev, AUD_HDMI_STATUS_v2,
-					     status_reg);
-			mid_hdmi_audio_read(pdev, AUD_HDMI_STATUS_v2,
-					    &status_reg);
-		}
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static void _had_wq(struct work_struct *work)
-{
-	struct hdmi_lpe_audio_ctx *ctx =
-		container_of(work, struct hdmi_lpe_audio_ctx, hdmi_audio_wq);
-
-	mid_hdmi_audio_signal_event(ctx->pdev, HAD_EVENT_HOT_PLUG);
-}
-
-static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
-{
-	struct platform_device *pdev = dev_id;
-	u32 audio_stat, audio_reg;
-	struct hdmi_lpe_audio_ctx *ctx;
-
-	dev_dbg(&pdev->dev, "%s: Enter\n", __func__);
-
-	ctx = platform_get_drvdata(pdev);
-
-	audio_reg = AUD_HDMI_STATUS_v2;
-	mid_hdmi_audio_read(pdev, audio_reg, &audio_stat);
-
-	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
-		mid_hdmi_audio_write(pdev, audio_reg, HDMI_AUDIO_UNDERRUN);
-		mid_hdmi_audio_signal_event(pdev,
-				HAD_EVENT_AUDIO_BUFFER_UNDERRUN);
-	}
-
-	if (audio_stat & HDMI_AUDIO_BUFFER_DONE) {
-		mid_hdmi_audio_write(pdev, audio_reg, HDMI_AUDIO_BUFFER_DONE);
-		mid_hdmi_audio_signal_event(pdev,
-				HAD_EVENT_AUDIO_BUFFER_DONE);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static void notify_audio_lpe(struct platform_device *pdev)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-	struct intel_hdmi_lpe_audio_pdata *pdata = pdev->dev.platform_data;
-
-	if (pdata->hdmi_connected != true) {
-
-		dev_dbg(&pdev->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
-			__func__);
-
-		if (ctx->state == hdmi_connector_status_connected) {
-
-			ctx->state = hdmi_connector_status_disconnected;
-
-			mid_hdmi_audio_signal_event(pdev,
-				HAD_EVENT_HOT_UNPLUG);
-		} else
-			dev_dbg(&pdev->dev, "%s: Already Unplugged!\n",
-				__func__);
-
-	} else {
-		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
-
-		switch (eld->pipe_id) {
-		case 0:
-			ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
-			break;
-		case 1:
-			ctx->had_config_offset = AUDIO_HDMI_CONFIG_B;
-			break;
-		case 2:
-			ctx->had_config_offset = AUDIO_HDMI_CONFIG_C;
-			break;
-		default:
-			dev_dbg(&pdev->dev, "Invalid pipe %d\n",
-				eld->pipe_id);
-			break;
-		}
-
-		memcpy(&ctx->eld, eld->eld_data, sizeof(ctx->eld));
-
-		mid_hdmi_audio_signal_event(pdev, HAD_EVENT_HOT_PLUG);
-
-		ctx->state = hdmi_connector_status_connected;
-
-		dev_dbg(&pdev->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
-			__func__, eld->port_id,	pdata->tmds_clock_speed);
-
-		if (pdata->tmds_clock_speed) {
-			ctx->tmds_clock_speed = pdata->tmds_clock_speed;
-			ctx->dp_output = pdata->dp_output;
-			ctx->link_rate = pdata->link_rate;
-			mid_hdmi_audio_signal_event(pdev,
-						    HAD_EVENT_MODE_CHANGING);
-		}
-	}
-}
-
-/**
- * hdmi_lpe_audio_probe - start bridge with i915
- *
- * This function is called when the i915 driver creates the
- * hdmi-lpe-audio platform device. Card creation is deferred until a
- * hot plug event is received
- */
-static int hdmi_lpe_audio_probe(struct platform_device *pdev)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-	struct intel_hdmi_lpe_audio_pdata *pdata;
-	int irq;
-	struct resource *res_mmio;
-	void __iomem *mmio_start;
-	int ret = 0;
-	unsigned long flag_irq;
-
-	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
-	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
-		return -EINVAL;
-	}
-
-	/* get resources */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not get irq resource\n");
-		return -ENODEV;
-	}
-
-	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mmio) {
-		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
-		return -ENXIO;
-	}
-
-	dev_dbg(&pdev->dev, "%s: mmio_start = 0x%x, mmio_end = 0x%x\n",
-		__func__, (unsigned int)res_mmio->start,
-		(unsigned int)res_mmio->end);
-
-	mmio_start = ioremap_nocache(res_mmio->start,
-				     (size_t)(resource_size(res_mmio)));
-	if (!mmio_start) {
-		dev_err(&pdev->dev, "Could not get ioremap\n");
-		return -EACCES;
-	}
-
-	/* alloc and save context */
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (ctx == NULL) {
-		ret = -ENOMEM;
-		goto error_ctx;
-	}
-
-	ctx->pdev = pdev;
-	ctx->irq = irq;
-	dev_dbg(&pdev->dev, "hdmi lpe audio: irq num = %d\n", irq);
-	ctx->mmio_start = mmio_start;
-	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
-	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
-	ctx->state = hdmi_connector_status_disconnected;
-
-	/* assume pipe A as default */
-	ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
-
-	platform_set_drvdata(pdev, ctx);
-
-	/* setup interrupt handler */
-	ret = request_irq(irq, display_pipe_interrupt_handler, 0,
-			  pdev->name, pdev);
-
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq failed\n");
-		goto error_irq;
-	}
-
-	ret = hdmi_audio_probe(pdev, &ctx->had);
-	if (ret < 0)
-		goto error_probe;
-
-	dev_dbg(&pdev->dev, "hdmi lpe audio: setting pin eld notify callback\n");
-
-	/* The Audio driver is loading now and we need to notify
-	 * it if there is an HDMI device attached
-	 */
-	dev_dbg(&pdev->dev, "%s: Scheduling HDMI audio work queue\n",
-				__func__);
-	schedule_work(&ctx->hdmi_audio_wq);
-
-	spin_lock_irqsave(&pdata->lpe_audio_slock, flag_irq);
-	pdata->notify_audio_lpe = notify_audio_lpe;
-	if (pdata->notify_pending) {
-
-		dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
-		notify_audio_lpe(pdev);
-		pdata->notify_pending = false;
-	}
-	spin_unlock_irqrestore(&pdata->lpe_audio_slock, flag_irq);
-
-	return ret;
-
- error_probe:
-	free_irq(irq, pdev);
- error_irq:
-	kfree(ctx);
- error_ctx:
-	iounmap(mmio_start);
-	return ret;
-}
-
-/**
- * hdmi_lpe_audio_remove - stop bridge with i915
- *
- * This function is called when the platform device is destroyed. The sound
- * card should have been removed on hot plug event.
- */
-static int hdmi_lpe_audio_remove(struct platform_device *pdev)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
-
-	hdmi_audio_remove(ctx->had);
-
-	/* release resources */
-	iounmap(ctx->mmio_start);
-	free_irq(ctx->irq, pdev);
-	kfree(ctx);
-	return 0;
-}
-
-static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
-				  pm_message_t state)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "%s: state %d",  __func__, ctx->state);
-	/* HDMI is not connected, assuming audio device is suspended already */
-	if (ctx->state != hdmi_connector_status_disconnected)
-		hdmi_audio_suspend(ctx->had);
-	return 0;
-}
-
-static int hdmi_lpe_audio_resume(struct platform_device *pdev)
-{
-	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "%s: state %d",  __func__, ctx->state);
-	/* HDMI is not connected, there is no need to resume audio device */
-	if (ctx->state != hdmi_connector_status_disconnected)
-		hdmi_audio_resume(ctx->had);
-	return 0;
-}
-
-static struct platform_driver hdmi_lpe_audio_driver = {
-	.driver		= {
-		.name  = "hdmi-lpe-audio",
-	},
-	.probe          = hdmi_lpe_audio_probe,
-	.remove		= hdmi_lpe_audio_remove,
-	.suspend	= hdmi_lpe_audio_suspend,
-	.resume		= hdmi_lpe_audio_resume
-};
-
-module_platform_driver(hdmi_lpe_audio_driver);
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hdmi_lpe_audio");
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index a9d51b7c5bae..8f320b4aa3b7 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -27,12 +27,11 @@
 #include <sound/initval.h>
 #include <linux/version.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 #include <sound/asoundef.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
 
-struct platform_device;
-
 #define AUD_CONFIG_VALID_BIT			(1<<9)
 #define AUD_CONFIG_DP_MODE			(1<<15)
 #define AUD_CONFIG_BLOCK_BIT			(1<<7)
@@ -636,24 +635,4 @@ enum had_event_type {
 	HAD_EVENT_QUERY_IS_AUDIO_SUSPENDED,
 };
 
-/*
- * HDMI Display Controller Audio Interface
- *
- */
-struct hdmi_audio_event {
-	int type;
-};
-
-int mid_hdmi_audio_read(struct platform_device *pdev, u32 reg, u32 *val);
-int mid_hdmi_audio_write(struct platform_device *pdev, u32 reg, u32 val);
-int mid_hdmi_audio_rmw(struct platform_device *pdev,
-		       u32 reg, u32 val, u32 mask);
-
-int mid_hdmi_audio_get_caps(struct platform_device *pdev,
-			    enum had_caps_list get_element,
-			    void *capabilities);
-int mid_hdmi_audio_set_caps(struct platform_device *pdev,
-			    enum had_caps_list set_element,
-			    void *capabilties);
-
 #endif
-- 
2.11.0
