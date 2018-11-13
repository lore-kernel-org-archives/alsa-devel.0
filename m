From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/35] axfer: add a common interface to
	transfer data frames
Date: Tue, 13 Nov 2018 15:41:25 +0900
Message-ID: <20181113064147.13577-13-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A8D267AB1
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:17 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so5505658plr.8
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:16 -0800 (PST)
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

ALSA has PCM interface to transfer data frames. In userspace, there're
some implementation to utilize this interface to produce application
programming interface; alsa-lib (libasound) and tinyalsa. However, it's
possible to use the interface with raw I/O operations.

This commit adds an common interface to transfer data frames for this
program, named as 'xfer'. This internal interface is designed for users
to select several backend for data transmission. This includes some
functions expected to be called by main program just for data
transmission. In an aspect to maintain PCM substream, suspend feature is
required to handle a pair of SIGTSTP/SIGCONT UNIX signals.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am |   7 +-
 axfer/xfer.c      | 170 ++++++++++++++++++++++++++++++++++++++++++++++
 axfer/xfer.h      |  80 ++++++++++++++++++++++
 3 files changed, 255 insertions(+), 2 deletions(-)
 create mode 100644 axfer/xfer.c
 create mode 100644 axfer/xfer.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index f17e59b..9371365 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -18,7 +18,8 @@ noinst_HEADERS = \
 	misc.h \
 	subcmd.h \
 	container.h \
-	mapper.h
+	mapper.h \
+	xfer.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -34,4 +35,6 @@ axfer_SOURCES = \
 	mapper.h \
 	mapper.c \
 	mapper-single.c \
