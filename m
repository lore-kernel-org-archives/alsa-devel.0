From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/35] perf map: Convert map.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:04 -0300
Message-ID: <20170306193825.24011-15-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 196672669E3
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
Link: http://lkml.kernel.org/r/1487691303-31858-6-git-send-email-elena.reshetova@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 6 +++---
 tools/perf/util/map.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 0a943e7b1ea7..f0e2428efd0b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -141,7 +141,7 @@ void map__init(struct map *map, enum map_type type,
 	RB_CLEAR_NODE(&map->rb_node);
 	map->groups   = NULL;
 	map->erange_warned = false;
-	atomic_set(&map->refcnt, 1);
+	refcount_set(&map->refcnt, 1);
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
@@ -255,7 +255,7 @@ void map__delete(struct map *map)
 
 void map__put(struct map *map)
 {
-	if (map && atomic_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(&map->refcnt))
 		map__delete(map);
 }
 
@@ -354,7 +354,7 @@ struct map *map__clone(struct map *from)
 	struct map *map = memdup(from, sizeof(*map));
 
 	if (map != NULL) {
-		atomic_set(&map->refcnt, 1);
+		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
 		dso__get(map->dso);
 		map->groups = NULL;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index abdacf800c98..9545ff343ec5 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -1,7 +1,7 @@
 #ifndef __PERF_MAP_H
 #define __PERF_MAP_H
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
@@ -51,7 +51,7 @@ struct map {
 
 	struct dso		*dso;
 	struct map_groups	*groups;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 };
 
 struct kmap {
@@ -150,7 +150,7 @@ struct map *map__clone(struct map *map);
 static inline struct map *map__get(struct map *map)
 {
 	if (map)
-		atomic_inc(&map->refcnt);
+		refcount_inc(&map->refcnt);
 	return map;
 }
 
-- 
2.9.3
