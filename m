From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH] ASoC: sst_platform created helper functions
Date: Tue, 11 Jan 2011 14:50:35 +0530
Message-ID: <1294737635-18145-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B9024594
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 10:07:13 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Harsha Priya <priya.harsha@intel.com>

Few funtions can be modularized in this driver to make them look cleaner
like managing the stream status with locks and filling pcm parameters.

This patch adds helper functions to do the same.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |  123 ++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 0e994c1..a4e3fa3 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -105,7 +105,45 @@ struct snd_soc_dai_driver sst_platform_dai[] = {
 	},
 },
 };
+
 /* helper functions */
+static inline void sst_set_stream_status(struct sst_runtime_stream *stream,
+					int state)
+{
+	spin_lock(&stream->status_lock);
+	stream->stream_status = state;
+	spin_unlock(&stream->status_lock);
+}
+
+static inline int sst_get_stream_status(struct sst_runtime_stream *stream)
+{
+	int state;
+
+	spin_lock(&stream->status_lock);
+	state = stream->stream_status;
+	spin_unlock(&stream->status_lock);
+	return state;
+}
+
+static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
+				struct snd_sst_stream_params *param)
+{
+
+	param->uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
+	param->uc.pcm_params.num_chan = (u8) substream->runtime->channels;
+	param->uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param->uc.pcm_params.reserved = 0;
+	param->uc.pcm_params.sfreq = substream->runtime->rate;
+	param->uc.pcm_params.ring_buffer_size =
+					snd_pcm_lib_buffer_bytes(substream);
+	param->uc.pcm_params.period_count = substream->runtime->period_size;
+	param->uc.pcm_params.ring_buffer_addr =
+				virt_to_phys(substream->dma_buffer.area);
+	pr_debug("period_cnt = %d\n", param->uc.pcm_params.period_count);
+	pr_debug("sfreq= %d, wd_sz = %d\n",
+		 param->uc.pcm_params.sfreq, param->uc.pcm_params.pcm_wd_sz);
+}
+
 static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream =
@@ -115,26 +153,10 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 	int ret_val;
 
 	/* set codec params and inform SST driver the same */
-
-	param.uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
-	param.uc.pcm_params.num_chan = (u8) substream->runtime->channels;
-	param.uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
-	param.uc.pcm_params.reserved = 0;
-	param.uc.pcm_params.sfreq = substream->runtime->rate;
-	param.uc.pcm_params.ring_buffer_size =
-					snd_pcm_lib_buffer_bytes(substream);
-	param.uc.pcm_params.period_count = substream->runtime->period_size;
-	param.uc.pcm_params.ring_buffer_addr =
-				virt_to_phys(substream->dma_buffer.area);
+	sst_fill_pcm_params(substream, &param);
 	substream->runtime->dma_area = substream->dma_buffer.area;
-
-	pr_debug("period_cnt = %d\n", param.uc.pcm_params.period_count);
-	pr_debug("sfreq= %d, wd_sz = %d\n",
-		 param.uc.pcm_params.sfreq, param.uc.pcm_params.pcm_wd_sz);
-
 	str_params.sparams = param;
-	str_params.codec = SST_CODEC_TYPE_PCM;
-
+	str_params.codec =  param.uc.pcm_params.codec;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		str_params.ops = STREAM_OPS_PLAYBACK;
 		str_params.device_type = substream->pcm->device + 1;
@@ -153,28 +175,23 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 
 	stream->stream_info.str_id = ret_val;
 	pr_debug("str id :  %d\n", stream->stream_info.str_id);
-
 	return ret_val;
 }
 
-
 static void sst_period_elapsed(void *mad_substream)
 {
 	struct snd_pcm_substream *substream = mad_substream;
 	struct sst_runtime_stream *stream;
+	int status;
 
 	if (!substream || !substream->runtime)
 		return;
 	stream = substream->runtime->private_data;
 	if (!stream)
 		return;
-
-	spin_lock(&stream->status_lock);
-	if (stream->stream_status != SST_PLATFORM_RUNNING) {
-		spin_unlock(&stream->status_lock);
+	status = sst_get_stream_status(stream);
+	if (status != SST_PLATFORM_RUNNING)
 		return;
-	}
-	spin_unlock(&stream->status_lock);
 	snd_pcm_period_elapsed(substream);
 }
 
@@ -185,9 +202,7 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	int ret_val;
 
 	pr_debug("setting buffer ptr param\n");
-	spin_lock(&stream->status_lock);
-	stream->stream_status = SST_PLATFORM_INIT;
-	spin_unlock(&stream->status_lock);
+	sst_set_stream_status(stream, SST_PLATFORM_INIT);
 	stream->stream_info.period_elapsed = sst_period_elapsed;
 	stream->stream_info.mad_substream = substream;
 	stream->stream_info.buffer_ptr = 0;
@@ -208,21 +223,14 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 	int ret_val = 0;
 
 	pr_debug("sst_platform_open called\n");
-
 	runtime = substream->runtime;
 	runtime->hw = sst_platform_pcm_hw;
-
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
-
 	spin_lock_init(&stream->status_lock);
 	stream->stream_info.str_id = 0;