-	mapper-multiple.c
+	mapper-multiple.c \
+	xfer.h \
+	xfer.c
diff --git a/axfer/xfer.c b/axfer/xfer.c
new file mode 100644
index 00000000..7c41a65
--- /dev/null
+++ b/axfer/xfer.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer.c - receiver/transmiter of data frames.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "xfer.h"
+#include "misc.h"
+
+#include <stdio.h>
+
+static const char *const xfer_type_labels[] = {
+	[XFER_TYPE_COUNT] = "",
+};
+
+enum xfer_type xfer_type_from_label(const char *label)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xfer_type_labels); ++i) {
+		if (!strcmp(xfer_type_labels[i], label))
+			return i;
+	}
+
+	return XFER_TYPE_UNSUPPORTED;
+}
+
+int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
+		      snd_pcm_stream_t direction, int argc, char *const *argv)
+{
+	struct {
+		enum xfer_type type;
+		const struct xfer_data *data;
+	} *entry, entries[] = {
+		{XFER_TYPE_COUNT, NULL},
+	};
+	int i;
+	int err;
+
+	assert(xfer);
+	assert(direction >= SND_PCM_STREAM_PLAYBACK);
+	assert(direction <= SND_PCM_STREAM_CAPTURE);
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		if (entries[i].type == type)
+			break;
+	}
+	if (i == ARRAY_SIZE(entries))
+		return -EINVAL;
+	entry = &entries[i];
+
+	xfer->direction = direction;
+	xfer->type = type;
+	xfer->ops = &entry->data->ops;
+
+	xfer->private_data = malloc(entry->data->private_size);
+	if (xfer->private_data == NULL)
+		return -ENOMEM;
+	memset(xfer->private_data, 0, entry->data->private_size);
+
+	err = xfer->ops->init(xfer, direction);
+	if (err < 0)
+		return err;
+
+	return xfer->ops->validate_opts(xfer);
+}
+
+void xfer_context_destroy(struct xfer_context *xfer)
+{
+	assert(xfer);
+
+	if (!xfer->ops)
+		return;
+
+	if (xfer->ops->destroy)
+		xfer->ops->destroy(xfer);
+	if (xfer->private_data)
+		free(xfer->private_data);
+}
+
+int xfer_context_pre_process(struct xfer_context *xfer,
+			     snd_pcm_format_t *format,
+			     unsigned int *samples_per_frame,
+			     unsigned int *frames_per_second,
+			     snd_pcm_access_t *access,
+			     snd_pcm_uframes_t *frames_per_buffer)
+{
+	int err;
+
+	assert(xfer);
+	assert(format);
+	assert(samples_per_frame);
+	assert(frames_per_second);
+	assert(access);
+	assert(frames_per_buffer);
+
+	if (!xfer->ops)
+		return -ENXIO;
+
+	err = xfer->ops->pre_process(xfer, format, samples_per_frame,
+				     frames_per_second, access,
+				     frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	assert(*format >= SND_PCM_FORMAT_S8);
+	assert(*format <= SND_PCM_FORMAT_LAST);
+	assert(*samples_per_frame > 0);
+	assert(*frames_per_second > 0);
+	assert(*access >= SND_PCM_ACCESS_MMAP_INTERLEAVED);
+	assert(*access <= SND_PCM_ACCESS_LAST);
+	assert(*frames_per_buffer > 0);
+
+	if (xfer->verbose > 1) {
+		fprintf(stderr, "Transfer: %s\n",
+			xfer_type_labels[xfer->type]);
+		fprintf(stderr, "  access: %s\n",
+			snd_pcm_access_name(*access));
+		fprintf(stderr, "  sample format: %s\n",
+			snd_pcm_format_name(*format));
+		fprintf(stderr, "  bytes/sample: %u\n",
+		       snd_pcm_format_physical_width(*format) / 8);
+		fprintf(stderr, "  samples/frame: %u\n",
+			*samples_per_frame);
+		fprintf(stderr, "  frames/second: %u\n",
+			*frames_per_second);
+		fprintf(stderr, "  frames/buffer: %lu\n",
+			*frames_per_buffer);
+	}
+
+	return 0;
+}
+
+int xfer_context_process_frames(struct xfer_context *xfer,
+				struct mapper_context *mapper,
+				struct container_context *cntrs,
+				unsigned int *frame_count)
+{
+	assert(xfer);
+	assert(mapper);
+	assert(cntrs);
+	assert(frame_count);
+
+	if (!xfer->ops)
+		return -ENXIO;
+
+	return xfer->ops->process_frames(xfer, frame_count, mapper, cntrs);
+}
+
+void xfer_context_pause(struct xfer_context *xfer, bool enable)
+{
+	assert(xfer);
+
+	if (!xfer->ops)
+		return;
+
+	xfer->ops->pause(xfer, enable);
+}
+
+void xfer_context_post_process(struct xfer_context *xfer)
+{
+	assert(xfer);
+
+	if (!xfer->ops)
+		return;
+
+	xfer->ops->post_process(xfer);
+}
diff --git a/axfer/xfer.h b/axfer/xfer.h
new file mode 100644
index 00000000..3faaec0
--- /dev/null
+++ b/axfer/xfer.h
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// xfer.h - a header for receiver/transmiter of data frames.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_XFER__H_
+#define __ALSA_UTILS_AXFER_XFER__H_
+
+#include "mapper.h"
+
+#include <getopt.h>
+
+enum xfer_type {
+	XFER_TYPE_UNSUPPORTED = -1,
+	XFER_TYPE_COUNT,
+};
+
+struct xfer_ops;
+
+struct xfer_context {
+	snd_pcm_stream_t direction;
+	enum xfer_type type;
+	const struct xfer_ops *ops;
+	void *private_data;
+
+	unsigned int verbose;
+};
+
+enum xfer_type xfer_type_from_label(const char *label);
+
+int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
+		      snd_pcm_stream_t direction, int argc, char *const *argv);
+void xfer_context_destroy(struct xfer_context *xfer);
+int xfer_context_pre_process(struct xfer_context *xfer,
+			     snd_pcm_format_t *format,
+			     unsigned int *samples_per_frame,
+			     unsigned int *frames_per_second,
+			     snd_pcm_access_t *access,
+			     snd_pcm_uframes_t *frames_per_buffer);
+int xfer_context_process_frames(struct xfer_context *xfer,
+				struct mapper_context *mapper,
+				struct container_context *cntrs,
+				unsigned int *frame_count);
+void xfer_context_pause(struct xfer_context *xfer, bool enable);
+void xfer_context_post_process(struct xfer_context *xfer);
+
+// For internal use in 'xfer' module.
+
+struct xfer_ops {
+	int (*init)(struct xfer_context *xfer, snd_pcm_stream_t direction);
+	int (*parse_opt)(struct xfer_context *xfer, int key, const char *optarg);
+	int (*validate_opts)(struct xfer_context *xfer);
+	int (*pre_process)(struct xfer_context *xfer, snd_pcm_format_t *format,
+			   unsigned int *samples_per_frame,
+			   unsigned int *frames_per_second,
+			   snd_pcm_access_t *access,
+			   snd_pcm_uframes_t *frames_per_buffer);
+	int (*process_frames)(struct xfer_context *xfer,
+			      unsigned int *frame_count,
+			      struct mapper_context *mapper,
+			      struct container_context *cntrs);
+	void (*post_process)(struct xfer_context *xfer);
+	void (*destroy)(struct xfer_context *xfer);
+	void (*pause)(struct xfer_context *xfer, bool enable);
+};
+
+struct xfer_data {
+	const char *s_opts;
+	const struct option *l_opts;
+	unsigned int l_opts_count;
+	struct xfer_ops ops;
+	unsigned int private_size;
+};
+
+extern const struct xfer_data xfer_alsa;
+
+#endif
-- 
2.19.1
