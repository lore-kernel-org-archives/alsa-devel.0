From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: mfld-pcm: Change sst_ops
	prototypes to take dev parameter
Date: Mon,  4 Aug 2014 15:04:21 +0530
Message-ID: <1407144861-30475-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AAAC26109C
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 11:55:51 +0200 (CEST)
In-Reply-To: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
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

sst_ops need to use the sst driver context. So pass sst device as argument,
which can be used to retrieve sst context.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 19 +++++++++----------
 sound/soc/intel/sst-mfld-platform.h     | 18 +++++++++---------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 42766a51c17e..a89ff7e18e1a 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -277,7 +277,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 
 	stream->stream_info.str_id = str_params.stream_id;
 
-	ret_val = stream->ops->open(&str_params);
+	ret_val = stream->ops->open(sst->dev, &str_params);
 	if (ret_val <= 0)
 		return ret_val;
 
@@ -314,13 +314,12 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	stream->stream_info.arg = substream;
 	stream->stream_info.buffer_ptr = 0;
 	stream->stream_info.sfreq = substream->runtime->rate;
-	ret_val = stream->ops->stream_init(&stream->stream_info);
+	ret_val = stream->ops->stream_init(sst->dev, &stream->stream_info);
 	if (ret_val)
 		pr_err("control_set ret error %d\n", ret_val);
 	return ret_val;
 
 }
-/* end -- helper functions */
 
 static int sst_media_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
@@ -372,7 +371,7 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
-		ret_val = stream->ops->close(str_id);
+		ret_val = stream->ops->close(sst->dev, str_id);
 	module_put(sst->dev->driver->owner);
 	kfree(stream);
 }
@@ -402,7 +401,7 @@ static int sst_media_prepare(struct snd_pcm_substream *substream,
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
-		ret_val = stream->ops->stream_drop(str_id);
+		ret_val = stream->ops->stream_drop(sst->dev, str_id);
 		return ret_val;
 	}
 
@@ -469,22 +468,22 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 		pr_debug("sst: Trigger Start\n");
 		status = SST_PLATFORM_RUNNING;
 		stream->stream_info.arg = substream;
-		ret_val = stream->ops->stream_start(str_id);
+		ret_val = stream->ops->stream_start(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		pr_debug("sst: in stop\n");
 		status = SST_PLATFORM_DROPPED;
-		ret_val = stream->ops->stream_drop(str_id);
+		ret_val = stream->ops->stream_drop(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		pr_debug("sst: in pause\n");
 		status = SST_PLATFORM_PAUSED;
-		ret_val = stream->ops->stream_pause(str_id);
+		ret_val = stream->ops->stream_pause(sst->dev, str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pr_debug("sst: in pause release\n");
 		status = SST_PLATFORM_RUNNING;
-		ret_val = stream->ops->stream_pause_release(str_id);
+		ret_val = stream->ops->stream_pause_release(sst->dev, str_id);
 		break;
 	default:
 		return -EINVAL;
@@ -509,7 +508,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	if (status == SST_PLATFORM_INIT)
 		return 0;
 	str_info = &stream->stream_info;
-	ret_val = stream->ops->stream_read_tstamp(str_info);
+	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
 	if (ret_val) {
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 2d6e65bbbc49..d4c28b8fb471 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -113,15 +113,15 @@ struct compress_sst_ops {
 };
 
 struct sst_ops {
-	int (*open) (struct snd_sst_params *str_param);
-	int (*stream_init) (struct pcm_stream_info *str_info);
-	int (*stream_start) (int str_id);
-	int (*stream_drop) (int str_id);
-	int (*stream_pause) (int str_id);
-	int (*stream_pause_release) (int str_id);
-	int (*stream_read_tstamp) (struct pcm_stream_info *str_info);
-	int (*send_byte_stream)(struct snd_sst_bytes_v2 *bytes);
-	int (*close) (unsigned int str_id);
+	int (*open) (struct device *dev, struct snd_sst_params *str_param);
+	int (*stream_init) (struct device *dev, struct pcm_stream_info *str_info);
+	int (*stream_start) (struct device *dev, int str_id);
+	int (*stream_drop) (struct device *dev, int str_id);
+	int (*stream_pause) (struct device *dev, int str_id);
+	int (*stream_pause_release) (struct device *dev, int str_id);
+	int (*stream_read_tstamp) (struct device *dev, struct pcm_stream_info *str_info);
+	int (*send_byte_stream)(struct device *dev, struct snd_sst_bytes_v2 *bytes);
+	int (*close) (struct device *dev, unsigned int str_id);
 };
 
 struct sst_runtime_stream {
-- 
1.9.0
