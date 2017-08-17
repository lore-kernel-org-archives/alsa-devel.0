From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 09/23] aplay: add an abstruction of waiter
	for I/O event notification
Date: Thu, 17 Aug 2017 20:59:50 +0900
Message-ID: <20170817120004.15326-10-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E7DE2266BFD
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

There're several types of system calls for multiplexed I/O. They're used to
receive notifications of I/O events. Typically, userspace applications call
it for file descriptor to yield CPU. When I/O is enabled, process of the
application is rescheduled, then the application execute I/O calls.

This commit adds an abstraction of the calls, named as 'waiter'. This is
expected to be used with non-blocking file operation.
---
 aplay/Makefile.am |  7 +++++--
 aplay/waiter.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 aplay/waiter.h    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 aplay/waiter.c
 create mode 100644 aplay/waiter.h

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 79f1535..634124b 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -8,7 +8,8 @@ man_MANS = aplay.1 arecord.1
 noinst_HEADERS = \
 	formats.h \
 	container.h \
-	aligner.h
+	aligner.h \
+	waiter.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -21,7 +22,9 @@ aplay_SOURCES = \
 	aligner.h \
 	aligner.c \
 	aligner-single.c \
-	aligner-multiple.c
+	aligner-multiple.c \
+	waiter.h \
+	waiter.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/waiter.c b/aplay/waiter.c
new file mode 100644
index 0000000..d29a533
--- /dev/null
+++ b/aplay/waiter.c
@@ -0,0 +1,60 @@
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
+int waiter_context_wait_event(struct waiter_context *waiter)
+{
+	return waiter->ops->wait_event(waiter);
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
diff --git a/aplay/waiter.h b/aplay/waiter.h
new file mode 100644
index 0000000..c63274a
--- /dev/null
+++ b/aplay/waiter.h
@@ -0,0 +1,54 @@
+/*
+ * waiter.h - a header for I/O event waiter.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_WAITER__H_
+#define __ALSA_UTILS_APLAY_WAITER__H_
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(array)	(sizeof(array)/sizeof(array[0]))
+#endif
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
+int waiter_context_wait_event(struct waiter_context *waiter);
+void waiter_context_release(struct waiter_context *waiter);
+void waiter_context_destroy(struct waiter_context *waiter);
+
+/* For internal use in 'waiter' module. */
+
+struct waiter_ops {
+	int (*prepare)(struct waiter_context *waiter, int *fds,
+		       unsigned int fd_count);
+	int (*wait_event)(struct waiter_context *waiter);
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
