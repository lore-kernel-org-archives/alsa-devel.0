From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/35] perf dso: Convert dso.refcnt from
	atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:03 -0300
Message-ID: <20170306193825.24011-14-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A192669B4
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
Link: http://lkml.kernel.org/r/1487691303-31858-5-git-send-email-elena.reshetova@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 +++---
 tools/perf/util/dso.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d38b62a700ca..42db00d78573 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1109,7 +1109,7 @@ struct dso *dso__new(const char *name)
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
 		pthread_mutex_init(&dso->lock, NULL);
-		atomic_set(&dso->refcnt, 1);
+		refcount_set(&dso->refcnt, 1);
 	}
 
 	return dso;
@@ -1147,13 +1147,13 @@ void dso__delete(struct dso *dso)
 struct dso *dso__get(struct dso *dso)
 {
 	if (dso)
-		atomic_inc(&dso->refcnt);
+		refcount_inc(&dso->refcnt);
 	return dso;
 }
 
 void dso__put(struct dso *dso)
 {
-	if (dso && atomic_dec_and_test(&dso->refcnt))
+	if (dso && refcount_dec_and_test(&dso->refcnt))
 		dso__delete(dso);
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ecc4bbd3f82e..12350b171727 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1,7 +1,7 @@
 #ifndef __PERF_DSO
 #define __PERF_DSO
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <sys/types.h>
@@ -187,7 +187,7 @@ struct dso {
 		void	 *priv;
 		u64	 db_id;
 	};
-	atomic_t	 refcnt;
+	refcount_t	 refcnt;
 	char		 name[0];
 };
 
-- 
2.9.3
