From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 22/39] axfer: add a common interface of
	waiter for I/O event notification
Date: Mon,  2 Oct 2017 09:19:23 +0900
Message-ID: <20171002001940.17218-23-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 79D7D266FEB
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
 axfer/Makefile.am |  7 ++++--
 axfer/waiter.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 axfer/waiter.h    | 45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 axfer/waiter.c
 create mode 100644 axfer/waiter.h

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index b378442b..f290cca8 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -21,7 +21,8 @@ noinst_HEADERS = \
 	mapper.h
 	options.h \
 	xfer.h \
-	xfer-alsa.h
+	xfer-alsa.h \
+	waiter.h
 
 axfer_SOURCES = \
 	misc.h \
@@ -45,4 +46,6 @@ axfer_SOURCES = \
 	xfer-libasound.h \
 	xfer-libasound.c \
 	xfer-libasound-irq-rw.c \
-	subcmd-transfer.c
+	subcmd-transfer.c \
+	waiter.h \
+	waiter.c
diff --git a/axfer/waiter.c b/axfer/waiter.c
new file mode 100644
index 00000000..dfe42f84
--- /dev/null
+++ b/axfer/waiter.c
@@ -0,0 +1,66 @@
+/*
+ * waiter.c - I/O event waiter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "waiter.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "misc.h"
+
+int waiter_context_init(struct waiter_context *waiter, enum waiter_type type)
+{
+	struct {
+		enum waiter_type type;
+		const struct waiter_data *waiter;
+	} entries[] = {
+		{WAITER_TYPE_COUNT,	NULL},
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
+	waiter->private_data = malloc(entries[i].waiter->private_size);
+	if (waiter->private_data == NULL)
+		return -ENOMEM;
+	memset(waiter->private_data, 0, entries[i].waiter->private_size);
+
+	waiter->type = type;
+	waiter->ops = &entries[i].waiter->ops;
+
+	return 0;
+}
+
+int waiter_context_prepare(struct waiter_context *waiter, int *fds,
+			   unsigned int fd_count)
+{
+	return waiter->ops->prepare(waiter, fds, fd_count);
+}
+
+int waiter_context_wait_event(struct waiter_context *waiter, int timeout_msec)
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
+	if (waiter->private_data)
+		free(waiter->private_data);
+	waiter->private_data = NULL;
+}
diff --git a/axfer/waiter.h b/axfer/waiter.h
new file mode 100644
index 00000000..dbd7ca70
--- /dev/null
+++ b/axfer/waiter.h
@@ -0,0 +1,45 @@
+/*
+ * waiter.h - a header for I/O event waiter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_AXFER_WAITER__H_
+#define __ALSA_UTILS_AXFER_WAITER__H_
+
+enum waiter_type {
+	WAITER_TYPE_COUNT,
+};
+
+struct waiter_ops;
+
+struct waiter_context {
+	enum waiter_type type;
+	const struct waiter_ops *ops;
+	void *private_data;
+};
+
+int waiter_context_init(struct waiter_context *waiter, enum waiter_type type);
+int waiter_context_prepare(struct waiter_context *waiter, int *fds,
+			   unsigned int fd_count);
+int waiter_context_wait_event(struct waiter_context *waiter, int timeout_msec);
+void waiter_context_release(struct waiter_context *waiter);
+void waiter_context_destroy(struct waiter_context *waiter);
+
+/* For internal use in 'waiter' module. */
+
+struct waiter_ops {
+	int (*prepare)(struct waiter_context *waiter, int *fds,
+		       unsigned int fd_count);
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
-- 
2.11.0
