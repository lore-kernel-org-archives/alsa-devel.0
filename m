From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/35] axfer: add support for a mapper for
	multiple target
Date: Tue, 13 Nov 2018 15:41:23 +0900
Message-ID: <20181113064147.13577-11-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id A4FD6267AB1
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:13 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so5522175plp.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:13 -0800 (PST)
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

This commit adds support of mapper for 'multiple' target. This handles
several files via 'container' functions, and constructs data frame buffer
for playback, or splits data frames from data frame buffer for capture.
When playback source files includes data frames with several channels, the
first channel is used to construct buffer. For capture direction, each of
channel of data frame is stored in one file, thus the file includes one
channel of data frame. When handling non-interleaved buffer, a caller
should use an array of buffer for each of channels with non-interleaved
data frames.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am       |   3 +-
 axfer/mapper-multiple.c | 259 ++++++++++++++++++++++++++++++++++++++++
 axfer/mapper.c          |  13 ++
 axfer/mapper.h          |   4 +
 4 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 axfer/mapper-multiple.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index baf9b89..f17e59b 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -33,4 +33,5 @@ axfer_SOURCES = \
 	container-raw.c \
 	mapper.h \
 	mapper.c \
-	mapper-single.c
+	mapper-single.c \
+	mapper-multiple.c
diff --git a/axfer/mapper-multiple.c b/axfer/mapper-multiple.c
new file mode 100644
index 00000000..a0978b9
--- /dev/null
+++ b/axfer/mapper-multiple.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mapper-multiple.c - a muxer/demuxer for multiple containers.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "mapper.h"
+#include "misc.h"
+
+struct multiple_state {
+	void (*align_frames)(void *frame_buf, unsigned int frame_count,
+			     char **buf, unsigned int bytes_per_sample,
+			     struct container_context *cntrs,
+			     unsigned int cntr_count);
+	char **bufs;
+	unsigned int cntr_count;
+};
+
+static void align_to_i(void *frame_buf, unsigned int frame_count,
+		       char **src_bufs, unsigned int bytes_per_sample,
+		       struct container_context *cntrs, unsigned int cntr_count)
+{
+	char *dst = frame_buf;
+	char *src;
+	unsigned int dst_pos;
+	unsigned int src_pos;
+	struct container_context *cntr;
+	int i, j;
+
+	// src: first channel in each of interleaved buffers in containers =>
+	// dst:interleaved.
+	for (i = 0; i < cntr_count; ++i) {
+		src = src_bufs[i];
+		cntr = cntrs + i;
+
+		for (j = 0; j < frame_count; ++j) {
+			// Use first src channel for each of dst channel.
+			src_pos = bytes_per_sample * cntr->samples_per_frame * j;
+			dst_pos = bytes_per_sample * (cntr_count * j + i);
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static void align_from_i(void *frame_buf, unsigned int frame_count,
+			 char **dst_bufs, unsigned int bytes_per_sample,
+			 struct container_context *cntrs,
+			 unsigned int cntr_count)
+{
+	char *src = frame_buf;
+	char *dst;
+	unsigned int src_pos;
+	unsigned int dst_pos;
+	struct container_context *cntr;
+	int i, j;
+
+	for (i = 0; i < cntr_count; ++i) {
+		dst = dst_bufs[i];
+		cntr = cntrs + i;
+
+		for (j = 0; j < frame_count; ++j) {
+			// Use first src channel for each of dst channel.
+			src_pos = bytes_per_sample * (cntr_count * j + i);
+			dst_pos = bytes_per_sample * cntr->samples_per_frame * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static int multiple_pre_process(struct mapper_context *mapper,
+				struct container_context *cntrs,
+				unsigned int cntr_count)
+{
+	struct multiple_state *state = mapper->private_data;
+	struct container_context *cntr;
+	int i;
+
+	// Additionally, format of samples in the containers should be the same
+	// as the format in PCM substream.
+	for (i = 0; i < cntr_count; ++i) {
+		cntr = cntrs + i;
+		if (mapper->bytes_per_sample != cntr->bytes_per_sample)
+			return -EINVAL;
+	}
+	state->cntr_count = cntr_count;
+
+	// Decide method to align frames.
+	if (mapper->type == MAPPER_TYPE_DEMUXER) {
+		if (mapper->access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+		    mapper->access == SND_PCM_ACCESS_MMAP_INTERLEAVED)
+			state->align_frames = align_from_i;
+		else if (mapper->access == SND_PCM_ACCESS_RW_NONINTERLEAVED ||
+			 mapper->access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			state->align_frames = NULL;
+		else
+			return -EINVAL;
+	} else {
+		if (mapper->access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+		    mapper->access == SND_PCM_ACCESS_MMAP_INTERLEAVED)
+			state->align_frames = align_to_i;
+		else if (mapper->access == SND_PCM_ACCESS_RW_NONINTERLEAVED ||
+			 mapper->access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			state->align_frames = NULL;
+		else
+			return -EINVAL;
+	}
+
+	if (state->align_frames) {
+		// Furthermore, in demuxer case, each container should be
+		// configured to store one sample per frame.
+		if (mapper->type == MAPPER_TYPE_DEMUXER) {
+			for (i = 0; i < cntr_count; ++i) {
+				cntr = cntrs + i;
+				if (cntrs->samples_per_frame != 1)
+					return -EINVAL;
+			}
+		}
+
+		state->bufs = calloc(cntr_count, sizeof(char *));
+		if (state->bufs == NULL)
+			return -ENOMEM;
+
+		for (i = 0; i < cntr_count; ++i) {
+			unsigned int bytes_per_buffer;
+
+			// Allocate intermediate buffer as the same size as a
+			// period for each of containers.
+			cntr = cntrs + i;
+
+			bytes_per_buffer = mapper->bytes_per_sample *
+					   cntr->samples_per_frame *
+					   mapper->frames_per_buffer;
+
+			state->bufs[i] = malloc(bytes_per_buffer);
+			if (state->bufs[i] == NULL)
+				return -ENOMEM;
+			memset(state->bufs[i], 0, bytes_per_buffer);
+		}
+	}
+
+	return 0;
+}
+
+static int process_containers(char **src_bufs, unsigned int *frame_count,
+			      struct container_context *cntrs,
+			      unsigned int cntr_count)
+{
+	struct container_context *cntr;
+	char *src;
+	int i;
+	int err = 0;
+
+	// TODO: arrangement for *frame_count.
+	for (i = 0; i < cntr_count; ++i) {
+		cntr = &cntrs[i];
+		src = src_bufs[i];
+
+		err = container_context_process_frames(cntr, src, frame_count);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+static int multiple_muxer_process_frames(struct mapper_context *mapper,
+					 void *frame_buf,
+					 unsigned int *frame_count,
+					 struct container_context *cntrs,
+					 unsigned int cntr_count)
+{
+	struct multiple_state *state = mapper->private_data;
+	char **src_bufs;
+	int err;
+
+	// If need to align PCM frames, process PCM frames to the intermediate
+	// buffer once.
+	if (!state->align_frames) {
+		// The most likely.
+		src_bufs = frame_buf;
+	} else {
+		src_bufs = state->bufs;
+	}
+	err = process_containers(src_bufs, frame_count, cntrs, cntr_count);
+	if (err < 0)
+		return err;
+
+	// Unlikely.
+	if (src_bufs != frame_buf && *frame_count > 0) {
+		state->align_frames(frame_buf, *frame_count, src_bufs,
+				    mapper->bytes_per_sample, cntrs,
+				    cntr_count);
+	}
+
+	return 0;
+}
+
+static int multiple_demuxer_process_frames(struct mapper_context *mapper,
+					   void *frame_buf,
+					   unsigned int *frame_count,
+					   struct container_context *cntrs,
+					   unsigned int cntr_count)
+{
+	struct multiple_state *state = mapper->private_data;
+	char **dst_bufs;
+
+	// If need to align PCM frames, process PCM frames to the intermediate
+	// buffer once.
+	if (!state->align_frames) {
+		// The most likely.
+		dst_bufs = frame_buf;
+	} else {
+		dst_bufs = state->bufs;
+		state->align_frames(frame_buf, *frame_count, dst_bufs,
+				    mapper->bytes_per_sample, cntrs,
+				    cntr_count);
+	}
+
+	return process_containers(dst_bufs, frame_count, cntrs, cntr_count);
+}
+
+static void multiple_post_process(struct mapper_context *mapper)
+{
+	struct multiple_state *state = mapper->private_data;
+	int i;
+
+	if (state->bufs) {
+		for (i = 0; i < state->cntr_count; ++i) {
+			if (state->bufs[i])
+				free(state->bufs[i]);
+		}
+		free(state->bufs);
+	}
+
+	state->bufs = NULL;
+	state->align_frames = NULL;
+}
+
+const struct mapper_data mapper_muxer_multiple = {
+	.ops = {
+		.pre_process = multiple_pre_process,
+		.process_frames = multiple_muxer_process_frames,
+		.post_process = multiple_post_process,
+	},
+	.private_size = sizeof(struct multiple_state),
+};
+
+const struct mapper_data mapper_demuxer_multiple = {
+	.ops = {
+		.pre_process = multiple_pre_process,
+		.process_frames = multiple_demuxer_process_frames,
+		.post_process = multiple_post_process,
+	},
+	.private_size = sizeof(struct multiple_state),
+};
diff --git a/axfer/mapper.c b/axfer/mapper.c
index 07ca595..4c3f0e3 100644
--- a/axfer/mapper.c
+++ b/axfer/mapper.c
@@ -19,6 +19,7 @@ static const char *const mapper_type_labels[] = {
 
 static const char *const mapper_target_labels[] = {
 	[MAPPER_TARGET_SINGLE] = "single",
+	[MAPPER_TARGET_MULTIPLE] = "multiple",
 };
 
 int mapper_context_init(struct mapper_context *mapper,
@@ -39,11 +40,17 @@ int mapper_context_init(struct mapper_context *mapper,
 		if (cntr_count == 1) {
 			data = &mapper_muxer_single;
 			mapper->target = MAPPER_TARGET_SINGLE;
+		} else {
+			data = &mapper_muxer_multiple;
+			mapper->target = MAPPER_TARGET_MULTIPLE;
 		}
 	} else {
 		if (cntr_count == 1) {
 			data = &mapper_demuxer_single;
 			mapper->target = MAPPER_TARGET_SINGLE;
+		} else {
+			data = &mapper_demuxer_multiple;
+			mapper->target = MAPPER_TARGET_MULTIPLE;
 		}
 	}
 
@@ -77,6 +84,12 @@ int mapper_context_pre_process(struct mapper_context *mapper,
 	assert(samples_per_frame > 0);
 	assert(cntrs);
 
+	// The purpose of multiple target is to mux/demux each channels to/from
+	// containers.
+	if (mapper->target == MAPPER_TARGET_MULTIPLE &&
+	    samples_per_frame != mapper->cntr_count)
+		return -EINVAL;
+
 	mapper->access = access;
 	mapper->bytes_per_sample = bytes_per_sample;
 	mapper->samples_per_frame = samples_per_frame;
diff --git a/axfer/mapper.h b/axfer/mapper.h
index 3a95d9f..58b6118 100644
--- a/axfer/mapper.h
+++ b/axfer/mapper.h
@@ -20,6 +20,7 @@ enum mapper_type {
 
 enum mapper_target {
 	MAPPER_TARGET_SINGLE = 0,
+	MAPPER_TARGET_MULTIPLE,
 	MAPPER_TARGET_COUNT,
 };
 
@@ -80,4 +81,7 @@ struct mapper_data {
 extern const struct mapper_data mapper_muxer_single;
 extern const struct mapper_data mapper_demuxer_single;
 
+extern const struct mapper_data mapper_muxer_multiple;
+extern const struct mapper_data mapper_demuxer_multiple;
+
 #endif
-- 
2.19.1
