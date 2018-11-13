From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/35] axfer: add a common interface to align
	data frames on different layout
Date: Tue, 13 Nov 2018 15:41:21 +0900
Message-ID: <20181113064147.13577-9-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 111F1267AB9
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:10 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so5547623pff.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:09 -0800 (PST)
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

In current aplay, several files can be handled as source of data frames for
playback, or destination of captured data frames by an option
'--separate-channels' (-I).

On the other hand, in ALSA PCM kernel/user interface, several types of
buffer are used to communicate between application/hardware;
 - mapped page frame for data frames with interleaved alignment
 - mapped page frame for data frames with non-interleaved alignment
 - buffer in user space for data frames with interleaved alignment
 - a list of buffer in user space for data frames with non-interleaved
   alignment

This commit adds a common interface, named as 'mapper' to convert frame
alignment between these two sides. This interface includes two types;
'muxer' and 'demuxer'. The 'muxer' is for playback direction, to
construct playback buffer with PCM frames from several files. The 'demuxer'
is for capture direction, to split PCM frames from capture buffer to
each of file. Unlike multimedia containers such as MPEG 2/4 Systems,
the 'muxer' and 'demuxer' are for playback/capture buffer, not for file
contents.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am |   7 ++-
 axfer/mapper.c    | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 axfer/mapper.h    |  79 +++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 axfer/mapper.c
 create mode 100644 axfer/mapper.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 55fcf71..cb4b188 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -17,7 +17,8 @@ LDADD = \
 noinst_HEADERS = \
 	misc.h \
 	subcmd.h \
-	container.h
+	container.h \
+	mapper.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -29,4 +30,6 @@ axfer_SOURCES = \
 	container-riff-wave.c \
 	container-au.c \
 	container-voc.c \
