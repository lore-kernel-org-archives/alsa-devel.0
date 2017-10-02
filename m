From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 30/39] axfer: add an implementation of
	waiter for epoll(7)
Date: Mon,  2 Oct 2017 09:19:31 +0900
Message-ID: <20171002001940.17218-31-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id AAD9D26701A
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:54 +0200 (CEST)
In-Reply-To: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This commit adds support of waiter for Linux specific epoll(7) system call.
For portability to the other Unix-like systems such as xBSD, modification
of Makefile.am may be required for conditional build, but this commit
includes no changes for it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am    |  3 +-
 axfer/waiter-epoll.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.c       |  1 +
 axfer/waiter.h       |  2 ++
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 axfer/waiter-epoll.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index 79592bc8..60ad3a84 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -50,4 +50,5 @@ axfer_SOURCES = \
 	waiter.h \
 	waiter.c \
 	waiter-poll.c \
-	xfer-libasound-irq-mmap.c
+	xfer-libasound-irq-mmap.c \
+	waiter-epoll.c
diff --git a/axfer/waiter-epoll.c b/axfer/waiter-epoll.c
new file mode 100644
index 00000000..33bf8d89
--- /dev/null
+++ b/axfer/waiter-epoll.c
@@ -0,0 +1,81 @@
+/*
+ * waiter-epoll.c - Waiter for event notification by epoll(7).
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "waiter.h"
+#include "misc.h"
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/epoll.h>
+
+struct epoll_state {
+	int epfd;
+	struct epoll_event *events;
+	unsigned int count;
+};
+
+static int epoll_prepare(struct waiter_context *waiter, int *fds,
+			 unsigned int fd_count)
+{
+	struct epoll_state *state = waiter->private_data;
+	int i;
+
+	state->events = calloc(fd_count, sizeof(struct epoll_event));
+	if (state->events == NULL)
+		return -ENOMEM;
+	state->count = fd_count;
+
+	state->epfd = epoll_create(1);
+	if (state->epfd < 0)
+		return -errno;
+
+	for (i = 0; i < fd_count; ++i) {
+		struct epoll_event *ev = &state->events[i];
+		ev->events = EPOLLIN | EPOLLOUT;
+		if (epoll_ctl(state->epfd, EPOLL_CTL_ADD, fds[i], ev) < 0)
+			return -errno;
+	}
+
+	return 0;
+}
+
+static int epoll_wait_event(struct waiter_context *waiter, int timeout_msec)
+{
+	struct epoll_state *state = waiter->private_data;
+	int err;
+
+	err = epoll_wait(state->epfd, state->events, state->count, timeout_msec);
+	if (err < 0)
+		return -errno;
+
+	return 0;
+}
+
+static void epoll_release(struct waiter_context *waiter)
+{
+	struct epoll_state *state = waiter->private_data;
+
+	if (state->events)
+		free(state->events);
+
+	close(state->epfd);
+
+	state->events = NULL;
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
index 045b7f31..f4e21a16 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -21,6 +21,7 @@ int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
 		const struct waiter_data *waiter;
 	} entries[] = {
 		{WAITER_TYPE_POLL, &waiter_poll},
+		{WAITER_TYPE_EPOLL, &waiter_epoll},
 	};
 	int i;
 
diff --git a/axfer/waiter.h b/axfer/waiter.h
index 00147f45..3f0dd744 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -11,6 +11,7 @@
 
 enum waiter_type {
 	WAITER_TYPE_POLL = 0,
+	WAITER_TYPE_EPOLL,
 	WAITER_TYPE_COUNT,
 };
 
@@ -44,5 +45,6 @@ struct waiter_data {
 };
 
 extern const struct waiter_data waiter_poll;
+extern const struct waiter_data waiter_epoll;
 
 #endif
-- 
2.11.0
