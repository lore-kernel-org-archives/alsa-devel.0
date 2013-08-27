From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] ALSA: compress: use mutex in drain
Date: Tue, 27 Aug 2013 12:10:32 +0530
Message-ID: <1377585639-29516-3-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: broonie@kernel.org, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since we dont have lock over the function, we need to aquire mutex when checking
and modfying states in drain and partial_drain handlers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
---
 sound/core/compress_offload.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 868aefd..e640f8c 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -676,18 +676,29 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	return retval;
 }
 
+/* this fn is called without lock being held and we change stream states here
+ * so while using the stream state auquire the lock but relase before invoking
+ * DSP as the call will possibly take a while
+ */
 static int snd_compr_drain(struct snd_compr_stream *stream)
 {
 	int retval;
 
+	mutex_lock(&stream->device->lock);
 	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
-		return -EPERM;
+			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
+		retval = -EPERM;
+		goto ret;
+	}
+	mutex_unlock(&stream->device->lock);
 	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
+	mutex_lock(&stream->device->lock);
 	if (!retval) {
 		stream->runtime->state = SNDRV_PCM_STATE_DRAINING;
 		wake_up(&stream->runtime->sleep);
 	}
+ret:
+	mutex_unlock(&stream->device->lock);
 	return retval;
 }
 
@@ -716,9 +727,14 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
 static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 {
 	int retval;
+
+	mutex_lock(&stream->device->lock);
 	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
+			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
+		mutex_unlock(&stream->device->lock);
 		return -EPERM;
+	}
+	mutex_unlock(&stream->device->lock);
 	/* stream can be drained only when next track has been signalled */
 	if (stream->next_track == false)
 		return -EPERM;
-- 
1.7.0.4
