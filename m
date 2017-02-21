From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/9] tools: convert cgroup_sel.refcnt from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:34:55 +0200
Message-ID: <1487691303-31858-2-git-send-email-elena.reshetova@intel.com>
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
 tools/perf/util/cgroup.c | 6 +++---
 tools/perf/util/cgroup.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index eafbf114..86399ed 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -127,19 +127,19 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			goto found;
 		n++;
 	}
-	if (atomic_read(&cgrp->refcnt) == 0)
+	if (refcount_read(&cgrp->refcnt) == 0)
 		free(cgrp);
 
 	return -1;
 found:
-	atomic_inc(&cgrp->refcnt);
+	refcount_inc(&cgrp->refcnt);
 	counter->cgrp = cgrp;
 	return 0;
 }
 
 void close_cgroup(struct cgroup_sel *cgrp)
 {
-	if (cgrp && atomic_dec_and_test(&cgrp->refcnt)) {
+	if (cgrp && refcount_dec_and_test(&cgrp->refcnt)) {
 		close(cgrp->fd);
 		zfree(&cgrp->name);
 		free(cgrp);
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 31f8dcd..d91966b 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -1,14 +1,14 @@
 #ifndef __CGROUP_H__
 #define __CGROUP_H__
 
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 
 struct option;
 
 struct cgroup_sel {
 	char *name;
 	int fd;
-	atomic_t refcnt;
+	refcount_t refcnt;
 };
 
 
-- 
2.7.4
