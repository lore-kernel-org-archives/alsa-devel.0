From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/35] perf thread: convert thread.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:07 -0300
Message-ID: <20170306193825.24011-18-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FA652669CC
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 20:38:43 +0100 (CET)
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

The refcount_t type and corresponding API should be used instead of atomic_t
when the variable is used as a reference counter.

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
Link: http://lkml.kernel.org/r/1487691303-31858-9-git-send-email-elena.reshetova@intel.com
[ Did missing conversion in __machine__remove_thread() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/thread.c  | 6 +++---
 tools/perf/util/thread.h  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 71c9720d4973..b9974fe41bc1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1439,7 +1439,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	if (machine->last_match == th)
 		machine->last_match = NULL;
 
-	BUG_ON(atomic_read(&th->refcnt) == 0);
+	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
 		pthread_rwlock_wrlock(&machine->threads_lock);
 	rb_erase_init(&th->rb_node, &machine->threads);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index f5af87f66663..74e79d26b421 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -53,7 +53,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 			goto err_thread;
 
 		list_add(&comm->list, &thread->comm_list);
-		atomic_set(&thread->refcnt, 1);
+		refcount_set(&thread->refcnt, 1);
 		RB_CLEAR_NODE(&thread->rb_node);
 	}
 
@@ -88,13 +88,13 @@ void thread__delete(struct thread *thread)
 struct thread *thread__get(struct thread *thread)
 {
 	if (thread)
-		atomic_inc(&thread->refcnt);
+		refcount_inc(&thread->refcnt);
 	return thread;
 }
 
 void thread__put(struct thread *thread)
 {
-	if (thread && atomic_dec_and_test(&thread->refcnt)) {
+	if (thread && refcount_dec_and_test(&thread->refcnt)) {
 		/*
 		 * Remove it from the dead_threads list, as last reference
 		 * is gone.
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 99263cb6e6b6..e57188546465 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -1,7 +1,7 @@
 #ifndef __PERF_THREAD_H
 #define __PERF_THREAD_H
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <unistd.h>
@@ -23,7 +23,7 @@ struct thread {
 	pid_t			tid;
 	pid_t			ppid;
 	int			cpu;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	char			shortname[3];
 	bool			comm_set;
 	int			comm_len;
-- 
2.9.3
