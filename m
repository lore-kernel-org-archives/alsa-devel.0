From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/35] perf cgroup: Convert cgroup_sel.refcnt
	from atomic_t to refcount_t
Date: Mon,  6 Mar 2017 16:38:00 -0300
Message-ID: <20170306193825.24011-11-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F042669AD
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 20:38:41 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Windsor <dwindsor@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Kook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1487691303-31858-2-git-send-email-elena.reshetova@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 6 +++---
 tools/perf/util/cgroup.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index eafbf11442b2..86399eda3684 100644
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
index 31f8dcdbd7ef..d91966b97cbd 100644
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
2.9.3
