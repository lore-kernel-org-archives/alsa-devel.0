From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/35] axfer: add support for blocking data
	transmission operation of alsa-lib PCM API
Date: Tue, 13 Nov 2018 15:41:28 +0900
Message-ID: <20181113064147.13577-16-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FEAF267AE5
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:22 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so64226pls.7
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:22 -0800 (PST)
In-Reply-To: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In alsa-lib PCM API, snd_pcm_read[i|n]() and snd_pcm_write[i|n]() are used
to transfer data frames from/to hardware. When a handler is not opened with
specific flags, these functions perform blocking operation; i.e. the
function call doesn't return till all of request number of data frames are
actually handled, or call is interrupted by Unix signals, or PCM substeam
corrupts due to hardware reasons.

This commit adds support for this type of data transmission. For cases that
requested data frames are not processed by container interface, this commit
adds internal cache mechanism to handle rest of data frames in next timing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am             |   8 +-
 axfer/frame-cache.c           | 111 ++++++++++++
 axfer/frame-cache.h           |  47 ++++++
 axfer/xfer-libasound-irq-rw.c | 307 ++++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.c        |   6 +
 axfer/xfer-libasound.h        |   2 +
 6 files changed, 479 insertions(+), 2 deletions(-)
 create mode 100644 axfer/frame-cache.c
 create mode 100644 axfer/frame-cache.h
 create mode 100644 axfer/xfer-libasound-irq-rw.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 1ec4ab4..07c1fb3 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -20,7 +20,8 @@ noinst_HEADERS = \
 	container.h \
 	mapper.h \
 	xfer.h \
-	xfer-libasound.h
+	xfer-libasound.h \
+	frame-cache.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -41,4 +42,7 @@ axfer_SOURCES = \
 	xfer.c \
 	xfer-options.c \
 	xfer-libasound.h \
