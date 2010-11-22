From: ramesh.babu@intel.com
Subject: [PATCH 3/5] [RFC]intel_hdmi_audio: driver module -
	ALSA intereaction
Date: Mon, 22 Nov 2010 19:09:44 +0530
Message-ID: <1290433186-31628-3-git-send-email-ramesh.babu@intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 21C3E1039C3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:34:19 +0100 (CET)
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

This patch creates intel_mid_hdmi_audio.c file.  It intereacts
with ALSA framework to enable the audio playback through HDMI
interface.  This code uses standard ALSA APIs.

Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
---
 .../drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c  |  546 ++++++++++++++++++++
 1 files changed, 546 insertions(+), 0 deletions(-)
 create mode 100644 sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c

diff --git a/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c
new file mode 100644
index 0000000..3ef4d48
--- /dev/null
+++ b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio.c
@@ -0,0 +1,546 @@
+/*
+ *   intel_mid_hdmi_audio.c - Intel HDMI audio driver for MID
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
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include "intel_mid_hdmi_audio.h"
+
+MODULE_AUTHOR("Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>");
+MODULE_AUTHOR("Ramesh Babu K V <ramesh.babu@intel.com>");
+MODULE_DESCRIPTION("Intel HDMI Audio driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{Intel,Intel_HAD}");
+
+#define INFO_FRAME_WORD1	0x000a0184
+#define FIFO_THRESHOLD		0xFE
+#define BYTES_PER_WORD		0x4
+#define CH_STATUS_MAP_32KHZ	0x3
+#define CH_STATUS_MAP_44KHZ	0x0
+#define CH_STATUS_MAP_48KHZ	0x2
+#define MAX_SMPL_WIDTH_20	0x0
+#define MAX_SMPL_WIDTH_24	0x1
+#define SMPL_WIDTH_16BITS	0x1
+#define SMPL_WIDTH_24BITS	0x5
+#define CHANNEL_ALLOCATION	0x1F
+#define SET_BYTE0		0x000000FF
+#define VALID_DIP_WORDS		3
+#define LAYOUT0			0
+#define LAYOUT1			1
+
+/*standard module options for ALSA. This module supports only one card*/
+int hdmi_card_index = SNDRV_DEFAULT_IDX1;
+char *hdmi_card_id = SNDRV_DEFAULT_STR1;
+
+module_param(hdmi_card_index, int, 0444);
+MODULE_PARM_DESC(hdmi_card_index,
+		"Index value for INTEL Intel HDMI Audio controller.");
+module_param(hdmi_card_id, charp, 0444);
+MODULE_PARM_DESC(hdmi_card_id,
+		"ID string for INTEL Intel HDMI Audio controller.");
+
+/* hardware capability structure */
+static const struct snd_pcm_hardware snd_intel_hadstream = {
+	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_DOUBLE |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME |
+		SNDRV_PCM_INFO_MMAP|
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_SYNC_START),
+	.formats = (SNDRV_PCM_FMTBIT_S24 |
+		SNDRV_PCM_FMTBIT_U24),
+	.rates = SNDRV_PCM_RATE_32000 |
+		SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000 |
+		SNDRV_PCM_RATE_64000 |
+		SNDRV_PCM_RATE_88200 |
+		SNDRV_PCM_RATE_96000 |
+		SNDRV_PCM_RATE_176400 |
+		SNDRV_PCM_RATE_192000,
+	.rate_min = HAD_MIN_RATE,
+	.rate_max = HAD_MAX_RATE,
+	.channels_min = HAD_MIN_CHANNEL,
+	.channels_max = HAD_MAX_CHANNEL,
+	.buffer_bytes_max = HAD_MAX_PERIOD_BYTES,
+	.period_bytes_min = HAD_MIN_PERIOD_BYTES,
+	.period_bytes_max = HAD_MAX_BUFFER,
+	.periods_min = HAD_MIN_PERIODS,
+	.periods_max = HAD_MAX_PERIODS,
+	.fifo_size = HAD_FIFO_SIZE,
+};
+
+struct snd_intelhad *intelhaddata;
+
+/**
+* snd_intelhad_open - stream initializations are done here
+* @substream:substream for which the stream function is called
+*
+* This function is called whenever a PCM stream is opened
+*/
+static int snd_intelhad_open(struct snd_pcm_substream *substream)
+{
+	struct snd_intelhad *intelhaddata;
+	struct snd_pcm_runtime *runtime;
+	struct had_stream_pvt *stream;
+	int retval;
+
+	BUG_ON(!substream);
+
+	pr_debug("had: snd_intelhad_open called\n");
+
+	intelhaddata = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+	/* set the runtime hw parameter with local snd_pcm_hardware struct */
+	runtime->hw = snd_intel_hadstream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+	stream->stream_status = STREAM_INIT;
+	runtime->private_data = stream;
+	intelhaddata->reg_ops->hdmi_audio_write_register(AUD_HDMI_STATUS, 0);
+	retval = snd_pcm_hw_constraint_integer(runtime,
+			 SNDRV_PCM_HW_PARAM_PERIODS);
+	return retval;
+}
+
+/**
+* had_period_elapsed - updates the hardware pointer status
+* @had_substream:substream for which the stream function is called
+*
+*/
+static void had_period_elapsed(void *had_substream)
+{
+	struct snd_pcm_substream *substream = had_substream;
+	struct had_stream_pvt *stream;
+
+	pr_debug("had: calling period elapsed\n");
+	if (!substream || !substream->runtime)
+		return;
+	stream = substream->runtime->private_data;
+	if (!stream)
+		return;
+
+	if (stream->stream_status != STREAM_RUNNING)
+		return;
+	snd_pcm_period_elapsed(substream);
+	return;
+}
+
+/**
+* snd_intelhad_init_stream - internal function to initialize stream info
+* @substream:substream for which the stream function is called
+*
+*/
+static int snd_intelhad_init_stream(struct snd_pcm_substream *substream)
+{
+	struct snd_intelhad *intelhaddata = snd_pcm_substream_chip(substream);
+
+	pr_debug("had: setting buffer ptr param\n");
+	intelhaddata->stream_info.period_elapsed = had_period_elapsed;
+	intelhaddata->stream_info.had_substream = substream;
+	intelhaddata->stream_info.buffer_ptr = 0;
+	intelhaddata->stream_info.buffer_rendered = 0;
+	intelhaddata->stream_info.sfreq = substream->runtime->rate;
+	return 0;
+}
+
+/**
+ * snd_intelhad_close- to free parameteres when stream is stopped
+ *
+ * @substream:  substream for which the function is called
+ *
+ * This function is called by ALSA framework when stream is stopped
+ */
+static int snd_intelhad_close(struct snd_pcm_substream *substream)
+{
+	struct snd_intelhad *intelhaddata;
+	struct had_stream_pvt *stream;
+	BUG_ON(!substream);
+
+	stream = substream->runtime->private_data;
+
+	pr_debug("had: snd_intelhad_close called\n");
+	intelhaddata = snd_pcm_substream_chip(substream);
+	if (intelhaddata->stream_info.str_id) {
+		intelhaddata->playback_cnt--;
+		intelhaddata->stream_info.str_id = 0;
+	}
+	intelhaddata->stream_info.buffer_rendered = 0;
+	intelhaddata->stream_info.buffer_ptr = 0;
+
+	kfree(substream->runtime->private_data);
+	return 0;
+}
+
+/**
+ * snd_intelhad_hw_params- to setup the hardware parameters
+ * like allocating the buffers
+ *
+ * @substream:  substream for which the function is called
+ * @hw_params: hardware parameters
+ *
+ * This function is called by ALSA framework when hardware params are set
+ */
+static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	int retval;
+	struct snd_pcm_runtime *runtime;
+
+	BUG_ON(!substream);
+	BUG_ON(!hw_params);
+	pr_debug("had: snd_intelhad_hw_params called\n");
+
+	runtime = substream->runtime;
+
+	retval = snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+	if (retval < 0)
+		return -ENOMEM;
+	pr_debug("had: allocated memory = %d\n",
+					params_buffer_bytes(hw_params));
+	memset(substream->runtime->dma_area, 0,
+			params_buffer_bytes(hw_params));
+
+	pr_debug("had: snd_intelhad_hw_params exited\n");
+	return retval;
+}
+
+/**
+ * snd_intelhad_hw_free- to release the resources allocated during
+ * hardware params setup
+ *
+ * @substream:  substream for which the function is called
+ *
+ * This function is called by ALSA framework before close callback.
+ *
+ */
+static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
+{
+	BUG_ON(!substream);
+	pr_debug("had: snd_intelhad_hw_free called\n");
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/**
+* snd_intelhad_pcm_trigger - stream activities are handled here
+* @substream:substream for which the stream function is called
+* @cmd:the stream commamd thats requested from upper layer
+* This function is called whenever an a stream activity is invoked
+*/
+static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int i, caps, retval = 0;
+	u32 regval = 0;
+	struct snd_intelhad *intelhaddata;
+	struct had_stream_pvt *stream;
+	struct hdmi_audio_registers_ops *reg_ops;
+	struct hdmi_audio_query_set_ops *query_ops;
+
+	BUG_ON(!substream);
+
+	intelhaddata = snd_pcm_substream_chip(substream);
+	stream = substream->runtime->private_data;
+	reg_ops = intelhaddata->reg_ops;
+	query_ops = intelhaddata->query_ops;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pr_debug("had: Trigger Start\n");
+		caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
+		retval = query_ops->hdmi_audio_set_caps(
+					HAD_SET_ENABLE_AUDIO_INT, &caps);
+		if (retval)
+			return retval;
+		retval = query_ops->hdmi_audio_set_caps(
+					HAD_SET_ENABLE_AUDIO, NULL);
+		if (retval)
+			return retval;
+
+		retval = reg_ops->hdmi_audio_read_modify(AUD_CONFIG,
+					SET_BIT0, REG_BIT_0);
+		stream->substream = substream;
+		stream->stream_status = STREAM_RUNNING;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		pr_debug("had: Trigger Stop\n");
+		caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
+		retval = query_ops->hdmi_audio_set_caps(
+					HAD_SET_DISABLE_AUDIO_INT, &caps);
+		if (retval)
+			return retval;
+		retval = query_ops->hdmi_audio_set_caps(
+					HAD_SET_DISABLE_AUDIO, NULL);
+		if (retval)
+			return retval;
+		stream->stream_status = STREAM_DROPPED;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		pr_debug("had: Trigger Pause\n");
+		/* disable the validity bits */
+		for (i = 0; i < MAX_HW_BUFS; i++) {
+			retval = reg_ops->hdmi_audio_read_register(
+					AUD_BUF_A_ADDR+(i*REG_WIDTH), &regval);
+			if (retval)
+				return retval;
+			if (regval & REG_BIT_0) {
+				retval = reg_ops->hdmi_audio_read_modify(
+						AUD_BUF_A_ADDR+(i * REG_WIDTH),
+						0, REG_BIT_0);
+				if (retval)
+					return retval;
+				intelhaddata->buf_info[HAD_BUF_TYPE_A + i].
+						is_valid = true;
+			}
+		}
+		stream->stream_status = STREAM_PAUSED;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		pr_debug("had: Trigger Resume\n");
+		/* enable the validity bits */
+		for (i = 0; i < MAX_HW_BUFS; i++) {
+			if (intelhaddata->buf_info[HAD_BUF_TYPE_A + i].is_valid)
+				retval = reg_ops->hdmi_audio_read_modify(
+					AUD_BUF_A_ADDR + (i * REG_WIDTH),
+					SET_BIT0, REG_BIT_0);
+		}
+		stream->stream_status = STREAM_RUNNING;
+		break;
+
+	default:
+		retval = -EINVAL;
+	}
+	return retval;
+}
+
+/**
+* snd_intelhad_pcm_prepare- internal preparation before starting a stream
+*
+* @substream:  substream for which the function is called
+*
+* This function is called when a stream is started for internal preparation.
+*/
+static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct had_stream_pvt *stream;
+	int retval;
+	u32 disp_samp_freq, n_param;
+	struct snd_intelhad *intelhaddata;
+	struct snd_pcm_runtime *runtime;
+
+	pr_debug("had: pcm_prepare called\n");
+
+	BUG_ON(!substream);
+	runtime = substream->runtime;
+	pr_debug("had:period_size=%d\n",
+				frames_to_bytes(runtime, runtime->period_size));
+	pr_debug("had:periods=%d\n", runtime->periods);
+	pr_debug("had:buffer_size=%d\n", snd_pcm_lib_buffer_bytes(substream));
+	pr_debug("had:rate=%d\n", runtime->rate);
+	pr_debug("had:channels=%d\n", runtime->channels);
+
+	stream = substream->runtime->private_data;
+	intelhaddata = snd_pcm_substream_chip(substream);
+	if (intelhaddata->stream_info.str_id) {
+		pr_debug("had:_prepare is called for existing str_id#%d\n",
+					intelhaddata->stream_info.str_id);
+		retval = snd_intelhad_pcm_trigger(substream,
+						SNDRV_PCM_TRIGGER_STOP);
+		return retval;
+	}
+
+	intelhaddata->playback_cnt++;
+	intelhaddata->stream_info.str_id = intelhaddata->playback_cnt;
+	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
+			"%d", intelhaddata->stream_info.str_id);
+	retval = snd_intelhad_init_stream(substream);
+	if (retval)
+		goto prep_end;
+	/* Get N value in KHz */
+	retval = intelhaddata->query_ops->hdmi_audio_get_caps(
+				HAD_GET_SAMPLING_FREQ, &disp_samp_freq);
+	if (retval) {
+		pr_debug("had: querying display sampling freq failed\n");
+		goto prep_end;
+	} else
+		pr_debug("had: TMDS freq = %d kHz\n", disp_samp_freq);
+
+	retval = snd_intelhad_prog_n(substream->runtime->rate, &n_param);
+	if (retval) {
+		pr_debug("had: programming N value failed\n");
+		goto prep_end;
+	}
+	retval = snd_intelhad_prog_cts(
+			substream->runtime->rate/1000, disp_samp_freq, n_param);
+	if (retval) {
+		pr_debug("had: programming CTS value failed\n");
+		goto prep_end;
+	}
+
+	retval = snd_intelhad_prog_DIP(substream);
+	if (retval) {
+		pr_debug("had: programming DIP values failed\n");
+		goto prep_end;
+	}
+	retval = snd_intelhad_init_audio_ctrl(substream);
+	if (retval) {
+		pr_debug("had: initializing audio controller regs failed\n");
+		goto prep_end;
+	}
+	retval = snd_intelhad_prog_ring_buf(substream) ;
+	if (retval)
+		pr_debug("had: initializing ring buffer regs failed\n");
+
+prep_end:
+	return retval;
+}
+
+/**
+ * snd_intelhad_pcm_pointer- to send the current buffer pointer processed by hw
+ *
+ * @substream:  substream for which the function is called
+ *
+ * This function is called by ALSA framework to get the current hw buffer ptr
+ * when a period is elapsed
+ */
+static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
+					struct snd_pcm_substream *substream)
+{
+	struct had_stream_pvt *stream;
+	struct snd_intelhad *intelhaddata;
+	u32 bytes_rendered;
+
+	pr_debug("had: Called snd_intelhad_pcm_pointer\n");
+	BUG_ON(!substream);
+
+	intelhaddata = snd_pcm_substream_chip(substream);
+	stream = substream->runtime->private_data;
+
+	div_u64_rem(intelhaddata->stream_info.buffer_rendered,
+			intelhaddata->stream_info.ring_buf_size,
+			&(bytes_rendered));
+	intelhaddata->stream_info.buffer_ptr = bytes_to_frames(
+						substream->runtime,
+						bytes_rendered);
+	pr_debug("had:pcm_pointer = %#x\n",
+			intelhaddata->stream_info.buffer_ptr);
+	return intelhaddata->stream_info.buffer_ptr;
+}
+
+/*PCM operations structure and the calls back for the same */
+struct snd_pcm_ops snd_intelhad_playback_ops = {
+	.open =	snd_intelhad_open,
+	.close = snd_intelhad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelhad_hw_params,
+	.hw_free = snd_intelhad_hw_free,
+	.prepare = snd_intelhad_pcm_prepare,
+	.trigger = snd_intelhad_pcm_trigger,
+	.pointer = snd_intelhad_pcm_pointer,
+};
+
+/*
+* alsa_card_intelhad_init- driver init function
+* This function is called when driver module is inserted
+*/
+static int __init alsa_card_intelhad_init(void)
+{
+	int retval;
+	struct had_callback_ops ops_cb;
+
+	pr_debug("had: init called\n");
+	pr_info(KERN_INFO "INFO: ******** HAD DRIVER loading.. Ver: %s\n",
+					HAD_DRIVER_VERSION);
+
+	/* allocate memory for saving internal context and working */
+	intelhaddata = kzalloc(sizeof(*intelhaddata), GFP_KERNEL);
+	if (!intelhaddata) {
+		pr_debug("had: mem alloc failed\n");
+		return -ENOMEM;
+	}
+	/* allocate memory for display driver api set */
+	intelhaddata->reg_ops = kzalloc(
+				sizeof(struct hdmi_audio_registers_ops),
+				GFP_KERNEL);
+	if (!intelhaddata->reg_ops) {
+		pr_debug("had: mem alloc failed\n");
+		retval = -ENOMEM;
+		goto free_context;
+	}
+	intelhaddata->query_ops = kzalloc(
+				sizeof(struct hdmi_audio_query_set_ops),
+				GFP_KERNEL);
+	if (!intelhaddata->query_ops) {
+		pr_debug("had: mem alloc failed\n");
+		retval = -ENOMEM;
+		goto free_regops;
+	}
+	ops_cb.intel_had_event_call_back = had_event_handler;
+	/* registering with display driver to get access to display APIs */
+	retval = intel_hdmi_audio_query_capabilities(
+			ops_cb.intel_had_event_call_back,
+			&intelhaddata->reg_ops,
+			&intelhaddata->query_ops);
+	if (retval) {
+		pr_debug("had: registering with display driver failed\n");
+		goto free_allocs;
+	}
+	pr_debug("had:...init complete\n");
+	return retval;
+free_allocs:
+	kfree(intelhaddata->query_ops);
+free_regops:
+	kfree(intelhaddata->reg_ops);
+free_context:
+	kfree(intelhaddata);
+	pr_err("had: driver init failed\n");
+	return retval;
+}
+
+/**
+* alsa_card_intelhad_exit- driver exit function
+* This function is called when driver module is removed
+*/
+static void __exit alsa_card_intelhad_exit(void)
+{
+	pr_debug("had:had_exit called\n");
+	if (intelhaddata) {
+		kfree(intelhaddata->query_ops);
+		kfree(intelhaddata->reg_ops);
+		kfree(intelhaddata);
+	}
+}
+late_initcall(alsa_card_intelhad_init);
+module_exit(alsa_card_intelhad_exit);
-- 
1.6.2.5