-	container-raw.c
+	container-raw.c \
+	mapper.h \
+	mapper.c
diff --git a/axfer/mapper.c b/axfer/mapper.c
new file mode 100644
index 00000000..eb63a0e
--- /dev/null
+++ b/axfer/mapper.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mapper.c - an interface of muxer/demuxer between buffer with data frames and
+// 	      formatted files.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "mapper.h"
+#include "misc.h"
+
+#include <stdio.h>
+
+static const char *const mapper_type_labels[] = {
+	[MAPPER_TYPE_MUXER] = "muxer",
+	[MAPPER_TYPE_DEMUXER] = "demuxer",
+};
+
+static const char *const mapper_target_labels[] = {
+	[MAPPER_TARGET_COUNT] = "",
+};
+
+int mapper_context_init(struct mapper_context *mapper,
+			enum mapper_type type, unsigned int cntr_count,
+			unsigned int verbose)
+{
+	const struct mapper_data *data = NULL;
+
+	assert(mapper);
+	assert(cntr_count > 0);
+
+	// Detect forgotten to destruct.
+	assert(mapper->private_data == NULL);
+
+	memset(mapper, 0, sizeof(*mapper));
+
+	mapper->ops = &data->ops;
+	mapper->type = type;
+
+	mapper->private_data = malloc(data->private_size);
+	if (mapper->private_data == NULL)
+		return -ENOMEM;
+	memset(mapper->private_data, 0, data->private_size);
+
+	mapper->cntr_count = cntr_count;
+	mapper->verbose = verbose;
+
+	return 0;
+}
+
+int mapper_context_pre_process(struct mapper_context *mapper,
+			       snd_pcm_access_t access,
+			       unsigned int bytes_per_sample,
+			       unsigned int samples_per_frame,
+			       unsigned int frames_per_buffer,
+			       struct container_context *cntrs)
+{
+	int err;
+
+	assert(mapper);
+	assert(access >= SND_PCM_ACCESS_MMAP_INTERLEAVED);
+	assert(access <= SND_PCM_ACCESS_RW_NONINTERLEAVED);
+	assert(bytes_per_sample > 0);
+	assert(samples_per_frame > 0);
+	assert(cntrs);
+
+	mapper->access = access;
+	mapper->bytes_per_sample = bytes_per_sample;
+	mapper->samples_per_frame = samples_per_frame;
+	mapper->frames_per_buffer = frames_per_buffer;
+
+	err = mapper->ops->pre_process(mapper, cntrs, mapper->cntr_count);
+	if (err < 0)
+		return err;
+
+	if (mapper->verbose > 0) {
+		fprintf(stderr, "Mapper: %s\n",
+		       mapper_type_labels[mapper->type]);
+		fprintf(stderr, "  target: %s\n",
+		       mapper_target_labels[mapper->target]);
+		fprintf(stderr, "  access: %s\n",
+		       snd_pcm_access_name(mapper->access));
+		fprintf(stderr, "  bytes/sample: %u\n",
+			mapper->bytes_per_sample);
+		fprintf(stderr, "  samples/frame: %u\n",
+			mapper->samples_per_frame);
+		fprintf(stderr, "  frames/buffer: %lu\n",
+			mapper->frames_per_buffer);
+	}
+
+	return 0;
+}
+
+int mapper_context_process_frames(struct mapper_context *mapper,
+				  void *frame_buffer,
+				  unsigned int *frame_count,
+				  struct container_context *cntrs)
+{
+	assert(mapper);
+	assert(frame_buffer);
+	assert(frame_count);
+	assert(*frame_count <= mapper->frames_per_buffer);
+	assert(cntrs);
+
+	return mapper->ops->process_frames(mapper, frame_buffer, frame_count,
+					    cntrs, mapper->cntr_count);
+}
+
+void mapper_context_post_process(struct mapper_context *mapper)
+{
+	assert(mapper);
+
+	if (mapper->ops && mapper->ops->post_process)
+		mapper->ops->post_process(mapper);
+}
+
+void mapper_context_destroy(struct mapper_context *mapper)
+{
+	assert(mapper);
+
+	if (mapper->private_data)
+		free(mapper->private_data);
+	mapper->private_data = NULL;
+}
diff --git a/axfer/mapper.h b/axfer/mapper.h
new file mode 100644
index 00000000..c4caf09
--- /dev/null
+++ b/axfer/mapper.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mapper.h - an interface of muxer/demuxer between buffer with data frames and
+//	      formatted files.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_MAPPER__H_
+#define __ALSA_UTILS_AXFER_MAPPER__H_
+
+#include "container.h"
+
+enum mapper_type {
+	MAPPER_TYPE_MUXER = 0,
+	MAPPER_TYPE_DEMUXER,
+	MAPPER_TYPE_COUNT,
+};
+
+enum mapper_target {
+	MAPPER_TARGET_COUNT,
+};
+
+struct mapper_ops;
+
+struct mapper_context {
+	enum mapper_type type;
+	enum mapper_target target;
+	const struct mapper_ops *ops;
+	unsigned int private_size;
+
+	void *private_data;
+	unsigned int cntr_count;
+
+	// A part of parameters of PCM substream.
+	snd_pcm_access_t access;
+	unsigned int bytes_per_sample;
+	unsigned int samples_per_frame;
+	snd_pcm_uframes_t frames_per_buffer;
+
+	unsigned int verbose;
+};
+
+int mapper_context_init(struct mapper_context *mapper,
+			enum mapper_type type, unsigned int cntr_count,
+			unsigned int verbose);
+int mapper_context_pre_process(struct mapper_context *mapper,
+			       snd_pcm_access_t access,
+			       unsigned int bytes_per_sample,
+			       unsigned int samples_per_frame,
+			       unsigned int frames_per_buffer,
+			       struct container_context *cntrs);
+int mapper_context_process_frames(struct mapper_context *mapper,
+				  void *frame_buffer,
+				  unsigned int *frame_count,
+				  struct container_context *cntrs);
+void mapper_context_post_process(struct mapper_context *mapper);
+void mapper_context_destroy(struct mapper_context *mapper);
+
+// For internal use in 'mapper' module.
+
+struct mapper_ops {
+	int (*pre_process)(struct mapper_context *mapper,
+			   struct container_context *cntrs,
+			   unsigned int cntr_count);
+	int (*process_frames)(struct mapper_context *mapper,
+			      void *frame_buffer, unsigned int *frame_count,
+			      struct container_context *cntrs,
+			      unsigned int cntr_count);
+	void (*post_process)(struct mapper_context *mapper);
+};
+
+struct mapper_data {
+	struct mapper_ops ops;
+	unsigned int private_size;
+};
+
+#endif
-- 
2.19.1