-	xfer-libasound.c
+	xfer-libasound.c \
+	frame-cache.h \
+	frame-cache.c \
+	xfer-libasound-irq-rw.c
diff --git a/axfer/frame-cache.c b/axfer/frame-cache.c
new file mode 100644
index 00000000..882568f
--- /dev/null
+++ b/axfer/frame-cache.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// frame-cache.c - maintainer of cache for data frame.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "frame-cache.h"
+
+static void align_frames_in_i(struct frame_cache *cache,
+			      unsigned int consumed_count)
+{
+	char *buf = cache->buf;
+	unsigned int offset;
+	unsigned int size;
+
+	cache->remained_count -= consumed_count;
+
+	offset = cache->bytes_per_sample * cache->samples_per_frame *
+		 consumed_count;
+	size = cache->bytes_per_sample * cache->samples_per_frame *
+	       cache->remained_count;
+	memmove(buf, buf + offset, size);
+
+	cache->buf_ptr = buf + size;
+}
+
+static void align_frames_in_n(struct frame_cache *cache,
+			      unsigned int consumed_count)
+{
+	char **bufs = cache->buf;
+	char **buf_ptrs = cache->buf_ptr;
+	unsigned int offset;
+	unsigned int size;
+	int i;
+
+	cache->remained_count -= consumed_count;
+
+	for (i = 0; i < cache->samples_per_frame; ++i) {
+		offset = cache->bytes_per_sample * consumed_count;
+		size = cache->bytes_per_sample * cache->remained_count;
+		memmove(bufs[i], bufs[i] + offset, size);
+		buf_ptrs[i] = bufs[i] + size;
+	}
+}
+
+int frame_cache_init(struct frame_cache *cache, snd_pcm_access_t access,
+		     unsigned int bytes_per_sample,
+		     unsigned int samples_per_frame,
+		     unsigned int frames_per_cache)
+{
+	if (access == SND_PCM_ACCESS_RW_INTERLEAVED)
+		cache->align_frames = align_frames_in_i;
+	else if (access == SND_PCM_ACCESS_RW_NONINTERLEAVED)
+		cache->align_frames = align_frames_in_n;
+	else
+		return -EINVAL;
+	cache->access = access;
+
+	if (access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+		char *buf;
+
+		buf = calloc(frames_per_cache,
+			     bytes_per_sample * samples_per_frame);
+		if (buf == NULL)
+			return -ENOMEM;
+		cache->buf = buf;
+		cache->buf_ptr = buf;
+	} else {
+		char **bufs;
+		char **buf_ptrs;
+		int i;
+
+		bufs = calloc(samples_per_frame, sizeof(*bufs));
+		if (bufs == NULL)
+			return -ENOMEM;
+		buf_ptrs = calloc(samples_per_frame, sizeof(*buf_ptrs));
+		if (buf_ptrs == NULL)
+			return -ENOMEM;
+		for (i = 0; i < samples_per_frame; ++i) {
+			bufs[i] = calloc(frames_per_cache, bytes_per_sample);
+			if (bufs[i] == NULL)
+				return -ENOMEM;
+			buf_ptrs[i] = bufs[i];
+		}
+		cache->buf = bufs;
+		cache->buf_ptr = buf_ptrs;
+	}
+
+	cache->remained_count = 0;
+	cache->bytes_per_sample = bytes_per_sample;
+	cache->samples_per_frame = samples_per_frame;
+	cache->frames_per_cache = frames_per_cache;
+
+	return 0;
+}
+
+void frame_cache_destroy(struct frame_cache *cache)
+{
+	if (cache->access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		int i;
+		for (i = 0; i < cache->samples_per_frame; ++i) {
+			char **bufs = cache->buf;
+			free(bufs[i]);
+		}
+		free(cache->buf_ptr);
+	}
+	free(cache->buf);
+	memset(cache, 0, sizeof(*cache));
+}
diff --git a/axfer/frame-cache.h b/axfer/frame-cache.h
new file mode 100644
index 00000000..7191333
--- /dev/null
+++ b/axfer/frame-cache.h
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// frame-cache.h - maintainer of cache for data frame.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include <alsa/asoundlib.h>
+
+struct frame_cache {
+	void *buf;
+	void *buf_ptr;
+
+	unsigned int remained_count;
+
+	snd_pcm_access_t access;
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	unsigned int frames_per_cache;
+
+	void (*align_frames)(struct frame_cache *cache,
+			     unsigned int consumed_count);
+};
+
+int frame_cache_init(struct frame_cache *cache, snd_pcm_access_t access,
+		     unsigned int bytes_per_sample,
+		     unsigned int samples_per_frame,
+		     unsigned int frames_per_cache);
+void frame_cache_destroy(struct frame_cache *cache);
+
+static inline unsigned int frame_cache_get_count(struct frame_cache *cache)
+{
+	return cache->remained_count;
+}
+
+static inline void frame_cache_increase_count(struct frame_cache *cache,
+					      unsigned int frame_count)
+{
+	cache->remained_count += frame_count;
+}
+
+static inline void frame_cache_reduce(struct frame_cache *cache,
+				      unsigned int consumed_count)
+{
+	cache->align_frames(cache, consumed_count);
+}
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
new file mode 100644
index 00000000..59634b4
--- /dev/null
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer-libasound-irq-rw.c - IRQ-based scheduling model for read/write operation.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "xfer-libasound.h"
+#include "misc.h"
+#include "frame-cache.h"
+
+struct rw_closure {
+	snd_pcm_access_t access;
+	int (*process_frames)(struct libasound_state *state,
+			      snd_pcm_state_t status, unsigned int *frame_count,
+			      struct mapper_context *mapper,
+		      struct container_context *cntrs);
+	struct frame_cache cache;
+};
+
+static int read_frames(struct libasound_state *state, unsigned int *frame_count,
+		       unsigned int avail_count, struct mapper_context *mapper,
+		       struct container_context *cntrs)
+{
+	struct rw_closure *closure = state->private_data;
+	snd_pcm_sframes_t handled_frame_count;
+	unsigned int consumed_count;
+	int err;
+
+	// Trim according up to expected frame count.
+	if (*frame_count < avail_count)
+		avail_count = *frame_count;
+
+	// Cache required amount of frames.
+	if (avail_count > frame_cache_get_count(&closure->cache)) {
+		avail_count -= frame_cache_get_count(&closure->cache);
+
+		// Execute write operation according to the shape of buffer.
+		// These operations automatically start the substream.
+		if (closure->access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+			handled_frame_count = snd_pcm_readi(state->handle,
+							closure->cache.buf_ptr,
+							avail_count);
+		} else {
+			handled_frame_count = snd_pcm_readn(state->handle,
+							closure->cache.buf_ptr,
+							avail_count);
+		}
+		if (handled_frame_count < 0) {
+			err = handled_frame_count;
+			return err;
+		}
+		frame_cache_increase_count(&closure->cache, handled_frame_count);
+		avail_count = frame_cache_get_count(&closure->cache);
+	}
+
+	// Write out to file descriptors.
+	consumed_count = avail_count;
+	err = mapper_context_process_frames(mapper, closure->cache.buf,
+					    &consumed_count, cntrs);
+	if (err < 0)
+		return err;
+
+	frame_cache_reduce(&closure->cache, consumed_count);
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
+		// Check available space on the buffer.
+		avail = snd_pcm_avail(state->handle);
+		if (avail < 0) {
+			err = avail;
+			goto error;
+		}
+		avail_count = (snd_pcm_uframes_t)avail;
+
+		if (avail_count == 0) {
+			// Request data frames so that blocking is just
+			// released.
+			err = snd_pcm_sw_params_get_avail_min(state->sw_params,
+							      &avail_count);
+			if (err < 0)
+				goto error;
+		}
+	} else {
+		// Request data frames so that the PCM substream starts.
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
+	struct rw_closure *closure = state->private_data;
+	snd_pcm_uframes_t consumed_count;
+	snd_pcm_sframes_t handled_frame_count;
+	int err;
+
+	// Trim according up to expected frame count.
+	if (*frame_count < avail_count)
+		avail_count = *frame_count;
+
+	// Cache required amount of frames.
+	if (avail_count > frame_cache_get_count(&closure->cache)) {
+		avail_count -= frame_cache_get_count(&closure->cache);
+
+		// Read frames to transfer.
+		err = mapper_context_process_frames(mapper,
+				closure->cache.buf_ptr, &avail_count, cntrs);
+		if (err < 0)
+			return err;
+		frame_cache_increase_count(&closure->cache, avail_count);
+		avail_count = frame_cache_get_count(&closure->cache);
+	}
+
+	// Execute write operation according to the shape of buffer. These
+	// operations automatically start the stream.
+	consumed_count = avail_count;
+	if (closure->access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+		handled_frame_count = snd_pcm_writei(state->handle,
+					closure->cache.buf, consumed_count);
+	} else {
+		handled_frame_count = snd_pcm_writen(state->handle,
+					closure->cache.buf, consumed_count);
+	}
+	if (handled_frame_count < 0) {
+		err = handled_frame_count;
+		return err;
+	}
+
+	consumed_count = handled_frame_count;
+	frame_cache_reduce(&closure->cache, consumed_count);
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
+		// Check available space on the buffer.
+		avail = snd_pcm_avail(state->handle);
+		if (avail < 0) {
+			err = avail;
+			goto error;
+		}
+		avail_count = (unsigned int)avail;
+
+		if (avail_count == 0) {
+			// Fill with data frames so that blocking is just
+			// released.
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
+		// Fill with data frames so that the PCM substream starts.
+		err = snd_pcm_sw_params_get_start_threshold(state->sw_params,
+						&frames_for_start_threshold);
+		if (err < 0)
+			goto error;
+
+		// But the above number can be too small and cause XRUN because
+		// I/O operation is done per period.
+		err = snd_pcm_hw_params_get_period_size(state->hw_params,
+						&frames_per_period, NULL);
+		if (err < 0)
+			goto error;
+
+		// Use larger one to prevent from both of XRUN and successive
+		// blocking.
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
+	struct rw_closure *closure = state->private_data;
+	snd_pcm_format_t format;
+	snd_pcm_uframes_t frames_per_buffer;
+	int bytes_per_sample;
+	unsigned int samples_per_frame;
+	int err;
+
+	err = snd_pcm_hw_params_get_format(state->hw_params, &format);
+	if (err < 0)
+		return err;
+	bytes_per_sample = snd_pcm_format_physical_width(format) / 8;
+	if (bytes_per_sample <= 0)
+		return -ENXIO;
+
+	err = snd_pcm_hw_params_get_channels(state->hw_params,
+					     &samples_per_frame);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_buffer_size(state->hw_params,
+						&frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_access(state->hw_params, &closure->access);
+	if (err < 0)
+		return err;
+
+	err = frame_cache_init(&closure->cache, closure->access,
+			       bytes_per_sample, samples_per_frame,
+			       frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+		closure->process_frames = r_process_frames_blocking;
+	else
+		closure->process_frames = w_process_frames_blocking;
+
+	return 0;
+}
+
+static int irq_rw_process_frames(struct libasound_state *state,
+				unsigned int *frame_count,
+				struct mapper_context *mapper,
+				struct container_context *cntrs)
+{
+	struct rw_closure *closure = state->private_data;
+	snd_pcm_state_t status;
+
+	// Need to recover the stream.
+	status = snd_pcm_state(state->handle);
+	if (status != SND_PCM_STATE_RUNNING && status != SND_PCM_STATE_PREPARED)
+		return -EPIPE;
+
+	// NOTE: Actually, status can be shift always.
+	return closure->process_frames(state, status, frame_count, mapper, cntrs);
+}
+
+static void irq_rw_post_process(struct libasound_state *state)
+{
+	struct rw_closure *closure = state->private_data;
+
+	frame_cache_destroy(&closure->cache);
+}
+
+const struct xfer_libasound_ops xfer_libasound_irq_rw_ops = {
+	.pre_process	= irq_rw_pre_process,
+	.process_frames	= irq_rw_process_frames,
+	.post_process	= irq_rw_post_process,
+	.private_size	= sizeof(struct rw_closure),
+};
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 2bca465..bf1b056 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -251,6 +251,12 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 		return err;
 
 	// Assign I/O operation.
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
index 57fa867..3f3ae6e 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -43,4 +43,6 @@ struct xfer_libasound_ops {
 	unsigned int private_size;
 };
 
+extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
+
 #endif
-- 
2.19.1
