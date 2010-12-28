From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [RFC 2/4] ASoC SST: Add mid platfrom driver
Date: Tue, 28 Dec 2010 17:40:58 +0530
Message-ID: <1293538258-31885-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BD5810388B
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:09:20 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the platform driver for mid asoc drivers
This platfrom driver sends commands to sst dsp engine driver for the dai operations

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mid_platform.c     |  326 ++++++++++++++++++++++++++++++++++
 sound/soc/mid-x86/mid_platform.h     |   77 ++++++++
 sound/soc/mid-x86/mid_platform_pvt.c |  121 +++++++++++++
 3 files changed, 524 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/mid_platform.c
 create mode 100644 sound/soc/mid-x86/mid_platform.h
 create mode 100644 sound/soc/mid-x86/mid_platform_pvt.c

diff --git a/sound/soc/mid-x86/mid_platform.c b/sound/soc/mid-x86/mid_platform.c
new file mode 100644
index 0000000..8c854df
--- /dev/null
+++ b/sound/soc/mid-x86/mid_platform.c
@@ -0,0 +1,326 @@
+/*
+ *  mid_platform.c - Intel MID common Platform driver
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Harsha Priya <priya.harsha@intel.com>
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
+ *
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/intel_sst.h>
+#include <linux/slab.h>
+#include "mid_platform.h"
+
+static struct snd_pcm_hardware snd_intelmad_pcm_hw = {
+	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_DOUBLE |
+			SNDRV_PCM_INFO_PAUSE |
+			SNDRV_PCM_INFO_RESUME |
+			SNDRV_PCM_INFO_MMAP|
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_SYNC_START),
+	.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+			SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
+	.rates = (SNDRV_PCM_RATE_8000|
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000),
+	.rate_min = MIN_RATE,
+	.rate_max = MAX_RATE,
+	.channels_min =	MIN_CHANNEL,
+	.channels_max =	MAX_CHANNEL_AMIC,
+	.buffer_bytes_max = MAX_BUFFER,
+	.period_bytes_min = MIN_PERIOD_BYTES,
+	.period_bytes_max = MAX_PERIOD_BYTES,
+	.periods_min = MIN_PERIODS,
+	.periods_max = MAX_PERIODS,
+	.fifo_size = FIFO_SIZE,
+};
+
+static int mid_platform_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct mid_runtime_stream *stream;
+	int ret_val = 0;
+
+	WARN_ON(!substream);
+
+	pr_debug("mid_platform_open called\n");
+
+	runtime = substream->runtime;
+	runtime->hw = snd_intelmad_pcm_hw;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+	stream->stream_info.str_id = 0;
+	stream->stream_status = INIT;
+	stream->stream_info.mad_substream = substream;
+	/* allocate memory for LPE API set */
+	stream->sstdrv_ops = kzalloc(sizeof(*stream->sstdrv_ops),
+							GFP_KERNEL);
+	if (!stream->sstdrv_ops) {
+		pr_err("sst: mem allocation for ops fail\n");
+		kfree(stream);
+		return -ENOMEM;
+	}
+	stream->sstdrv_ops->vendor_id = MSIC_VENDOR_ID;
+
+	/* registering with SST driver to get access to SST APIs to use */
+	ret_val = register_sst_card(stream->sstdrv_ops);
+	if (ret_val) {
+		pr_err("sst: sst card registration failed\n");
+		return ret_val;
+	}
+	runtime->private_data = stream;
+	return snd_pcm_hw_constraint_integer(runtime,
+			 SNDRV_PCM_HW_PARAM_PERIODS);
+}
+
+static int mid_platform_close(struct snd_pcm_substream *substream)
+{
+	struct mid_runtime_stream *stream;
+	int ret_val = 0, str_id;
+
+	pr_debug("mid_platform_close called\n");
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+	str_id = stream->stream_info.str_id;
+
+	if (str_id)
+		ret_val = stream->sstdrv_ops->pcm_control->close(str_id);
+	kfree(stream->sstdrv_ops);
+	kfree(stream);
+	return ret_val;
+}
+
+static int mid_platform_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct mid_runtime_stream *stream;
+	int ret_val = 0, str_id;
+	struct mid_sst_pcm_control *sst_ops;
+
+	pr_debug("mid_platform_pcm_prepare called\n");
+
+	WARN_ON(!substream);
+	stream = substream->runtime->private_data;
+	sst_ops  = stream->sstdrv_ops->pcm_control;
+	str_id = stream->stream_info.str_id;
+	if (stream->stream_info.str_id) {
+		ret_val = sst_ops->device_control(SST_SND_DROP, &str_id);
+		return ret_val;
+	}
+
+	ret_val = snd_intelmad_alloc_stream(substream);
+	if (ret_val < 0)
+		return ret_val;
+	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
+			"%d", stream->stream_info.str_id);
+
+	ret_val = snd_intelmad_init_stream(substream);
+	if (ret_val)
+		return ret_val;
+	substream->runtime->hw.info = SNDRV_PCM_INFO_BLOCK_TRANSFER;
+	return ret_val;
+}
+
+static int mid_platform_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int ret_val = 0, str_id;
+	struct mid_runtime_stream *stream;
+	struct mid_sst_pcm_control *sst_ops;
+
+	pr_debug("mid_platform_pcm_trigger called\n");
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+
+	sst_ops  = stream->sstdrv_ops->pcm_control;
+	str_id = stream->stream_info.str_id;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pr_debug("sst: Trigger Start\n");
+		ret_val = sst_ops->device_control(SST_SND_START, &str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = RUNNING;
+		stream->stream_info.mad_substream = substream;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pr_debug("sst: in stop\n");
+		ret_val = sst_ops->device_control(SST_SND_DROP, &str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = DROPPED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		pr_debug("sst: in pause\n");
+		ret_val = sst_ops->device_control(SST_SND_PAUSE, &str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = PAUSED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		pr_debug("sst: in pause release\n");
+		ret_val = sst_ops->device_control(SST_SND_RESUME, &str_id);
+		if (ret_val)
+			return ret_val;
+		stream->stream_status = RUNNING;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return ret_val;
+}
+
+
+static snd_pcm_uframes_t mid_platform_pcm_pointer
+			(struct snd_pcm_substream *substream)
+{
+	/* struct snd_pcm_runtime *runtime = substream->runtime; */
+	struct mid_runtime_stream *stream;
+	int ret_val;
+	struct mid_sst_pcm_control *sst_ops;
+	struct mid_pcm_stream_info *str_info;
+
+	pr_debug("mid_platform_pcm_pointer called\n");
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+	if (stream->stream_status == INIT)
+		return 0;
+	sst_ops  = stream->sstdrv_ops->pcm_control;
+	str_info = &stream->stream_info;
+	ret_val = sst_ops->device_control(SST_SND_BUFFER_POINTER, str_info);
+	if (ret_val) {
+		pr_err("sst: error code = 0x%x\n", ret_val);
+		return ret_val;
+	}
+
+	return stream->stream_info.buffer_ptr;
+}
+
+
+static struct snd_pcm_ops intel_mid_platform_ops = {
+	.open = mid_platform_open,
+	.close = mid_platform_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.prepare = mid_platform_pcm_prepare,
+	.trigger = mid_platform_pcm_trigger,
+	.pointer = mid_platform_pcm_pointer,
+};
+
+static void intel_mid_pcm_free(struct snd_pcm *pcm)
+{
+	pr_debug("intel_mid_pcm_free called\n");
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+int intel_mid_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+			struct snd_pcm *pcm)
+{
+	int retval = 0;
+
+	pr_debug("intel_mid_pcm_new called\n");
+
+	if (dai->driver->playback.channels_min ||
+			dai->driver->capture.channels_min) {
+		retval =  snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL),
+			MIN_BUFFER, MAX_BUFFER);
+		if (retval) {
+			pr_err("dma buffer allocationf fail\n");
+			return retval;
+		}
+	}
+
+	return retval;
+}
+struct snd_soc_platform_driver intelmid_soc_platform_drv = {
+	.ops		= &intel_mid_platform_ops,
+	.pcm_new	= intel_mid_pcm_new,
+	.pcm_free	= intel_mid_pcm_free,
+};
+
+static int intelmid_platform_probe(struct platform_device *pdev)
+{
+	struct mid_dev_data *dev_data = platform_get_drvdata(pdev);
+	int ret;
+	pr_debug("intelmid_platform_probe called\n");
+	ret = snd_soc_register_platform(&pdev->dev, &intelmid_soc_platform_drv);
+	if (ret) {
+		pr_err("registering soc platform failed\n");
+		return ret;
+	}
+	return snd_soc_register_dais(&pdev->dev,
+				dev_data->dai, dev_data->num_dais);
+}
+
+static int intelmid_platform_remove(struct platform_device *pdev)
+{
+	struct mid_dev_data *dev_data = platform_get_drvdata(pdev);
+
+	if (dev_data)
+		snd_soc_unregister_dais(&pdev->dev, dev_data->num_dais);
+
+	snd_soc_unregister_platform(&pdev->dev);
+	pr_debug("intelmid_platform_remove sucess\n");
+
+	return 0;
+}
+
+static struct platform_driver intelmid_platform_driver = {
+	.driver		= {
+		.name		= "mid-audio-platform",
+		.owner		= THIS_MODULE,
+	},
+	.probe		= intelmid_platform_probe,
+	.remove		= intelmid_platform_remove,
+	/*.suspend	= intelmid_platform_suspend,
+	.resume		= intelmid_platform_resume,*/
+};
+
+static int __init intel_mid_soc_platform_init(void)
+{
+	pr_debug("intel_mid_soc_platform_init called\n");
+	return  platform_driver_register(&intelmid_platform_driver);
+}
+module_init(intel_mid_soc_platform_init);
+
+static void __exit intel_mid_soc_platform_exit(void)
+{
+	platform_driver_unregister(&intelmid_platform_driver);
+	pr_debug("intel_mid_soc_platform_exit sucess\n");
+}
+module_exit(intel_mid_soc_platform_exit);
+
+MODULE_DESCRIPTION("ASoC Intel(R) PLATFORM driver");
+MODULE_AUTHOR("Harsha Priya");
+MODULE_LICENSE("GPL v2");
+
diff --git a/sound/soc/mid-x86/mid_platform.h b/sound/soc/mid-x86/mid_platform.h
new file mode 100644
index 0000000..6d719c0
--- /dev/null
+++ b/sound/soc/mid-x86/mid_platform.h
@@ -0,0 +1,77 @@
+/*
+ *  mid_platform.h - Intel MID Platform driver header file
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Harsha Priya <priya.harsha@intel.com>
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
+ *
+ *
+ */
+
+#ifndef __MID_PLATFORMDRV_H__
+#define __MID_PLATFORMDRV_H__
+
+#define MIN_RATE		8000
+#define MAX_RATE		48000
+#define MIN_CHANNEL		1
+#define MAX_CHANNEL_AMIC	2
+#define MAX_CHANNEL_DMIC	5
+#define MAX_BUFFER		(800*1024)
+#define MIN_BUFFER		(800*1024)
+#define MIN_PERIOD_BYTES	32
+#define MAX_PERIOD_BYTES	MAX_BUFFER
+#define MIN_PERIODS		2
+#define MAX_PERIODS		(1024*2)
+#define FIFO_SIZE		0
+#define MSIC_VENDOR_ID          0x3
+#define SST_CARD_NAMES "intel_mid_card"
+
+int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream);
+int snd_intelmad_init_stream(struct snd_pcm_substream *substream);
+
+struct mid_runtime_stream {
+	int     stream_status;
+	struct mid_pcm_stream_info stream_info;
+	struct intel_sst_card_ops *sstdrv_ops;
+	unsigned long long buffer_ptr;
+};
+
+struct mid_dev_data {
+	struct snd_soc_dai_driver *dai;
+	int	num_dais;
+};
+
+enum mid_drv_status {
+	INIT = 1,
+	STARTED,
+	RUNNING,
+	PAUSED,
+	DROPPED,
+};
+
+/* device */
+enum SND_INPUT_DEVICE {
+	AMIC,
+	DMIC,
+	HS_MIC,
+	IN_UNDEFINED
+};
+
+
+#endif
+
diff --git a/sound/soc/mid-x86/mid_platform_pvt.c b/sound/soc/mid-x86/mid_platform_pvt.c
new file mode 100644
index 0000000..124191f
--- /dev/null
+++ b/sound/soc/mid-x86/mid_platform_pvt.c
@@ -0,0 +1,121 @@
+/*
+ *  mid_platform_pvt.c - Intel MID Platform driver private functions
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Harsha Priya <priya.harsha@intel.com>
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
+ *
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <sound/pcm.h>
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "mid_platform.h"
+
+int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream)
+{
+	struct mid_runtime_stream *stream =
+			substream->runtime->private_data;
+	struct snd_sst_stream_params param = {{{0,},},};
+	struct snd_sst_params str_params = {0};
+	int ret_val;
+
+	/* set codec params and inform SST driver the same */
+
+	param.uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
+	param.uc.pcm_params.num_chan = (u8) substream->runtime->channels;
+	param.uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param.uc.pcm_params.reserved = 0;
+	param.uc.pcm_params.sfreq = substream->runtime->rate;
+	param.uc.pcm_params.ring_buffer_size =
+					snd_pcm_lib_buffer_bytes(substream);
+	param.uc.pcm_params.period_count = substream->runtime->period_size;
+	param.uc.pcm_params.ring_buffer_addr =
+				virt_to_phys(substream->dma_buffer.area);
+	substream->runtime->dma_area = substream->dma_buffer.area;
+
+	pr_debug("period_cnt = %d\n", param.uc.pcm_params.period_count);
+	pr_debug("sfreq= %d, wd_sz = %d\n",
+		 param.uc.pcm_params.sfreq, param.uc.pcm_params.pcm_wd_sz);
+
+	str_params.sparams = param;
+	str_params.codec = SST_CODEC_TYPE_PCM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		str_params.ops = STREAM_OPS_PLAYBACK;
+		str_params.device_type = substream->pcm->device + 1;
+		pr_debug("Playbck stream,Device %d\n",
+					substream->pcm->device);
+	} else {
+		str_params.ops = STREAM_OPS_CAPTURE;
+		str_params.device_type = SND_SST_DEVICE_CAPTURE;
+		pr_debug("Capture stream,Device %d\n",
+					substream->pcm->device);
+	}
+	ret_val = stream->sstdrv_ops->pcm_control->open(&str_params);
+	pr_debug("SST_SND_PLAY/CAPTURE ret_val = %x\n", ret_val);
+	if (ret_val < 0)
+		return ret_val;
+
+	stream->stream_info.str_id = ret_val;
+	pr_debug("str id :  %d\n", stream->stream_info.str_id);
+
+	return ret_val;
+}
+
+
+void period_elapsed(void *mad_substream)
+{
+	struct snd_pcm_substream *substream = mad_substream;
+	struct mid_runtime_stream *stream;
+
+	if (!substream || !substream->runtime)
+		return;
+	stream = substream->runtime->private_data;
+	if (!stream)
+		return;
+
+	if (stream->stream_status != RUNNING)
+		return;
+	pr_debug("calling period elapsed\n");
+	snd_pcm_period_elapsed(substream);
+	return;
+}
+
+int snd_intelmad_init_stream(struct snd_pcm_substream *substream)
+{
+	struct mid_runtime_stream *stream =
+			substream->runtime->private_data;
+	int ret_val;
+
+	pr_debug("setting buffer ptr param\n");
+	stream->stream_status = INIT;
+	stream->stream_info.period_elapsed = period_elapsed;
+	stream->stream_info.mad_substream = substream;
+	stream->stream_info.buffer_ptr = 0;
+	stream->stream_info.sfreq = substream->runtime->rate;
+	ret_val = stream->sstdrv_ops->pcm_control->device_control(
+			SST_SND_STREAM_INIT, &stream->stream_info);
+	if (ret_val)
+		pr_err("control_set ret error %d\n", ret_val);
+	return ret_val;
+
+}
-- 
1.7.2.3
