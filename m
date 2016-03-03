From: Thomas Klausner <tk@giga.or.at>
Subject: Re: [PATCH] define more missing types for non-Linux
Date: Thu, 3 Mar 2016 10:58:52 +0100
Message-ID: <20160303095852.GH8492@danbala.tuwien.ac.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
 <1456758321-2256-2-git-send-email-tk@giga.or.at>
 <s5h8u23xzt1.wl-tiwai@suse.de>
 <20160302221454.GC8492@danbala.tuwien.ac.at>
 <s5h60x3sy97.wl-tiwai@suse.de>
 <20160303095041.GG8492@danbala.tuwien.ac.at>
 <s5hwppjriol.wl-tiwai@suse.de>
 <sfid-H20160303-105510-+052.44-1@spamfilter.osbf.lua>
 <s5hvb53rimi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FsscpQKzF/jJk6ya"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A4C2619D0
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 10:58:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvb53rimi.wl-tiwai@suse.de>
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


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 10:55:01AM +0100, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 10:53:46 +0100,
> Takashi Iwai wrote:
> > You need to add it in include/Makefile.am, too.
> > Otherwise it'll slip from the tarball.

Good catch, added.

> Oh, also it'd be good if you give your sign-off, too.
> For user-space, I accept the patches without sign-off as long as they
> are trivial enough.  But this kind of change is preferred with a
> proper sign off, of course.

Sure!
 Thomas

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Define-some-types-if-missing.patch"

>From 0d0a1408432a27cfa1908373bccbb66ac413fc5d Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Wed, 2 Mar 2016 23:11:54 +0100
Subject: [PATCH] Define some types if missing.

Include Linux headers on Linux only.
For portability with non-Linux.

Signed-off-by: Thomas Klausner <wiz@NetBSD.org>
---
 include/Makefile.am   |  2 +-
 include/local.h       |  6 ++---
 include/type_compat.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 4 deletions(-)
 create mode 100644 include/type_compat.h

diff --git a/include/Makefile.am b/include/Makefile.am
index ff931fd..8c83c11 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -59,7 +59,7 @@ alsainclude_HEADERS += alisp.h
 endif
 
 noinst_HEADERS = alsa sys.h search.h list.h aserver.h local.h alsa-symbols.h \
-	asoundlib-head.h asoundlib-tail.h
+	asoundlib-head.h asoundlib-tail.h type_compat.h
 
 DISTCLEANFILES = stamp-vh version.h alsa asoundlib.h
 
diff --git a/include/local.h b/include/local.h
index 28ed106..317f2e3 100644
--- a/include/local.h
+++ b/include/local.h
@@ -50,11 +50,11 @@
 #include <sys/poll.h>
 #include <sys/types.h>
 #include <errno.h>
+#if defined(__linux__)
 #include <linux/types.h>
 #include <linux/ioctl.h>
-
-#ifndef EBADFD
-#define EBADFD EBADF
+#else
+#include "type_compat.h"
 #endif
 
 #ifdef SUPPORT_RESMGR
diff --git a/include/type_compat.h b/include/type_compat.h
new file mode 100644
index 0000000..9cc209f
--- /dev/null
+++ b/include/type_compat.h
@@ -0,0 +1,66 @@
+/*
+ *  ALSA lib - compatibility header to be included by local.h
+ *  Copyright (c) 2016 by  Thomas Klausner <wiz@NetBSD.org>
+ *
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __TYPE_COMPAT_H
+#define __TYPE_COMPAT_H
+
+#ifndef EBADFD
+#define EBADFD EBADF
+#endif
+
+#ifndef __u16
+#define __u16	uint16_t
+#endif
+#ifndef __u32
+#define __u32	uint32_t
+#endif
+#ifndef __u64
+#define __u64	uint64_t
+#endif
+#ifndef __le16
+#define __le16	uint16_t
+#endif
+#ifndef __le32
+#define __le32	uint32_t
+#endif
+#ifndef __le64
+#define __le64	uint64_t
+#endif
+#ifndef u_int8_t
+#define u_int8_t	uint8_t
+#endif
+#ifndef u_int16_t
+#define u_int16_t	uint16_t
+#endif
+#ifndef u_int32_t
+#define u_int32_t	uint32_t
+#endif
+#ifndef u_int32_t
+#define u_int32_t	uint64_t
+#endif
+#ifndef __kernel_pid_t
+#define __kernel_pid_t	pid_t
+#endif
+#ifndef __kernel_off_t
+#define __kernel_off_t	off_t
+#endif
+
+#endif
-- 
2.7.1


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--FsscpQKzF/jJk6ya--
