From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 32/35] axfer: add an implementation of waiter
	for epoll(7)
Date: Tue, 13 Nov 2018 15:41:44 +0900
Message-ID: <20181113064147.13577-32-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 39345267AE5
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:50 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id 64so1069816pfr.9
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:50 -0800 (PST)
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

This commit adds support of waiter for Linux specific epoll(7) system call.
For portability to the other Unix-like systems such as xBSD, modification
of Makefile.am may be required for conditional build, but this commit
includes no changes for it.

Below lines are examples to use this option:
$ axfer transfer --waiter-type=epoll -M -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer --waiter-type=epoll -M -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am    |   3 +-
 axfer/waiter-epoll.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.c       |   2 +
 axfer/waiter.h       |   2 +
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 axfer/waiter-epoll.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 867007b..ab1d0b4 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -52,4 +52,5 @@ axfer_SOURCES = \
 	waiter.h \
 	waiter.c \
 	waiter-poll.c \
-	waiter-select.c
+	waiter-select.c \
+	waiter-epoll.c
diff --git a/axfer/waiter-epoll.c b/axfer/waiter-epoll.c
new file mode 100644
index 00000000..8f084f1
--- /dev/null
+++ b/axfer/waiter-epoll.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// waiter-epoll.c - Waiter for event notification by epoll(7).
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "waiter.h"
+#include "misc.h"
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/epoll.h>
+
+struct epoll_state {
+	int epfd;
+	struct epoll_event *events;
+	unsigned int ev_count;
+};
+
+static int epoll_prepare(struct waiter_context *waiter)
+{
+	struct epoll_state *state = waiter->private_data;
+	int i;
+
+	state->ev_count = waiter->pfd_count;
+	state->events = calloc(state->ev_count, sizeof(*state->events));
+	if (state->events == NULL)
+		return -ENOMEM;
+
+	state->epfd = epoll_create(1);
+	if (state->epfd < 0)
+		return -errno;
+
+	for (i = 0; i < waiter->pfd_count; ++i) {
+		struct epoll_event ev = {
+			.data.fd = waiter->pfds[i].fd,
+			.events = waiter->pfds[i].events,
+		};
+		if (epoll_ctl(state->epfd, EPOLL_CTL_ADD, ev.data.fd, &ev) < 0)
+			return -errno;
+	}
+
+	return 0;
+}
+
+static int epoll_wait_event(struct waiter_context *waiter, int timeout_msec)
+{
+	struct epoll_state *state = waiter->private_data;
+	unsigned int ev_count;
+	int i, j;
+	int err;
+
+	memset(state->events, 0, state->ev_count * sizeof(*state->events));
+	err = epoll_wait(state->epfd, state->events, state->ev_count,
+			 timeout_msec);
+	if (err < 0)
+		return -errno;
+	ev_count = (unsigned int)err;
+
+	if (ev_count > 0) {
+		// Reconstruct data of pollfd structure.
+		for (i = 0; i < ev_count; ++i) {
+			struct epoll_event *ev = &state->events[i];
+			for (j = 0; j < waiter->pfd_count; ++j) {
+				if (waiter->pfds[i].fd == ev->data.fd) {
+					waiter->pfds[i].revents = ev->events;
+					break;
+				}
+			}
+		}
+	}
+
+	return ev_count;
+}
+
+static void epoll_release(struct waiter_context *waiter)
+{
+	struct epoll_state *state = waiter->private_data;
+	int i;
+
+	for (i = 0; i < waiter->pfd_count; ++i) {
+		int fd = waiter->pfds[i].fd;
+		epoll_ctl(state->epfd, EPOLL_CTL_DEL, fd, NULL);
+	}
+
+	free(state->events);
+	state->events = NULL;
+
+	close(state->epfd);
+
+	state->ev_count = 0;
+	state->epfd = 0;
+}
+
+const struct waiter_data waiter_epoll = {
+	.ops = {
+		.prepare	= epoll_prepare,
+		.wait_event	= epoll_wait_event,
+		.release	= epoll_release,
+	},
+	.private_size = sizeof(struct epoll_state),
+};
diff --git a/axfer/waiter.c b/axfer/waiter.c
index 08428e3..1e9c811 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -18,6 +18,7 @@ static const char *const waiter_type_labels[] = {
 	[WAITER_TYPE_DEFAULT] = "default",
 	[WAITER_TYPE_POLL] = "poll",
 	[WAITER_TYPE_SELECT] = "select",
+	[WAITER_TYPE_EPOLL] = "epoll",
 };
 
 enum waiter_type waiter_type_from_label(const char *label)
@@ -46,6 +47,7 @@ int waiter_context_init(struct waiter_context *waiter,
 	} entries[] = {
 		{WAITER_TYPE_POLL,	&waiter_poll},
 		{WAITER_TYPE_SELECT,	&waiter_select},
+		{WAITER_TYPE_EPOLL,	&waiter_epoll},
 	};
 	int i;
 
diff --git a/axfer/waiter.h b/axfer/waiter.h
index fec16b7..db18e33 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -15,6 +15,7 @@ enum waiter_type {
 	WAITER_TYPE_DEFAULT = 0,
 	WAITER_TYPE_POLL,
 	WAITER_TYPE_SELECT,
+	WAITER_TYPE_EPOLL,
 	WAITER_TYPE_COUNT,
 };
 
@@ -55,5 +56,6 @@ struct waiter_data {
 
 extern const struct waiter_data waiter_poll;
 extern const struct waiter_data waiter_select;
+extern const struct waiter_data waiter_epoll;
 
 #endif
-- 
2.19.1
