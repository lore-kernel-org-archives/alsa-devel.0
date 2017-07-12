From: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH - alsa-lib 1/2] cleanup: fix poll.h includes
Date: Wed, 12 Jul 2017 10:45:18 +0200
Message-ID: <20170712084519.11389-1-ncopa@alpinelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According POSIX[1] and linux manpage[2] the include is poll.h, not
sys/poll.h.

This fixes the he following compiler warning when build with musl libc:

  /usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
   #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
    ^~~~~~~

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>

diff --git a/aserver/aserver.c b/aserver/aserver.c
index ac20706b..46f731a4 100644
--- a/aserver/aserver.c
+++ b/aserver/aserver.c
@@ -20,7 +20,7 @@
 
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <stdio.h>
diff --git a/include/asoundlib-head.h b/include/asoundlib-head.h
index 1ec611e5..21e32c6b 100644
--- a/include/asoundlib-head.h
+++ b/include/asoundlib-head.h
@@ -35,6 +35,6 @@
 #include <string.h>
 #include <fcntl.h>
 #include <assert.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <errno.h>
 #include <stdarg.h>
diff --git a/include/local.h b/include/local.h
index 317f2e32..6a43a473 100644
--- a/include/local.h
+++ b/include/local.h
@@ -47,7 +47,7 @@
 #error Header defining endianness not defined
 #endif
 #include <stdarg.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/types.h>
 #include <errno.h>
 #if defined(__linux__)
diff --git a/src/control/control.c b/src/control/control.c
index 134ba4c8..6439b294 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -90,7 +90,7 @@ against the original design.
 #include <string.h>
 #include <fcntl.h>
 #include <signal.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <stdbool.h>
 #include "control_local.h"
 
diff --git a/src/control/control_shm.c b/src/control/control_shm.c
index bd07d4af..9a2e268b 100644
--- a/src/control/control_shm.c
+++ b/src/control/control_shm.c
@@ -27,7 +27,7 @@
 #include <fcntl.h>
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <sys/mman.h>
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 200b10c2..2b4ce8ec 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -651,7 +651,7 @@ playback devices.
 #include <stdarg.h>
 #include <signal.h>
 #include <ctype.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/mman.h>
 #include <limits.h>
 #include "pcm_local.h"
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 9fd376d8..393083f5 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -30,7 +30,7 @@
 #include <grp.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/shm.h>
 #include <sys/sem.h>
 #include <sys/wait.h>
diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 1948289c..4cf220a4 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <malloc.h>
 #include <string.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/mman.h>
 #ifdef HAVE_SYS_SHM_H
 #include <sys/shm.h>
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 5d8aaf21..21a57fc6 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -34,7 +34,7 @@
 #include <signal.h>
 #include <math.h>
 #include <sys/socket.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <pthread.h>
 #include "pcm_local.h"
 
diff --git a/src/pcm/pcm_shm.c b/src/pcm/pcm_shm.c
index a815ac6b..4ee958c1 100644
--- a/src/pcm/pcm_shm.c
+++ b/src/pcm/pcm_shm.c
@@ -36,7 +36,7 @@
 #include <sys/ioctl.h>
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/un.h>
 #include <sys/mman.h>
 #include <netinet/in.h>
diff --git a/src/seq/seq.c b/src/seq/seq.c
index b206e2f8..d5ed1c6a 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -777,7 +777,7 @@ void event_filter(snd_seq_t *seq, snd_seq_event_t *ev)
 
 */
 
-#include <sys/poll.h>
+#include <poll.h>
 #include "seq_local.h"
 
 /****************************************************************************
diff --git a/src/shmarea.c b/src/shmarea.c
index 9843aa8b..eaa71f00 100644
--- a/src/shmarea.c
+++ b/src/shmarea.c
@@ -27,7 +27,7 @@
 #include <malloc.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
 #include "list.h"
-- 
2.13.2
