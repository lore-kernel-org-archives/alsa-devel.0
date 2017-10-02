From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 23/39] axfer: add support of waiter for
	poll(2)
Date: Mon,  2 Oct 2017 09:19:24 +0900
Message-ID: <20171002001940.17218-24-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 7AF6A266FEC
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

This commit adds support of waiter for poll(2) system call.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am   |  3 ++-
 axfer/waiter-poll.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.c      |  2 +-
 axfer/waiter.h      |  3 +++
 4 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 axfer/waiter-poll.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index f290cca8..a4e9f1bc 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -48,4 +48,5 @@ axfer_SOURCES = \
 	xfer-libasound-irq-rw.c \
 	subcmd-transfer.c \
 	waiter.h \
-	waiter.c
+	waiter.c \
+	waiter-poll.c
diff --git a/axfer/waiter-poll.c b/axfer/waiter-poll.c
new file mode 100644
index 00000000..70813ee0
--- /dev/null
+++ b/axfer/waiter-poll.c
@@ -0,0 +1,68 @@
+/*
+ * waiter-waiter-poll.c - Waiter for event notification by poll(2).
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
+#include <errno.h>
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
+static int poll_wait_event(struct waiter_context *waiter, int timeout_msec)
+{
+	struct poll_state *state = waiter->private_data;
+	int err;
+
+	err = poll(state->pfds, state->count, timeout_msec);
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
diff --git a/axfer/waiter.c b/axfer/waiter.c
index dfe42f84..045b7f31 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -20,7 +20,7 @@ int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
 		enum waiter_type type;
 		const struct waiter_data *waiter;
 	} entries[] = {
-		{WAITER_TYPE_COUNT,	NULL},
+		{WAITER_TYPE_POLL, &waiter_poll},
 	};
 	int i;
 
diff --git a/axfer/waiter.h b/axfer/waiter.h
index dbd7ca70..00147f45 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -10,6 +10,7 @@
 #define __ALSA_UTILS_AXFER_WAITER__H_
 
 enum waiter_type {
+	WAITER_TYPE_POLL = 0,
 	WAITER_TYPE_COUNT,
 };
 
@@ -42,4 +43,6 @@ struct waiter_data {
 	unsigned int private_size;
 };
 
+extern const struct waiter_data waiter_poll;
+
 #endif
-- 
2.11.0
