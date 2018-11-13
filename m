From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 31/35] axfer: add an implementation of waiter
	for select(2)
Date: Tue, 13 Nov 2018 15:41:43 +0900
Message-ID: <20181113064147.13577-31-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97277267AC2
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:48 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id w7so5211998pgp.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:48 -0800 (PST)
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

This commit adds support of waiter for select(2) system call.

Below lines are examples to use this option:
$ axfer transfer --waiter-type=select -M -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer --waiter-type=select -M -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am     |   3 +-
 axfer/waiter-select.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.c        |   2 +
 axfer/waiter.h        |   2 +
 4 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 axfer/waiter-select.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 7123006..867007b 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -51,4 +51,5 @@ axfer_SOURCES = \
 	xfer-libasound-irq-mmap.c \
 	waiter.h \
 	waiter.c \
-	waiter-poll.c
+	waiter-poll.c \
+	waiter-select.c
diff --git a/axfer/waiter-select.c b/axfer/waiter-select.c
new file mode 100644
index 00000000..a35ea85
--- /dev/null
+++ b/axfer/waiter-select.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// waiter-select.c - Waiter for event notification by select(2).
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "waiter.h"
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/select.h>
+
+// Except for POLLERR.
+#define POLLIN_SET	(POLLRDNORM | POLLRDBAND | POLLIN | POLLHUP)
+#define POLLOUT_SET	(POLLWRBAND | POLLWRNORM | POLLOUT)
+#define POLLEX_SET	(POLLPRI)
+
+struct select_state {
+	fd_set rfds_rd;
+	fd_set rfds_wr;
+	fd_set rfds_ex;
+};
+
+static int select_prepare(struct waiter_context *waiter)
+{
+	return 0;
+}
+
+static int select_wait_event(struct waiter_context *waiter, int timeout_msec)
+{
+	struct select_state *state = waiter->private_data;
+	struct pollfd *pfd;
+	int fd_max;
+	struct timeval tv, *tv_ptr;
+	int i;
+	int err;
+
+	FD_ZERO(&state->rfds_rd);
+	FD_ZERO(&state->rfds_wr);
+	FD_ZERO(&state->rfds_ex);
+
+	fd_max = 0;
+	for (i = 0; i < waiter->pfd_count; ++i) {
+		pfd = &waiter->pfds[i];
+
+		if (pfd->events & POLLIN_SET)
+			FD_SET(pfd->fd, &state->rfds_rd);
+		if (pfd->events & POLLOUT_SET)
+			FD_SET(pfd->fd, &state->rfds_wr);
+		if (pfd->events & POLLEX_SET)
+			FD_SET(pfd->fd, &state->rfds_ex);
+		if (pfd->fd > fd_max)
+			fd_max = pfd->fd;
+	}
+
+	if (timeout_msec < 0) {
+		tv_ptr = NULL;
+	} else {
+		tv.tv_sec = 0;
+		tv.tv_usec = timeout_msec * 1000;
+		tv_ptr = &tv;
+	}
+
+	err = select(fd_max + 1, &state->rfds_rd, &state->rfds_wr,
+		     &state->rfds_ex, tv_ptr);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < waiter->pfd_count; ++i) {
+		pfd = &waiter->pfds[i];
+
+		pfd->revents = 0;
+		if (FD_ISSET(pfd->fd, &state->rfds_rd))
+			pfd->revents |= POLLIN;
+		if (FD_ISSET(pfd->fd, &state->rfds_wr))
+			pfd->revents |= POLLOUT;
+		if (FD_ISSET(pfd->fd, &state->rfds_ex))
+			pfd->revents |= POLLHUP;
+	}
+
+	return 0;
+}
+
+static void select_release(struct waiter_context *waiter)
+{
+	return;
+}
+
+const struct waiter_data waiter_select = {
+	.ops = {
+		.prepare	= select_prepare,
+		.wait_event	= select_wait_event,
+		.release	= select_release,
+	},
+	.private_size = sizeof(struct select_state),
+};
diff --git a/axfer/waiter.c b/axfer/waiter.c
index 446e617..08428e3 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -17,6 +17,7 @@
 static const char *const waiter_type_labels[] = {
 	[WAITER_TYPE_DEFAULT] = "default",
 	[WAITER_TYPE_POLL] = "poll",
+	[WAITER_TYPE_SELECT] = "select",
 };
 
 enum waiter_type waiter_type_from_label(const char *label)
@@ -44,6 +45,7 @@ int waiter_context_init(struct waiter_context *waiter,
 		const struct waiter_data *waiter;
 	} entries[] = {
 		{WAITER_TYPE_POLL,	&waiter_poll},
+		{WAITER_TYPE_SELECT,	&waiter_select},
 	};
 	int i;
 
diff --git a/axfer/waiter.h b/axfer/waiter.h
index 9366724..fec16b7 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -14,6 +14,7 @@
 enum waiter_type {
 	WAITER_TYPE_DEFAULT = 0,
 	WAITER_TYPE_POLL,
+	WAITER_TYPE_SELECT,
 	WAITER_TYPE_COUNT,
 };
 
@@ -53,5 +54,6 @@ struct waiter_data {
 };
 
 extern const struct waiter_data waiter_poll;
+extern const struct waiter_data waiter_select;
 
 #endif
-- 
2.19.1
