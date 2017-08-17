From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 08/23] aplay: add an implementation of
	aligner for multiple target
Date: Thu, 17 Aug 2017 20:59:49 +0900
Message-ID: <20170817120004.15326-9-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 173A8266EE0
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

This commit adds support for aligner with 'multiple' target. This handles
several files via 'container' functions.
---
 aplay/Makefile.am        |   3 +-
 aplay/aligner-multiple.c | 337 +++++++++++++++++++++++++++++++++++++++++++++++
 aplay/aligner.c          |  17 ++-
 aplay/aligner.h          |   4 +
 4 files changed, 359 insertions(+), 2 deletions(-)
 create mode 100644 aplay/aligner-multiple.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 68f6411..79f1535 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -20,7 +20,8 @@ aplay_SOURCES = \
 	container-voc.c \
 	aligner.h \
 	aligner.c \
-	aligner-single.c
+	aligner-single.c \
+	aligner-multiple.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/aligner-multiple.c b/aplay/aligner-multiple.c
new file mode 100644
index 0000000..437e3cc
--- /dev/null
+++ b/aplay/aligner-multiple.c
@@ -0,0 +1,337 @@
+/*
+ * aligner-multiple.c - a muxer/demuxer for multiple containers.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "aligner.h"
+
+struct multiple_state {
+	void (*align_frames)(void *frame_buf, unsigned int frame_count,
+			     char **buf, unsigned int bytes_per_sample,
+			     struct container_context *cntrs,
+			     unsigned int cntr_count);
+	char **bufs;
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
+	/*
+	 * src: first channel in each of interleaved buffers in containers =>
+	 * dst:interleaved.
+	 */
+	for (i = 0; i < cntr_count; ++i) {
+		src = src_bufs[i];
+		cntr = cntrs + i;
+
+		for (j = 0; j < frame_count; ++j) {
+			/* Use first src channel for each of dst channel. */
+			src_pos = bytes_per_sample * cntr->samples_per_frame * j;
+			dst_pos = i + bytes_per_sample * cntr_count * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static void align_to_n(void *frame_buf, unsigned int frame_count,
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
+	/*
+	 * src: first channel in each of interleaved buffers in containers =>
+	 * dst:noninterleaved.
+	 */
+	for (i = 0; i < cntr_count; ++i) {
+		src = src_bufs[i];
+		cntr = cntrs + i;
+
+		for (j = 0; j < frame_count; ++j) {
+			/* Use first src channel for each of dst channel. */
+			src_pos = bytes_per_sample * cntr->samples_per_frame * j;
+			dst_pos = j + bytes_per_sample * cntr_count * i;
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
+			/* Use first src channel for each of dst channel. */
+			src_pos = bytes_per_sample * cntr_count * j + i;
+			dst_pos = bytes_per_sample * cntr->samples_per_frame * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static void align_from_n(void *frame_buf, unsigned int frame_count,
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
+			/* Use first src channel for each of dst channel. */
+			src_pos = bytes_per_sample * cntr_count * i + j;
+			dst_pos = bytes_per_sample * cntr->samples_per_frame * j;
+
+			memcpy(dst + dst_pos, src + src_pos, bytes_per_sample);
+		}
+	}
+}
+
+static int multiple_pre_process(struct aligner_context *aligner,
+				struct container_context *cntrs,
+				unsigned int cntr_count)
+{
+	static const struct {
+		enum aligner_type type;
+		int access;
+		void (*align_frames)(void *frame_buf, unsigned int frame_count,
+				     char **buf, unsigned int bytes_per_sample,
+				     struct container_context *cntrs,
+				     unsigned int cntr_count);
+	} entries[] = {
+		{
+			ALIGNER_TYPE_MUXER,
+			SND_PCM_ACCESS_RW_INTERLEAVED,
+			align_to_i,
+		},
+		{
+			ALIGNER_TYPE_MUXER,
+			SND_PCM_ACCESS_RW_NONINTERLEAVED,
+			align_to_n,
+		},
+		{
+			ALIGNER_TYPE_DEMUXER,
+			SND_PCM_ACCESS_MMAP_INTERLEAVED,
+			align_from_i,
+		},
+		{
+			ALIGNER_TYPE_DEMUXER,
+			SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
+			align_from_n,
+		},
+	};
+	struct multiple_state *state = aligner->private_data;
+	struct container_context *cntr;
+	int i;
+
+	/*
+	 * Additionally, format of samples in the containers should be the same
+	 * as the format in PCM substream.
+	 */
+	for (i = 0; i < cntr_count; ++i) {
+		cntr = cntrs + i;
+		if (aligner->bytes_per_sample != cntr->bytes_per_sample)
+			return -EINVAL;
+	}
+
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
+		/*
+		 * Furthermore, in demuxer case, each container should be
+		 * configured to store one sample per frame.
+		 */
+		if (aligner->type == ALIGNER_TYPE_DEMUXER) {
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
+			/*
+			 * Allocate intermediate buffer as the same size as a
+			 * period for each of containers.
+			 */
+			cntr = cntrs + i;
+
+			bytes_per_buffer = aligner->bytes_per_sample *
+					   cntr->samples_per_frame *
+					   aligner->frames_per_buffer;
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
+	/* TODO: arrangement for *frame_count. */
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
+static int multiple_muxer_process_frames(struct aligner_context *aligner,
+					 void *frame_buf,
+					 unsigned int *frame_count,
+					 struct container_context *cntrs,
+					 unsigned int cntr_count)
+{
+	struct multiple_state *state = aligner->private_data;
+	char **src_bufs;
+	int err;
+
+	/*
+	 * If need to align PCM frames, process PCM frames to the intermediate
+	 * buffer once.
+	 */
+	if (!state->align_frames) {
+		/* The most likely. */
+		src_bufs = frame_buf;
+	} else {
+		src_bufs = state->bufs;
+	}
+	err = process_containers(src_bufs, frame_count, cntrs, cntr_count);
+	if (err < 0)
+		return err;
+
+	/* Unlikely. */
+	if (src_bufs != frame_buf && *frame_count > 0) {
+		state->align_frames(frame_buf, *frame_count, src_bufs,
+				    aligner->bytes_per_sample, cntrs,
+				    cntr_count);
+	}
+
+	return 0;
+}
+
+static int multiple_demuxer_process_frames(struct aligner_context *aligner,
+					   void *frame_buf,
+					   unsigned int *frame_count,
+					   struct container_context *cntrs,
+					   unsigned int cntr_count)
+{
+	struct multiple_state *state = aligner->private_data;
+	char **dst_bufs;
+
+	/*
+	 * If need to align PCM frames, process PCM frames to the intermediate
+	 * buffer once.
+	 */
+	if (!state->align_frames) {
+		/* The most likely. */
+		dst_bufs = frame_buf;
+	} else {
+		dst_bufs = state->bufs;
+		state->align_frames(frame_buf, *frame_count, dst_bufs,
+				    aligner->bytes_per_sample, cntrs,
+				    cntr_count);
+	}
+
+	return process_containers(dst_bufs, frame_count, cntrs, cntr_count);
+}
+
+static void multiple_post_process(struct aligner_context *aligner)
+{
+	struct multiple_state *state = aligner->private_data;
+
+	if (state->bufs) {
+		if (state->bufs[0])
+			free(state->bufs[0]);
+		free(state->bufs);
+	}
+
+	state->bufs = NULL;
+	state->align_frames = NULL;
+}
+
+const struct aligner_data aligner_muxer_multiple = {
+	.ops = {
+		.pre_process = multiple_pre_process,
+		.process_frames = multiple_muxer_process_frames,
+		.post_process = multiple_post_process,
+	},
+	.private_size = sizeof(struct multiple_state),
+};
+
+const struct aligner_data aligner_demuxer_multiple = {
+	.ops = {
+		.pre_process = multiple_pre_process,
+		.process_frames = multiple_demuxer_process_frames,
+		.post_process = multiple_post_process,
+	},
+	.private_size = sizeof(struct multiple_state),
+};
diff --git a/aplay/aligner.c b/aplay/aligner.c
index e578031..6d260a3 100644
--- a/aplay/aligner.c
+++ b/aplay/aligner.c
@@ -17,23 +17,30 @@ static const char *const aligner_type_labels[] = {
 
 static const char *const aligner_target_labels[] = {
 	[ALIGNER_TARGET_SINGLE] = "single",
+	[ALIGNER_TARGET_MULTIPLE] = "multiple",
 };
 
 int aligner_context_init(struct aligner_context *aligner,
 			enum aligner_type type, unsigned int cntr_count,
 			unsigned int verbose)
 {
-	const struct aligner_data *data = NULL;
+	const struct aligner_data *data;
 
 	if (type == ALIGNER_TYPE_MUXER) {
 		if (cntr_count == 1) {
 			data = &aligner_muxer_single;
 			aligner->target = ALIGNER_TARGET_SINGLE;
+		} else {
+			data = &aligner_muxer_multiple;
+			aligner->target = ALIGNER_TARGET_MULTIPLE;
 		}
 	} else {
 		if (cntr_count == 1) {
 			data = &aligner_demuxer_single;
 			aligner->target = ALIGNER_TARGET_SINGLE;
+		} else {
+			data = &aligner_demuxer_multiple;
+			aligner->target = ALIGNER_TARGET_MULTIPLE;
 		}
 	}
 	aligner->ops = &data->ops;
@@ -59,6 +66,14 @@ int aligner_context_pre_process(struct aligner_context *aligner,
 {
 	int err;
 
+	/*
+	 * The purpose of multiple target is to mux/demux each channels to/from
+	 * containers.
+	 */
+	if (aligner->target == ALIGNER_TARGET_MULTIPLE &&
+	    samples_per_frame != aligner->cntr_count)
+		return -EINVAL;
+
 	aligner->access = access;
 	aligner->bytes_per_sample = snd_pcm_format_physical_width(format) / 8;
 	aligner->samples_per_frame = samples_per_frame;
diff --git a/aplay/aligner.h b/aplay/aligner.h
index 333b584..bf8b689 100644
--- a/aplay/aligner.h
+++ b/aplay/aligner.h
@@ -21,6 +21,7 @@ enum aligner_type {
 
 enum aligner_target {
 	ALIGNER_TARGET_SINGLE = 0,
+	ALIGNER_TARGET_MULTIPLE,
 	ALIGNER_TARGET_COUNT,
 };
 
@@ -81,4 +82,7 @@ struct aligner_data {
 extern const struct aligner_data aligner_muxer_single;
 extern const struct aligner_data aligner_demuxer_single;
 
+extern const struct aligner_data aligner_muxer_multiple;
+extern const struct aligner_data aligner_demuxer_multiple;
+
 #endif
-- 
2.11.0
