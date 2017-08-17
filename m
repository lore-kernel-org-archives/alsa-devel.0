From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 07/23] aplay: add an implementation of
	aligner for single target
Date: Thu, 17 Aug 2017 20:59:48 +0900
Message-ID: <20170817120004.15326-8-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1CCBB266EF3
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:13 +0200 (CEST)
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

This commit adds support for aligner with 'single' target. This handles
one file via 'container' functions.
---
 aplay/Makefile.am      |   5 +-
 aplay/aligner-single.c | 256 +++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/aligner.c        |  21 ++--
 aplay/aligner.h        |   4 +
 4 files changed, 275 insertions(+), 11 deletions(-)
 create mode 100644 aplay/aligner-single.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 59052d9..68f6411 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -17,9 +17,10 @@ aplay_SOURCES = \
 	container.c \
 	container-riff-wave.c \
 	container-au.c \
-	container-voc.c
+	container-voc.c \
 	aligner.h \
-	aligner.c
+	aligner.c \
+	aligner-single.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/aligner-single.c b/aplay/aligner-single.c
new file mode 100644
index 0000000..70f0f91
--- /dev/null
+++ b/aplay/aligner-single.c
@@ -0,0 +1,256 @@
+/*
+ * aligner-single.c - a muxer/demuxer for single containers.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "aligner.h"
+
+struct single_state {
+	void (*align_frames)(void *frame_buf, unsigned int frame_count,
+			     char *buf, unsigned int bytes_per_sample,
+			     unsigned int samples_per_frame);
+	char *buf;
+
+	/* A part of parameters of a container. */
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+};
+
+static void align_to_n(void *frame_buf, unsigned int frame_count,
+		       char *src, unsigned int bytes_per_sample,
+		       unsigned int samples_per_frame)
+{
+	char *dst = frame_buf;
+	unsigned int src_pos;
+	unsigned int dst_pos;
+	int i, j;
+
+	/* src: interleaved => dst: non-interleaved.  */
+	for (i = 0; i < samples_per_frame; ++i) {
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = j + bytes_per_sample * samples_per_frame * i;
+			dst_pos = i + bytes_per_sample * samples_per_frame * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
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
+	/* src: interleaved => dst: a set of interleaved buffers.  */
+	for (i = 0; i < samples_per_frame; ++i) {
+		dst = dst_bufs[i];
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = bytes_per_sample * samples_per_frame * j + i;
+			dst_pos = j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static void align_from_n(void *frame_buf, unsigned int frame_count,
+			 char *dst, unsigned int bytes_per_sample,
+			 unsigned samples_per_frame)
+{
+	char *src = frame_buf;
+	unsigned int dst_pos;
+	unsigned int src_pos;
+	int i, j;
+
+	/* src: non-interleaved => dst: interleaved.  */
+	for (i = 0; i < samples_per_frame; ++i) {
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = i + bytes_per_sample * samples_per_frame * j;
+			dst_pos = j + bytes_per_sample * samples_per_frame * i;
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
+	/* src: a set of interleaved buffers => dst:interleaved.  */
+	for (i = 0; i < samples_per_frame; ++i) {
+		src = src_bufs[i];
+		for (j = 0; j < frame_count; ++j) {
+			src_pos = j;
+			dst_pos = bytes_per_sample * samples_per_frame * j + i;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static int single_pre_process(struct aligner_context *aligner,
+			      struct container_context *cntrs,
+			      unsigned int cntr_count)
+{
+	static const struct {
+		enum aligner_type type;
+		int access;
+		void (*align_frames)(void *frame_buf, unsigned int frame_count,
+				     char *buf, unsigned int bytes_per_sample,
+				     unsigned int samples_per_frame);
+	} entries[] = {
+		{
+			ALIGNER_TYPE_MUXER,
+			SND_PCM_ACCESS_RW_NONINTERLEAVED,
+			align_to_n,
+		},
+		{
+			ALIGNER_TYPE_MUXER,
+			SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
+			align_to_vector,
+		},
+		{
+			ALIGNER_TYPE_DEMUXER,
+			SND_PCM_ACCESS_RW_NONINTERLEAVED,
+			align_from_n,
+		},
+		{
+			ALIGNER_TYPE_DEMUXER,
+			SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
+			align_from_vector,
+		},
+	};
+	struct single_state *state = aligner->private_data;
+	unsigned int bytes_per_buffer;
+	int i;
+
+	if (cntrs->bytes_per_sample != aligner->bytes_per_sample ||
+	    cntrs->samples_per_frame != aligner->samples_per_frame)
+		return -EINVAL;
+
+	/* Decide method to align frames. */
+	state->align_frames = NULL;
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		if (entries[i].type == aligner->type &&
+		    (entries[i].access == aligner->access)) {
+			state->align_frames = entries[i].align_frames;
+			break;
+		}
+	}
+
+	if (state->align_frames) {
+		/* Allocate intermediate buffer as the same size as a period. */
+		bytes_per_buffer = aligner->bytes_per_sample *
+				   aligner->samples_per_frame *
+				   aligner->frames_per_buffer;
+		state->buf = malloc(bytes_per_buffer);
+		if (state->buf == NULL)
+			return -ENOMEM;
+		memset(state->buf, 0, bytes_per_buffer);
+	}
+
+	return 0;
+}
+
+static int single_muxer_process_frames(struct aligner_context *aligner,
+				       void *frame_buf,
+				       unsigned int *frame_count,
+				       struct container_context *cntrs,
+				       unsigned int cntr_count)
+{
+	struct single_state *state = aligner->private_data;
+	void *src;
+	int err;
+
+	/*
+	 * If need to align PCM frames, process PCM frames to the intermediate
+	 * buffer once.
+	 */
+	if (!state->align_frames) {
+		/* The most likely. */
+		src = frame_buf;
+	} else {
+		src = state->buf;
+	}
+	err = container_context_process_frames(cntrs, src, frame_count);
+	if (err < 0)
+		return err;
+
+	/* Unlikely. */
+	if (src != frame_buf && *frame_count > 0)
+		state->align_frames(frame_buf, *frame_count, src,
+				    state->bytes_per_sample,
+				    state->samples_per_frame);
+
+	return 0;
+}
+
+static int single_demuxer_process_frames(struct aligner_context *aligner,
+					 void *frame_buf,
+					 unsigned int *frame_count,
+					 struct container_context *cntrs,
+					 unsigned int cntr_count)
+{
+	struct single_state *state = aligner->private_data;
+	void *dst;
+
+	/*
+	 * If need to align PCM frames, process PCM frames to the intermediate
+	 * buffer once.
+	 */
+	if (!state->align_frames) {
+		/* The most likely. */
+		dst = frame_buf;
+	} else {
+		state->align_frames(frame_buf, *frame_count, state->buf,
+				    state->bytes_per_sample,
+				    state->samples_per_frame);
+		dst = state->buf;
+	}
+
+	return container_context_process_frames(cntrs, dst, frame_count);
+}
+
+static void single_post_process(struct aligner_context *aligner)
+{
+	struct single_state *state = aligner->private_data;
+
+	if (state->buf)
+		free(state->buf);
+
+	state->buf = NULL;
+	state->align_frames = NULL;
+}
+
+const struct aligner_data aligner_muxer_single = {
+	.ops = {
+		.pre_process = single_pre_process,
+		.process_frames = single_muxer_process_frames,
+		.post_process = single_post_process,
+	},
+	.private_size = sizeof(struct single_state),
+};
+
+const struct aligner_data aligner_demuxer_single = {
+	.ops = {
+		.pre_process = single_pre_process,
+		.process_frames = single_demuxer_process_frames,
+		.post_process = single_post_process,
+	},
+	.private_size = sizeof(struct single_state),
+};
diff --git a/aplay/aligner.c b/aplay/aligner.c
index db59fc8..e578031 100644
--- a/aplay/aligner.c
+++ b/aplay/aligner.c
@@ -16,7 +16,7 @@ static const char *const aligner_type_labels[] = {
 };
 
 static const char *const aligner_target_labels[] = {
-	[ALIGNER_TARGET_COUNT] = "",
+	[ALIGNER_TARGET_SINGLE] = "single",
 };
 
 int aligner_context_init(struct aligner_context *aligner,
@@ -25,6 +25,17 @@ int aligner_context_init(struct aligner_context *aligner,
 {
 	const struct aligner_data *data = NULL;
 
+	if (type == ALIGNER_TYPE_MUXER) {
+		if (cntr_count == 1) {
+			data = &aligner_muxer_single;
+			aligner->target = ALIGNER_TARGET_SINGLE;
+		}
+	} else {
+		if (cntr_count == 1) {
+			data = &aligner_demuxer_single;
+			aligner->target = ALIGNER_TARGET_SINGLE;
+		}
+	}
 	aligner->ops = &data->ops;
 	aligner->type = type;
 
@@ -48,14 +59,6 @@ int aligner_context_pre_process(struct aligner_context *aligner,
 {
 	int err;
 
-	/*
-	 * The purpose of multiple target is to mux/demux each channels to/from
-	 * containers.
-	 */
-	if (aligner->target == ALIGNER_TARGET_MULTIPLE &&
-	    samples_per_frame != aligner->cntr_count)
-		return -EINVAL;
-
 	aligner->access = access;
 	aligner->bytes_per_sample = snd_pcm_format_physical_width(format) / 8;
 	aligner->samples_per_frame = samples_per_frame;
diff --git a/aplay/aligner.h b/aplay/aligner.h
index 441dda4..333b584 100644
--- a/aplay/aligner.h
+++ b/aplay/aligner.h
@@ -20,6 +20,7 @@ enum aligner_type {
 };
 
 enum aligner_target {
+	ALIGNER_TARGET_SINGLE = 0,
 	ALIGNER_TARGET_COUNT,
 };
 
@@ -77,4 +78,7 @@ struct aligner_data {
 	unsigned int private_size;
 };
 
+extern const struct aligner_data aligner_muxer_single;
+extern const struct aligner_data aligner_demuxer_single;
+
 #endif
-- 
2.11.0
