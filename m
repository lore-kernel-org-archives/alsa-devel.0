From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 13/23] aplay: add an abstraction for
	transferring of PCM frames
Date: Thu, 17 Aug 2017 20:59:54 +0900
Message-ID: <20170817120004.15326-14-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F2C6A266EC4
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

ALSA has PCM interface to transfer data frames, while the interface includes
several variations of use cases.

This commit adds an abstraction to transfer data frames, named as 'xfer'.
This includes some functions expected to be called by main program.
---
 aplay/Makefile.am |   7 ++--
 aplay/xfer.c      | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/xfer.h      |  71 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 2 deletions(-)
 create mode 100644 aplay/xfer.c
 create mode 100644 aplay/xfer.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 196e1ca..9056f56 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -10,7 +10,8 @@ noinst_HEADERS = \
 	container.h \
 	aligner.h \
 	waiter.h \
-	options.h
+	options.h \
+	xfer.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -29,7 +30,9 @@ aplay_SOURCES = \
 	waiter-poll.c \
 	waiter-epoll.c \
 	options.h \
-	options.c
+	options.c \
+	xfer.h \
+	xfer.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/xfer.c b/aplay/xfer.c
new file mode 100644
index 0000000..3fe094e
--- /dev/null
+++ b/aplay/xfer.c
@@ -0,0 +1,101 @@
+/*
+ * xfer.c - receiver/transmiter of data frames.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer.h"
+
+#include <gettext.h>
+
+static const char *const xfer_type_labels[] = {
+	[XFER_TYPE_ALSA] = "alsa",
+};
+
+int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
+		      snd_pcm_stream_t direction, struct context_options *opts)
+{
+	struct {
+		enum xfer_type type;
+		const struct xfer_data *data;
+	} entries[] = {
+		{XFER_TYPE_ALSA, NULL},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		if (entries[i].type == type)
+			break;
+	}
+	if (i == ARRAY_SIZE(entries))
+		return -EINVAL;
+
+	xfer->type = type;
+	xfer->ops = &entries[i].data->ops;
+	xfer->verbose = opts->verbose;
+
+	xfer->private_data = malloc(entries[i].data->private_size);
+	if (xfer->private_data == NULL)
+		return -ENOMEM;
+	memset(xfer->private_data, 0, entries[i].data->private_size);
+
+	return xfer->ops->init(xfer, direction, opts);
+}
+
+void xfer_context_destroy(struct xfer_context *xfer)
+{
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
+	err = xfer->ops->pre_process(xfer, format, samples_per_frame,
+				     frames_per_second, access,
+				     frames_per_buffer);
+	if (err < 0)
+		return err;
+
+	if (xfer->verbose > 0) {
+		printf("Transfer: %s\n", xfer_type_labels[xfer->type]);
+		printf("  access: %s\n", snd_pcm_access_name(*access));
+		printf("  sample format: %s\n", snd_pcm_format_name(*format));
+		printf("  bytes/sample: %u\n",
+		       snd_pcm_format_physical_width(*format) / 8);
+		printf("  samples/frame: %u\n", *samples_per_frame);
+		printf("  frames/second: %u\n", *frames_per_second);
+		printf("  frames/buffer: %lu\n", *frames_per_buffer);
+		printf("\n");
+	}
+
+	return 0;
+}
+
+int xfer_context_process_frames(struct xfer_context *xfer,
+				struct aligner_context *aligner,
+				struct container_context *cntrs,
+				unsigned int *frame_count)
+{
+	return xfer->ops->process_frames(xfer, frame_count, aligner, cntrs);
+}
+
+void xfer_context_pause(struct xfer_context *xfer, bool enable)
+{
+	xfer->ops->pause(xfer, enable);
+}
+
+void xfer_context_post_process(struct xfer_context *xfer)
+{
+	xfer->ops->post_process(xfer);
+}
diff --git a/aplay/xfer.h b/aplay/xfer.h
new file mode 100644
index 0000000..749fa6c
--- /dev/null
+++ b/aplay/xfer.h
@@ -0,0 +1,71 @@
+/*
+ * xfer.h - a header for receiver/transmiter of data frames.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_XFER__H_
+#define __ALSA_UTILS_APLAY_XFER__H_
+
+#include "aligner.h"
+#include "options.h"
+
+enum xfer_type {
+	XFER_TYPE_ALSA = 0,
+};
+
+struct xfer_ops;
+
+struct xfer_context  {
+	enum xfer_type type;
+	const struct xfer_ops *ops;
+	void *private_data;
+
+	unsigned int verbose;
+};
+
+int xfer_context_init(struct xfer_context *xfer, enum xfer_type type,
+		      snd_pcm_stream_t direction, struct context_options *opts);
+void xfer_context_destroy(struct xfer_context *xfer);
+int xfer_context_pre_process(struct xfer_context *xfer,
+			     snd_pcm_format_t *format,
+			     unsigned int *samples_per_frame,
+			     unsigned int *frames_per_second,
+			     snd_pcm_access_t *access,
+			     snd_pcm_uframes_t *frames_per_buffer);
+int xfer_context_process_frames(struct xfer_context *xfer,
+				struct aligner_context *aligner,
+				struct container_context *cntrs,
+				unsigned int *frame_count);
+void xfer_context_pause(struct xfer_context *xfer, bool enable);
+void xfer_context_post_process(struct xfer_context *xfer);
+
+/* For internal use in 'xfer' module. */
+
+struct xfer_ops {
+	int (*init)(struct xfer_context *xfer, snd_pcm_stream_t direction,
+		    struct context_options *opts);
+	int (*pre_process)(struct xfer_context *xfer, snd_pcm_format_t *format,
+			   unsigned int *samples_per_frame,
+			   unsigned int *frames_per_second,
+			   snd_pcm_access_t *access,
+			   snd_pcm_uframes_t *frames_per_buffer);
+	int (*process_frames)(struct xfer_context *xfer,
+			      unsigned int *frame_count,
+			      struct aligner_context *aligner,
+			      struct container_context *cntrs);
+	void (*post_process)(struct xfer_context *xfer);
+	void (*destroy)(struct xfer_context *xfer);
+	void (*pause)(struct xfer_context *xfer, bool enable);
+};
+
+struct xfer_data {
+	struct xfer_ops ops;
+	unsigned int private_size;
+};
+
+extern const struct xfer_data xfer_alsa;
+
+#endif
-- 
2.11.0
