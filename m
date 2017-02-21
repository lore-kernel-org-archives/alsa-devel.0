From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 7/9] tools: convert perf_map.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:35:01 +0200
Message-ID: <1487691303-31858-8-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/evlist.c | 18 +++++++++---------
 tools/perf/util/evlist.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b601f28..564b924 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -777,7 +777,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *md, bool check_messu
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!atomic_read(&md->refcnt))
+	if (!refcount_read(&md->refcnt))
 		return NULL;
 
 	head = perf_mmap__read_head(md);
@@ -794,7 +794,7 @@ perf_mmap__read_backward(struct perf_mmap *md)
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
 	 */
-	if (!atomic_read(&md->refcnt))
+	if (!refcount_read(&md->refcnt))
 		return NULL;
 
 	head = perf_mmap__read_head(md);
@@ -856,7 +856,7 @@ void perf_mmap__read_catchup(struct perf_mmap *md)
 {
 	u64 head;
 
-	if (!atomic_read(&md->refcnt))
+	if (!refcount_read(&md->refcnt))
 		return;
 
 	head = perf_mmap__read_head(md);
@@ -875,14 +875,14 @@ static bool perf_mmap__empty(struct perf_mmap *md)
 
 static void perf_mmap__get(struct perf_mmap *map)
 {
-	atomic_inc(&map->refcnt);
+	refcount_inc(&map->refcnt);
 }
 
 static void perf_mmap__put(struct perf_mmap *md)
 {
-	BUG_ON(md->base && atomic_read(&md->refcnt) == 0);
+	BUG_ON(md->base && refcount_read(&md->refcnt) == 0);
 
-	if (atomic_dec_and_test(&md->refcnt))
+	if (refcount_dec_and_test(&md->refcnt))
 		perf_mmap__munmap(md);
 }
 
@@ -894,7 +894,7 @@ void perf_mmap__consume(struct perf_mmap *md, bool overwrite)
 		perf_mmap__write_tail(md, old);
 	}
 
-	if (atomic_read(&md->refcnt) == 1 && perf_mmap__empty(md))
+	if (refcount_read(&md->refcnt) == 1 && perf_mmap__empty(md))
 		perf_mmap__put(md);
 }
 
@@ -937,7 +937,7 @@ static void perf_mmap__munmap(struct perf_mmap *map)
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
 		map->fd = -1;
-		atomic_set(&map->refcnt, 0);
+		refcount_set(&map->refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
@@ -1001,7 +1001,7 @@ static int perf_mmap__mmap(struct perf_mmap *map,
 	 * evlist layer can't just drop it when filtering events in
 	 * perf_evlist__filter_pollfd().
 	 */
-	atomic_set(&map->refcnt, 2);
+	refcount_set(&map->refcnt, 2);
 	map->prev = 0;
 	map->mask = mp->mask;
 	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 389b9cc..3994299 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -1,7 +1,7 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/list.h>
 #include <api/fd/array.h>
 #include <stdio.h>
@@ -29,7 +29,7 @@ struct perf_mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
-	atomic_t	 refcnt;
+	refcount_t	 refcnt;
 	u64		 prev;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __attribute__((aligned(8)));
-- 
2.7.4
