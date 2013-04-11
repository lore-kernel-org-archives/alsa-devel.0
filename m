From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ALSA: compress_core: Add support for
	capture streams
Date: Thu, 11 Apr 2013 19:00:42 +0100
Message-ID: <1365703245-20738-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 847422661E4
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:10:01 +0200 (CEST)
In-Reply-To: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |   43 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 52ca4cc..d0fc9a1 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -296,7 +296,41 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 static ssize_t snd_compr_read(struct file *f, char __user *buf,
 		size_t count, loff_t *offset)
 {
-	return -ENXIO;
+	struct snd_compr_file *data = f->private_data;
+	struct snd_compr_stream *stream;
+	size_t avail;
+	int retval;
+
+	if (snd_BUG_ON(!data))
+		return -EFAULT;
+
+	stream = &data->stream;
+	mutex_lock(&stream->device->lock);
+
+	/* read is allowed when stream is running */
+	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+		retval = -EBADFD;
+		goto out;
+	}
+
+	avail = snd_compr_get_avail(stream);
+	pr_debug("avail returned %ld\n", (unsigned long)avail);
+	/* calculate how much we can read from buffer */
+	if (avail > count)
+		avail = count;
+
+	if (stream->ops->copy) {
+		retval = stream->ops->copy(stream, buf, avail);
+	} else {
+		retval = -ENXIO;
+		goto out;
+	}
+	if (retval > 0)
+		stream->runtime->total_bytes_transferred += retval;
+
+out:
+	mutex_unlock(&stream->device->lock);
+	return retval;
 }
 
 static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma)
@@ -481,7 +515,12 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
 			goto out;
-		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+
+		if (stream->direction == SND_COMPRESS_PLAYBACK)
+			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+		else
+			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+
 		stream->metadata_set = false;
 		stream->next_track = false;
 	} else {
-- 
1.7.2.5
