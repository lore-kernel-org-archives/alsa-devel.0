From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Fix stream volume set no effect
	issue on Broadwell
Date: Tue, 25 Nov 2014 21:00:53 +0800
Message-ID: <1416920453-21342-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D24E9265233
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 14:00:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The volume setting control for capture stream doesn't take effect on intel
Broadwell platform. Root cause it at 2 points:
1. set stream volume with channel=2 is wrongly bapassed;
2. the saved stream volume should be restored after stream is commit.

Here correct these 2 items to fix the stream volume set issue.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 35 ++++++++++++++++++++++++++---------
 sound/soc/intel/sst-haswell-ipc.h |  1 +
 sound/soc/intel/sst-haswell-pcm.c | 21 ++++++++++++---------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index ffd5728..3f8c482 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1042,14 +1042,9 @@ int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
 
 	trace_ipc_request("set stream volume", stream->reply.stream_hw_id);
 
-	if (channel > 1)
+	if (channel >= 2 && channel != SST_HSW_CHANNELS_ALL)
 		return -EINVAL;
 
-	if (stream->mute[channel]) {
-		stream->mute_volume[channel] = volume;
-		return 0;
-	}
-
 	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) |
 		IPC_STR_TYPE(IPC_STR_STAGE_MESSAGE);
 	header |= (stream->reply.stream_hw_id << IPC_STR_ID_SHIFT);
@@ -1057,9 +1052,28 @@ int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
 	header |= (stage_id << IPC_STG_ID_SHIFT);
 
 	req = &stream->vol_req;
-	req->channel = channel;
 	req->target_volume = volume;
 
+	/* set both at same time ? */
+	if (channel == SST_HSW_CHANNELS_ALL) {
+		if (hsw->mute[0] && hsw->mute[1]) {
+			hsw->mute_volume[0] = hsw->mute_volume[1] = volume;
+			return 0;
+		} else if (hsw->mute[0])
+			req->channel = 1;
+		else if (hsw->mute[1])
+			req->channel = 0;
+		else
+			req->channel = SST_HSW_CHANNELS_ALL;
+	} else {
+		/* set only 1 channel */
+		if (hsw->mute[channel]) {
+			hsw->mute_volume[channel] = volume;
+			return 0;
+		}
+		req->channel = channel;
+	}
+
 	ret = ipc_tx_message_wait(hsw, header, req, sizeof(*req), NULL, 0);
 	if (ret < 0) {
 		dev_err(hsw->dev, "error: set stream volume failed\n");
@@ -1138,8 +1152,11 @@ int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
 
 	trace_ipc_request("set mixer volume", volume);
 
+	if (channel >= 2 && channel != SST_HSW_CHANNELS_ALL)
+		return -EINVAL;
+
 	/* set both at same time ? */
-	if (channel == 2) {
+	if (channel == SST_HSW_CHANNELS_ALL) {
 		if (hsw->mute[0] && hsw->mute[1]) {
 			hsw->mute_volume[0] = hsw->mute_volume[1] = volume;
 			return 0;
@@ -1148,7 +1165,7 @@ int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
 		else if (hsw->mute[1])
 			req.channel = 0;
 		else
-			req.channel = 0xffffffff;
+			req.channel = SST_HSW_CHANNELS_ALL;
 	} else {
 		/* set only 1 channel */
 		if (hsw->mute[channel]) {
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 387511f..138e894 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -24,6 +24,7 @@
 #define SST_HSW_NO_CHANNELS		4
 #define SST_HSW_MAX_DX_REGIONS		14
 #define SST_HSW_DX_CONTEXT_SIZE        (640 * 1024)
+#define SST_HSW_CHANNELS_ALL		0xffffffff
 
 #define SST_HSW_FW_LOG_CONFIG_DWORDS	12
 #define SST_HSW_GLOBAL_LOG		15
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 7eb9afc..331237f 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -189,7 +189,8 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] ==
 		ucontrol->value.integer.value[1]) {
 		volume = hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
-		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0, 2, volume);
+		/* apply volume value to all channels */
+		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0, SST_HSW_CHANNELS_ALL, volume);
 	} else {
 		volume = hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
 		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0, 0, volume);
@@ -255,7 +256,7 @@ static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[1]) {
 
 		volume = hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
-		sst_hsw_mixer_set_volume(hsw, 0, 2, volume);
+		sst_hsw_mixer_set_volume(hsw, 0, SST_HSW_CHANNELS_ALL, volume);
 
 	} else {
 		volume = hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
@@ -525,7 +526,15 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		dev_err(rtd->dev, "error: failed to commit stream %d\n", ret);
 		return ret;
 	}
-	pcm_data->allocated = true;
+
+	if (!pcm_data->allocated) {
+		/* Set previous saved volume */
+		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0,
+				0, pcm_data->volume[0]);
+		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0,
+				1, pcm_data->volume[1]);
+		pcm_data->allocated = true;
+	}
 
 	ret = sst_hsw_stream_pause(hsw, pcm_data->stream, 1);
 	if (ret < 0)
@@ -632,12 +641,6 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 
-	/* Set previous saved volume */
-	sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0,
-			0, pcm_data->volume[0]);
-	sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0,
-			1, pcm_data->volume[1]);
-
 	mutex_unlock(&pcm_data->mutex);
 	return 0;
 }
-- 
1.9.1
