From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 06/23] aplay: aligner: add an abstraction
	to align buffers with different data
Date: Thu, 17 Aug 2017 20:59:47 +0900
Message-ID: <20170817120004.15326-7-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 162A8266EDF
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

In current implementation of aplay, several files can be handled as source
or destination of handled PCM frames, by an option '--separate-channels'
(-I).

On the other hand, in ALSA kernel/user interface, several types of buffer
are used to communicate between applications/hardwares;
 - mapped page frame with interleaved frames
 - mapped page frame with non-interleaved frames
 - buffer in user space with interleaved frames
 - a list of buffer in user space for non-interleaved frames

This commit adds an abstraction to convert frame alignment between these
two sides, named as 'aligner'. This gets buffer pointer for the interface
and call functions of 'container' to write/read files. This includes two
types; muxer and demuxer. The 'muxer' is for playback direction, to
construct playback buffer with PCM frames from several files. The 'demuxer'
is for capture direction, to split PCM frames from capture buffer to
each of file.
---
 aplay/Makefile.am |   5 ++-
 aplay/aligner.c   | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/aligner.h   |  80 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 aplay/aligner.c
 create mode 100644 aplay/aligner.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index ef70bcb..59052d9 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -7,7 +7,8 @@ bin_PROGRAMS = aplay
 man_MANS = aplay.1 arecord.1
 noinst_HEADERS = \
 	formats.h \
-	container.h
+	container.h \
+	aligner.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -17,6 +18,8 @@ aplay_SOURCES = \
 	container-riff-wave.c \
 	container-au.c \
 	container-voc.c
+	aligner.h \
+	aligner.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/aligner.c b/aplay/aligner.c
new file mode 100644
index 0000000..db59fc8
--- /dev/null
+++ b/aplay/aligner.c
@@ -0,0 +1,104 @@
+/*
+ * aligner.c - a muxer/demuxer between data frams and file containers.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "aligner.h"
+
+#include <gettext.h>
+
+static const char *const aligner_type_labels[] = {
+	[ALIGNER_TYPE_MUXER] = "muxer",
+	[ALIGNER_TYPE_DEMUXER] = "demuxer",
+};
+
+static const char *const aligner_target_labels[] = {
+	[ALIGNER_TARGET_COUNT] = "",
+};
+
+int aligner_context_init(struct aligner_context *aligner,
+			enum aligner_type type, unsigned int cntr_count,
+			unsigned int verbose)
+{
+	const struct aligner_data *data = NULL;
+
+	aligner->ops = &data->ops;
+	aligner->type = type;
+
+	aligner->private_data = malloc(data->private_size);
+	if (aligner->private_data == NULL)
+		return -ENOMEM;
+	memset(aligner->private_data, 0, data->private_size);
+
+	aligner->cntr_count = cntr_count;
+	aligner->verbose = verbose;
+
+	return 0;
+}
+
+int aligner_context_pre_process(struct aligner_context *aligner,
+				snd_pcm_access_t access,
+				snd_pcm_format_t format,
+				unsigned int samples_per_frame,
+				unsigned int frames_per_buffer,
+				struct container_context *cntrs)
+{
+	int err;
+
+	/*
+	 * The purpose of multiple target is to mux/demux each channels to/from
+	 * containers.
+	 */
+	if (aligner->target == ALIGNER_TARGET_MULTIPLE &&
+	    samples_per_frame != aligner->cntr_count)
+		return -EINVAL;
+
+	aligner->access = access;
+	aligner->bytes_per_sample = snd_pcm_format_physical_width(format) / 8;
+	aligner->samples_per_frame = samples_per_frame;
+	aligner->frames_per_buffer = frames_per_buffer;
+
+	err = aligner->ops->pre_process(aligner, cntrs, aligner->cntr_count);
+	if (err < 0)
+		return err;
+
+	if (aligner->verbose > 0) {
+		printf(_("Aligner: %s\n"),
+		       aligner_type_labels[aligner->type]);
+		printf(_("  target: %s\n"),
+		       aligner_target_labels[aligner->target]);
+		printf(_("  access: %s\n"),
+		       snd_pcm_access_name(aligner->access));
+		printf(_("  bytes/sample: %u\n"), aligner->bytes_per_sample);
+		printf(_("  samples/frame: %u\n"), aligner->samples_per_frame);
+		printf(_("  frames/buffer: %lu\n"), aligner->frames_per_buffer);
+		printf("\n");
+	}
+
+	return 0;
+}
+
+int aligner_context_process_frames(struct aligner_context *aligner,
+				   void *frame_buffer,
+				   unsigned int *frame_count,
+				   struct container_context *cntrs)
+{
+	return aligner->ops->process_frames(aligner, frame_buffer, frame_count,
+					    cntrs, aligner->cntr_count);
+}
+
+void aligner_context_post_process(struct aligner_context *aligner)
+{
+	if (aligner->ops && aligner->ops->post_process)
+		aligner->ops->post_process(aligner);
+}
+
+void aligner_context_destroy(struct aligner_context *aligner)
+{
+	if (aligner->private_data)
+		free(aligner->private_data);
+	aligner->private_data = NULL;
+}
diff --git a/aplay/aligner.h b/aplay/aligner.h
new file mode 100644
index 0000000..441dda4
--- /dev/null
+++ b/aplay/aligner.h
@@ -0,0 +1,80 @@
+/*
+ * aligner.h - a header muxer/demuxer between data frames and file containers.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_ALIGNER__H_
+#define __ALSA_UTILS_APLAY_ALIGNER__H_
+
+#include "container.h"
+
+#include <string.h>
+
+enum aligner_type {
+	ALIGNER_TYPE_MUXER = 0,
+	ALIGNER_TYPE_DEMUXER,
+	ALIGNER_TYPE_COUNT,
+};
+
+enum aligner_target {
+	ALIGNER_TARGET_COUNT,
+};
+
+struct aligner_ops;
+
+struct aligner_context {
+	enum aligner_type type;
+	enum aligner_target target;
+	const struct aligner_ops *ops;
+	unsigned int private_size;
+
+	void *private_data;
+	unsigned int cntr_count;
+
+	/* A part of parameters of PCM substream. */
+	snd_pcm_access_t access;
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	snd_pcm_uframes_t frames_per_buffer;
+
+	unsigned int verbose;
+};
+
+int aligner_context_init(struct aligner_context *aligner,
+			enum aligner_type type, unsigned int cntr_count,
+			unsigned int verbose);
+int aligner_context_pre_process(struct aligner_context *aligner,
+				snd_pcm_access_t access,
+				snd_pcm_format_t format,
+				unsigned int samples_per_frame,
+				unsigned int frames_per_buffer,
+				struct container_context *cntrs);
+int aligner_context_process_frames(struct aligner_context *aligner,
+				   void *frame_buffer,
+				   unsigned int *frame_count,
+				   struct container_context *cntrs);
+void aligner_context_post_process(struct aligner_context *aligner);
+void aligner_context_destroy(struct aligner_context *aligner);
+
+/* For internal use in 'aligner' module. */
+
+struct aligner_ops {
+	int (*pre_process)(struct aligner_context *aligner,
+			   struct container_context *cntrs,
+			   unsigned int cntr_count);
+	int (*process_frames)(struct aligner_context *aligner,
+			      void *frame_buffer, unsigned int *frame_count,
+			      struct container_context *cntrs,
+			      unsigned int cntr_count);
+	void (*post_process)(struct aligner_context *aligner);
+};
+
+struct aligner_data {
+	struct aligner_ops ops;
+	unsigned int private_size;
+};
+
+#endif
-- 
2.11.0
