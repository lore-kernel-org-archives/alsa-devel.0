From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 11/23] aplay: add an implementation of
	waiter for epoll(7)
Date: Thu, 17 Aug 2017 20:59:52 +0900
Message-ID: <20170817120004.15326-12-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EA42F266DFD
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

This commit adds support for Linux specific epoll(7) system call.
---
 aplay/Makefile.am    |  3 ++-
 aplay/waiter-epoll.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/waiter.c       |  1 +
 aplay/waiter.h       |  2 ++
 4 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 aplay/waiter-epoll.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index a4a353e..4042bbe 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -25,7 +25,8 @@ aplay_SOURCES = \
 	aligner-multiple.c \
 	waiter.h \
 	waiter.c \
-	waiter-poll.c
+	waiter-poll.c \
+	waiter-epoll.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/waiter-epoll.c b/aplay/waiter-epoll.c
new file mode 100644
index 0000000..579f16c
--- /dev/null
+++ b/aplay/waiter-epoll.c
@@ -0,0 +1,76 @@
+/*
+ * waiter-waiter-epoll.c - Waiter for event notification by epoll(7).
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "waiter.h"
+
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
+static int epoll_wait_event(struct waiter_context *waiter)
+{
+	struct epoll_state *state = waiter->private_data;
+	int err;
+
+	err = epoll_wait(state->epfd, state->events, state->count, 0);
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
diff --git a/aplay/waiter.c b/aplay/waiter.c
index c238bf1..b822359 100644
--- a/aplay/waiter.c
+++ b/aplay/waiter.c
@@ -15,6 +15,7 @@ int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
 		const struct waiter_data *waiter;
 	} entries[] = {
 		{WAITER_TYPE_POLL, &waiter_poll},
+		{WAITER_TYPE_EPOLL, &waiter_epoll},
 	};
 	int i;
 
diff --git a/aplay/waiter.h b/aplay/waiter.h
index 5059a00..0fb508f 100644
--- a/aplay/waiter.h
+++ b/aplay/waiter.h
@@ -20,6 +20,7 @@
 
 enum waiter_type {
 	WAITER_TYPE_POLL = 0,
+	WAITER_TYPE_EPOLL = 0,
 	WAITER_TYPE_COUNT,
 };
 
@@ -53,5 +54,6 @@ struct waiter_data {
 };
 
 extern const struct waiter_data waiter_poll;
+extern const struct waiter_data waiter_epoll;
 
 #endif
-- 
2.11.0
