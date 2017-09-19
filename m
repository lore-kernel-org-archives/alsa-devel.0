From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 16/38] axfer: add support for blocking
	data transmission operation of alsa-lib PCM API
Date: Tue, 19 Sep 2017 09:43:56 +0900
Message-ID: <20170919004418.24668-17-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 65254266ED0
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 02:44:30 +0200 (CEST)
In-Reply-To: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In alsa-lib PCM API, snd_pcm_read[i|n]() and snd_pcm_write[i|n] are used
to transfer data frames from/to hardware. When a handler is not opened with
specific flags, these functions perform blocking operation; i.e. the
function call doesn't return till all of request number of data frames are
actually handled, or call is interrupted by Unix signals, or PCM substeam
corrupts due to hardware reasons.

This commit adds support for this type of data transmission. For cases that
handled data frames are not processed by container interface, this commit
adds internal cache mechanism to handle rest of data frames in next timing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am             |   3 +-
 axfer/xfer-libasound-irq-rw.c | 406 ++++++++++++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.c        |  12 +-
 axfer/xfer-libasound.h        |   3 +
 4 files changed, 422 insertions(+), 2 deletions(-)
 create mode 100644 axfer/xfer-libasound-irq-rw.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index ab4e3ae1..e928f796 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -43,4 +43,5 @@ axfer_SOURCES = \
 	xfer.h \
 	xfer.c \
 	xfer-libasound.h \
