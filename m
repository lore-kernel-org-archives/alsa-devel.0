From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 28/35] axfer: add a common interface of waiter
	for I/O event notification
Date: Tue, 13 Nov 2018 15:41:40 +0900
Message-ID: <20181113064147.13577-28-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 91F2F267B6C
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:43 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id t13so2542810ply.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:43 -0800 (PST)
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

There're several types of system calls for multiplexed I/O. They're used to
receive notifications of I/O events. Typically, userspace applications call
them against file descriptor to yield CPU. When I/O is enabled on any of
the descriptors, a task of the application is rescheduled, then the
application execute I/O calls.

This commit adds a common interface for this type of system calls, named as
'waiter'. This is expected to be used with non-blocking file operation and
operations on mapped page frame.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am               |  5 +-
 axfer/waiter.c                  | 99 +++++++++++++++++++++++++++++++++
 axfer/waiter.h                  | 54 ++++++++++++++++++
 axfer/xfer-libasound-irq-mmap.c | 14 ++++-
 axfer/xfer-libasound-irq-rw.c   | 26 ++++++++-
 axfer/xfer-libasound.c          | 76 +++++++++++++++++++++++++
 axfer/xfer-libasound.h          |  7 +++
 7 files changed, 277 insertions(+), 4 deletions(-)
 create mode 100644 axfer/waiter.c
 create mode 100644 axfer/waiter.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 960811e..e425a28 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -22,6 +22,7 @@ noinst_HEADERS = \
 	xfer.h \
 	xfer-libasound.h \
 	frame-cache.h
+	waiter.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -47,4 +48,6 @@ axfer_SOURCES = \
 	frame-cache.c \
 	xfer-libasound-irq-rw.c \
 	subcmd-transfer.c \
