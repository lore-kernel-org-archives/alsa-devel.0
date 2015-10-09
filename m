From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH alsa-lib] fix _GNU_SOURCE handling & header
	inclusion
Date: Fri,  9 Oct 2015 17:47:40 -0400
Message-ID: <1444427260-19958-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C46265238
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 23:47:46 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 1355733BF11
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 21:47:43 +0000 (UTC)
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

From: Mike Frysinger <vapier@chromium.org>

The configure script blindly adds -D_GNU_SOURCE to all build settings,
even on non-GNU systems.  This isn't too much of a big deal (even if
it uses the wrong variable -- CFLAGS instead of CPPFLAGS), except that
the alsa-lib source itself determines whether to use GNU features when
this is defined (such as versionsort).  So when we build on non-glibc
systems, we get build failures like:
src/ucm/parser.c:1268:18: error: 'versionsort' undeclared (first use in this function)
 #define SORTFUNC versionsort
                  ^
src/ucm/parser.c:1272:54: note: in expansion of macro 'SORTFUNC'
  err = scandir(filename, &namelist, filename_filter, SORTFUNC);
                                                      ^

The correct way to add these flags is to use the autoconf helper
AC_USE_SYSTEM_EXTENSIONS.  Unfortunately, that triggers some more
bugs in the alsa build.  This macro adds defines to config.h and
not directly to CPPFLAGS, so it relies on files correctly including
config.h before anything else.  A number of alsa files do not do
this leading to build failures.  The fix there is to shuffle the
includes around so that the local ones come first.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.ac               | 4 +---
 src/conf.c                 | 2 +-
 src/timer/timer.c          | 9 ++-------
 src/timer/timer_hw.c       | 6 ------
 src/timer/timer_local.h    | 5 ++---
 src/timer/timer_query.c    | 6 ------
 src/timer/timer_query_hw.c | 6 ------
 src/ucm/ucm_local.h        | 2 +-
 8 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/configure.ac b/configure.ac
index a14e52d..9cb8614 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,11 +27,9 @@ AC_PREFIX_DEFAULT(/usr)
 
 dnl Checks for programs.
 
-CFLAGS="$CFLAGS -D_GNU_SOURCE"
-
-
 AC_PROG_CC
 AC_PROG_CPP
+AC_USE_SYSTEM_EXTENSIONS
 AC_PROG_INSTALL
 AC_PROG_LN_S 
 AC_DISABLE_STATIC
diff --git a/src/conf.c b/src/conf.c
index c6a83ee..91fca25 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -414,12 +414,12 @@ beginning:</P>
 */
 
 
+#include "local.h"
 #include <stdarg.h>
 #include <limits.h>
 #include <sys/stat.h>
 #include <dirent.h>
 #include <locale.h>
-#include "local.h"
 #ifdef HAVE_LIBPTHREAD
 #include <pthread.h>
 #endif
diff --git a/src/timer/timer.c b/src/timer/timer.c
index b71a9f8..a25e4f7 100644
--- a/src/timer/timer.c
+++ b/src/timer/timer.c
@@ -67,15 +67,10 @@ This example shows opening a timer device and reading of timer events.
  * \anchor example_test_timer
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <sys/ioctl.h>
 #include "timer_local.h"
 
+#include <signal.h>
+
 static int snd_timer_open_conf(snd_timer_t **timer,
 			       const char *name, snd_config_t *timer_root,
 			       snd_config_t *timer_conf, int mode)
diff --git a/src/timer/timer_hw.c b/src/timer/timer_hw.c
index e833fc8..e61b994 100644
--- a/src/timer/timer_hw.c
+++ b/src/timer/timer_hw.c
@@ -19,12 +19,6 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
 #include "timer_local.h"
 
 #ifndef PIC
diff --git a/src/timer/timer_local.h b/src/timer/timer_local.h
index 8040b05..eef3b06 100644
--- a/src/timer/timer_local.h
+++ b/src/timer/timer_local.h
@@ -19,10 +19,9 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <limits.h>
 #include "local.h"
+#include <limits.h>
+#include <sys/ioctl.h>
 
 #ifndef DOC_HIDDEN
 typedef struct {
diff --git a/src/timer/timer_query.c b/src/timer/timer_query.c
index 50b098a..93d2455 100644
--- a/src/timer/timer_query.c
+++ b/src/timer/timer_query.c
@@ -26,12 +26,6 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
 #include "timer_local.h"
 
 static int snd_timer_query_open_conf(snd_timer_query_t **timer,
diff --git a/src/timer/timer_query_hw.c b/src/timer/timer_query_hw.c
index 289ca52..d0c4391 100644
--- a/src/timer/timer_query_hw.c
+++ b/src/timer/timer_query_hw.c
@@ -19,12 +19,6 @@
  *
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
 #include "timer_local.h"
 
 #ifndef PIC
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index c1655c7..3a5d2c2 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -36,8 +36,8 @@
 #define UC_MGR_DEBUG
 #endif
 
-#include <pthread.h>
 #include "local.h"
+#include <pthread.h>
 #include "use-case.h"
 
 #define MAX_FILE		256
-- 
2.5.2
