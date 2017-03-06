From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/35] perf map: Convert map_groups.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:05 -0300
Message-ID: <20170306193825.24011-16-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DD212669BD
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
Link: http://lkml.kernel.org/r/1487691303-31858-7-git-send-email-elena.reshetova@intel.com
[ Did the missing conversion of tests/thread-mg-share.c too ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/thread-mg-share.c | 12 ++++++------
 tools/perf/util/map.c              |  4 ++--
 tools/perf/util/map.h              |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index 188b63140fc8..76686dd6f5ec 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -43,7 +43,7 @@ int test__thread_mg_share(int subtest __maybe_unused)
 			leader && t1 && t2 && t3 && other);
 
 	mg = leader->mg;
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&mg->refcnt), 4);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 4);
 
 	/* test the map groups pointer is shared */
 	TEST_ASSERT_VAL("map groups don't match", mg == t1->mg);
@@ -71,25 +71,25 @@ int test__thread_mg_share(int subtest __maybe_unused)
 	machine__remove_thread(machine, other_leader);
 
 	other_mg = other->mg;
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&other_mg->refcnt), 2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
 
 	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->mg);
 
 	/* release thread group */
 	thread__put(leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&mg->refcnt), 3);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 3);
 
 	thread__put(t1);
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&mg->refcnt), 2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 2);
 
 	thread__put(t2);
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&mg->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 1);
 
 	thread__put(t3);
 
 	/* release other group  */
 	thread__put(other_leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", atomic_read(&other_mg->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 1);
 
 	thread__put(other);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f0e2428efd0b..1d9ebcf9e38e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -485,7 +485,7 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 		maps__init(&mg->maps[i]);
 	}
 	mg->machine = machine;
-	atomic_set(&mg->refcnt, 1);
+	refcount_set(&mg->refcnt, 1);
 }
 
 static void __maps__purge(struct maps *maps)
@@ -547,7 +547,7 @@ void map_groups__delete(struct map_groups *mg)
 
 void map_groups__put(struct map_groups *mg)
 {
-	if (mg && atomic_dec_and_test(&mg->refcnt))
+	if (mg && refcount_dec_and_test(&mg->refcnt))
 		map_groups__delete(mg);
 }
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9545ff343ec5..c8a5a644c0a9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -67,7 +67,7 @@ struct maps {
 struct map_groups {
 	struct maps	 maps[MAP__NR_TYPES];
 	struct machine	 *machine;
-	atomic_t	 refcnt;
+	refcount_t	 refcnt;
 };
 
 struct map_groups *map_groups__new(struct machine *machine);
@@ -77,7 +77,7 @@ bool map_groups__empty(struct map_groups *mg);
 static inline struct map_groups *map_groups__get(struct map_groups *mg)
 {
 	if (mg)
-		atomic_inc(&mg->refcnt);
+		refcount_inc(&mg->refcnt);
 	return mg;
 }
 
-- 
2.9.3
