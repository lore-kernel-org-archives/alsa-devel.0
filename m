From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 8/9] ALSA: compress: call pointer callback and
	updates under a lock
Date: Tue, 27 Aug 2013 12:10:38 +0530
Message-ID: <1377585639-29516-9-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 86502264FEE
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:52 +0200 (CEST)
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

to prevent racy claculations as multiple threads can invoke and update values

While at it give some emptylines in code to improve readablity

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/compress_driver.h |    2 ++
 sound/core/compress_offload.c   |   13 +++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 9031a26..30258f3 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -48,6 +48,7 @@ struct snd_compr_ops;
  *	the ring buffer
  * @total_bytes_transferred: cumulative bytes transferred by offload DSP
  * @sleep: poll sleep
+ * @pointer_lock: lock used for buffer pointer update
  */
 struct snd_compr_runtime {
 	snd_pcm_state_t state;
@@ -60,6 +61,7 @@ struct snd_compr_runtime {
 	u64 total_bytes_transferred;
 	wait_queue_head_t sleep;
 	void *private_data;
+	struct mutex pointer_lock;
 };
 
 /**
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 898a1d9..01b179f 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -122,6 +122,7 @@ static int snd_compr_open(struct inode *inode, struct file *f)
 		return -ENOMEM;
 	}
 	runtime->state = SNDRV_PCM_STATE_OPEN;
+	mutex_init(&runtime->pointer_lock);
 	init_waitqueue_head(&runtime->sleep);
 	data->stream.runtime = runtime;
 	f->private_data = (void *)data;
@@ -151,13 +152,21 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 {
 	if (!stream->ops->pointer)
 		return -ENOTSUPP;
+
+	mutex_lock(&stream->runtime->pointer_lock);
+
 	stream->ops->pointer(stream, tstamp);
+
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
+
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
 		stream->runtime->total_bytes_transferred = tstamp->copied_total;
 	else
 		stream->runtime->total_bytes_available = tstamp->copied_total;
+
+	mutex_unlock(&stream->runtime->pointer_lock);
+
 	return 0;
 }
 
@@ -165,7 +174,9 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		struct snd_compr_avail *avail)
 {
 	memset(avail, 0, sizeof(*avail));
+
 	snd_compr_update_tstamp(stream, &avail->tstamp);
+
 	/* Still need to return avail even if tstamp can't be filled in */
 
 	if (stream->runtime->total_bytes_available == 0 &&
@@ -174,9 +185,11 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		pr_debug("detected init and someone forgot to do a write\n");
 		return stream->runtime->buffer_size;
 	}
+
 	pr_debug("app wrote %lld, DSP consumed %lld\n",
 			stream->runtime->total_bytes_available,
 			stream->runtime->total_bytes_transferred);
+
 	if (stream->runtime->total_bytes_available ==
 				stream->runtime->total_bytes_transferred) {
 		if (stream->direction == SND_COMPRESS_PLAYBACK) {
-- 
1.7.0.4
