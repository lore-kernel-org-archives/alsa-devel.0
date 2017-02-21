From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 8/9] tools: convert thread.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:35:02 +0200
Message-ID: <1487691303-31858-9-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/thread.c | 6 +++---
 tools/perf/util/thread.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index f5af87f..74e79d2 100644
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
index 99263cb..e571885 100644
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
2.7.4
