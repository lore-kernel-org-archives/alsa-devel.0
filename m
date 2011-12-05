From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v2] asoc: sst_platform: fix the dsp driver
	interface
Date: Mon,  5 Dec 2011 19:13:41 +0530
Message-ID: <1323092621-27903-1-git-send-email-vinod.koul@linux.intel.com>
References: <1323084324-9420-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9273B103AD2
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:45:35 +0100 (CET)
In-Reply-To: <1323084324-9420-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

lower level drivers typically register with upper layers.
So fix by exporting symbols from sst_platform driver for dsp driver to
register to sst platform driver

Now this driver doesnt depend on sst driver, so remove the dependency
and the header files

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/mid-x86/Kconfig        |    1 -
 sound/soc/mid-x86/sst_platform.c |  130 ++++++++++++++++++++++++--------------
 sound/soc/mid-x86/sst_platform.h |   82 ++++++++++++++++++++++--
 3 files changed, 158 insertions(+), 55 deletions(-)

diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
index 2935042..61c10bf 100644
--- a/sound/soc/mid-x86/Kconfig
+++ b/sound/soc/mid-x86/Kconfig
@@ -1,7 +1,6 @@
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
-	depends on SND_INTEL_SST
 	select SND_SOC_SN95031
 	select SND_SST_PLATFORM
 	help
diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 94f70b3..24f9471 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -32,10 +32,51 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include "../../../drivers/staging/intel_sst/intel_sst_ioctl.h"
-#include "../../../drivers/staging/intel_sst/intel_sst.h"
 #include "sst_platform.h"
 
+static struct sst_device *sst;
+static DEFINE_MUTEX(sst_lock);
+
+int sst_register_dsp(struct sst_device *dev)
+{
+	BUG_ON(!dev);
+	if (!try_module_get(dev->dev->driver->owner))
+		return -ENODEV;
+	mutex_lock(&sst_lock);
+	if (sst) {
+		pr_err("we already have a device %s\n", sst->name);
+		module_put(dev->dev->driver->owner);
+		mutex_unlock(&sst_lock);
+		return -EEXIST;
+	}
+	pr_debug("registering device %s\n", dev->name);
+	sst = dev;
+	mutex_unlock(&sst_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_register_dsp);
+
+int sst_unregister_dsp(struct sst_device *dev)
+{
+	BUG_ON(!dev);
+	if (dev != sst)
+		return -EINVAL;
+
+	mutex_lock(&sst_lock);
+
+	if (!sst) {
+		mutex_unlock(&sst_lock);
+		return -EIO;
+	}
+
+	module_put(sst->dev->driver->owner);
+	pr_debug("unreg %s\n", sst->name);
+	sst = NULL;
+	mutex_unlock(&sst_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_unregister_dsp);
+
 static struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_DOUBLE |
@@ -135,37 +176,34 @@ static inline int sst_get_stream_status(struct sst_runtime_stream *stream)
 }
 
 static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
-				struct snd_sst_stream_params *param)
+				struct sst_pcm_params *param)
 {
 
-	param->uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
-	param->uc.pcm_params.num_chan = (u8) substream->runtime->channels;
-	param->uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
-	param->uc.pcm_params.reserved = 0;
-	param->uc.pcm_params.sfreq = substream->runtime->rate;
-	param->uc.pcm_params.ring_buffer_size =
-					snd_pcm_lib_buffer_bytes(substream);
-	param->uc.pcm_params.period_count = substream->runtime->period_size;
-	param->uc.pcm_params.ring_buffer_addr =
-				virt_to_phys(substream->dma_buffer.area);
-	pr_debug("period_cnt = %d\n", param->uc.pcm_params.period_count);
-	pr_debug("sfreq= %d, wd_sz = %d\n",
-		 param->uc.pcm_params.sfreq, param->uc.pcm_params.pcm_wd_sz);
+	param->codec = SST_CODEC_TYPE_PCM;
+	param->num_chan = (u8) substream->runtime->channels;
+	param->pcm_wd_sz = substream->runtime->sample_bits;
+	param->reserved = 0;
+	param->sfreq = substream->runtime->rate;
+	param->ring_buffer_size = snd_pcm_lib_buffer_bytes(substream);
+	param->period_count = substream->runtime->period_size;
+	param->ring_buffer_addr = virt_to_phys(substream->dma_buffer.area);
+	pr_debug("period_cnt = %d\n", param->period_count);
+	pr_debug("sfreq= %d, wd_sz = %d\n", param->sfreq, param->pcm_wd_sz);
 }
 
 static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
