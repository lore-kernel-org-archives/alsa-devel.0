From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/19] ASoC: Intel: mfld_pcm: move stream
	handling to dai_ops
Date: Fri, 13 Jun 2014 18:03:51 +0530
Message-ID: <1402662848-24534-3-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F2D362616F3
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:51 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This helps us to handle pcm and compress ops seperately and per dai

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |  112 +++++++++++++++++-------------
 1 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 7c790f5..0d46005 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -230,19 +230,12 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 }
 /* end -- helper functions */
 
-static int sst_platform_open(struct snd_pcm_substream *substream)
+static int sst_media_open(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
 {
+	int ret_val = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sst_runtime_stream *stream;
-	int ret_val;
-
-	pr_debug("sst_platform_open called\n");
-
-	snd_soc_set_runtime_hwparams(substream, &sst_platform_pcm_hw);
-	ret_val = snd_pcm_hw_constraint_integer(runtime,
-						SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret_val < 0)
-		return ret_val;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
@@ -251,50 +244,54 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 
 	/* get the sst ops */
 	mutex_lock(&sst_lock);
-	if (!sst) {
+	if (!sst ||
+	    !try_module_get(sst->dev->driver->owner)) {
 		pr_err("no device available to run\n");
-		mutex_unlock(&sst_lock);
-		kfree(stream);
-		return -ENODEV;
-	}
-	if (!try_module_get(sst->dev->driver->owner)) {
-		mutex_unlock(&sst_lock);
-		kfree(stream);
-		return -ENODEV;
+		ret_val = -ENODEV;
+		goto out_ops;
 	}
 	stream->ops = sst->ops;
 	mutex_unlock(&sst_lock);
 
 	stream->stream_info.str_id = 0;
-	sst_set_stream_status(stream, SST_PLATFORM_INIT);
+
 	stream->stream_info.mad_substream = substream;
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
-	return 0;
+	/* Make sure, that the period size is always even */
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
+
+	return snd_pcm_hw_constraint_integer(runtime,
+			 SNDRV_PCM_HW_PARAM_PERIODS);
+out_ops:
+	kfree(stream);
+	mutex_unlock(&sst_lock);
+	return ret_val;
 }
 
-static int sst_platform_close(struct snd_pcm_substream *substream)
+static void sst_media_close(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
 
-	pr_debug("sst_platform_close called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->ops->close(str_id);
 	module_put(sst->dev->driver->owner);
 	kfree(stream);
-	return ret_val;
+	return;
 }
 
-static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
+static int sst_media_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
 
-	pr_debug("sst_platform_pcm_prepare called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
@@ -316,6 +313,41 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
+static int sst_media_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
+	return 0;
+}
+
+static int sst_media_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static struct snd_soc_dai_ops sst_media_dai_ops = {
+	.startup = sst_media_open,
+	.shutdown = sst_media_close,
+	.prepare = sst_media_prepare,
+	.hw_params = sst_media_hw_params,
+	.hw_free = sst_media_hw_free,
+};
+
+static int sst_platform_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+
+	if (substream->pcm->internal)
+		return 0;
+
+	runtime = substream->runtime;
+	runtime->hw = sst_platform_pcm_hw;
+	return 0;
+}
+
 static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
@@ -377,32 +409,14 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
 	}
-	return stream->stream_info.buffer_ptr;
-}
-
-static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-
-	return 0;
-}
-
-static int sst_platform_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
+	return str_info->buffer_ptr;
 }
 
 static struct snd_pcm_ops sst_platform_ops = {
 	.open = sst_platform_open,
-	.close = sst_platform_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.prepare = sst_platform_pcm_prepare,
 	.trigger = sst_platform_pcm_trigger,
 	.pointer = sst_platform_pcm_pointer,
-	.hw_params = sst_platform_pcm_hw_params,
-	.hw_free = sst_platform_pcm_hw_free,
 };
 
 static void sst_pcm_free(struct snd_pcm *pcm)
@@ -413,15 +427,15 @@ static void sst_pcm_free(struct snd_pcm *pcm)
 
 static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int retval = 0;
 
-	pr_debug("sst_pcm_new called\n");
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
-			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+	if (dai->driver->playback.channels_min ||
+			dai->driver->capture.channels_min) {
 		retval =  snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL),
+			snd_dma_continuous_data(GFP_DMA),
 			SST_MIN_BUFFER, SST_MAX_BUFFER);
 		if (retval) {
 			pr_err("dma buffer allocationf fail\n");
-- 
1.7.0.4
