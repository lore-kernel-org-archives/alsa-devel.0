From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] add atomic operations for Blackfin parts
Date: Sun, 17 Jan 2010 16:55:03 -0500
Message-ID: <1263765303-7175-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 37A14103805
	for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2010 22:55:04 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 500C81B4019
	for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2010 21:55:00 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/iatomic.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/iatomic.h b/include/iatomic.h
index 8f6ec22..e92dbfd 100644
--- a/include/iatomic.h
+++ b/include/iatomic.h
@@ -1079,6 +1079,29 @@ static __inline__ int atomic_sub_return(int i, volatile atomic_t *v)
 
 #endif /* __sh__ */
 
+#ifdef __bfin__
+
+#include <bfin_fixed_code.h>
+
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)   { (i) }
+
+#define atomic_read(v)   ((v)->counter)
+#define atomic_set(v,i)  (((v)->counter) = (i))
+#define atomic_add(i,v)  bfin_atomic_add32(&(v)->counter, i)
+#define atomic_sub(i,v)  bfin_atomic_sub32(&(v)->counter, i)
+#define atomic_inc(v)    bfin_atomic_inc32(&(v)->counter);
+#define atomic_dec(v)    bfin_atomic_dec32(&(v)->counter);
+
+#define mb() __asm__ __volatile__ ("" : : : "memory")
+#define rmb() mb()
+#define wmb() mb()
+
+#define IATOMIC_DEFINED 1
+
+#endif /* __bfin__ */
+
 #ifndef IATOMIC_DEFINED
 /*
  * non supported architecture.
-- 
1.6.6
