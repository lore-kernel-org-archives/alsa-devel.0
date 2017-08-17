From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 10/23] aplay: add an implementation of
	waiter for poll(2)
Date: Thu, 17 Aug 2017 20:59:51 +0900
Message-ID: <20170817120004.15326-11-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F0EF4266EB5
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

This commit adds support for poll(2) system call.
---
 aplay/Makefile.am   |  3 ++-
 aplay/waiter-poll.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/waiter.c      |  2 +-
 aplay/waiter.h      |  3 +++
 4 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 aplay/waiter-poll.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 634124b..a4a353e 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -24,7 +24,8 @@ aplay_SOURCES = \
 	aligner-single.c \
 	aligner-multiple.c \
 	waiter.h \
-	waiter.c
+	waiter.c \
+	waiter-poll.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/waiter-poll.c b/aplay/waiter-poll.c
new file mode 100644
index 0000000..68ef4ae
--- /dev/null
+++ b/aplay/waiter-poll.c
@@ -0,0 +1,66 @@
+/*
+ * waiter-waiter-poll.c - Waiter for event notification by poll(2).
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "waiter.h"
+
+#include <poll.h>
+
+struct poll_state {
+	struct pollfd *pfds;
+	unsigned int count;
+};
+
+static int poll_prepare(struct waiter_context *waiter, int *fds,
+			unsigned int fd_count)
+{
+	struct poll_state *state = waiter->private_data;
+	int i;
+
+	state->pfds = calloc(fd_count, sizeof(struct pollfd));
+	if (state->pfds == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < fd_count; ++i) {
+		state->pfds[i].fd = fds[i];
+		state->pfds[i].events = POLLIN | POLLOUT;
+	}
+
+	state->count = fd_count;
+
+	return 0;
+}
+
+static int poll_wait_event(struct waiter_context *waiter)
+{
+	struct poll_state *state = waiter->private_data;
+	int err;
+
+
+	err = poll(state->pfds, state->count, -1);
+	if (err < 0)
+		return -errno;
+
+	return 0;
+}
+
+static void poll_release(struct waiter_context *waiter)
+{
+	struct poll_state *state = waiter->private_data;
+
+	free(state->pfds);
+	state->pfds = 0;
+}
+
+const struct waiter_data waiter_poll = {
+	.ops = {
+		.prepare	= poll_prepare,
+		.wait_event	= poll_wait_event,
+		.release	= poll_release,
+	},
+	.private_size = sizeof(struct poll_state),
+};
diff --git a/aplay/waiter.c b/aplay/waiter.c
index d29a533..c238bf1 100644
--- a/aplay/waiter.c
+++ b/aplay/waiter.c
@@ -14,7 +14,7 @@ int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
 		enum waiter_type type;
 		const struct waiter_data *waiter;
 	} entries[] = {
-		{WAITER_TYPE_COUNT,	NULL},
+		{WAITER_TYPE_POLL, &waiter_poll},
 	};
 	int i;
 
diff --git a/aplay/waiter.h b/aplay/waiter.h
index c63274a..5059a00 100644
--- a/aplay/waiter.h
+++ b/aplay/waiter.h
@@ -19,6 +19,7 @@
 #endif
 
 enum waiter_type {
+	WAITER_TYPE_POLL = 0,
 	WAITER_TYPE_COUNT,
 };
 
@@ -51,4 +52,6 @@ struct waiter_data {
 	unsigned int private_size;
 };
 
+extern const struct waiter_data waiter_poll;
+
 #endif
-- 
2.11.0
