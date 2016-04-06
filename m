From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/6] ALSA: compress: Add function to
	indicate the stream has gone bad
Date: Wed, 6 Apr 2016 11:21:51 +0100
Message-ID: <1459938115-25456-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 30D72265130
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 12:21:58 +0200 (CEST)
In-Reply-To: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently, the avail IOCTL doesn't pass any error status, which
means typically on error it simply shows no data available. This
can lead to situations where user-space is waiting indefinitely
for data that will never come as the DSP has suffered an
unrecoverable error.

Add snd_compr_stop_xrun which end drivers can call to indicate
the stream has suffered an unrecoverable error and stop it. The
avail and poll IOCTLs are then updated to report if the stream is
in an error state to user-space. Allowing the error to propagate
out. Processing of the actual snd_compr_stop needs to be deferred
to a worker thread as the end driver may detect the errors during
an existing operation callback.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |  3 +++
 sound/core/compress_offload.c   | 58 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index c0abcdc..968fe2e 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -78,6 +78,7 @@ struct snd_compr_stream {
 	struct snd_compr_ops *ops;
 	struct snd_compr_runtime *runtime;
 	struct snd_compr *device;
+	struct delayed_work xrun_work;
 	enum snd_compr_direction direction;
 	bool metadata_set;
 	bool next_track;
@@ -187,4 +188,6 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+int snd_compr_stop_xrun(struct snd_compr_stream *stream);
+
 #endif
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a9933c0..0b93121 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -67,6 +67,8 @@ struct snd_compr_file {
 	struct snd_compr_stream stream;
 };
 
+static void xrun_delayed_work(struct work_struct *work);
+
 /*
  * a note on stream states used:
  * we use following states in the compressed core
@@ -123,6 +125,9 @@ static int snd_compr_open(struct inode *inode, struct file *f)
 		snd_card_unref(compr->card);
 		return -ENOMEM;
 	}
+
+	INIT_DELAYED_WORK(&data->stream.xrun_work, xrun_delayed_work);
+
 	data->stream.ops = compr->ops;
 	data->stream.direction = dirn;
 	data->stream.private_data = compr->private_data;
@@ -153,6 +158,8 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 	struct snd_compr_file *data = f->private_data;
 	struct snd_compr_runtime *runtime = data->stream.runtime;
 
+	cancel_delayed_work_sync(&data->stream.xrun_work);
+
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_DRAINING:
@@ -237,6 +244,14 @@ snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 	avail = snd_compr_calc_avail(stream, &ioctl_avail);
 	ioctl_avail.avail = avail;
 
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_XRUN:
+		return -EBADFD;
+	default:
+		break;
+	}
+
 	if (copy_to_user((__u64 __user *)arg,
 				&ioctl_avail, sizeof(ioctl_avail)))
 		return -EFAULT;
@@ -397,10 +412,16 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_XRUN:
 		retval = -EBADFD;
 		goto out;
+	default:
+		break;
 	}
+
 	poll_wait(f, &stream->runtime->sleep, wait);
 
 	avail = snd_compr_get_avail(stream);
@@ -420,6 +441,9 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		if (avail >= stream->runtime->fragment_size)
 			retval = snd_compr_get_poll(stream);
 		break;
+	case SNDRV_PCM_STATE_XRUN:
+		retval = -EBADFD;
+		break;
 	default:
 		if (stream->direction == SND_COMPRESS_PLAYBACK)
 			retval = POLLOUT | POLLWRNORM | POLLERR;
@@ -698,6 +722,38 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	return retval;
 }
 
+static void xrun_delayed_work(struct work_struct *work)
+{
+	struct snd_compr_stream *stream;
+
+	stream = container_of(work, struct snd_compr_stream, xrun_work.work);
+
+	mutex_lock(&stream->device->lock);
+	snd_compr_stop(stream);
+	mutex_unlock(&stream->device->lock);
+}
+
+/*
+ * snd_compr_stop_xrun: Report a fatal error on a stream
+ * @stream: pointer to stream
+ *
+ * Stop the stream and set its state to XRUN.
+ *
+ * Should be called with compressed device lock held.
+ */
+int snd_compr_stop_xrun(struct snd_compr_stream *stream)
+{
+	if (stream->runtime->state == SNDRV_PCM_STATE_XRUN)
+		return 0;
+
+	stream->runtime->state = SNDRV_PCM_STATE_XRUN;
+
+	queue_delayed_work(system_power_efficient_wq, &stream->xrun_work, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_compr_stop_xrun);
+
 static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 {
 	int ret;
-- 
2.1.4
