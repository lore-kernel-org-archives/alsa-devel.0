From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/35] perf thread_map: Convert
	thread_map.refcnt from atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:08 -0300
Message-ID: <20170306193825.24011-19-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B88266DFB
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 20:38:58 +0100 (CET)
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
Link: http://lkml.kernel.org/r/1487691303-31858-10-git-send-email-elena.reshetova@intel.com
[ Did missing tests/thread-map.c conversion ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/thread-map.c |  6 +++---
 tools/perf/util/thread_map.c  | 20 ++++++++++----------
 tools/perf/util/thread_map.h  |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index f2d2e542d0ee..a63d6945807b 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -29,7 +29,7 @@ int test__thread_map(int subtest __maybe_unused)
 			thread_map__comm(map, 0) &&
 			!strcmp(thread_map__comm(map, 0), NAME));
 	TEST_ASSERT_VAL("wrong refcnt",
-			atomic_read(&map->refcnt) == 1);
+			refcount_read(&map->refcnt) == 1);
 	thread_map__put(map);
 
 	/* test dummy pid */
@@ -44,7 +44,7 @@ int test__thread_map(int subtest __maybe_unused)
 			thread_map__comm(map, 0) &&
 			!strcmp(thread_map__comm(map, 0), "dummy"));
 	TEST_ASSERT_VAL("wrong refcnt",
-			atomic_read(&map->refcnt) == 1);
+			refcount_read(&map->refcnt) == 1);
 	thread_map__put(map);
 	return 0;
 }
@@ -71,7 +71,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 			thread_map__comm(threads, 0) &&
 			!strcmp(thread_map__comm(threads, 0), NAME));
 	TEST_ASSERT_VAL("wrong refcnt",
-			atomic_read(&threads->refcnt) == 1);
+			refcount_read(&threads->refcnt) == 1);
 	thread_map__put(threads);
 	return 0;
 }
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 7c3fcc538a70..9026408ea55b 100644
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
index ea0ef08c6303..bd34d7a0b9fa 100644
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
2.9.3
