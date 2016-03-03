From: Thomas Klausner <tk@giga.or.at>
Subject: Re: [PATCH] define more missing types for non-Linux
Date: Thu, 3 Mar 2016 10:50:41 +0100
Message-ID: <20160303095041.GG8492@danbala.tuwien.ac.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
 <1456758321-2256-2-git-send-email-tk@giga.or.at>
 <s5h8u23xzt1.wl-tiwai@suse.de>
 <20160302221454.GC8492@danbala.tuwien.ac.at>
 <sfid-H20160303-103215-+045.37-1@spamfilter.osbf.lua>
 <s5h60x3sy97.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0C9261ABB
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 10:50:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h60x3sy97.wl-tiwai@suse.de>
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


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 10:32:04AM +0100, Takashi Iwai wrote:
> Can we put this in include/type_compat.h or something like that, and
> include it in #else block of #ifdef __linux__?
> 
> As a bonus, the EBADFD definition can also go to there, too.

Sure, see attached.
 Thomas

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Define-some-types-if-missing.patch"

>From c68bfda4e5198b50b32937de669155afb423d726 Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Wed, 2 Mar 2016 23:11:54 +0100
Subject: [PATCH] Define some types if missing.

For portability with non-Linux.

Include Linux headers on Linux only.
---
 include/local.h       |  6 ++---
 include/type_compat.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100644 include/type_compat.h

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


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye--
