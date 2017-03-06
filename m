From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/35] perf cpumap: Convert cpu_map.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:01 -0300
Message-ID: <20170306193825.24011-12-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 191102669CE
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
Link: http://lkml.kernel.org/r/1487691303-31858-3-git-send-email-elena.reshetova@intel.com
[ fixed mixed conversion to refcount in tests/cpumap.c ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/cpumap.c |  2 +-
 tools/perf/util/cpumap.c  | 16 ++++++++--------
 tools/perf/util/cpumap.h  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f168a85992d0..4478773cdb97 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -66,7 +66,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  map->nr == 2);
 	TEST_ASSERT_VAL("wrong cpu", map->map[0] == 1);
 	TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
-	TEST_ASSERT_VAL("wrong refcnt", atomic_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
 	cpu_map__put(map);
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8c7504939113..39ad2caccf56 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -29,7 +29,7 @@ static struct cpu_map *cpu_map__default_new(void)
 			cpus->map[i] = i;
 
 		cpus->nr = nr_cpus;
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -43,7 +43,7 @@ static struct cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -252,7 +252,7 @@ struct cpu_map *cpu_map__dummy_new(void)
 	if (cpus != NULL) {
 		cpus->nr = 1;
 		cpus->map[0] = -1;
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -269,7 +269,7 @@ struct cpu_map *cpu_map__empty_new(int nr)
 		for (i = 0; i < nr; i++)
 			cpus->map[i] = -1;
 
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -278,7 +278,7 @@ struct cpu_map *cpu_map__empty_new(int nr)
 static void cpu_map__delete(struct cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(atomic_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
 		free(map);
 	}
@@ -287,13 +287,13 @@ static void cpu_map__delete(struct cpu_map *map)
 struct cpu_map *cpu_map__get(struct cpu_map *map)
 {
 	if (map)
-		atomic_inc(&map->refcnt);
+		refcount_inc(&map->refcnt);
 	return map;
 }
 
 void cpu_map__put(struct cpu_map *map)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(&map->refcnt))
 		cpu_map__delete(map);
 }
 
@@ -357,7 +357,7 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(int), cmp_ids);
 
-	atomic_set(&c->refcnt, 1);
+	refcount_set(&c->refcnt, 1);
 	*res = c;
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 1a0549af8f5c..e84491636c1b 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -3,13 +3,13 @@
 
 #include <stdio.h>
 #include <stdbool.h>
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
 struct cpu_map {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	int nr;
 	int map[];
 };
-- 
2.9.3
