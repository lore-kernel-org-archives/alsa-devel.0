Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 815B0265E48
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:02:13 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:02:08 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <258ad21e6a70b9fb23d730d3570dab0033c0abd3.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 4/7] ALSA: compress_core: Add support for
	capture streams
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de, vinod.koul@intel.com
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-ID: <alsa-devel@alsa-project.org>

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |   43 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 52ca4cc..52a2765 100644
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
@@ -481,9 +515,14 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
 			goto out;
-		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+
 		stream->metadata_set = false;
 		stream->next_track = false;
+
+		if (stream->direction == SND_COMPRESS_PLAYBACK)
+			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+		else
+			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
 	} else {
 		return -EPERM;
 	}
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
