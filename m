From: Thomas Klausner <tk@giga.or.at>
Subject: Remaining compatibility patches for NetBSD
Date: Thu, 3 Mar 2016 13:02:42 +0100
Message-ID: <20160303120242.GL8492@danbala.tuwien.ac.at>
References: <s5hwppjriol.wl-tiwai@suse.de> <s5hvb53rimi.wl-tiwai@suse.de>
 <20160303095852.GH8492@danbala.tuwien.ac.at>
 <s5hsi07ribw.wl-tiwai@suse.de>
 <20160303101005.GI8492@danbala.tuwien.ac.at>
 <s5hpovbrhf2.wl-tiwai@suse.de>
 <20160303111840.GJ8492@danbala.tuwien.ac.at>
 <s5hsi076bd6.wl-tiwai@suse.de>
 <sfid-H20160303-124109-+071.57-1@spamfilter.osbf.lua>
 <20160303113921.GK8492@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T6xhMxlHU34Bk0ad"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AED1260535
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 13:02:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160303113921.GK8492@danbala.tuwien.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are the remaining patches to make the build succeed on NetBSD.
More patches are needed for FreeBSD and Solaris, but let's take it one
at a time :-)

I think the first two (0002 and 0003) should be uncontroversial.

For patch 0004 it would perhaps be good to have versionsort/alphasort
in a central place instead of two. Do you have a suggestion where?

I'm not sure what to do about 0005 since you said you don't want to
modify include/sound/asound.h.

endian.h seems to be unneeded on src/topology/tplg_local.h; if it's
needed, I can move it inside the #ifdef.
 Thomas

--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-Add-more-compatibility-defines.patch"

>From b8abae028c02294906e99b1bc66423a89dce54ec Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Thu, 3 Mar 2016 12:56:58 +0100
Subject: [PATCH 2/5] Add more compatibility defines.

---
 include/type_compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/type_compat.h b/include/type_compat.h
index 9cc209f..0c10aed 100644
--- a/include/type_compat.h
+++ b/include/type_compat.h
@@ -25,6 +25,9 @@
 #ifndef EBADFD
 #define EBADFD EBADF
 #endif
+#ifndef ESTRPIPE
+#define ESTRPIPE EPIPE
+#endif
 
 #ifndef __u16
 #define __u16	uint16_t
@@ -63,4 +66,8 @@
 #define __kernel_off_t	off_t
 #endif
 
+#ifndef __bitwise
+#define __bitwise
+#endif
+
 #endif
-- 
2.7.1


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-Only-use-F_SETSIG-fcntl-where-it-exists.patch"

>From 72ada4937e512055abd39f83f31214d1e7ee4ebe Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Thu, 3 Mar 2016 12:57:34 +0100
Subject: [PATCH 3/5] Only use F_SETSIG fcntl where it exists.

---
 src/timer/timer_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/timer/timer_hw.c b/src/timer/timer_hw.c
index e61b994..ddaebd3 100644
--- a/src/timer/timer_hw.c
+++ b/src/timer/timer_hw.c
@@ -85,10 +85,12 @@ static int snd_timer_hw_async(snd_timer_t *timer, int sig, pid_t pid)
 	}
 	if (sig < 0)
 		return 0;
+#ifdef F_SETSIG
 	if (fcntl(fd, F_SETSIG, (long)sig) < 0) {
 		SYSERR("F_SETSIG failed");
 		return -errno;
 	}
+#endif
 	if (fcntl(fd, F_SETOWN, (long)pid) < 0) {
 		SYSERR("F_SETOWN failed");
 		return -errno;
-- 
2.7.1


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0004-Use-alphasort-where-versionsort-is-not-available.patch"

>From 23ec0e49db34590c8d74b336d7fe0f97dcf28f26 Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Thu, 3 Mar 2016 12:58:07 +0100
Subject: [PATCH 4/5] Use alphasort where versionsort is not available.

---
 src/conf.c       | 2 +-
 src/ucm/parser.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index a4f2a4f..f8b7a66 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3549,7 +3549,7 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 			int n;
 
 #ifndef DOC_HIDDEN
-#ifdef _GNU_SOURCE
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 9e1cb41..8405bd2 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1264,7 +1264,7 @@ int uc_mgr_scan_master_configs(const char **_list[])
 		"%s", env ? env : ALSA_USE_CASE_DIR);
 	filename[MAX_FILE-1] = '\0';
 
-#ifdef _GNU_SOURCE
+#if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
 #define SORTFUNC	versionsort
 #else
 #define SORTFUNC	alphasort
-- 
2.7.1


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0005-Wrap-linux-specific-headers-in-ifdef-__linux__.patch"

>From 678c4fd1ada7fb79988df0431312fcdfac9911f8 Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Thu, 3 Mar 2016 12:58:30 +0100
Subject: [PATCH 5/5] Wrap linux-specific headers in #ifdef __linux__

---
 include/sound/asound.h    | 4 ++++
 src/topology/tplg_local.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index a82108e..3d581b5 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -23,7 +23,11 @@
 #ifndef _UAPI__SOUND_ASOUND_H
 #define _UAPI__SOUND_ASOUND_H
 
+#ifdef __linux__
 #include <linux/types.h>
+#else
+#include <sys/ioctl.h>
+#endif
 
 #ifndef __KERNEL__
 #include <stdlib.h>
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index e66d7f4..2b44edd 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -13,8 +13,9 @@
 #include <limits.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <endian.h>
+#ifdef __linux__
 #include <linux/types.h>
+#endif
 
 #include "local.h"
 #include "list.h"
-- 
2.7.1


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--T6xhMxlHU34Bk0ad--
