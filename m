From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 9/9] tools: convert thread_map.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:35:03 +0200
Message-ID: <1487691303-31858-10-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/thread_map.c | 20 ++++++++++----------
 tools/perf/util/thread_map.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 7c3fcc5..9026408 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -66,7 +66,7 @@ struct thread_map *thread_map__new_by_pid(pid_t pid)
 		for (i = 0; i < items; i++)
 			thread_map__set_pid(threads, i, atoi(namelist[i]->d_name));
 		threads->nr = items;
-		atomic_set(&threads->refcnt, 1);
+		refcount_set(&threads->refcnt, 1);
 	}
 
 	for (i=0; i<items; i++)
@@ -83,7 +83,7 @@ struct thread_map *thread_map__new_by_tid(pid_t tid)
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, tid);
 		threads->nr = 1;
-		atomic_set(&threads->refcnt, 1);
+		refcount_set(&threads->refcnt, 1);
 	}
 
 	return threads;
@@ -105,7 +105,7 @@ struct thread_map *thread_map__new_by_uid(uid_t uid)
 		goto out_free_threads;
 
 	threads->nr = 0;
-	atomic_set(&threads->refcnt, 1);
+	refcount_set(&threads->refcnt, 1);
 
 	while ((dirent = readdir(proc)) != NULL) {
 		char *end;
@@ -235,7 +235,7 @@ static struct thread_map *thread_map__new_by_pid_str(const char *pid_str)
 out:
 	strlist__delete(slist);
 	if (threads)
-		atomic_set(&threads->refcnt, 1);
+		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_namelist:
@@ -255,7 +255,7 @@ struct thread_map *thread_map__new_dummy(void)
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, -1);
 		threads->nr = 1;
-		atomic_set(&threads->refcnt, 1);
+		refcount_set(&threads->refcnt, 1);
 	}
 	return threads;
 }
@@ -300,7 +300,7 @@ struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	}
 out:
 	if (threads)
-		atomic_set(&threads->refcnt, 1);
+		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_threads:
@@ -326,7 +326,7 @@ static void thread_map__delete(struct thread_map *threads)
 	if (threads) {
 		int i;
 
-		WARN_ONCE(atomic_read(&threads->refcnt) != 0,
+		WARN_ONCE(refcount_read(&threads->refcnt) != 0,
 			  "thread map refcnt unbalanced\n");
 		for (i = 0; i < threads->nr; i++)
 			free(thread_map__comm(threads, i));
@@ -337,13 +337,13 @@ static void thread_map__delete(struct thread_map *threads)
 struct thread_map *thread_map__get(struct thread_map *map)
 {
 	if (map)
-		atomic_inc(&map->refcnt);
+		refcount_inc(&map->refcnt);
 	return map;
 }
 
 void thread_map__put(struct thread_map *map)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(&map->refcnt))
 		thread_map__delete(map);
 }
 
@@ -423,7 +423,7 @@ static void thread_map__copy_event(struct thread_map *threads,
 		threads->map[i].comm = strndup(event->entries[i].comm, 16);
 	}
 
-	atomic_set(&threads->refcnt, 1);
+	refcount_set(&threads->refcnt, 1);
 }
 
 struct thread_map *thread_map__new_event(struct thread_map_event *event)
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index ea0ef08..bd34d7a 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -3,7 +3,7 @@
 
 #include <sys/types.h>
 #include <stdio.h>
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 
 struct thread_map_data {
 	pid_t    pid;
@@ -11,7 +11,7 @@ struct thread_map_data {
 };
 
 struct thread_map {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	int nr;
 	struct thread_map_data map[];
 };
-- 
2.7.4
