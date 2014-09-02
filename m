From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v5 01/12] ASoC: mfld: pcm: Replace pr_ with dev_
Date: Tue,  2 Sep 2014 18:05:56 +0530
Message-ID: <1409661367-19047-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D105E265526
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 14:58:28 +0200 (CEST)
In-Reply-To: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 8e1e9bc..85deecd 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -43,12 +43,12 @@ int sst_register_dsp(struct sst_device *dev)
 		return -ENODEV;
 	mutex_lock(&sst_lock);
 	if (sst) {
-		pr_err("we already have a device %s\n", sst->name);
+		dev_err(dev->dev, "we already have a device %s\n", sst->name);
 		module_put(dev->dev->driver->owner);
 		mutex_unlock(&sst_lock);
 		return -EEXIST;
 	}
-	pr_debug("registering device %s\n", dev->name);
+	dev_dbg(dev->dev, "registering device %s\n", dev->name);
 	sst = dev;
 	mutex_unlock(&sst_lock);
 	return 0;
@@ -70,7 +70,7 @@ int sst_unregister_dsp(struct sst_device *dev)
 	}
 
 	module_put(sst->dev->driver->owner);
-	pr_debug("unreg %s\n", sst->name);
+	dev_dbg(dev->dev, "unreg %s\n", sst->name);
 	sst = NULL;
 	mutex_unlock(&sst_lock);
 	return 0;
@@ -306,9 +306,10 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	int ret_val;
 
-	pr_debug("setting buffer ptr param\n");
+	dev_dbg(rtd->dev, "setting buffer ptr param\n");
 	sst_set_stream_status(stream, SST_PLATFORM_INIT);
 	stream->stream_info.period_elapsed = sst_period_elapsed;
 	stream->stream_info.arg = substream;
@@ -316,7 +317,7 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	stream->stream_info.sfreq = substream->runtime->rate;
 	ret_val = stream->ops->stream_init(sst->dev, &stream->stream_info);
 	if (ret_val)
-		pr_err("control_set ret error %d\n", ret_val);
+		dev_err(rtd->dev, "control_set ret error %d\n", ret_val);
 	return ret_val;
 
 }
@@ -337,7 +338,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	mutex_lock(&sst_lock);
 	if (!sst ||
 	    !try_module_get(sst->dev->driver->owner)) {
-		pr_err("no device available to run\n");
+		dev_err(dai->dev, "no device available to run\n");
 		ret_val = -ENODEV;
 		goto out_ops;
 	}
@@ -385,10 +386,11 @@ static inline unsigned int get_current_pipe_id(struct snd_soc_platform *platform
 			substream->runtime->private_data;
 	u32 str_id = stream->stream_info.str_id;
 	unsigned int pipe_id;
+
 	pipe_id = map[str_id].device_id;
 
-	pr_debug("%s: got pipe_id = %#x for str_id = %d\n",
-		 __func__, pipe_id, str_id);
+	dev_dbg(platform->dev, "got pipe_id = %#x for str_id = %d\n",
+			pipe_id, str_id);
 	return pipe_id;
 }
 
@@ -459,29 +461,30 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	int ret_val = 0, str_id;
 	struct sst_runtime_stream *stream;
 	int status;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
-	pr_debug("sst_platform_pcm_trigger called\n");
+	dev_dbg(rtd->dev, "sst_platform_pcm_trigger called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		pr_debug("sst: Trigger Start\n");
+		dev_dbg(rtd->dev, "sst: Trigger Start\n");
 		status = SST_PLATFORM_RUNNING;
 		stream->stream_info.arg = substream;
 		ret_val = stream->ops->stream_start(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		pr_debug("sst: in stop\n");
+		dev_dbg(rtd->dev, "sst: in stop\n");
 		status = SST_PLATFORM_DROPPED;
 		ret_val = stream->ops->stream_drop(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		pr_debug("sst: in pause\n");
+		dev_dbg(rtd->dev, "sst: in pause\n");
 		status = SST_PLATFORM_PAUSED;
 		ret_val = stream->ops->stream_pause(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		pr_debug("sst: in pause release\n");
+		dev_dbg(rtd->dev, "sst: in pause release\n");
 		status = SST_PLATFORM_RUNNING;
 		ret_val = stream->ops->stream_pause_release(sst->dev, str_id);
 		break;
@@ -502,6 +505,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	struct sst_runtime_stream *stream;
 	int ret_val, status;
 	struct pcm_stream_info *str_info;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	stream = substream->runtime->private_data;
 	status = sst_get_stream_status(stream);
@@ -510,7 +514,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	str_info = &stream->stream_info;
 	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
 	if (ret_val) {
-		pr_err("sst: error code = %d\n", ret_val);
+		dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
 		return ret_val;
 	}
 	substream->runtime->delay = str_info->pcm_delay;
@@ -526,7 +530,7 @@ static struct snd_pcm_ops sst_platform_ops = {
 
 static void sst_pcm_free(struct snd_pcm *pcm)
 {
-	pr_debug("sst_pcm_free called\n");
+	dev_dbg(pcm->dev, "sst_pcm_free called\n");
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
@@ -543,7 +547,7 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			snd_dma_continuous_data(GFP_DMA),
 			SST_MIN_BUFFER, SST_MAX_BUFFER);
 		if (retval) {
-			pr_err("dma buffer allocationf fail\n");
+			dev_err(rtd->dev, "dma buffer allocationf fail\n");
 			return retval;
 		}
 	}
@@ -576,13 +580,11 @@ static int sst_platform_probe(struct platform_device *pdev)
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (drv == NULL) {
-		pr_err("kzalloc failed\n");
 		return -ENOMEM;
 	}
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (pdata == NULL) {
-		pr_err("kzalloc failed for pdata\n");
 		return -ENOMEM;
 	}
 
@@ -594,14 +596,14 @@ static int sst_platform_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_platform(&pdev->dev, &sst_soc_platform_drv);
 	if (ret) {
-		pr_err("registering soc platform failed\n");
+		dev_err(&pdev->dev, "registering soc platform failed\n");
 		return ret;
 	}
 
 	ret = snd_soc_register_component(&pdev->dev, &sst_component,
 				sst_platform_dai, ARRAY_SIZE(sst_platform_dai));
 	if (ret) {
-		pr_err("registering cpu dais failed\n");
+		dev_err(&pdev->dev, "registering cpu dais failed\n");
 		snd_soc_unregister_platform(&pdev->dev);
 	}
 	return ret;
@@ -612,7 +614,7 @@ static int sst_platform_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
-	pr_debug("sst_platform_remove success\n");
+	dev_dbg(&pdev->dev, "sst_platform_remove success\n");
 	return 0;
 }
 
-- 
1.9.0
