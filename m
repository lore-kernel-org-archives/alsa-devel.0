From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 6/9] tools: convert map_groups.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:35:00 +0200
Message-ID: <1487691303-31858-7-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/map.c | 4 ++--
 tools/perf/util/map.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f0e2428..1d9ebcf 100644
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
index 9545ff3..c8a5a64 100644
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
2.7.4
