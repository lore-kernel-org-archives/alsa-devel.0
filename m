From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/35] axfer: add support for MMAP PCM operation
Date: Tue, 13 Nov 2018 15:41:35 +0900
Message-ID: <20181113064147.13577-23-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id EDEA1267B5C
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:34 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id z11so2594128pgu.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:34 -0800 (PST)
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

In alsa-lib PCM API, data frames can be handled in mapped page frame,
instead of calling any system calls.

This commit support for this type of operation. To reduce CPU usage,
this commit uses 'snd_pcm_wait()' to wait for event notification.

Below lines are examples to execute:
$ axfer transfer -M -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer -M -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am               |   3 +-
 axfer/xfer-libasound-irq-mmap.c | 268 ++++++++++++++++++++++++++++++++
 axfer/xfer-libasound.c          |  27 +++-
 axfer/xfer-libasound.h          |   4 +
 4 files changed, 298 insertions(+), 4 deletions(-)
 create mode 100644 axfer/xfer-libasound-irq-mmap.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 386f8e2..960811e 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -46,4 +46,5 @@ axfer_SOURCES = \
 	frame-cache.h \
 	frame-cache.c \
 	xfer-libasound-irq-rw.c \
-	subcmd-transfer.c
+	subcmd-transfer.c \
+	xfer-libasound-irq-mmap.c
diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
new file mode 100644
index 00000000..87ef7e0
--- /dev/null
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer-libasound-irq-mmap.c - IRQ-based scheduling model for mmap operation.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "xfer-libasound.h"
+#include "misc.h"
+
+struct map_layout {
+	snd_pcm_status_t *status;
+
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
+	err = snd_pcm_status_malloc(&layout->status);
+	if (err < 0)
+		return err;
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
+	// Wait for hardware IRQ when no avail space in buffer.
+	err = snd_pcm_wait(state->handle, -1);
+	if (err < 0)
+		return err;
+
+	// Sync cache in user space to data in kernel space to calculate avail
+	// frames according to the latest positions on PCM buffer.
+	//
+	// This has an additional advantage to handle libasound PCM plugins.
+	// Most of libasound PCM plugins perform resampling in .avail_update()
+	// callback for capture PCM substream, then update positions on buffer.
+	//
+	// MEMO: either snd_pcm_avail_update() and snd_pcm_mmap_begin() can
+	// return the same number of available frames.
+	avail = snd_pcm_avail_update(state->handle);
+	if (avail < 0)
+		return (int)avail;
+	if (*frame_count < avail)
+		avail = *frame_count;
+
+	err = snd_pcm_mmap_begin(state->handle, &areas, &frame_offset, &avail);
+	if (err < 0)
+		return err;
+
+	// Trim according up to expected frame count.
+	if (*frame_count < avail)
+		avail_count = *frame_count;
+	else
+		avail_count = (unsigned int)avail;
+
+	// TODO: Perhaps, the complex layout can be supported as a variation of
+	// vector type. However, there's no driver with this layout.
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
+					    cntrs);
+	if (err < 0)
+		return err;
+	if (avail_count == 0) {
+		*frame_count = 0;
+		return 0;
+	}
+
+	consumed_count = snd_pcm_mmap_commit(state->handle, frame_offset,
+					     avail_count);
+	if (consumed_count < 0)
+		return (int)consumed_count;
+	if (consumed_count != avail_count)
+		logging(state, "A bug of access plugin for this PCM node.\n");
+
+	*frame_count = consumed_count;
+
+	return 0;
+}
+
+static int irq_mmap_r_process_frames(struct libasound_state *state,
+				     unsigned *frame_count,
+				     struct mapper_context *mapper,
+				     struct container_context *cntrs)
+{
+	struct map_layout *layout = state->private_data;
+	snd_pcm_state_t s;
+	int err;
+
+	// To querying current status of hardware, we need to care of
+	// synchronization between 3 levels:
+	//  1. status to actual hardware by driver.
+	//  2. status data in kernel space.
+	//  3. status data in user space.
+	//
+	// Kernel driver query 1 and sync 2, according to requests of some
+	// ioctl(2) commands. For synchronization between 2 and 3, ALSA PCM core
+	// supports mmap(2) operation on cache coherent architectures, some
+	// ioctl(2) commands on cache incoherent architecture. In usage of the
+	// former mechanism, we need to care of concurrent access by IRQ context
+	// and process context to the mapped page frame.
+	// In a call of ioctl(2) with SNDRV_PCM_IOCTL_STATUS and
+	// SNDRV_PCM_IOCTL_STATUS_EXT, the above care is needless because
+	// mapped page frame is unused regardless of architectures in a point of
+	// cache coherency.
+	err = snd_pcm_status(state->handle, layout->status);
+	if (err < 0)
+		goto error;
+	s = snd_pcm_status_get_state(layout->status);
+
+	// TODO: if reporting something, do here with the status data.
+
+	// For capture direction, need to start stream explicitly.
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
+	struct map_layout *layout = state->private_data;
+	snd_pcm_state_t s;
+	int err;
+
+	// Read my comment in 'irq_mmap_r_process_frames().
+	err = snd_pcm_status(state->handle, layout->status);
+	if (err < 0)
+		goto error;
+	s = snd_pcm_status_get_state(layout->status);
+
+	// TODO: if reporting something, do here with the status data.
+
+	err = irq_mmap_process_frames(state, frame_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	// Need to start playback stream explicitly
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
+	if (layout->status)
+		snd_pcm_status_free(layout->status);
+	layout->status = NULL;
+
+	free(layout->vector);
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
index cb26b69..c2e1282 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -14,10 +14,11 @@ enum no_short_opts {
 	OPT_FATAL_ERRORS = 200,
 };
 
-#define S_OPTS	"D:N"
+#define S_OPTS	"D:NM"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
 	{"nonblock",		0, 0, 'N'},
+	{"mmap",		0, 0, 'M'},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 };
@@ -49,6 +50,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->node_literal = arg_duplicate_string(optarg, &err);
 	else if (key == 'N')
 		state->nonblock = true;
+	else if (key == 'M')
+		state->mmap = true;
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else
@@ -70,6 +73,13 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 			return -ENOMEM;
 	}
 
+	if (state->mmap && state->nonblock) {
+		fprintf(stderr,
+			"An option for mmap operation should not be used with "
+			"nonblocking option.\n");
+		return -EINVAL;
+	}
+
 	return err;
 }
 
@@ -82,8 +92,13 @@ static int set_access_hw_param(struct libasound_state *state)
 	if (err < 0)
 		return err;
 	snd_pcm_access_mask_none(mask);
-	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
-	snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	if (state->mmap) {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
+	} else {
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_INTERLEAVED);
+		snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	}
 	err = snd_pcm_hw_params_set_access_mask(state->handle, state->hw_params,
 						mask);
 	snd_pcm_access_mask_free(mask);
@@ -279,6 +294,12 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
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
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 6656aeb..550b1c2 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -32,6 +32,7 @@ struct libasound_state {
 
 	bool finish_at_xrun:1;
 	bool nonblock:1;
+	bool mmap:1;
 };
 
 // For internal use in 'libasound' module.
@@ -48,4 +49,7 @@ struct xfer_libasound_ops {
 
 extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
 
+extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_r_ops;
+extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_w_ops;
+
 #endif
-- 
2.19.1
