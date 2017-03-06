From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/35] perf evlist: Convert perf_map.refcnt
	from atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:06 -0300
Message-ID: <20170306193825.24011-17-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DFA2266DF7
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
Link: http://lkml.kernel.org/r/1487691303-31858-8-git-send-email-elena.reshetova@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 18 +++++++++---------
 tools/perf/util/evlist.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b601f2814a30..564b924fb48a 100644
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
index 389b9ccdf8c7..39942995f537 100644
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
2.9.3
