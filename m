From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v5 2/4] ALSA: compress: Add function to
	indicate the stream has gone bad
Date: Wed, 20 Apr 2016 13:40:01 +0100
Message-ID: <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6654B266536
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 14:40:23 +0200 (CEST)
In-Reply-To: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Add snd_compr_stop_error which end drivers can call to indicate
the stream has suffered an unrecoverable error and stop it. The
avail and poll IOCTLs are then updated to report if the stream is
in an error state to user-space. Allowing the error to propagate
out. Processing of the actual snd_compr_stop needs to be deferred
to a worker thread as the end driver may detect the errors during
an existing operation callback.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |  5 +++
 sound/core/compress_offload.c   | 70 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index c0abcdc..cee8c00 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -68,6 +68,7 @@ struct snd_compr_runtime {
  * @ops: pointer to DSP callbacks
  * @runtime: pointer to runtime structure
  * @device: device pointer
+ * @error_work: delayed work used when closing the stream due to an error
  * @direction: stream direction, playback/recording
  * @metadata_set: metadata set flag, true when set
  * @next_track: has userspace signal next track transition, true when set
@@ -78,6 +79,7 @@ struct snd_compr_stream {
 	struct snd_compr_ops *ops;
 	struct snd_compr_runtime *runtime;
 	struct snd_compr *device;
+	struct delayed_work error_work;
 	enum snd_compr_direction direction;
 	bool metadata_set;
 	bool next_track;
@@ -187,4 +189,7 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+int snd_compr_stop_error(struct snd_compr_stream *stream,
+			 snd_pcm_state_t state);
+
 #endif
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 507071d..28043bb 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -67,6 +67,8 @@ struct snd_compr_file {
 	struct snd_compr_stream stream;
 };
 
+static void error_delayed_work(struct work_struct *work);
+
 /*
  * a note on stream states used:
  * we use following states in the compressed core
@@ -123,6 +125,9 @@ static int snd_compr_open(struct inode *inode, struct file *f)
 		snd_card_unref(compr->card);
 		return -ENOMEM;
 	}
+
+	INIT_DELAYED_WORK(&data->stream.error_work, error_delayed_work);
+
 	data->stream.ops = compr->ops;
 	data->stream.direction = dirn;
 	data->stream.private_data = compr->private_data;
@@ -153,6 +158,8 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 	struct snd_compr_file *data = f->private_data;
 	struct snd_compr_runtime *runtime = data->stream.runtime;
 
+	cancel_delayed_work_sync(&data->stream.error_work);
+
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_DRAINING:
@@ -237,6 +244,15 @@ snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 	avail = snd_compr_calc_avail(stream, &ioctl_avail);
 	ioctl_avail.avail = avail;
 
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+		return -EBADFD;
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
+	default:
+		break;
+	}
+
 	if (copy_to_user((__u64 __user *)arg,
 				&ioctl_avail, sizeof(ioctl_avail)))
 		return -EFAULT;
@@ -346,11 +362,13 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
 	switch (stream->runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_PREPARED:
-	case SNDRV_PCM_STATE_XRUN:
 	case SNDRV_PCM_STATE_SUSPENDED:
 	case SNDRV_PCM_STATE_DISCONNECTED:
 		retval = -EBADFD;
 		goto out;
+	case SNDRV_PCM_STATE_XRUN:
+		retval = -EPIPE;
+		goto out;
 	}
 
 	avail = snd_compr_get_avail(stream);
@@ -400,10 +418,18 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
 		retval = -EBADFD;
 		goto out;
+	case SNDRV_PCM_STATE_XRUN:
+		retval = -EPIPE;
+		goto out;
+	default:
+		break;
 	}
+
 	poll_wait(f, &stream->runtime->sleep, wait);
 
 	avail = snd_compr_get_avail(stream);
@@ -423,6 +449,9 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		if (avail >= stream->runtime->fragment_size)
 			retval = snd_compr_get_poll(stream);
 		break;
+	case SNDRV_PCM_STATE_XRUN:
+		retval = -EPIPE;
+		break;
 	default:
 		if (stream->direction == SND_COMPRESS_PLAYBACK)
 			retval = POLLOUT | POLLWRNORM | POLLERR;
@@ -701,6 +730,43 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	return retval;
 }
 
+static void error_delayed_work(struct work_struct *work)
+{
+	struct snd_compr_stream *stream;
+
+	stream = container_of(work, struct snd_compr_stream, error_work.work);
+
+	mutex_lock(&stream->device->lock);
+
+	if (!stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP))
+		wake_up(&stream->runtime->sleep);
+
+	mutex_unlock(&stream->device->lock);
+}
+
+/*
+ * snd_compr_stop_error: Report a fatal error on a stream
+ * @stream: pointer to stream
+ * @state: state to transition the stream to
+ *
+ * Stop the stream and set its state.
+ *
+ * Should be called with compressed device lock held.
+ */
+int snd_compr_stop_error(struct snd_compr_stream *stream,
+			 snd_pcm_state_t state)
+{
+	if (stream->runtime->state == state)
+		return 0;
+
+	stream->runtime->state = state;
+
+	queue_delayed_work(system_power_efficient_wq, &stream->error_work, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_compr_stop_error);
+
 static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 {
 	int ret;
-- 
2.1.4
