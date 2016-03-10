From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ALSA: compress: Handle errors during avail
	requests
Date: Thu, 10 Mar 2016 10:44:52 +0000
Message-ID: <1457606694-10985-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C9F9260686
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:44:56 +0100 (CET)
In-Reply-To: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

No errors are currently returned whilst checking the amount of available
data. If user-space does an avail request which encounters an error it
will generally return zero, causing user-space to poll and if each
subsequence avail request also returns zero it will wait indefinitely for
data that is never coming. This patch updates the code so that errors
during avail requests will be correctly propagated to user-space.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c | 64 +++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 7fac3ca..c9c0849 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -170,9 +170,15 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 		struct snd_compr_tstamp *tstamp)
 {
+	int ret;
+
 	if (!stream->ops->pointer)
 		return -ENOTSUPP;
-	stream->ops->pointer(stream, tstamp);
+
+	ret = stream->ops->pointer(stream, tstamp);
+	if (ret < 0)
+		return ret;
+
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
@@ -182,18 +188,24 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 	return 0;
 }
 
-static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
+static int snd_compr_calc_avail(struct snd_compr_stream *stream,
 		struct snd_compr_avail *avail)
 {
+	int ret;
+
 	memset(avail, 0, sizeof(*avail));
-	snd_compr_update_tstamp(stream, &avail->tstamp);
+	ret = snd_compr_update_tstamp(stream, &avail->tstamp);
+	if (ret < 0)
+		return ret;
+
 	/* Still need to return avail even if tstamp can't be filled in */
 
 	if (stream->runtime->total_bytes_available == 0 &&
 			stream->runtime->state == SNDRV_PCM_STATE_SETUP &&
 			stream->direction == SND_COMPRESS_PLAYBACK) {
 		pr_debug("detected init and someone forgot to do a write\n");
-		return stream->runtime->buffer_size;
+		avail->avail = stream->runtime->buffer_size;
+		return 0;
 	}
 	pr_debug("app wrote %lld, DSP consumed %lld\n",
 			stream->runtime->total_bytes_available,
@@ -202,9 +214,11 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 				stream->runtime->total_bytes_transferred) {
 		if (stream->direction == SND_COMPRESS_PLAYBACK) {
 			pr_debug("both pointers are same, returning full avail\n");
-			return stream->runtime->buffer_size;
+			avail->avail = stream->runtime->buffer_size;
+			return 0;
 		} else {
 			pr_debug("both pointers are same, returning no avail\n");
+			avail->avail = 0;
 			return 0;
 		}
 	}
@@ -215,24 +229,30 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		avail->avail = stream->runtime->buffer_size - avail->avail;
 
 	pr_debug("ret avail as %lld\n", avail->avail);
-	return avail->avail;
+	return 0;
 }
 
-static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
+static inline int snd_compr_get_avail(struct snd_compr_stream *stream,
+				      size_t *avail)
 {
-	struct snd_compr_avail avail;
+	struct snd_compr_avail full_avail;
+	int ret;
+
+	ret = snd_compr_calc_avail(stream, &full_avail);
+	*avail = full_avail.avail;
 
-	return snd_compr_calc_avail(stream, &avail);
+	return ret;
 }
 
 static int
 snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 {
 	struct snd_compr_avail ioctl_avail;
-	size_t avail;
+	int ret;
 
-	avail = snd_compr_calc_avail(stream, &ioctl_avail);
-	ioctl_avail.avail = avail;
+	ret = snd_compr_calc_avail(stream, &ioctl_avail);
+	if (ret < 0)
+		return ret;
 
 	if (copy_to_user((__u64 __user *)arg,
 				&ioctl_avail, sizeof(ioctl_avail)))
@@ -287,11 +307,14 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	/* write is allowed when stream is running or has been steup */
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
 			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
-		mutex_unlock(&stream->device->lock);
-		return -EBADFD;
+		retval = -EBADFD;
+		goto out;
 	}
 
-	avail = snd_compr_get_avail(stream);
+	retval = snd_compr_get_avail(stream, &avail);
+	if (retval < 0)
+		goto out;
+
 	pr_debug("avail returned %ld\n", (unsigned long)avail);
 	/* calculate how much we can write to buffer */
 	if (avail > count)
@@ -313,6 +336,7 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 		pr_debug("stream prepared, Houston we are good to go\n");
 	}
 
+out:
 	mutex_unlock(&stream->device->lock);
 	return retval;
 }
@@ -346,7 +370,10 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
 		goto out;
 	}
 
-	avail = snd_compr_get_avail(stream);
+	retval = snd_compr_get_avail(stream, &avail);
+	if (retval < 0)
+		goto out;
+
 	pr_debug("avail returned %ld\n", (unsigned long)avail);
 	/* calculate how much we can read from buffer */
 	if (avail > count)
@@ -399,7 +426,10 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 	}
 	poll_wait(f, &stream->runtime->sleep, wait);
 
-	avail = snd_compr_get_avail(stream);
+	retval = snd_compr_get_avail(stream, &avail);
+	if (retval < 0)
+		goto out;
+
 	pr_debug("avail is %ld\n", (unsigned long)avail);
 	/* check if we have at least one fragment to fill */
 	switch (stream->runtime->state) {
-- 
2.1.4