-	xfer-libasound.c
+	xfer-libasound.c \
+	xfer-libasound-irq-rw.c
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
new file mode 100644
index 00000000..7fe4f934
--- /dev/null
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -0,0 +1,406 @@
+/*
+ * xfer-libasound-io-rw.c - I/O helper for SND_PCM_ACCESS_RW_XXX.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-libasound.h"
+#include "misc.h"
+
+struct frame_cache {
+	void *buf;
+	void *buf_ptr;
+
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_buffer;
+	snd_pcm_access_t access;
+
+	int (*handle)(struct libasound_state *state, snd_pcm_state_t status,
+		      unsigned int *frame_count, struct mapper_context *mapper,
+		      struct container_context *cntrs);
+	void (*align_frames)(struct frame_cache *cache,
+			     unsigned int consumed_count,
+			     unsigned int bytes_per_sample,
+			     unsigned int samples_per_frame);
+
+	unsigned int remained_count;
+};
+
+static void align_frames_in_i(struct frame_cache *cache,
+			      unsigned int consumed_count,
+			      unsigned int bytes_per_sample,
+			      unsigned int samples_per_frame)
+{
+	char *buf = cache->buf;
+	unsigned int offset;
+	unsigned int size;
+
+	cache->remained_count -= consumed_count;
+
+	offset = bytes_per_sample * samples_per_frame * consumed_count;
+	size = bytes_per_sample * samples_per_frame * cache->remained_count;
+	memcpy(buf, buf + offset, size);
+
+	cache->buf_ptr = buf + size;
+}
+
+static void align_frames_in_n(struct frame_cache *cache,
+			      unsigned int consumed_count,
+			      unsigned int bytes_per_sample,
+			      unsigned int samples_per_frame)
+{
+	char **bufs = cache->buf;
+	char **buf_ptrs = cache->buf_ptr;
+	char *buf;
+	unsigned int offset;
+	unsigned int size;
+	int i;
+
+	cache->remained_count -= consumed_count;
+
+	for (i = 0; i < samples_per_frame; ++i) {
+		buf = bufs[i];
+		offset = bytes_per_sample * consumed_count;
+		size = bytes_per_sample * cache->remained_count;
+		memcpy(buf, buf + offset, size);
+
+		buf_ptrs[i] = buf + size;
+	}
+}
+
+static int read_frames(struct libasound_state *state, unsigned int *frame_count,
+		       unsigned int avail_count, struct mapper_context *mapper,
+		       struct container_context *cntrs)
+{
+	struct frame_cache *cache = state->private_data;
+	unsigned int consumed_count;
+	int err;
+
+	/* Trim according up to expected frame count. */
+	if (*frame_count < avail_count)
+		avail_count = *frame_count;
+
+	/* Cache required amount of frames. */
+	if (avail_count > cache->remained_count) {
+		avail_count -= cache->remained_count;
+
+		/*
+		 * Execute write operation according to the shape of buffer.
+		 * These operations automatically start the substream.
+		 */
+		if (cache->access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+			err = snd_pcm_readi(state->handle, cache->buf_ptr,
+					    avail_count);
+		} else {
+			err = snd_pcm_readn(state->handle, cache->buf_ptr,
+					    avail_count);
+		}
+		if (err < 0)
+			return err;
+		cache->remained_count += err;
+		avail_count = cache->remained_count;
+	}
+
+	/* Write out to file descriptors. */
+	consumed_count = avail_count;
+	err = mapper_context_process_frames(mapper, cache->buf,
+					     &consumed_count, cntrs);
+	if (err < 0)
+		return err;
+
+	cache->align_frames(cache, consumed_count, cache->bytes_per_sample,
+			    cache->samples_per_frame);
+
+	*frame_count = consumed_count;
+
+	return 0;
+}
+
+static int r_process_frames_blocking(struct libasound_state *state,
+				     snd_pcm_state_t status,
+				     unsigned int *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail_count;
+	int err = 0;
+
+	if (status == SND_PCM_STATE_RUNNING) {
+		/* Check available space on the buffer. */
+		avail = snd_pcm_avail(state->handle);
+		if (avail < 0) {
+			err = avail;
+			goto error;
+		}
+		avail_count = (snd_pcm_uframes_t)avail;
+
+		if (avail_count == 0) {
+			/*
+			 * Request data frames so that blocking is just
+			 * released.
+			 */
+			err = snd_pcm_sw_params_get_avail_min(state->sw_params,
+							      &avail_count);
+			if (err < 0)
+				goto error;
+		}
+	} else {
+		/* Request data frames so that the PCM substream starts. */
+		snd_pcm_uframes_t frame_count;
+		err = snd_pcm_sw_params_get_start_threshold(state->sw_params,
+							    &frame_count);
+		if (err < 0)
+			goto error;
+
+		avail_count = (unsigned int)frame_count;
+	}
+
+	err = read_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int write_frames(struct libasound_state *state,
+			unsigned int *frame_count, unsigned int avail_count,
+			struct mapper_context *mapper,
+			struct container_context *cntrs)
+{
+	struct frame_cache *cache = state->private_data;
+	snd_pcm_uframes_t consumed_count;
+	int err;
+
+	/* Trim according up to expected frame count. */
+	if (*frame_count < avail_count)
+		avail_count = *frame_count;
+
+	/* Cache required amount of frames. */
+	if (avail_count > cache->remained_count) {
+		avail_count -= cache->remained_count;
+
+		/* Read frames to transfer. */
+		err = mapper_context_process_frames(mapper, cache->buf_ptr,
+						     &avail_count, cntrs);
+		if (err < 0)
+			return err;
+		cache->remained_count += avail_count;
+		avail_count = cache->remained_count;
+	}
+
+	/*
+	 * Execute write operation according to the shape of buffer. These
+	 * operations automatically start the stream.
+	 */
+	consumed_count = avail_count;
+	if (cache->access == SND_PCM_ACCESS_RW_INTERLEAVED)
+		err = snd_pcm_writei(state->handle, cache->buf, consumed_count);
+	else
+		err = snd_pcm_writen(state->handle, cache->buf, consumed_count);
+	if (err < 0)
+		return err;
+
+	consumed_count = (unsigned int)err;
+	cache->align_frames(cache, consumed_count, cache->bytes_per_sample,
+			    cache->samples_per_frame);
+
+	*frame_count = consumed_count;
+
+	return 0;
+}
+
+static int w_process_frames_blocking(struct libasound_state *state,
+				     snd_pcm_state_t status,
+				     unsigned int *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	unsigned int avail_count;
+	int err;
+
+	if (status == SND_PCM_STATE_RUNNING) {
+		/* Check available space on the buffer. */
+		avail = snd_pcm_avail(state->handle);
+		if (avail < 0) {
+			err = avail;
+			goto error;
+		}
+		avail_count = (unsigned int)avail;
+
+		if (avail_count == 0) {
+			/*
+			 * Fill with data frames so that blocking is just
+			 * released.
+			 */
+			snd_pcm_uframes_t avail_min;
+			err = snd_pcm_sw_params_get_avail_min(state->sw_params,
+							      &avail_min);
+			if (err < 0)
+				goto error;
+			avail_count = (unsigned int)avail_min;
+		}
+	} else {
+		snd_pcm_uframes_t frames_for_start_threshold;
+		snd_pcm_uframes_t frames_per_period;
+
+		/* Fill with data frames so that the PCM substream starts. */
+		err = snd_pcm_sw_params_get_start_threshold(state->sw_params,
+						&frames_for_start_threshold);
+		if (err < 0)
+			goto error;
+
+		/*
+		 * But the above number can be too small and cause XRUN because
+		 * I/O operation is done per period.
+		 */
+		err = snd_pcm_hw_params_get_period_size(state->hw_params,
+						&frames_per_period, NULL);
+		if (err < 0)
+			goto error;
+
+		/*
+		 * Use larger one to prevent from both of XRUN and successive
+		 * blocking.
+		 */
+		if (frames_for_start_threshold > frames_per_period)
+			avail_count = (unsigned int)frames_for_start_threshold;
+		else
+			avail_count = (unsigned int)frames_per_period;
+	}
+
+	err = write_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int irq_rw_pre_process(struct libasound_state *state)
+{
+	struct frame_cache *cache = state->private_data;
+	snd_pcm_format_t format;
+	snd_pcm_uframes_t frames_per_buffer;
+	int bytes_per_sample;
+	uint64_t bytes_per_buffer;
+	int err;
+
+	err = snd_pcm_hw_params_get_format(state->hw_params, &format);
+	if (err < 0)
+		return err;
+	bytes_per_sample = snd_pcm_format_physical_width(format);
+	if (bytes_per_sample <= 0)
+		return -ENXIO;
+	cache->bytes_per_sample = bytes_per_sample;
+
+	err = snd_pcm_hw_params_get_channels(state->hw_params,
+					     &cache->samples_per_frame);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_buffer_size(state->hw_params,
+						&frames_per_buffer);
+	if (err < 0)
+		return err;
+	cache->frames_per_buffer = (unsigned int)frames_per_buffer;
+
+	/* Allocate buffer and assign callback for alignment. */
+	err = snd_pcm_hw_params_get_access(state->hw_params, &cache->access);
+	if (err < 0)
+		return err;
+	if (cache->access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+		bytes_per_buffer = cache->bytes_per_sample *
+				   cache->samples_per_frame *
+				   cache->frames_per_buffer;
+		cache->buf = malloc(bytes_per_buffer);
+		if (cache->buf == NULL)
+			return -ENOMEM;
+		cache->buf_ptr = cache->buf;
+		cache->align_frames = align_frames_in_i;
+	} else if (cache->access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		char **bufs;
+		char **buf_ptrs;
+		int i;
+		bufs = calloc(cache->samples_per_frame * 2, sizeof(*bufs));
+		if (bufs == NULL)
+			return -ENOMEM;
+		buf_ptrs = bufs + cache->samples_per_frame * sizeof(*bufs);
+		for (i = 0; i < cache->samples_per_frame; ++i) {
+			bytes_per_buffer = cache->bytes_per_sample *
+					   cache->frames_per_buffer;
+			bufs[i] = malloc(bytes_per_buffer);
+			if (bufs[i] == NULL)
+				return -ENOMEM;
+			buf_ptrs[i] = bufs[i];
+		}
+		cache->buf = bufs;
+		cache->buf_ptr = buf_ptrs;
+		cache->align_frames = align_frames_in_n;
+	} else {
+		return -ENXIO;
+	}
+
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+		cache->handle = r_process_frames_blocking;
+	else
+		cache->handle = w_process_frames_blocking;
+
+	return 0;
+}
+
+static int irq_rw_process_frames(struct libasound_state *state,
+				unsigned int *frame_count,
+				struct mapper_context *mapper,
+				struct container_context *cntrs)
+{
+	struct frame_cache *cache = state->private_data;
+	snd_pcm_state_t status;
+
+	/* Need to recover the stream. */
+	status = snd_pcm_state(state->handle);
+	if (status != SND_PCM_STATE_RUNNING && status != SND_PCM_STATE_PREPARED)
+		return -EPIPE;
+
+	/* NOTE: Actually, status can be shift always. */
+	return cache->handle(state, status, frame_count, mapper, cntrs);
+}
+
+static void irq_rw_post_process(struct libasound_state *state)
+{
+	struct frame_cache *cache = state->private_data;
+
+	if (cache->buf == NULL) {
+		if (cache->access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+			char **bufs = cache->buf;
+			char **buf_ptrs = cache->buf_ptr;
+			int i;
+			for (i = 0; i < cache->samples_per_frame; ++i) {
+				if (bufs[i])
+					free(bufs[i]);
+				bufs[i] = NULL;
+				buf_ptrs[i] = NULL;
+			}
+			free(cache->buf_ptr);
+		}
+		free(cache->buf);
+	}
+	cache->buf = NULL;
+	cache->buf_ptr = NULL;
+}
+
+const struct xfer_libasound_ops xfer_libasound_irq_rw_ops = {
+	.pre_process	= irq_rw_pre_process,
+	.process_frames	= irq_rw_process_frames,
+	.post_process	= irq_rw_post_process,
+	.private_size	= sizeof(struct frame_cache),
+};
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 0683090c..f4a1f51a 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -48,8 +48,12 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 		node = opts->node;
 
 	err = snd_pcm_open(&state->handle, node, direction, 0);
-	if (err < 0)
+	if (err < 0) {
+		fprintf(stderr,
+			"Fail to open libasound PCM node for %s: %s\n",
+			snd_pcm_stream_name(direction), node);
 		return err;
+	}
 
 	err = snd_pcm_hw_params_malloc(&state->hw_params);
 	if (err < 0)
@@ -215,6 +219,12 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 
 	/* Assign I/O operation. */
+	if (*access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+	    *access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		state->ops = &xfer_libasound_irq_rw_ops;
+	} else {
+		return -ENXIO;
+	}
 	if (state->ops->private_size > 0) {
 		state->private_data = malloc(state->ops->private_size);
 		if (state->private_data == NULL)
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 72807cdd..97b26634 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -42,4 +42,7 @@ struct xfer_libasound_ops {
 	unsigned int private_size;
 };
 
+extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_ops;
+extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
+
 #endif
-- 
2.11.0
