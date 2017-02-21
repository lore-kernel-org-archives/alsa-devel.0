From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 5/9] tools: convert map.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:34:59 +0200
Message-ID: <1487691303-31858-6-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/map.c | 6 +++---
 tools/perf/util/map.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 0a943e7..f0e2428 100644
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
index abdacf8..9545ff3 100644
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
2.7.4
