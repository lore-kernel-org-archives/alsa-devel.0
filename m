From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv2][PATCH 25/38] axfer: add support for MMAP PCM
	operation
Date: Tue, 19 Sep 2017 09:44:05 +0900
Message-ID: <20170919004418.24668-26-o-takashi@sakamocchi.jp>
References: <20170919004418.24668-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 1A04B266EBE
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

In alsa-lib PCM API, data frames can be handled in mapped page frame,
instead of calling any system calls.

This commit support for this type of operation. To reduce CPU usage,
added waiter interface is used for event notification.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am               |   3 +-
 axfer/options.c                 |  12 ++-
 axfer/options.h                 |   1 +
 axfer/xfer-libasound-irq-mmap.c | 216 ++++++++++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.c          |  22 +++-
 axfer/xfer-libasound.h          |   4 +-
 6 files changed, 252 insertions(+), 6 deletions(-)
 create mode 100644 axfer/xfer-libasound-irq-mmap.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index a4e9f1bc..79592bc8 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -49,4 +49,5 @@ axfer_SOURCES = \
 	subcmd-transfer.c \
 	waiter.h \
 	waiter.c \
-	waiter-poll.c
+	waiter-poll.c \
+	xfer-libasound-irq-mmap.c
diff --git a/axfer/options.c b/axfer/options.c
index 5863824c..1433e458 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -265,6 +265,13 @@ static int apply_policies(struct context_options *opts,
 			return err;
 	}
 
