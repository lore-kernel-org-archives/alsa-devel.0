From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/9] tools: convert cpu_map.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:34:56 +0200
Message-ID: <1487691303-31858-3-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/cpumap.c | 16 ++++++++--------
 tools/perf/util/cpumap.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 2c0b522..0e21e28 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -28,7 +28,7 @@ static struct cpu_map *cpu_map__default_new(void)
 			cpus->map[i] = i;
 
 		cpus->nr = nr_cpus;
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -42,7 +42,7 @@ static struct cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -251,7 +251,7 @@ struct cpu_map *cpu_map__dummy_new(void)
 	if (cpus != NULL) {
 		cpus->nr = 1;
 		cpus->map[0] = -1;
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -268,7 +268,7 @@ struct cpu_map *cpu_map__empty_new(int nr)
 		for (i = 0; i < nr; i++)
 			cpus->map[i] = -1;
 
-		atomic_set(&cpus->refcnt, 1);
+		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
@@ -277,7 +277,7 @@ struct cpu_map *cpu_map__empty_new(int nr)
 static void cpu_map__delete(struct cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(atomic_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(&map->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
 		free(map);
 	}
@@ -286,13 +286,13 @@ static void cpu_map__delete(struct cpu_map *map)
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
 
@@ -356,7 +356,7 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(int), cmp_ids);
 
-	atomic_set(&c->refcnt, 1);
+	refcount_set(&c->refcnt, 1);
 	*res = c;
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 06bd689..4f12a01 100644
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
2.7.4
