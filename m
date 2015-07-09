From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH alsa-plugins] include speexdsp_types.h,
	not speex_types.h
Date: Thu,  9 Jul 2015 12:43:29 +0300
Message-ID: <1436435009-1653-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 18B4426510F
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 11:43:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Speexdsp was separated from speex in 1.2rc2. speex_types.h is not
shipped by speexdsp, so alsa-plugins shouldn't use that file. speexdsp
has speexdsp_types.h, which has the same contents as speex_types.h.

speexdsp_types.h is a new file introduced in 1.2rc2, so this change
bumps the minimum supported speexdsp version. The version check in
configure.ac will actually break if speexdsp 1.2 ever gets released,
because pkg-config thinks that "1.2" < "1.2rc2", but I think it's
useful to fail if the installed speexdsp version is 1.2rc1 (which I
believe is very common on current distributions). If a non-rc version
of speexdsp will ever get released, I hope version number 1.2 will be
skipped for this reason. (A non-rc version seems unlikely, since
1.2rc1 was released years ago, so it's pretty likely that the project
is stuck on so called "release candidates" forever...)

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 configure.ac          | 2 +-
 pph/arch.h            | 2 +-
 pph/speex_resampler.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 902a6d7..c554d22 100644
--- a/configure.ac
+++ b/configure.ac
@@ -108,7 +108,7 @@ AC_SUBST(AVCODEC_CFLAGS)
 AC_SUBST(AVCODEC_LIBS)
 AC_SUBST(AVCODEC_HEADER)
 
-PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
+PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2rc2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
 AM_CONDITIONAL(HAVE_SPEEXDSP, test "$HAVE_SPEEXDSP" = "yes")
 
 AC_ARG_WITH([speex],
diff --git a/pph/arch.h b/pph/arch.h
index e2d731a..a07d0d9 100644
--- a/pph/arch.h
+++ b/pph/arch.h
@@ -36,7 +36,7 @@
 #define ARCH_H
 
 #ifndef OUTSIDE_SPEEX
-#include "speex/speex_types.h"
+#include "speex/speexdsp_types.h"
 #endif
 
 #define ABS(x) ((x) < 0 ? (-(x)) : (x))      /**< Absolute integer value. */
diff --git a/pph/speex_resampler.h b/pph/speex_resampler.h
index c44fbcd..aa85abb 100644
--- a/pph/speex_resampler.h
+++ b/pph/speex_resampler.h
@@ -82,7 +82,7 @@
       
 #else /* OUTSIDE_SPEEX */
 
-#include "speex/speex_types.h"
+#include "speex/speexdsp_types.h"
 
 #endif /* OUTSIDE_SPEEX */
 
-- 
1.9.3
