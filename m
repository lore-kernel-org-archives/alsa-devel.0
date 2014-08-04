From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: mfld-pcm: Use function
	instead of ioctl
Date: Mon,  4 Aug 2014 15:04:20 +0530
Message-ID: <1407144861-30475-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F5CC2608CF
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 11:55:48 +0200 (CEST)
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 21 +++++++++------------
 sound/soc/intel/sst-mfld-platform.h     | 19 ++++++-------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 706212a6a68c..42766a51c17e 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -314,8 +314,7 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	stream->stream_info.arg = substream;
 	stream->stream_info.buffer_ptr = 0;
 	stream->stream_info.sfreq = substream->runtime->rate;
-	ret_val = stream->ops->device_control(
-			SST_SND_STREAM_INIT, &stream->stream_info);
+	ret_val = stream->ops->stream_init(&stream->stream_info);
 	if (ret_val)
 		pr_err("control_set ret error %d\n", ret_val);
 	return ret_val;
@@ -403,8 +402,7 @@ static int sst_media_prepare(struct snd_pcm_substream *substream,
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
-		ret_val = stream->ops->device_control(
-				SST_SND_DROP, &str_id);
+		ret_val = stream->ops->stream_drop(str_id);
 		return ret_val;
 	}
 
@@ -461,7 +459,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	int ret_val = 0, str_id;
 	struct sst_runtime_stream *stream;
-	int str_cmd, status;
+	int status;
 
 	pr_debug("sst_platform_pcm_trigger called\n");
 	stream = substream->runtime->private_data;
@@ -469,29 +467,29 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		pr_debug("sst: Trigger Start\n");
-		str_cmd = SST_SND_START;
 		status = SST_PLATFORM_RUNNING;
 		stream->stream_info.arg = substream;
+		ret_val = stream->ops->stream_start(str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		pr_debug("sst: in stop\n");
-		str_cmd = SST_SND_DROP;
 		status = SST_PLATFORM_DROPPED;
+		ret_val = stream->ops->stream_drop(str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		pr_debug("sst: in pause\n");
-		str_cmd = SST_SND_PAUSE;
 		status = SST_PLATFORM_PAUSED;
+		ret_val = stream->ops->stream_pause(str_id);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pr_debug("sst: in pause release\n");
-		str_cmd = SST_SND_RESUME;
 		status = SST_PLATFORM_RUNNING;
+		ret_val = stream->ops->stream_pause_release(str_id);
 		break;
 	default:
 		return -EINVAL;
 	}
-	ret_val = stream->ops->device_control(str_cmd, &str_id);
+
 	if (!ret_val)
 		sst_set_stream_status(stream, status);
 
@@ -511,8 +509,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	if (status == SST_PLATFORM_INIT)
 		return 0;
 	str_info = &stream->stream_info;
-	ret_val = stream->ops->device_control(
-				SST_SND_BUFFER_POINTER, str_info);
+	ret_val = stream->ops->stream_read_tstamp(str_info);
 	if (ret_val) {
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index cc3a088df7dd..2d6e65bbbc49 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -54,18 +54,6 @@ enum sst_drv_status {
 	SST_PLATFORM_DROPPED,
 };
 
-enum sst_controls {
-	SST_SND_ALLOC =			0x00,
-	SST_SND_PAUSE =			0x01,
-	SST_SND_RESUME =		0x02,
-	SST_SND_DROP =			0x03,
-	SST_SND_FREE =			0x04,
-	SST_SND_BUFFER_POINTER =	0x05,
-	SST_SND_STREAM_INIT =		0x06,
-	SST_SND_START	 =		0x07,
-	SST_MAX_CONTROLS = 		0x07,
-};
-
 enum sst_stream_ops {
 	STREAM_OPS_PLAYBACK = 0,
 	STREAM_OPS_CAPTURE,
@@ -126,7 +114,12 @@ struct compress_sst_ops {
 
 struct sst_ops {
 	int (*open) (struct snd_sst_params *str_param);
-	int (*device_control) (int cmd, void *arg);
+	int (*stream_init) (struct pcm_stream_info *str_info);
+	int (*stream_start) (int str_id);
+	int (*stream_drop) (int str_id);
+	int (*stream_pause) (int str_id);
+	int (*stream_pause_release) (int str_id);
+	int (*stream_read_tstamp) (struct pcm_stream_info *str_info);
 	int (*send_byte_stream)(struct snd_sst_bytes_v2 *bytes);
 	int (*close) (unsigned int str_id);
 };
-- 
1.9.0
