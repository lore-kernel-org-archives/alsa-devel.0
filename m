From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 15/23] aplay: add implementation of I/O
Date: Thu, 17 Aug 2017 20:59:56 +0900
Message-ID: <20170817120004.15326-16-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E10C6266F0E
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:16 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This commit adds I/O implementation for 'mmap' and 'rw' operations.
In 'mmap' operation, a pointer to mapped page frame is given to
'aligner' function to copy file data directly. In 'rw' operations,
this implementation has buffers to cache PCM frames to absorb a case
that requested number of frames are not fully handled.
---
 aplay/Makefile.am         |   4 +-
 aplay/xfer-alsa-io-mmap.c | 134 +++++++++++++++++
 aplay/xfer-alsa-io-rw.c   | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 aplay/xfer-alsa.c         |  12 ++
 aplay/xfer-alsa.h         |   4 +
 5 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 aplay/xfer-alsa-io-mmap.c
 create mode 100644 aplay/xfer-alsa-io-rw.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 9108049..9d5e044 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -35,7 +35,9 @@ aplay_SOURCES = \
 	xfer.h \
 	xfer.c \
 	xfer-alsa.h \
-	xfer-alsa.c
+	xfer-alsa.c \
+	xfer-alsa-io-mmap.c \
+	xfer-alsa-io-rw.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/xfer-alsa-io-mmap.c b/aplay/xfer-alsa-io-mmap.c
new file mode 100644
index 0000000..7ddb880
--- /dev/null
+++ b/aplay/xfer-alsa-io-mmap.c
@@ -0,0 +1,134 @@
+/*
+ * xfer-alsa-io-mmap.c - I/O helper for SND_PCM_ACCESS_MMAP_XXX.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-alsa.h"
+
+static int alsa_mmap_pre_process(struct alsa_state *state)
+{
+	const snd_pcm_channel_area_t *areas;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail = 0;
+	unsigned int samples_per_frame;
+	int i;
+	int err;
+
+	if (state->verbose) {
+		err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset,
+					 &avail);
+		if (err < 0)
+			return err;
+
+		err = snd_pcm_hw_params_get_channels(state->hw_params,
+						     &samples_per_frame);
+		if (err < 0)
+			return err;
+
+		printf("attributes for mapped page frame:\n");
+		for (i = 0; i < samples_per_frame; ++i) {
+			const snd_pcm_channel_area_t *area = areas + i;
+			printf("  sample number: %d\n", i);
+			printf("    address: %p\n", area->addr);
+			printf("    bits for offset: %u\n", area->first);
+			printf("    bits/frame: %u\n", area->step);
+		}
+		printf("\n");
+	}
+	return 0;
+}
+
+static int alsa_mmap_process_frames(struct alsa_state *state,
+				    unsigned *frame_count,
+				    struct aligner_context *aligner,
+				    struct container_context *cntrs)
+{
+	const snd_pcm_channel_area_t *areas;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail;
+	unsigned int avail_count;
+	char *frame_buf;
+	int err;
+
+	/* For capture direction, need to start stream explicitly. */
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+		snd_pcm_state_t s = snd_pcm_state(state->handle);
+		if (s != SND_PCM_STATE_RUNNING) {
+			if (s != SND_PCM_STATE_PREPARED) {
+				err = -EPIPE;
+				goto error;
+			}
+
+			err = snd_pcm_start(state->handle);
+			if (err < 0)
+				goto error;
+		}
+	}
+
+	if (state->waiter) {
+		err = waiter_context_wait_event(state->waiter);
+		if (err < 0)
+			goto error;
+	}
+
+	avail = *frame_count;
+	err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset, &avail);
+	if (err < 0)
+		goto error;
+
+	/* Trim according up to expected frame count. */
+	if (*frame_count < avail)
+		avail_count = *frame_count;
+	else
+		avail_count = (unsigned int)avail;
+
+	frame_buf = areas[0].addr;
+	/* TODO: What's going on non-interleaved buffer??? */
+	frame_buf += snd_pcm_frames_to_bytes(state->handle, frame_offset);
+	err = aligner_context_process_frames(aligner, frame_buf, &avail_count,
+					     cntrs);
+	if (err < 0)
+		goto error;
+	if (avail_count == 0)
+		goto error;
+
+	err = snd_pcm_mmap_commit(state->handle, frame_offset, avail_count);
+	if (err < 0)
+		goto error;
+
+	/* Need to start playback stream explicitly */
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_PLAYBACK) {
+		snd_pcm_state_t s = snd_pcm_state(state->handle);
+		if (s != SND_PCM_STATE_RUNNING) {
+			if (s != SND_PCM_STATE_PREPARED) {
+				err = -EPIPE;
+				goto error;
+			}
+
+			err = snd_pcm_start(state->handle);
+			if (err < 0)
+				goto error;
+		}
+	}
+
+	*frame_count = avail_count;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static void alsa_mmap_post_process(struct alsa_state *state)
+{
+	return;
+}
+
+const struct xfer_alsa_io_ops xfer_alsa_mmap_ops = {
+	.pre_process	= alsa_mmap_pre_process,
+	.process_frames	= alsa_mmap_process_frames,
+	.post_process	= alsa_mmap_post_process,
+};
diff --git a/aplay/xfer-alsa-io-rw.c b/aplay/xfer-alsa-io-rw.c
new file mode 100644
index 0000000..a69d7e0
--- /dev/null
+++ b/aplay/xfer-alsa-io-rw.c
@@ -0,0 +1,368 @@
+/*
+ * xfer-alsa-io-rw.c - I/O helper for SND_PCM_ACCESS_RW_XXX.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-alsa.h"
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
+	void (*align_frames)(struct frame_cache *cache,
+			     unsigned int avail_count,
+			     unsigned int consumed_count,
+			     unsigned int bytes_per_sample,
+			     unsigned int samples_per_frame);
+
+	unsigned int remained_count;
+};
+
+static void align_frames_in_i(struct frame_cache *cache,
+			      unsigned int avail_count,
+			      unsigned int consumed_count,
+			      unsigned int bytes_per_sample,
+			      unsigned int samples_per_frame)
+{
+	char *buf = cache->buf;
+	unsigned int offset;
+	unsigned int size;
+
+	cache->remained_count = avail_count - consumed_count;
+
+	if (cache->remained_count == 0) {
+		cache->buf_ptr = buf;
+	} else {
+		offset = bytes_per_sample * samples_per_frame * consumed_count;
+		size = bytes_per_sample * samples_per_frame *
+		       cache->remained_count;
+		if (offset > 0)
+			memcpy(buf, buf + offset, size);
+		cache->buf_ptr = buf + size;
+	}
+}
+
+static void align_frames_in_n(struct frame_cache *cache,
+			      unsigned int avail_count,
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
+	cache->remained_count = avail_count - consumed_count;
+
+	if (cache->remained_count == 0) {
+		for (i = 0; i < samples_per_frame; ++i)
+			buf_ptrs[i] = bufs[i];
+		return;
+	}
+
+	for (i = 0; i < samples_per_frame; ++i) {
+		buf = bufs[i];
+		offset = bytes_per_sample * consumed_count;
+		size = bytes_per_sample * cache->remained_count;
+		memcpy(buf, buf + offset, size);
+		buf_ptrs[i] = buf + size;
+	}
+}
+
+static int alsa_rw_pre_process(struct alsa_state *state)
+{
+	struct frame_cache *cache = state->io_private_data;
+	snd_pcm_format_t format;
+	snd_pcm_uframes_t frames_per_buffer;
+	uint64_t bytes_per_buffer;
+	int err;
+
+	err = snd_pcm_hw_params_get_format(state->hw_params, &format);
+	if (err < 0)
+		return err;
+	cache->bytes_per_sample = snd_pcm_format_physical_width(format);
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
+	return 0;
+}
+
+static int alsa_r_process_frames(struct alsa_state *state,
+				 unsigned int *frame_count,
+				 struct aligner_context *aligner,
+				 struct container_context *cntrs)
+{
+	struct frame_cache *cache = state->io_private_data;
+	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail_count;
+	unsigned int consumed_count;
+	int err = 0;
+
+	/* In non-blocking mode, work with I/O notifier. */
+	if (state->waiter) {
+		snd_pcm_state_t s = snd_pcm_state(state->handle);
+		if (s != SND_PCM_STATE_RUNNING) {
+			if (s != SND_PCM_STATE_PREPARED) {
+				err = -EPIPE;
+				goto error;
+			}
+
+			err = snd_pcm_start(state->handle);
+			if (err < 0)
+				goto error;
+		}
+
+		err = waiter_context_wait_event(state->waiter);
+		if (err < 0)
+			goto error;
+	}
+
+	/* Check available space on the buffer. */
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (snd_pcm_uframes_t)avail;
+
+	if (avail_count == 0) {
+		/* In non-blocking operation, let's go to a next iteration. */
+		if (state->waiter) {
+			err = -EAGAIN;
+			goto error;
+		}
+
+		/* Prepare for blocking this process till 'avail_min'. */
+		err = snd_pcm_sw_params_get_avail_min(state->sw_params,
+						      &avail_count);
+		if (err < 0)
+			goto error;
+	}
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
+			goto error;
+		cache->remained_count += err;
+		avail_count = cache->remained_count;
+	}
+
+	/* Write out to file descriptors. */
+	consumed_count = avail_count;
+	err = aligner_context_process_frames(aligner, cache->buf,
+					     &consumed_count, cntrs);
+	if (err < 0)
+		goto error;
+	cache->align_frames(cache, cache->remained_count, consumed_count,
+			    cache->bytes_per_sample, cache->samples_per_frame);
+
+	*frame_count = consumed_count;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int alsa_w_process_frames(struct alsa_state *state,
+				 unsigned *frame_count,
+				 struct aligner_context *aligner,
+				 struct container_context *cntrs)
+{
+	struct frame_cache *cache = state->io_private_data;
+	snd_pcm_sframes_t avail;
+	unsigned int avail_count;
+	snd_pcm_uframes_t consumed_count;
+	int err;
+
+	/* In non-blocking mode, work with I/O notifier. */
+	if (state->waiter) {
+		snd_pcm_state_t s = snd_pcm_state(state->handle);
+		/* Need to recover the stream. */
+		if (s != SND_PCM_STATE_RUNNING && s != SND_PCM_STATE_PREPARED) {
+			err = -EPIPE;
+			goto error;
+		}
+
+		err = waiter_context_wait_event(state->waiter);
+		if (err < 0)
+			goto error;
+	}
+
+	/* Check available space on the buffer. */
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (unsigned int)avail;
+
+	if (avail_count == 0) {
+		/* In non-blocking operation, let's go to a next iteration. */
+		if (state->waiter) {
+			err = 0;
+			goto error;
+		}
+
+		if (snd_pcm_state(state->handle) == SND_PCM_STATE_RUNNING) {
+			snd_pcm_uframes_t avail_min;
+			err = snd_pcm_sw_params_get_avail_min(state->sw_params,
+							      &avail_min);
+			if (err < 0)
+				goto error;
+			avail_count = (unsigned int)avail_min;
+		} else {
+			/* NOTE: precisely, start_threshold is important. */
+			avail_count = state->frames_per_buffer;
+		}
+	}
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
+		err = aligner_context_process_frames(aligner, cache->buf_ptr,
+						     &avail_count, cntrs);
+		if (err < 0)
+			goto error;
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
+		goto error;
+	cache->align_frames(cache, cache->remained_count, (unsigned int)err,
+			    cache->bytes_per_sample, cache->samples_per_frame);
+
+	*frame_count = consumed_count;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static void alsa_rw_post_process(struct alsa_state *state)
+{
+	struct frame_cache *cache = state->io_private_data;
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
+
+		}
+		free(cache->buf);
+		free(cache->buf_ptr);
+	}
+	cache->buf = NULL;
+	cache->buf_ptr = NULL;
+}
+
+const struct xfer_alsa_io_ops xfer_alsa_r_ops = {
+	.pre_process	= alsa_rw_pre_process,
+	.process_frames	= alsa_r_process_frames,
+	.post_process	= alsa_rw_post_process,
+	.private_size	= sizeof(struct frame_cache),
+};
+
+const struct xfer_alsa_io_ops xfer_alsa_w_ops = {
+	.pre_process	= alsa_rw_pre_process,
+	.process_frames	= alsa_w_process_frames,
+	.post_process	= alsa_rw_post_process,
+	.private_size	= sizeof(struct frame_cache),
+};
diff --git a/aplay/xfer-alsa.c b/aplay/xfer-alsa.c
index 4a84153..57be488 100644
--- a/aplay/xfer-alsa.c
+++ b/aplay/xfer-alsa.c
@@ -391,6 +391,18 @@ static int xfer_alsa_pre_process(struct xfer_context *xfer,
 		return err;
 
 	/* Assign I/O operation. */
+	if (*access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
+	    *access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		state->io_ops = &xfer_alsa_mmap_ops;
+	} else if (*access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+		   *access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+			state->io_ops = &xfer_alsa_r_ops;
+		else
+			state->io_ops = &xfer_alsa_w_ops;
+	} else {
+		return -ENXIO;
+	}
 	if (state->io_ops->private_size > 0) {
 		state->io_private_data = malloc(state->io_ops->private_size);
 		if (state->io_private_data == NULL)
diff --git a/aplay/xfer-alsa.h b/aplay/xfer-alsa.h
index 10c417b..1731f04 100644
--- a/aplay/xfer-alsa.h
+++ b/aplay/xfer-alsa.h
@@ -54,4 +54,8 @@ struct xfer_alsa_sched_ops {
 	int (*pre_process)(struct xfer_context *xfer);
 };
 
+extern const struct xfer_alsa_io_ops xfer_alsa_mmap_ops;
+extern const struct xfer_alsa_io_ops xfer_alsa_r_ops;
+extern const struct xfer_alsa_io_ops xfer_alsa_w_ops;
+
 #endif
-- 
2.11.0
