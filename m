From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/35] axfer: add support for a mapper for
	single target
Date: Tue, 13 Nov 2018 15:41:22 +0900
Message-ID: <20181113064147.13577-10-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05120267ABF
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:11 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id p6-v6so5520420pll.4
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:11 -0800 (PST)
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

In usual use case of aplay, single file is used to playback or capture data
frames.

This commit adds support of single type mapper for this use case. All of
supported file format can include data frame with interleaved alignment,
thus this mapper have a functionality to convert from several types of
data frame alignment to interleaved alignment or vise versa. When
handling non-interleaved buffer, a caller should use an array of buffer
for each of channels with non-interleaved data frames.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am     |   3 +-
 axfer/mapper-single.c | 191 ++++++++++++++++++++++++++++++++++++++++++
 axfer/mapper.c        |  14 +++-
 axfer/mapper.h        |   4 +
 4 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100644 axfer/mapper-single.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index cb4b188..baf9b89 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -32,4 +32,5 @@ axfer_SOURCES = \
 	container-voc.c \
 	container-raw.c \
 	mapper.h \
-	mapper.c
+	mapper.c \
+	mapper-single.c
diff --git a/axfer/mapper-single.c b/axfer/mapper-single.c
new file mode 100644
index 00000000..aa8aa19
--- /dev/null
+++ b/axfer/mapper-single.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mapper-single.c - a muxer/demuxer for single containers.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "mapper.h"
+#include "misc.h"
+
+struct single_state {
+	void (*align_frames)(void *frame_buf, unsigned int frame_count,
+			     char *buf, unsigned int bytes_per_sample,
+			     unsigned int samples_per_frame);
+	char *buf;
+};
+
+static void align_to_vector(void *frame_buf, unsigned int frame_count,
+			    char *src, unsigned int bytes_per_sample,
+			    unsigned samples_per_frame)
+{
+	char **dst_bufs = frame_buf;
+	char *dst;
+	unsigned int src_pos;
+	unsigned int dst_pos;
+	int i, j;
+
+	// src: interleaved => dst: a set of interleaved buffers.
+	for (i = 0; i < samples_per_frame; ++i) {
+		dst = dst_bufs[i];
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = bytes_per_sample * (samples_per_frame * j + i);
+			dst_pos = bytes_per_sample * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static void align_from_vector(void *frame_buf, unsigned int frame_count,
+			      char *dst, unsigned int bytes_per_sample,
+			      unsigned int samples_per_frame)
+{
+	char **src_bufs = frame_buf;
+	char *src;
+	unsigned int dst_pos;
+	unsigned int src_pos;
+	int i, j;
+
+	// src: a set of interleaved buffers => dst:interleaved.
+	for (i = 0; i < samples_per_frame; ++i) {
+		src = src_bufs[i];
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = bytes_per_sample * j;
+			dst_pos = bytes_per_sample * (samples_per_frame * j + i);
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static int single_pre_process(struct mapper_context *mapper,
+			      struct container_context *cntrs,
+			      unsigned int cntr_count)
+{
+	struct single_state *state = mapper->private_data;
+	unsigned int bytes_per_buffer;
+
+	if (cntrs->bytes_per_sample != mapper->bytes_per_sample ||
+	    cntrs->samples_per_frame != mapper->samples_per_frame)
+		return -EINVAL;
+
+	// Decide method to align frames.
+	if (mapper->type == MAPPER_TYPE_DEMUXER) {
+		if (mapper->access == SND_PCM_ACCESS_RW_NONINTERLEAVED ||
+		    mapper->access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			state->align_frames = align_from_vector;
+		else if (mapper->access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+			 mapper->access == SND_PCM_ACCESS_MMAP_INTERLEAVED)
+			state->align_frames = NULL;
+		else
+			return -EINVAL;
+	} else {
+		if (mapper->access == SND_PCM_ACCESS_RW_NONINTERLEAVED ||
+		    mapper->access == SND_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			state->align_frames = align_to_vector;
+		else if (mapper->access == SND_PCM_ACCESS_RW_INTERLEAVED ||
+			 mapper->access == SND_PCM_ACCESS_MMAP_INTERLEAVED)
+			state->align_frames = NULL;
+		else
+			return -EINVAL;
+	}
+
+	if (state->align_frames) {
+		// Allocate intermediate buffer as the same size as a period.
+		bytes_per_buffer = mapper->bytes_per_sample *
+				   mapper->samples_per_frame *
+				   mapper->frames_per_buffer;
+		state->buf = malloc(bytes_per_buffer);
+		if (state->buf == NULL)
+			return -ENOMEM;
+		memset(state->buf, 0, bytes_per_buffer);
+	}
+
+	return 0;
+}
+
+static int single_muxer_process_frames(struct mapper_context *mapper,
+				       void *frame_buf,
+				       unsigned int *frame_count,
+				       struct container_context *cntrs,
+				       unsigned int cntr_count)
+{
+	struct single_state *state = mapper->private_data;
+	void *src;
+	int err;
+
+	// If need to align PCM frames, process PCM frames to the intermediate
+	// buffer once.
+	if (!state->align_frames) {
+		// The most likely.
+		src = frame_buf;
+	} else {
+		src = state->buf;
+	}
+	err = container_context_process_frames(cntrs, src, frame_count);
+	if (err < 0)
+		return err;
+
+	// Unlikely.
+	if (src != frame_buf && *frame_count > 0)
+		state->align_frames(frame_buf, *frame_count, src,
+				    mapper->bytes_per_sample,
+				    mapper->samples_per_frame);
+
+	return 0;
+}
+
+static int single_demuxer_process_frames(struct mapper_context *mapper,
+					 void *frame_buf,
+					 unsigned int *frame_count,
+					 struct container_context *cntrs,
+					 unsigned int cntr_count)
+{
+	struct single_state *state = mapper->private_data;
+	void *dst;
+
+	// If need to align PCM frames, process PCM frames to the intermediate
+	// buffer once.
+	if (!state->align_frames) {
+		// The most likely.
+		dst = frame_buf;
+	} else {
+		state->align_frames(frame_buf, *frame_count, state->buf,
+				    mapper->bytes_per_sample,
+				    mapper->samples_per_frame);
+		dst = state->buf;
+	}
+
+	return container_context_process_frames(cntrs, dst, frame_count);
+}
+
+static void single_post_process(struct mapper_context *mapper)
+{
+	struct single_state *state = mapper->private_data;
+
+	if (state->buf)
+		free(state->buf);
+
+	state->buf = NULL;
+	state->align_frames = NULL;
+}
+
+const struct mapper_data mapper_muxer_single = {
+	.ops = {
+		.pre_process = single_pre_process,
+		.process_frames = single_muxer_process_frames,
+		.post_process = single_post_process,
+	},
+	.private_size = sizeof(struct single_state),
+};
+
+const struct mapper_data mapper_demuxer_single = {
+	.ops = {
+		.pre_process = single_pre_process,
+		.process_frames = single_demuxer_process_frames,
+		.post_process = single_post_process,
+	},
+	.private_size = sizeof(struct single_state),
+};
diff --git a/axfer/mapper.c b/axfer/mapper.c
index eb63a0e..07ca595 100644
--- a/axfer/mapper.c
+++ b/axfer/mapper.c
@@ -18,7 +18,7 @@ static const char *const mapper_type_labels[] = {
 };
 
 static const char *const mapper_target_labels[] = {
-	[MAPPER_TARGET_COUNT] = "",
+	[MAPPER_TARGET_SINGLE] = "single",
 };
 
 int mapper_context_init(struct mapper_context *mapper,
@@ -35,6 +35,18 @@ int mapper_context_init(struct mapper_context *mapper,
 
 	memset(mapper, 0, sizeof(*mapper));
 
+	if (type == MAPPER_TYPE_MUXER) {
+		if (cntr_count == 1) {
+			data = &mapper_muxer_single;
+			mapper->target = MAPPER_TARGET_SINGLE;
+		}
+	} else {
+		if (cntr_count == 1) {
+			data = &mapper_demuxer_single;
+			mapper->target = MAPPER_TARGET_SINGLE;
+		}
+	}
+
 	mapper->ops = &data->ops;
 	mapper->type = type;
 
diff --git a/axfer/mapper.h b/axfer/mapper.h
index c4caf09..3a95d9f 100644
--- a/axfer/mapper.h
+++ b/axfer/mapper.h
@@ -19,6 +19,7 @@ enum mapper_type {
 };
 
 enum mapper_target {
+	MAPPER_TARGET_SINGLE = 0,
 	MAPPER_TARGET_COUNT,
 };
 
@@ -76,4 +77,7 @@ struct mapper_data {
 	unsigned int private_size;
 };
 
+extern const struct mapper_data mapper_muxer_single;
+extern const struct mapper_data mapper_demuxer_single;
+
 #endif
-- 
2.19.1
