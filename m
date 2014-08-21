From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 03/11] ASoC: Intel: sst - add pcm ops handling
Date: Thu, 21 Aug 2014 18:20:42 +0530
Message-ID: <1408625450-32315-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B2213265344
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:12:54 +0200 (CEST)
In-Reply-To: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds low level IPC handling for pcm stream operations

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c | 475 ++++++++++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 sound/soc/intel/sst/sst_drv_interface.c

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
new file mode 100644
index 000000000000..e2cf1964409a
--- /dev/null
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -0,0 +1,475 @@
+/*
+ *  sst_drv_interface.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-14 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com)
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/math64.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+#include "../sst-dsp.h"
+
+
+
+#define NUM_CODEC 2
+#define MIN_FRAGMENT 2
+#define MAX_FRAGMENT 4
+#define MIN_FRAGMENT_SIZE (50 * 1024)
+#define MAX_FRAGMENT_SIZE (1024 * 1024)
+#define SST_GET_BYTES_PER_SAMPLE(pcm_wd_sz)  (((pcm_wd_sz + 15) >> 4) << 1)
+
+int free_stream_context(struct intel_sst_drv *sst_drv_ctx, unsigned int str_id)
+{
+	struct stream_info *stream;
+	int ret = 0;
+
+	stream = get_stream_info(sst_drv_ctx, str_id);
+	if (stream) {
+		/* str_id is valid, so stream is alloacted */
+		ret = sst_free_stream(sst_drv_ctx, str_id);
+		if (ret)
+			sst_clean_stream(&sst_drv_ctx->streams[str_id]);
+		return ret;
+	}
+	return ret;
+}
+
+/*
+ * sst_get_stream_allocated - this function gets a stream allocated with
+ * the given params
+ *
+ * @str_param : stream params
+ * @lib_dnld : pointer to pointer of lib downlaod struct
+ *
+ * This creates new stream id for a stream, in case lib is to be downloaded to
+ * DSP, it downloads that
+ */
+int sst_get_stream_allocated(struct intel_sst_drv *sst_drv_ctx,
+	struct snd_sst_params *str_param,
+	struct snd_sst_lib_download **lib_dnld)
+{
+	int retval, str_id;
+	struct sst_block *block;
+	struct snd_sst_alloc_response *response;
+	struct stream_info *str_info;
+
+	pr_debug("In %s\n", __func__);
+	block = sst_create_block(sst_drv_ctx, 0, 0);
+	if (block == NULL)
+		return -ENOMEM;
+
+	retval = sst_drv_ctx->ops->alloc_stream(sst_drv_ctx, str_param, block);
+	str_id = retval;
+	if (retval < 0) {
+		pr_err("sst_alloc_stream failed %d\n", retval);
+		goto free_block;
+	}
+	pr_debug("Stream allocated %d\n", retval);
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (str_info == NULL) {
+		pr_err("get stream info returned null\n");
+		str_id = -EINVAL;
+		goto free_block;
+	}
+
+	/* Block the call for reply */
+	retval = sst_wait_timeout(sst_drv_ctx, block);
+	if (retval != 0) {
+		pr_err("sst: FW alloc failed retval %d\n", retval);
+		/* alloc failed, so reset the state to uninit */
+		str_info->status = STREAM_UN_INIT;
+		str_id = retval;
+	} else if (block->data) {
+		response = (struct snd_sst_alloc_response *)block->data;
+		retval = response->str_type.result;
+		if (!retval)
+			goto free_block;
+
+		pr_err("sst: FW alloc failed retval %d\n", retval);
+		if (retval == SST_ERR_STREAM_IN_USE) {
+			pr_err("sst:FW not in clean state, send free for:%d\n",
+					str_id);
+			sst_free_stream(sst_drv_ctx, str_id);
+			*lib_dnld = NULL;
+		} else {
+			*lib_dnld = NULL;
+		}
+		str_id = -retval;
+	}
+free_block:
+	sst_free_block(sst_drv_ctx, block);
+	return str_id; /*will ret either error (in above if) or correct str id*/
+}
+
+/*
+ * sst_get_sfreq - this function returns the frequency of the stream
+ *
+ * @str_param : stream params
+ */
+int sst_get_sfreq(struct snd_sst_params *str_param)
+{
+	switch (str_param->codec) {
+	case SST_CODEC_TYPE_PCM:
+		return str_param->sparams.uc.pcm_params.sfreq;
+	case SST_CODEC_TYPE_AAC:
+		return str_param->sparams.uc.aac_params.externalsr;
+	case SST_CODEC_TYPE_MP3:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * sst_get_sfreq - this function returns the frequency of the stream
+ *
+ * @str_param : stream params
+ */
+int sst_get_num_channel(struct snd_sst_params *str_param)
+{
+	switch (str_param->codec) {
+	case SST_CODEC_TYPE_PCM:
+		return str_param->sparams.uc.pcm_params.num_chan;
+	case SST_CODEC_TYPE_MP3:
+		return str_param->sparams.uc.mp3_params.num_chan;
+	case SST_CODEC_TYPE_AAC:
+		return str_param->sparams.uc.aac_params.num_chan;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * sst_get_stream - this function prepares for stream allocation
+ *
+ * @str_param : stream param
+ */
+int sst_get_stream(struct intel_sst_drv *sst_drv_ctx,
+			struct snd_sst_params *str_param)
+{
+	int retval;
+	struct stream_info *str_info;
+	struct snd_sst_lib_download *lib_dnld;
+
+	pr_debug("In %s\n", __func__);
+	/* stream is not allocated, we are allocating */
+	retval = sst_get_stream_allocated(sst_drv_ctx, str_param, &lib_dnld);
+
+	if (retval <= 0) {
+		retval = -EIO;
+		goto err;
+	}
+	/* store sampling freq */
+	str_info = &sst_drv_ctx->streams[retval];
+	str_info->sfreq = sst_get_sfreq(str_param);
+
+err:
+	return retval;
+}
+
+/*
+ * sst_open_pcm_stream - Open PCM interface
+ *
+ * @str_param: parameters of pcm stream
+ *
+ * This function is called by MID sound card driver to open
+ * a new pcm interface
+ */
+static int sst_open_pcm_stream(struct device *dev,
+		struct snd_sst_params *str_param)
+{
+	int retval;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	if (!str_param)
+		return -EINVAL;
+
+	pr_debug("%s: doing rtpm_get\n", __func__);
+
+	retval = pm_runtime_get_sync(sst_drv_ctx->dev);
+	if (retval)
+		return retval;
+	retval = sst_get_stream(sst_drv_ctx, str_param);
+	if (retval > 0) {
+		sst_drv_ctx->stream_cnt++;
+	} else {
+		pr_err("sst_get_stream returned err %d\n", retval);
+		sst_pm_runtime_put(sst_drv_ctx);
+	}
+
+	return retval;
+}
+
+/*
+ * sst_close_pcm_stream - Close PCM interface
+ *
+ * @str_id: stream id to be closed
+ *
+ * This function is called by MID sound card driver to close
+ * an existing pcm interface
+ */
+static int sst_close_pcm_stream(struct device *dev, unsigned int str_id)
+{
+	struct stream_info *stream;
+	int retval = 0;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	pr_debug("%s: Entry\n", __func__);
+	stream = get_stream_info(sst_drv_ctx, str_id);
+	if (!stream) {
+		pr_err("stream info is NULL for str %d!!!\n", str_id);
+		return -EINVAL;
+	}
+
+	if (stream->status == STREAM_RESET) {
+		/* silently fail here as we have cleaned the stream */
+		pr_debug("stream in reset state...\n");
+
+		retval = 0;
+		goto put;
+	}
+
+	retval = free_stream_context(sst_drv_ctx, str_id);
+put:
+	stream->pcm_substream = NULL;
+	stream->status = STREAM_UN_INIT;
+	stream->period_elapsed = NULL;
+	sst_drv_ctx->stream_cnt--;
+
+	/*
+	 * The free_stream will return a error if there is no stream to free,
+	 * (i.e. the alloc failure case). And in this case the open does a put
+	 * in the error scenario, so skip in this case.
+	 *
+	 * In the close we need to handle put in the success scenario and
+	 * the timeout error(EBUSY) scenario.
+	 * */
+	if (!retval || (retval == -EBUSY))
+		sst_pm_runtime_put(sst_drv_ctx);
+	else
+		pr_err("%s: free stream returned err %d\n", __func__, retval);
+
+	pr_debug("%s: Exit\n", __func__);
+	return 0;
+}
+
+static inline int sst_calc_tstamp(struct pcm_stream_info *info,
+		struct snd_pcm_substream *substream,
+		struct snd_sst_tstamp *fw_tstamp)
+{
+	size_t delay_bytes, delay_frames;
+	size_t buffer_sz;
+	u32 pointer_bytes, pointer_samples;
+
+	pr_debug("mrfld ring_buffer_counter %llu in bytes\n",
+			fw_tstamp->ring_buffer_counter);
+	pr_debug("mrfld hardware_counter %llu in bytes\n",
+			 fw_tstamp->hardware_counter);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay_bytes = (size_t) (fw_tstamp->ring_buffer_counter -
+					fw_tstamp->hardware_counter);
+	else
+		delay_bytes = (size_t) (fw_tstamp->hardware_counter -
+					fw_tstamp->ring_buffer_counter);
+	delay_frames = bytes_to_frames(substream->runtime, delay_bytes);
+	buffer_sz = snd_pcm_lib_buffer_bytes(substream);
+	div_u64_rem(fw_tstamp->ring_buffer_counter, buffer_sz, &pointer_bytes);
+	pointer_samples = bytes_to_samples(substream->runtime, pointer_bytes);
+
+	pr_debug("pcm delay %zu in bytes\n", delay_bytes);
+
+	info->buffer_ptr = pointer_samples / substream->runtime->channels;
+
+	info->pcm_delay = delay_frames / substream->runtime->channels;
+	pr_debug("buffer ptr %llu pcm_delay rep: %llu\n",
+			info->buffer_ptr, info->pcm_delay);
+	return 0;
+}
+
+static int sst_read_timestamp(struct device *dev, struct pcm_stream_info *info)
+{
+	struct stream_info *stream;
+	struct snd_pcm_substream *substream;
+	struct snd_sst_tstamp fw_tstamp;
+	unsigned int str_id;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	str_id = info->str_id;
+	stream = get_stream_info(sst_drv_ctx, str_id);
+	if (!stream)
+		return -EINVAL;
+
+	if (!stream->pcm_substream)
+		return -EINVAL;
+	substream = stream->pcm_substream;
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(sst_drv_ctx->mailbox + sst_drv_ctx->tstamp)
+			+ (str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+	return sst_calc_tstamp(info, substream, &fw_tstamp);
+}
+
+static int sst_stream_start(struct device *dev, int str_id)
+{
+	struct stream_info *str_info;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+	str_info->prev = str_info->status;
+	str_info->status = STREAM_RUNNING;
+	sst_start_stream(sst_drv_ctx, str_id);
+
+	return 0;
+}
+
+static int sst_stream_drop(struct device *dev, int str_id)
+{
+	struct stream_info *str_info;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+	str_info->prev = STREAM_UN_INIT;
+	str_info->status = STREAM_INIT;
+	return sst_drop_stream(sst_drv_ctx, str_id);
+}
+
+static int sst_stream_init(struct device *dev, struct pcm_stream_info *str_info)
+{
+	int str_id = 0;
+	struct stream_info *stream;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	str_id = str_info->str_id;
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	stream = get_stream_info(sst_drv_ctx, str_id);
+	if (!stream)
+		return -EINVAL;
+
+	pr_debug("setting the period ptrs\n");
+	stream->pcm_substream = str_info->arg;
+	stream->period_elapsed = str_info->period_elapsed;
+	stream->sfreq = str_info->sfreq;
+	stream->prev = stream->status;
+	stream->status = STREAM_INIT;
+	pr_debug("pcm_substream %p, period_elapsed %p, sfreq %d, status %d\n",
+			stream->pcm_substream, stream->period_elapsed,
+				stream->sfreq, stream->status);
+
+	return 0;
+}
+
+int sst_stream_pause(int str_id)
+{
+	return -EPERM;
+}
+
+int sst_stream_pause_release(int str_id)
+{
+	return -EPERM;
+}
+
+/*
+ * sst_set_byte_stream - Set generic params
+ *
+ * @cmd: control cmd to be set
+ * @arg: command argument
+ *
+ * This function is called by MID sound card driver to configure
+ * SST runtime params.
+ */
+static int sst_send_byte_stream(struct device *dev,
+		struct snd_sst_bytes_v2 *bytes)
+{
+	int ret_val = 0;
+	struct intel_sst_drv *sst_drv_ctx = dev_get_drvdata(dev);
+
+	if (NULL == bytes)
+		return -EINVAL;
+	ret_val = pm_runtime_get_sync(sst_drv_ctx->dev);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = sst_send_byte_stream_mrfld(sst_drv_ctx, bytes);
+	sst_pm_runtime_put(sst_drv_ctx);
+
+	return ret_val;
+}
+
+static struct sst_ops pcm_ops = {
+	.open = sst_open_pcm_stream,
+	.stream_init = sst_stream_init,
+	.stream_start = sst_stream_start,
+	.stream_drop = sst_stream_drop,
+	.stream_read_tstamp = sst_read_timestamp,
+	.send_byte_stream = sst_send_byte_stream,
+	.close = sst_close_pcm_stream,
+};
+
+static struct sst_device sst_dsp_device = {
+	.name = "Intel(R) SST LPE",
+	.dev = NULL,
+	.ops = &pcm_ops,
+};
+
+/*
+ * sst_register - function to register DSP
+ *
+ * This functions registers DSP with the platform driver
+ */
+int sst_register(struct device *dev)
+{
+	int ret_val;
+
+	sst_dsp_device.dev = dev;
+	ret_val = sst_register_dsp(&sst_dsp_device);
+	if (ret_val)
+		pr_err("Unable to register DSP with platform driver\n");
+
+	return ret_val;
+}
+
+int sst_unregister(struct device *dev)
+{
+	return sst_unregister_dsp(&sst_dsp_device);
+}
-- 
1.9.0