-
-	spin_lock(&stream->status_lock);
-	stream->stream_status = SST_PLATFORM_INIT;
-	spin_unlock(&stream->status_lock);
-
+	sst_set_stream_status(stream, SST_PLATFORM_INIT);
 	stream->stream_info.mad_substream = substream;
 	/* allocate memory for SST API set */
 	stream->sstdrv_ops = kzalloc(sizeof(*stream->sstdrv_ops),
@@ -233,7 +241,6 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 	}
 	stream->sstdrv_ops->vendor_id = MSIC_VENDOR_ID;
-
 	/* registering with SST driver to get access to SST APIs to use */
 	ret_val = register_sst_card(stream->sstdrv_ops);
 	if (ret_val) {
@@ -251,14 +258,11 @@ static int sst_platform_close(struct snd_pcm_substream *substream)
 	int ret_val = 0, str_id;
 
 	pr_debug("sst_platform_close called\n");
-
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
-
 	if (str_id)
 		ret_val = stream->sstdrv_ops->control_set(
 					SST_SND_FREE, &str_id);
-
 	kfree(stream->sstdrv_ops);
 	kfree(stream);
 	return ret_val;
@@ -270,7 +274,6 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	int ret_val = 0, str_id;
 
 	pr_debug("sst_platform_pcm_prepare called\n");
-
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
@@ -299,11 +302,8 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	struct sst_runtime_stream *stream;
 
 	pr_debug("sst_platform_pcm_trigger called\n");
-
 	stream = substream->runtime->private_data;
-
 	str_id = stream->stream_info.str_id;
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		pr_debug("sst: Trigger Start\n");
@@ -311,9 +311,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					SST_SND_START, &str_id);
 		if (ret_val)
 			break;
-		spin_lock(&stream->status_lock);
-		stream->stream_status = SST_PLATFORM_RUNNING;
-		spin_unlock(&stream->status_lock);
+		sst_set_stream_status(stream, SST_PLATFORM_RUNNING);
 		stream->stream_info.mad_substream = substream;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -322,9 +320,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 				SST_SND_DROP, &str_id);
 		if (ret_val)
 			break;
-		spin_lock(&stream->status_lock);
-		stream->stream_status = SST_PLATFORM_DROPPED;
-		spin_unlock(&stream->status_lock);
+		sst_set_stream_status(stream, SST_PLATFORM_DROPPED);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		pr_debug("sst: in pause\n");
@@ -332,9 +328,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 				SST_SND_PAUSE, &str_id);
 		if (ret_val)
 			break;
-		spin_lock(&stream->status_lock);
-		stream->stream_status = SST_PLATFORM_PAUSED;
-		spin_unlock(&stream->status_lock);
+		sst_set_stream_status(stream, SST_PLATFORM_PAUSED);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pr_debug("sst: in pause release\n");
@@ -342,9 +336,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 			SST_SND_RESUME, &str_id);
 		if (ret_val)
 			break;
-		spin_lock(&stream->status_lock);
-		stream->stream_status = SST_PLATFORM_RUNNING;
-		spin_unlock(&stream->status_lock);
+		sst_set_stream_status(stream, SST_PLATFORM_RUNNING);
 		break;
 	default:
 		ret_val = -EINVAL;
@@ -357,18 +349,13 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
-	int ret_val;
+	int ret_val, status;
 	struct pcm_stream_info *str_info;
 
-
 	stream = substream->runtime->private_data;
-	spin_lock(&stream->status_lock);
-	if (stream->stream_status == SST_PLATFORM_INIT) {
-		spin_unlock(&stream->status_lock);
+	status = sst_get_stream_status(stream);
+	if (status == SST_PLATFORM_INIT)
 		return 0;
-	}
-	spin_unlock(&stream->status_lock);
-
 	str_info = &stream->stream_info;
 	ret_val = stream->sstdrv_ops->control_set(
 				SST_SND_BUFFER_POINTER, str_info);
@@ -376,7 +363,6 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
 	}
-
 	return stream->stream_info.buffer_ptr;
 }
 
@@ -402,7 +388,6 @@ int sst_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	int retval = 0;
 
 	pr_debug("sst_pcm_new called\n");
-
 	if (dai->driver->playback.channels_min ||
 			dai->driver->capture.channels_min) {
 		retval =  snd_pcm_lib_preallocate_pages_for_all(pcm,
@@ -414,7 +399,6 @@ int sst_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 			return retval;
 		}
 	}
-
 	return retval;
 }
 struct snd_soc_platform_driver sst_soc_platform_drv = {
@@ -433,6 +417,7 @@ static int sst_platform_probe(struct platform_device *pdev)
 		pr_err("registering soc platform failed\n");
 		return ret;
 	}
+
 	ret = snd_soc_register_dais(&pdev->dev,
 				sst_platform_dai, ARRAY_SIZE(sst_platform_dai));
 	if (ret) {
@@ -446,10 +431,8 @@ static int sst_platform_remove(struct platform_device *pdev)
 {
 
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sst_platform_dai));
-
 	snd_soc_unregister_platform(&pdev->dev);
 	pr_debug("sst_platform_remove sucess\n");
-
 	return 0;
 }
 
-- 
1.7.3.4
