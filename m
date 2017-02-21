From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/9] tools: convert comm_str.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:34:57 +0200
Message-ID: <1487691303-31858-4-git-send-email-elena.reshetova@intel.com>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/perf/util/comm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 21b7ff3..0fd3d70 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -2,12 +2,12 @@
 #include "util.h"
 #include <stdlib.h>
 #include <stdio.h>
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 
 struct comm_str {
 	char *str;
 	struct rb_node rb_node;
-	atomic_t refcnt;
+	refcount_t refcnt;
 };
 
 /* Should perhaps be moved to struct machine */
@@ -16,13 +16,13 @@ static struct rb_root comm_str_root;
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
 	if (cs)
-		atomic_inc(&cs->refcnt);
+		refcount_inc(&cs->refcnt);
 	return cs;
 }
 
 static void comm_str__put(struct comm_str *cs)
 {
-	if (cs && atomic_dec_and_test(&cs->refcnt)) {
+	if (cs && refcount_dec_and_test(&cs->refcnt)) {
 		rb_erase(&cs->rb_node, &comm_str_root);
 		zfree(&cs->str);
 		free(cs);
@@ -43,7 +43,7 @@ static struct comm_str *comm_str__alloc(const char *str)
 		return NULL;
 	}
 
-	atomic_set(&cs->refcnt, 0);
+	refcount_set(&cs->refcnt, 1);
 
 	return cs;
 }
@@ -95,8 +95,6 @@ struct comm *comm__new(const char *str, u64 timestamp, bool exec)
 		return NULL;
 	}
 
-	comm_str__get(comm->comm_str);
-
 	return comm;
 }
 
@@ -108,7 +106,6 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 	if (!new)
 		return -ENOMEM;
 
-	comm_str__get(new);
 	comm_str__put(old);
 	comm->comm_str = new;
 	comm->start = timestamp;
-- 
2.7.4
