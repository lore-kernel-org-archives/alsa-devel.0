From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 4/9] tools: convert dso.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:34:58 +0200
Message-ID: <1487691303-31858-5-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/dso.c | 6 +++---
 tools/perf/util/dso.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 3abe337..f88aa44 100644
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
index ecc4bbd..12350b1 100644
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
2.7.4