-	struct snd_sst_stream_params param = {{{0,},},};
-	struct snd_sst_params str_params = {0};
+	struct sst_pcm_params param = {0};
+	struct sst_stream_params str_params = {0};
 	int ret_val;
 
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
 	substream->runtime->dma_area = substream->dma_buffer.area;
 	str_params.sparams = param;
-	str_params.codec =  param.uc.pcm_params.codec;
+	str_params.codec =  param.codec;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		str_params.ops = STREAM_OPS_PLAYBACK;
 		str_params.device_type = substream->pcm->device + 1;
@@ -177,7 +215,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 		pr_debug("Capture stream,Device %d\n",
 					substream->pcm->device);
 	}
-	ret_val = stream->sstdrv_ops->pcm_control->open(&str_params);
+	ret_val = stream->ops->open(&str_params);
 	pr_debug("SST_SND_PLAY/CAPTURE ret_val = %x\n", ret_val);
 	if (ret_val < 0)
 		return ret_val;
@@ -216,7 +254,7 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	stream->stream_info.mad_substream = substream;
 	stream->stream_info.buffer_ptr = 0;
 	stream->stream_info.sfreq = substream->runtime->rate;
-	ret_val = stream->sstdrv_ops->pcm_control->device_control(
+	ret_val = stream->ops->device_control(
 			SST_SND_STREAM_INIT, &stream->stream_info);
 	if (ret_val)
 		pr_err("control_set ret error %d\n", ret_val);
@@ -229,7 +267,6 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sst_runtime_stream *stream;
-	int ret_val = 0;
 
 	pr_debug("sst_platform_open called\n");
 
@@ -243,27 +280,27 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 	if (!stream)
 		return -ENOMEM;
 	spin_lock_init(&stream->status_lock);
-	stream->stream_info.str_id = 0;
-	sst_set_stream_status(stream, SST_PLATFORM_INIT);
-	stream->stream_info.mad_substream = substream;
-	/* allocate memory for SST API set */
-	stream->sstdrv_ops = kzalloc(sizeof(*stream->sstdrv_ops),
-							GFP_KERNEL);
-	if (!stream->sstdrv_ops) {
-		pr_err("sst: mem allocation for ops fail\n");
+
+	/* get the sst ops */
+	mutex_lock(&sst_lock);
+	if (!sst) {
+		pr_err("no device available to run\n");
+		mutex_unlock(&sst_lock);
 		kfree(stream);
-		return -ENOMEM;
+		return -ENODEV;
 	}
-	stream->sstdrv_ops->vendor_id = MSIC_VENDOR_ID;
-	stream->sstdrv_ops->module_name = SST_CARD_NAMES;
-	/* registering with SST driver to get access to SST APIs to use */
-	ret_val = register_sst_card(stream->sstdrv_ops);
-	if (ret_val) {
-		pr_err("sst: sst card registration failed\n");
-		kfree(stream->sstdrv_ops);
+	if (!try_module_get(sst->dev->driver->owner)) {
+		mutex_unlock(&sst_lock);
 		kfree(stream);
-		return ret_val;
+		return -ENODEV;
 	}
+	stream->ops = sst->ops;
+	mutex_unlock(&sst_lock);
+
+	stream->stream_info.str_id = 0;
+	sst_set_stream_status(stream, SST_PLATFORM_INIT);
+	stream->stream_info.mad_substream = substream;
+	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
 	return 0;
@@ -278,9 +315,8 @@ static int sst_platform_close(struct snd_pcm_substream *substream)
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
-		ret_val = stream->sstdrv_ops->pcm_control->close(str_id);
-	unregister_sst_card(stream->sstdrv_ops);
-	kfree(stream->sstdrv_ops);
+		ret_val = stream->ops->close(str_id);
+	module_put(sst->dev->driver->owner);
 	kfree(stream);
 	return ret_val;
 }
@@ -294,8 +330,8 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
-		ret_val = stream->sstdrv_ops->pcm_control->device_control(
-					SST_SND_DROP, &str_id);
+		ret_val = stream->ops->device_control(
+				SST_SND_DROP, &str_id);
 		return ret_val;
 	}
 
@@ -347,8 +383,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	ret_val = stream->sstdrv_ops->pcm_control->device_control(str_cmd,
-								&str_id);
+	ret_val = stream->ops->device_control(str_cmd, &str_id);
 	if (!ret_val)
 		sst_set_stream_status(stream, status);
 
@@ -368,7 +403,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	if (status == SST_PLATFORM_INIT)
 		return 0;
 	str_info = &stream->stream_info;
-	ret_val = stream->sstdrv_ops->pcm_control->device_control(
+	ret_val = stream->ops->device_control(
 				SST_SND_BUFFER_POINTER, str_info);
 	if (ret_val) {
 		pr_err("sst: error code = %d\n", ret_val);
@@ -439,6 +474,7 @@ static int sst_platform_probe(struct platform_device *pdev)
 	int ret;
 
 	pr_debug("sst_platform_probe called\n");
+	sst = NULL;
 	ret = snd_soc_register_platform(&pdev->dev, &sst_soc_platform_drv);
 	if (ret) {
 		pr_err("registering soc platform failed\n");
diff --git a/sound/soc/mid-x86/sst_platform.h b/sound/soc/mid-x86/sst_platform.h
index df37028..f04f4f7 100644
--- a/sound/soc/mid-x86/sst_platform.h
+++ b/sound/soc/mid-x86/sst_platform.h
@@ -42,14 +42,14 @@
 #define SST_MIN_PERIODS		2
 #define SST_MAX_PERIODS		(1024*2)
 #define SST_FIFO_SIZE		0
-#define SST_CARD_NAMES		"intel_mid_card"
-#define MSIC_VENDOR_ID		3
+#define SST_CODEC_TYPE_PCM	1
 
-struct sst_runtime_stream {
-	int     stream_status;
-	struct pcm_stream_info stream_info;
-	struct intel_sst_card_ops *sstdrv_ops;
-	spinlock_t	status_lock;
+struct pcm_stream_info {
+	int str_id;
+	void *mad_substream;
+	void (*period_elapsed) (void *mad_substream);
+	unsigned long long buffer_ptr;
+	int sfreq;
 };
 
 enum sst_drv_status {
@@ -60,4 +60,72 @@ enum sst_drv_status {
 	SST_PLATFORM_DROPPED,
 };
 
+enum sst_controls {
+	SST_SND_ALLOC =			0x00,
+	SST_SND_PAUSE =			0x01,
+	SST_SND_RESUME =		0x02,
+	SST_SND_DROP =			0x03,
+	SST_SND_FREE =			0x04,
+	SST_SND_BUFFER_POINTER =	0x05,
+	SST_SND_STREAM_INIT =		0x06,
+	SST_SND_START	 =		0x07,
+	SST_MAX_CONTROLS =		0x07,
+};
+
+enum sst_stream_ops {
+	STREAM_OPS_PLAYBACK = 0,
+	STREAM_OPS_CAPTURE,
+};
+
+enum sst_audio_device_type {
+	SND_SST_DEVICE_HEADSET = 1,
+	SND_SST_DEVICE_IHF,
+	SND_SST_DEVICE_VIBRA,
+	SND_SST_DEVICE_HAPTIC,
+	SND_SST_DEVICE_CAPTURE,
+};
+
+/* PCM Parameters */
+struct sst_pcm_params {
+	u16 codec;	/* codec type */
+	u8 num_chan;	/* 1=Mono, 2=Stereo */
+	u8 pcm_wd_sz;	/* 16/24 - bit*/
+	u32 reserved;	/* Bitrate in bits per second */
+	u32 sfreq;	/* Sampling rate in Hz */
+	u32 ring_buffer_size;
+	u32 period_count;	/* period elapsed in samples*/
+	u32 ring_buffer_addr;
+};
+
+struct sst_stream_params {
+	u32 result;
+	u32 stream_id;
+	u8 codec;
+	u8 ops;
+	u8 stream_type;
+	u8 device_type;
+	struct sst_pcm_params sparams;
+};
+
+struct sst_ops {
+	int (*open) (struct sst_stream_params *str_param);
+	int (*device_control) (int cmd, void *arg);
+	int (*close) (unsigned int str_id);
+};
+
+struct sst_runtime_stream {
+	int     stream_status;
+	struct pcm_stream_info stream_info;
+	struct sst_ops *ops;
+	spinlock_t	status_lock;
+};
+
+struct sst_device {
+	char *name;
+	struct device *dev;
+	struct sst_ops *ops;
+};
+
+int sst_register_dsp(struct sst_device *sst);
+int sst_unregister_dsp(struct sst_device *sst);
 #endif
-- 
1.7.0.4