+	if (opts->mmap && opts->nonblock) {
+		fprintf(stderr,
+			"An option for mmap operation should not be used with "
+			"nonblocking option.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -289,7 +296,7 @@ void context_options_calculate_duration(struct context_options *opts,
 int context_options_init(struct context_options *opts, int argc,
 			 char *const *argv, snd_pcm_stream_t direction)
 {
-	static const char *s_opts = "hvqd:s:t:ID:f:c:r:N";
+	static const char *s_opts = "hvqd:s:t:ID:f:c:r:NM";
 	static const struct option l_opts[] = {
 		/* For generic purposes. */
 		{"help",		0, 0, 'h'},
@@ -307,6 +314,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"channels",		1, 0, 'c'},
 		{"rate",		1, 0, 'r'},
 		{"nonblock",            0, 0, 'N'},
+		{"mmap",                0, 0, 'M'},
 		/* For debugging. */
 		{"dump-hw-params",	0, 0, OPT_DUMP_HW_PARAMS},
 		{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
@@ -351,6 +359,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->frames_per_second = parse_l(optarg, &err);
 		else if (c == 'N')
 			opts->nonblock = true;
+		else if (c == 'M')
+			opts->mmap = true;
 		else if (c == OPT_DUMP_HW_PARAMS)
 			opts->dump_hw_params = true;
 		else if (c == OPT_FATAL_ERRORS)
diff --git a/axfer/options.h b/axfer/options.h
index fc4f03c1..272ce9b9 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -34,6 +34,7 @@ struct context_options {
 	unsigned int samples_per_frame;
 	unsigned int frames_per_second;
 	bool nonblock;
+	bool mmap;
 
 	/* For debugging. */
 	bool dump_hw_params;
diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
new file mode 100644
index 00000000..b2fb9a58
--- /dev/null
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -0,0 +1,216 @@
+/*
+ * xfer-libasound-io-mmap.c - I/O helper for SND_PCM_ACCESS_MMAP_XXX.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-libasound.h"
+#include "misc.h"
+
+struct map_layout {
+	char **vector;
+	unsigned int samples_per_frame;
+};
+
+static int irq_mmap_pre_process(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_access_t access;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail = 0;
+	int i;
+	int err;
+
+	err = snd_pcm_hw_params_get_access(state->hw_params, &access);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_params_get_channels(state->hw_params,
+					     &layout->samples_per_frame);
+	if (err < 0)
+		return err;
+
+	if (access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		layout->vector = calloc(layout->samples_per_frame,
+					sizeof(*layout->vector));
+		if (layout->vector == NULL)
+			return err;
+	}
+
+	if (state->verbose) {
+		const snd_pcm_channel_area_t *areas;
+		err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset,
+					 &avail);
+		if (err < 0)
+			return err;
+
+		logging(state, "attributes for mapped page frame:\n");
+		for (i = 0; i < layout->samples_per_frame; ++i) {
+			const snd_pcm_channel_area_t *area = areas + i;
+
+			logging(state, "  sample number: %d\n", i);
+			logging(state, "    address: %p\n", area->addr);
+			logging(state, "    bits for offset: %u\n", area->first);
+			logging(state, "    bits/frame: %u\n", area->step);
+		}
+		logging(state, "\n");
+	}
+
+	return 0;
+}
+
+static int irq_mmap_process_frames(struct libasound_state *state,
+				   unsigned int *frame_count,
+				   struct mapper_context *mapper,
+				   struct container_context *cntrs)
+{
+	struct map_layout *layout = state->private_data;
+	const snd_pcm_channel_area_t *areas;
+	snd_pcm_uframes_t frame_offset;
+	snd_pcm_uframes_t avail;
+	unsigned int avail_count;
+	void *frame_buf;
+	snd_pcm_sframes_t consumed_count;
+	int err;
+
+	err = waiter_context_wait_event(state->waiter, -1);
+	if (err < 0)
+		goto error;
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
+	/*
+	 * TODO: Perhaps, the complex layout can be supported as a variation of
+	 * vector type. However, there's no driver with this layout.
+	 */
+	if (layout->vector == NULL) {
+		frame_buf = areas[0].addr;
+		frame_buf += snd_pcm_frames_to_bytes(state->handle,
+						     frame_offset);
+	} else {
+		int i;
+		for (i = 0; i < layout->samples_per_frame; ++i) {
+			layout->vector[i] = areas[i].addr;
+			layout->vector[i] += snd_pcm_samples_to_bytes(
+						state->handle, frame_offset);
+		}
+		frame_buf = layout->vector;
+	}
+
+	err = mapper_context_process_frames(mapper, frame_buf, &avail_count,
+					     cntrs);
+	if (err < 0)
+		goto error;
+	if (avail_count == 0)
+		goto error;
+
+	consumed_count = snd_pcm_mmap_commit(state->handle, frame_offset,
+					     avail_count);
+	if (consumed_count < 0) {
+		err = consumed_count;
+		goto error;
+	}
+	if (consumed_count != avail_count)
+		logging(state, "A bug of access plugin for this PCM node.\n");
+
+	*frame_count = consumed_count;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int irq_mmap_r_process_frames(struct libasound_state *state,
+				     unsigned *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	int err;
+
+	/* For capture direction, need to start stream explicitly. */
+	snd_pcm_state_t s = snd_pcm_state(state->handle);
+	if (s != SND_PCM_STATE_RUNNING) {
+		if (s != SND_PCM_STATE_PREPARED) {
+			err = -EPIPE;
+			goto error;
+		}
+
+		err = snd_pcm_start(state->handle);
+		if (err < 0)
+			goto error;
+	}
+
+	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static int irq_mmap_w_process_frames(struct libasound_state *state,
+				     unsigned *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	int err;
+
+	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	/* Need to start playback stream explicitly */
+	snd_pcm_state_t s = snd_pcm_state(state->handle);
+	if (s != SND_PCM_STATE_RUNNING) {
+		if (s != SND_PCM_STATE_PREPARED) {
+			err = -EPIPE;
+			goto error;
+		}
+
+		err = snd_pcm_start(state->handle);
+		if (err < 0)
+			goto error;
+	}
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
+static void irq_mmap_post_process(struct libasound_state *state)
+{
+	struct map_layout *layout = state->private_data;
+
+	if (layout->vector)
+		free(layout->vector);
+	layout->vector = NULL;
+}
+
+const struct xfer_libasound_ops xfer_libasound_irq_mmap_w_ops = {
+	.pre_process	= irq_mmap_pre_process,
+	.process_frames	= irq_mmap_w_process_frames,
+	.post_process	= irq_mmap_post_process,
+	.private_size	= sizeof(struct map_layout),
+};
+
+const struct xfer_libasound_ops xfer_libasound_irq_mmap_r_ops = {
+	.pre_process	= irq_mmap_pre_process,
+	.process_frames	= irq_mmap_r_process_frames,
+	.post_process	= irq_mmap_post_process,
+	.private_size	= sizeof(struct map_layout),
+};
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 9d6c0bd6..0bc4f93e 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -30,8 +30,15 @@ static int set_access_hw_param(snd_pcm_t *handle,
 	if (err < 0)
 		return err;
 	snd_pcm_access_mask_none(mask);
-	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
-	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	if (opts->mmap) {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
+		snd_pcm_access_mask_set(mask,
+					SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
+	} else {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
+		snd_pcm_access_mask_set(mask,
+					SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	}
 	err = snd_pcm_hw_params_set_access_mask(handle, hw_params, mask);
 	snd_pcm_access_mask_free(mask);
 
@@ -69,7 +76,7 @@ static int xfer_libasound_init(struct xfer_context *xfer,
 	}
 
 	state->nonblock = !!(mode & SND_PCM_NONBLOCK);
-	if (opts->nonblock) {
+	if (opts->nonblock || opts->mmap) {
 		state->waiter = malloc(sizeof(*state->waiter));
 		if (state->waiter == NULL)
 			return -ENOMEM;
@@ -291,6 +298,12 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 	if (*access == SND_PCM_ACCESS_RW_INTERLEAVED ||
 	    *access == SND_PCM_ACCESS_RW_NONINTERLEAVED) {
 		state->ops = &xfer_libasound_irq_rw_ops;
+	} else if (*access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
+		   *access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
+			state->ops = &xfer_libasound_irq_mmap_r_ops;
+		else
+			state->ops = &xfer_libasound_irq_mmap_w_ops;
 	} else {
 		return -ENXIO;
 	}
@@ -433,6 +446,9 @@ static void xfer_libasound_post_process(struct xfer_context *xfer)
 	if (state->private_data)
 		free(state->private_data);
 	state->private_data = NULL;
+
+	if (state->waiter)
+		waiter_context_release(state->waiter);
 }
 
 static void xfer_libasound_destroy(struct xfer_context *xfer)
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 342651d1..d0771f8a 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -47,7 +47,9 @@ struct xfer_libasound_ops {
 	unsigned int private_size;
 };
 
-extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_ops;
 extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
 
+extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_r_ops;
+extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_w_ops;
+
 #endif
-- 
2.11.0
