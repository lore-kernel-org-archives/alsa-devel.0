From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 30/35] axfer: add an implementation of waiter
	for poll(2)
Date: Tue, 13 Nov 2018 15:41:42 +0900
Message-ID: <20181113064147.13577-30-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF08E267B80
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:46 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so5537318pfn.8
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:46 -0800 (PST)
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

This commit adds support of waiter for poll(2) system call.

Below lines are examples to use this option:
$ axfer transfer --waiter-type=poll -M -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer --waiter-type=poll -M -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am   |  3 ++-
 axfer/waiter-poll.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.c      |  3 ++-
 axfer/waiter.h      |  3 +++
 4 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 axfer/waiter-poll.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index e425a28..7123006 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -50,4 +50,5 @@ axfer_SOURCES = \
 	subcmd-transfer.c \
 	xfer-libasound-irq-mmap.c \
 	waiter.h \
-	waiter.c
+	waiter.c \
+	waiter-poll.c
diff --git a/axfer/waiter-poll.c b/axfer/waiter-poll.c
new file mode 100644
index 00000000..61aa1a0
--- /dev/null
+++ b/axfer/waiter-poll.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// waiter-poll.c - Waiter for event notification by poll(2).
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "waiter.h"
+#include "misc.h"
+
+#include <stdlib.h>
+#include <errno.h>
+#include <poll.h>
+
+static int poll_prepare(struct waiter_context *waiter)
+{
+	// Nothing to do because an instance of waiter has required data.
+	return 0;
+}
+
+static int poll_wait_event(struct waiter_context *waiter, int timeout_msec)
+{
+	int err;
+
+	err = poll(waiter->pfds, waiter->pfd_count, timeout_msec);
+	if (err < 0)
+		return -errno;
+
+	return err;
+}
+
+static void poll_release(struct waiter_context *waiter)
+{
+	// Nothing to do because an instance of waiter has required data.
+	return;
+}
+
+const struct waiter_data waiter_poll = {
+	.ops = {
+		.prepare	= poll_prepare,
+		.wait_event	= poll_wait_event,
+		.release	= poll_release,
+	},
+};
diff --git a/axfer/waiter.c b/axfer/waiter.c
index 0bc4740..446e617 100644
--- a/axfer/waiter.c
+++ b/axfer/waiter.c
@@ -16,6 +16,7 @@
 
 static const char *const waiter_type_labels[] = {
 	[WAITER_TYPE_DEFAULT] = "default",
+	[WAITER_TYPE_POLL] = "poll",
 };
 
 enum waiter_type waiter_type_from_label(const char *label)
@@ -42,7 +43,7 @@ int waiter_context_init(struct waiter_context *waiter,
 		enum waiter_type type;
 		const struct waiter_data *waiter;
 	} entries[] = {
-		{WAITER_TYPE_COUNT,	NULL},
+		{WAITER_TYPE_POLL,	&waiter_poll},
 	};
 	int i;
 
diff --git a/axfer/waiter.h b/axfer/waiter.h
index 17e01cb..9366724 100644
--- a/axfer/waiter.h
+++ b/axfer/waiter.h
@@ -13,6 +13,7 @@
 
 enum waiter_type {
 	WAITER_TYPE_DEFAULT = 0,
+	WAITER_TYPE_POLL,
 	WAITER_TYPE_COUNT,
 };
 
@@ -51,4 +52,6 @@ struct waiter_data {
 	unsigned int private_size;
 };
 
+extern const struct waiter_data waiter_poll;
+
 #endif
-- 
2.19.1
