From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: add include/linux/err.h
Date: Tue, 23 Sep 2014 09:04:50 +0200
Message-ID: <1411455890-8324-2-git-send-email-david.henningsson@canonical.com>
References: <1411455890-8324-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AC0AF261B19
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 09:04:54 +0200 (CEST)
In-Reply-To: <1411455890-8324-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

We recently started using it on the kernel side.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/linux/err.h | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/linux/err.h

diff --git a/include/linux/err.h b/include/linux/err.h
new file mode 100644
index 0000000..627729d
--- /dev/null
+++ b/include/linux/err.h
@@ -0,0 +1,64 @@
+#ifndef _LINUX_ERR_H
+#define _LINUX_ERR_H
+
+/*
+ * Kernel pointers have redundant information, so we can use a
+ * scheme where we can return either an error code or a normal
+ * pointer with the same return value.
+ *
+ * This should be a per-architecture thing, to allow different
+ * error and pointer decisions.
+ */
+#define MAX_ERRNO	4095
+
+#define __must_check 
+#define __force
+#define unlikely(x) x
+
+#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
+
+static inline void * __must_check ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long __must_check PTR_ERR(__force const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline bool __must_check IS_ERR(__force const void *ptr)
+{
+	return IS_ERR_VALUE((unsigned long)ptr);
+}
+
+static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
+{
+	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
+}
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * __must_check ERR_CAST(__force const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
+
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+
+/* Deprecated */
+#define PTR_RET(p) PTR_ERR_OR_ZERO(p)
+
+#endif /* _LINUX_ERR_H */
-- 
1.9.1
