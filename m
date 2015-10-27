From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH alsa-lib 2/2] support building w/out System V
	shared memory
Date: Tue, 27 Oct 2015 17:28:04 -0400
Message-ID: <1445981284-2182-2-git-send-email-vapier@gentoo.org>
References: <1445981284-2182-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 18296260639
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 22:28:09 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 2F61D340B6C
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 21:28:08 +0000 (UTC)
In-Reply-To: <1445981284-2182-1-git-send-email-vapier@gentoo.org>
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

Some systems, like Android/Bionic, do not support SysV at all.
Let the configure script detect if the header is available, and
if not, automatically disable the pieces that require it.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.ac       | 13 ++++++++++++-
 src/pcm/pcm_mmap.c | 15 ++++++++++++++-
 src/shmarea.c      |  9 ++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1dcc0a4..9490d39 100644
--- a/configure.ac
+++ b/configure.ac
@@ -295,7 +295,7 @@ fi
 AC_SUBST(ALSA_DEPLIBS)
 
 dnl Check for headers
-AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h])
+AC_CHECK_HEADERS([wordexp.h endian.h sys/endian.h sys/shm.h])
 
 dnl Check for resmgr support...
 AC_MSG_CHECKING(for resmgr support)
@@ -508,6 +508,13 @@ if test "$gcc_have_atomics" != "yes"; then
   build_pcm_meter="no"
 fi
 
+if test "$ac_cv_header_sys_shm_h" != "yes"; then
+  build_pcm_dmix="no"
+  build_pcm_dshare="no"
+  build_pcm_dsnoop="no"
+  build_pcm_shm="no"
+fi
+
 AM_CONDITIONAL([BUILD_PCM_PLUGIN], [test x$build_pcm_plugin = xyes])
 AM_CONDITIONAL([BUILD_PCM_PLUGIN_COPY], [test x$build_pcm_copy = xyes])
 AM_CONDITIONAL([BUILD_PCM_PLUGIN_LINEAR], [test x$build_pcm_linear = xyes])
@@ -594,6 +601,10 @@ for p in $ctl_plugins; do
   done
 done
 
+if test "$ac_cv_header_sys_shm_h" != "yes"; then
+  build_ctl_shm="no"
+fi
+
 AM_CONDITIONAL([BUILD_CTL_PLUGIN], [test x$build_ctl_plugin = xyes])
 AM_CONDITIONAL([BUILD_CTL_PLUGIN_SHM], [test x$build_ctl_shm = xyes])
 AM_CONDITIONAL([BUILD_CTL_PLUGIN_EXT], [test x$build_ctl_ext = xyes])
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 470bd04..5c4fbe1 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -17,13 +17,16 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-  
+
+#include "config.h"
 #include <stdio.h>
 #include <malloc.h>
 #include <string.h>
 #include <sys/poll.h>
 #include <sys/mman.h>
+#ifdef HAVE_SYS_SHM_H
 #include <sys/shm.h>
+#endif
 #include "pcm_local.h"
 
 void snd_pcm_mmap_appl_backward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -341,6 +344,7 @@ int snd_pcm_mmap(snd_pcm_t *pcm)
 			i->addr = ptr;
 			break;
 		case SND_PCM_AREA_SHM:
+#ifdef HAVE_SYS_SHM_H
 			if (i->u.shm.shmid < 0) {
 				int id;
 				/* FIXME: safer permission? */
@@ -385,6 +389,10 @@ int snd_pcm_mmap(snd_pcm_t *pcm)
 			}
 			i->addr = ptr;
 			break;
+#else
+			SYSERR("shm support not available");
+			return -ENOSYS;
+#endif
 		case SND_PCM_AREA_LOCAL:
 			ptr = malloc(size);
 			if (ptr == NULL) {
@@ -466,6 +474,7 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 			errno = 0;
 			break;
 		case SND_PCM_AREA_SHM:
+#ifdef HAVE_SYS_SHM_H
 			if (i->u.shm.area) {
 				snd_shm_area_destroy(i->u.shm.area);
 				i->u.shm.area = NULL;
@@ -482,6 +491,10 @@ int snd_pcm_munmap(snd_pcm_t *pcm)
 				}
 			}
 			break;
+#else
+			SYSERR("shm support not available");
+			return -ENOSYS;
+#endif
 		case SND_PCM_AREA_LOCAL:
 			free(i->addr);
 			break;
diff --git a/src/shmarea.c b/src/shmarea.c
index 071f9f3..9843aa8 100644
--- a/src/shmarea.c
+++ b/src/shmarea.c
@@ -17,7 +17,12 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-  
+
+#include "config.h"
+
+/* These funcs are only used by pcm_mmap when sys/shm.h is available. */
+#ifdef HAVE_SYS_SHM_H
+
 #include <stdio.h>
 #include <malloc.h>
 #include <string.h>
@@ -106,3 +111,5 @@ void snd_shm_area_destructor(void)
 		shmdt(area->ptr);
 	}
 }
+
+#endif
-- 
2.5.2