-	xfer-libasound-irq-mmap.c
+	xfer-libasound-irq-mmap.c \
+	waiter.h \
+	waiter.c
diff --git a/axfer/waiter.c b/axfer/waiter.c
new file mode 100644
index 00000000..0bc4740
--- /dev/null
+++ b/axfer/waiter.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// waiter.c - I/O event waiter.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "waiter.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "misc.h"
+
+static const char *const waiter_type_labels[] = {
+	[WAITER_TYPE_DEFAULT] = "default",
+};
+
+enum waiter_type waiter_type_from_label(const char *label)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(waiter_type_labels); ++i) {
+		if (!strcmp(waiter_type_labels[i], label))
+			return i;
+	}
+
+	return WAITER_TYPE_DEFAULT;
+}
+
+const char *waiter_label_from_type(enum waiter_type type)
+{
+	return waiter_type_labels[type];
+}
+
+int waiter_context_init(struct waiter_context *waiter,
+			enum waiter_type type, unsigned int pfd_count)
+{
+	struct {
+		enum waiter_type type;
+		const struct waiter_data *waiter;
+	} entries[] = {
+		{WAITER_TYPE_COUNT,	NULL},
+	};
+	int i;
+
+	if (pfd_count == 0)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		if (entries[i].type == type)
+			break;
+	}
+	if (i == ARRAY_SIZE(entries))
+		return -EINVAL;
+
+	waiter->private_data = malloc(entries[i].waiter->private_size);
+	if (waiter->private_data == NULL)
+		return -ENOMEM;
+	memset(waiter->private_data, 0, entries[i].waiter->private_size);
+
+	waiter->type = type;
+	waiter->ops = &entries[i].waiter->ops;
+
+	waiter->pfds = calloc(pfd_count, sizeof(*waiter->pfds));
+	if (waiter->pfds == NULL)
+		return -ENOMEM;
+	waiter->pfd_count = pfd_count;
+
+	return 0;
+}
+
+int waiter_context_prepare(struct waiter_context *waiter)
+{
+	return waiter->ops->prepare(waiter);
+}
+
+int waiter_context_wait_event(struct waiter_context *waiter,
+				int timeout_msec)
+{
+	return waiter->ops->wait_event(waiter, timeout_msec);
+}
+
+void waiter_context_release(struct waiter_context *waiter)
+{
+	waiter->ops->release(waiter);
+}
+
+void waiter_context_destroy(struct waiter_context *waiter)
+{
+	if (waiter->pfds)
+		free(waiter->pfds);
+	waiter->pfd_count = 0;
+	if (waiter->private_data)
+		free(waiter->private_data);
+	waiter->private_data = NULL;
+}
diff --git a/axfer/waiter.h b/axfer/waiter.h
new file mode 100644
index 00000000..17e01cb
--- /dev/null
+++ b/axfer/waiter.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// waiter.h - a header for I/O event waiter.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_WAITER__H_
+#define __ALSA_UTILS_AXFER_WAITER__H_
+
+#include <poll.h>
+
+enum waiter_type {
+	WAITER_TYPE_DEFAULT = 0,
+	WAITER_TYPE_COUNT,
+};
+
+struct waiter_ops;
+
+struct waiter_context {
+	enum waiter_type type;
+	const struct waiter_ops *ops;
+	void *private_data;
+
+	struct pollfd *pfds;
+	unsigned int pfd_count;
+};
+
+enum waiter_type waiter_type_from_label(const char *label);
+const char *waiter_label_from_type(enum waiter_type type);
+
+int waiter_context_init(struct waiter_context *waiter,
+			enum waiter_type type, unsigned int pfd_count);
+int waiter_context_prepare(struct waiter_context *waiter);
+int waiter_context_wait_event(struct waiter_context *waiter,
+				int timeout_msec);
+void waiter_context_release(struct waiter_context *waiter);
+void waiter_context_destroy(struct waiter_context *waiter);
+
+// For internal use in 'waiter' module.
+
+struct waiter_ops {
+	int (*prepare)(struct waiter_context *waiter);
+	int (*wait_event)(struct waiter_context *waiter, int timeout_msec);
+	void (*release)(struct waiter_context *waiter);
+};
+
+struct waiter_data {
+	struct waiter_ops ops;
+	unsigned int private_size;
+};
+
+#endif
diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
index 18f6dfe..0c96ee5 100644
--- a/axfer/xfer-libasound-irq-mmap.c
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -82,10 +82,22 @@ static int irq_mmap_process_frames(struct libasound_state *state,
 	int err;
 
 	if (state->use_waiter) {
+		unsigned short revents;
+
 		// Wait for hardware IRQ when no avail space in buffer.
-		err = snd_pcm_wait(state->handle, -1);
+		err = xfer_libasound_wait_event(state, -1, &revents);
 		if (err < 0)
 			return err;
+		if (revents & POLLERR) {
+			// TODO: error reporting?
+			return -EIO;
+		}
+		if (!(revents & (POLLIN | POLLOUT)))
+			return -EAGAIN;
+
+		// When rescheduled, current position of data transmission was
+		// queried to actual hardware by a handler of IRQ. No need to
+		// perform it; e.g. ioctl(2) with SNDRV_PCM_IOCTL_HWSYNC.
 	}
 
 	// Sync cache in user space to data in kernel space to calculate avail
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index 625c095..cf4155f 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -134,10 +134,21 @@ static int r_process_frames_nonblocking(struct libasound_state *state,
 	}
 
 	if (state->use_waiter) {
+		unsigned short revents;
+
 		// Wait for hardware IRQ when no available space.
-		err = snd_pcm_wait(state->handle, -1);
+		err = xfer_libasound_wait_event(state, -1, &revents);
 		if (err < 0)
 			goto error;
+		if (revents & POLLERR) {
+			// TODO: error reporting.
+			err = -EIO;
+			goto error;
+		}
+		if (!(revents & POLLIN)) {
+			err = -EAGAIN;
+			goto error;
+		}
 	}
 
 	// Check available space on the buffer.
@@ -289,10 +300,21 @@ static int w_process_frames_nonblocking(struct libasound_state *state,
 	int err;
 
 	if (state->use_waiter) {
+		unsigned short revents;
+
 		// Wait for hardware IRQ when no left space.
-		err = snd_pcm_wait(state->handle, -1);
+		err = xfer_libasound_wait_event(state, -1, &revents);
 		if (err < 0)
 			goto error;
+		if (revents & POLLERR) {
+			// TODO: error reporting.
+			err = -EIO;
+			goto error;
+		}
+		if (!(revents & POLLOUT)) {
+			err = -EAGAIN;
+			goto error;
+		}
 	}
 
 	// Check available space on the buffer.
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index a731423..5cef9f1 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -201,6 +201,7 @@ static int open_handle(struct xfer_context *xfer)
 
 	if ((state->nonblock || state->mmap) && !state->test_nowait)
 		state->use_waiter = true;
+	state->waiter_type = WAITER_TYPE_DEFAULT;
 
 	err = snd_pcm_hw_params_any(state->handle, state->hw_params);
 	if (err < 0)
@@ -220,6 +221,66 @@ static int open_handle(struct xfer_context *xfer)
 	return set_access_hw_param(state);
 }
 
+static int prepare_waiter(struct libasound_state *state)
+{
+	unsigned int pfd_count;
+	int err;
+
+	// Nothing to do for dafault waiter (=snd_pcm_wait()).
+	if (state->waiter_type == WAITER_TYPE_DEFAULT)
+		return 0;
+
+	err = snd_pcm_poll_descriptors_count(state->handle);
+	if (err < 0)
+		return err;
+	if (err == 0)
+		return -ENXIO;
+	pfd_count = (unsigned int)err;
+
+	state->waiter = malloc(sizeof(*state->waiter));
+	if (state->waiter == NULL)
+		return -ENOMEM;
+
+	err = waiter_context_init(state->waiter, state->waiter_type, pfd_count);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_poll_descriptors(state->handle, state->waiter->pfds,
+				       pfd_count);
+	if (err < 0)
+		return err;
+
+	return waiter_context_prepare(state->waiter);
+}
+
+int xfer_libasound_wait_event(struct libasound_state *state, int timeout_msec,
+			      unsigned short *revents)
+{
+	int err;
+
+	if (state->waiter_type != WAITER_TYPE_DEFAULT) {
+		struct waiter_context *waiter = state->waiter;
+
+		err = waiter_context_wait_event(waiter, timeout_msec);
+		if (err < 0)
+			return err;
+
+		err = snd_pcm_poll_descriptors_revents(state->handle,
+				waiter->pfds, waiter->pfd_count, revents);
+	} else {
+		err = snd_pcm_wait(state->handle, timeout_msec);
+		if (err < 0)
+			return err;
+
+		if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_PLAYBACK)
+			*revents = POLLOUT;
+		else
+			*revents = POLLIN;
+	}
+
+	return err;
+}
+
 static int configure_hw_params(struct libasound_state *state,
 			       snd_pcm_format_t format,
 			       unsigned int samples_per_frame,
@@ -559,6 +620,21 @@ static int xfer_libasound_pre_process(struct xfer_context *xfer,
 	if (xfer->verbose > 0)
 		snd_pcm_dump(state->handle, state->log);
 
+	if (state->use_waiter) {
+		// NOTE: This should be after configuring sw_params due to
+		// timer descriptor for time-based scheduling model.
+		err = prepare_waiter(state);
+		if (err < 0)
+			return err;
+
+		if (xfer->verbose > 0) {
+			logging(state, "Waiter type:\n");
+			logging(state,
+				"  %s\n",
+				waiter_label_from_type(state->waiter_type));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index cf940e5..0bcfb40 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_AXFER_XFER_LIBASOUND__H_
 
 #include "xfer.h"
+#include "waiter.h"
 
 #define logging(state, ...) \
 	snd_output_printf(state->log, __VA_ARGS__)
@@ -49,6 +50,9 @@ struct libasound_state {
 	bool no_softvol:1;
 
 	bool use_waiter:1;
+
+	enum waiter_type waiter_type;
+	struct waiter_context *waiter;
 };
 
 // For internal use in 'libasound' module.
@@ -63,6 +67,9 @@ struct xfer_libasound_ops {
 	unsigned int private_size;
 };
 
+int xfer_libasound_wait_event(struct libasound_state *state, int timeout_msec,
+			      unsigned short *revents);
+
 extern const struct xfer_libasound_ops xfer_libasound_irq_rw_ops;
 
 extern const struct xfer_libasound_ops xfer_libasound_irq_mmap_r_ops;
-- 
2.19.1
