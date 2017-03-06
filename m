From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/35] perf comm: Convert comm_str.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:02 -0300
Message-ID: <20170306193825.24011-13-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 195232669D8
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 20:38:44 +0100 (CET)
In-Reply-To: <20170306193825.24011-1-acme@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Kees Kook <keescook@chromium.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>, Jiri Olsa <jolsa@kernel.org>, Hans Liljestrand <ishkamiel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Elena Reshetova <elena.reshetova@intel.com>

The refcount_t type and corresponding API should be used instead of
atomic_t when the variable is used as a reference counter.

This allows to avoid accidental refcounter overflows that might lead to
use-after-free situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Kook <keescook@chromium.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Windsor <dwindsor@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Kook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: alsa-devel@alsa-project.org
Link: http://lkml.kernel.org/r/1487691303-31858-4-git-send-email-elena.reshetova@intel.com
[ Reinstated comm_str__get() function, needed when reusing entries in the rbtree ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 21b7ff382c3f..32837b6f7879 100644
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
@@ -61,7 +61,7 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
 
 		cmp = strcmp(str, iter->str);
 		if (!cmp)
-			return iter;
+			return comm_str__get(iter);
 
 		if (cmp < 0)
 			p = &(*p)->rb_left;
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
2.9.3
