From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH alsa-lib 1/2] pcm: drop unused sys/shm.h
	inclusion
Date: Tue, 27 Oct 2015 17:28:03 -0400
Message-ID: <1445981284-2182-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 84FA8260633
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 22:28:08 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 9FB04340B0B
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 21:28:07 +0000 (UTC)
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

This header isn't used in these files, so stop trying to include it.
This helps builds on systems that don't provide the header (such as
Android/Bionic).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 src/pcm/pcm.c         | 1 -
 src/pcm/pcm_generic.c | 1 -
 src/pcm/pcm_hw.c      | 1 -
 src/pcm/pcm_null.c    | 1 -
 src/pcm/pcm_plugin.c  | 1 -
 src/pcm/pcm_share.c   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index f5fc728..cbbc55a 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -635,7 +635,6 @@ playback devices.
 #include <signal.h>
 #include <ctype.h>
 #include <sys/poll.h>
-#include <sys/shm.h>
 #include <sys/mman.h>
 #include <limits.h>
 #include "pcm_local.h"
diff --git a/src/pcm/pcm_generic.c b/src/pcm/pcm_generic.c
index 9b60591..4dbef08 100644
--- a/src/pcm/pcm_generic.c
+++ b/src/pcm/pcm_generic.c
@@ -26,7 +26,6 @@
  *
  */
 
-#include <sys/shm.h>
 #include <sys/ioctl.h>
 #include <limits.h>
 #include "pcm_local.h"
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 232b197..66aec5c 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -36,7 +36,6 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/shm.h>
 #include "pcm_local.h"
 #include "../control/control_local.h"
 #include "../timer/timer_local.h"
diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index 0529820..5e63caa 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -28,7 +28,6 @@
   
 #include <byteswap.h>
 #include <limits.h>
-#include <sys/shm.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index c19e2f1..d007e8c 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -82,7 +82,6 @@ pcm.rate44100Hz {
 
 */
   
-#include <sys/shm.h>
 #include <limits.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 4b68f1f..5d8aaf2 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -35,7 +35,6 @@
 #include <math.h>
 #include <sys/socket.h>
 #include <sys/poll.h>
-#include <sys/shm.h>
 #include <pthread.h>
 #include "pcm_local.h"
 
-- 
2.5.2
