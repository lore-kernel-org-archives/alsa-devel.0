From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH] ASoC: sst_platform porting sst dsp driver
	interface as per latest in Greg's staging tree
Date: Tue, 11 Jan 2011 14:50:59 +0530
Message-ID: <1294737659-18185-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D75A245A5
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 10:07:31 +0100 (CET)
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

The interface between sst platform driver and intel sst dsp driver
have been changed in Greg's staging tree - next branch

This patch adds the interface changes compatible with the new interface
in Greg's staging tree

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |   49 ++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index a4e3fa3..1d1f544 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -168,7 +168,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 		pr_debug("Capture stream,Device %d\n",
 					substream->pcm->device);
 	}
-	ret_val = stream->sstdrv_ops->control_set(SST_SND_ALLOC, &str_params);
+	ret_val = stream->sstdrv_ops->pcm_control->open(&str_params);
 	pr_debug("SST_SND_PLAY/CAPTURE ret_val = %x\n", ret_val);
 	if (ret_val < 0)
 		return ret_val;
@@ -207,8 +207,8 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	stream->stream_info.mad_substream = substream;
 	stream->stream_info.buffer_ptr = 0;
 	stream->stream_info.sfreq = substream->runtime->rate;
-	ret_val = stream->sstdrv_ops->control_set(SST_SND_STREAM_INIT,
-				&stream->stream_info);
+	ret_val = stream->sstdrv_ops->pcm_control->device_control(
+			SST_SND_STREAM_INIT, &stream->stream_info);
 	if (ret_val)
 		pr_err("control_set ret error %d\n", ret_val);
 	return ret_val;
@@ -261,8 +261,7 @@ static int sst_platform_close(struct snd_pcm_substream *substream)
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
-		ret_val = stream->sstdrv_ops->control_set(
-					SST_SND_FREE, &str_id);
+		ret_val = stream->sstdrv_ops->pcm_control->close(str_id);
 	kfree(stream->sstdrv_ops);
 	kfree(stream);
 	return ret_val;
@@ -277,7 +276,7 @@ static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
-		ret_val = stream->sstdrv_ops->control_set(
+		ret_val = stream->sstdrv_ops->pcm_control->device_control(
 					SST_SND_DROP, &str_id);
 		return ret_val;
 	}
@@ -300,6 +299,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	int ret_val = 0, str_id;
 	struct sst_runtime_stream *stream;
+	int str_cmd, status;
 
 	pr_debug("sst_platform_pcm_trigger called\n");
 	stream = substream->runtime->private_data;
@@ -307,40 +307,33 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		pr_debug("sst: Trigger Start\n");
-		ret_val = stream->sstdrv_ops->control_set(
-					SST_SND_START, &str_id);
-		if (ret_val)
-			break;
-		sst_set_stream_status(stream, SST_PLATFORM_RUNNING);
+		str_cmd = SST_SND_START;
+		status = SST_PLATFORM_RUNNING;
 		stream->stream_info.mad_substream = substream;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		pr_debug("sst: in stop\n");
-		ret_val = stream->sstdrv_ops->control_set(
-				SST_SND_DROP, &str_id);
-		if (ret_val)
-			break;
-		sst_set_stream_status(stream, SST_PLATFORM_DROPPED);
+		str_cmd = SST_SND_DROP;
+		status = SST_PLATFORM_DROPPED;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		pr_debug("sst: in pause\n");
-		ret_val = stream->sstdrv_ops->control_set(
-				SST_SND_PAUSE, &str_id);
-		if (ret_val)
-			break;
-		sst_set_stream_status(stream, SST_PLATFORM_PAUSED);
+		str_cmd = SST_SND_PAUSE;
+		status = SST_PLATFORM_PAUSED;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pr_debug("sst: in pause release\n");
-		ret_val = stream->sstdrv_ops->control_set(
-			SST_SND_RESUME, &str_id);
-		if (ret_val)
-			break;
-		sst_set_stream_status(stream, SST_PLATFORM_RUNNING);
+		str_cmd = SST_SND_RESUME;
+		status = SST_PLATFORM_RUNNING;
 		break;
 	default:
-		ret_val = -EINVAL;
+		return -EINVAL;
 	}
+	ret_val = stream->sstdrv_ops->pcm_control->device_control(str_cmd,
+								&str_id);
+	if (!ret_val)
+		sst_set_stream_status(stream, status);
+
 	return ret_val;
 }
 
@@ -357,7 +350,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	if (status == SST_PLATFORM_INIT)
 		return 0;
 	str_info = &stream->stream_info;
-	ret_val = stream->sstdrv_ops->control_set(
+	ret_val = stream->sstdrv_ops->pcm_control->device_control(
 				SST_SND_BUFFER_POINTER, str_info);
 	if (ret_val) {
 		pr_err("sst: error code = %d\n", ret_val);
-- 
1.7.3.4
