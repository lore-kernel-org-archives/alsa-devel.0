From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH] define more missing types for non-Linux
Date: Wed, 2 Mar 2016 23:14:54 +0100
Message-ID: <20160302221454.GC8492@danbala.tuwien.ac.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
 <1456758321-2256-2-git-send-email-tk@giga.or.at>
 <sfid-H20160229-171048-+048.93-1@spamfilter.osbf.lua>
 <s5h8u23xzt1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F5D12652E5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 23:14:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8u23xzt1.wl-tiwai@suse.de>
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Mon, Feb 29, 2016 at 05:10:34PM +0100, Takashi Iwai wrote:
> On Mon, 29 Feb 2016 16:05:20 +0100,
> Thomas Klausner wrote:
> > 
> > From: Thomas Klausner <wiz@NetBSD.org>
> > 
> > ---
> >  include/sound/asound.h | 4 ++--
> 
> Sorry, this is no-go.  The files in include/sound/* are basically
> copies of Linux ABI.  So, all these files must not be modified in
> alsa-lib side.  And, using __kernel_off_t there is in purpose -- to
> distinguish from the user-space off_t.
> 
> That said, the best workaround for these files are to provide the
> compatible typedefs.

So how about the attached patch instead?

> OTOH, the code changes in include/pcm.h and src/pcm/* are acceptable,
> in general, but I still hesitate to apply it, so far.  If it's only
> about portability, we may wrap it with a few typedefs instead of
> touching so many lines.  And it would bring any other real benefit?
> It's the question...

I still prefer uint* to u_int* because uint* is in POSIX and u_int* is
not, but I added the necessary defines in the new patch.
 Thomas

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Define-some-types-if-missing.patch"

>From 634255a4d87a12132bb65868f5658fd14cd2bfd7 Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Wed, 2 Mar 2016 23:11:54 +0100
Subject: [PATCH] Define some types if missing.

For portability with non-Linux.

Include Linux header on Linux only.
---
 include/local.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/local.h b/include/local.h
index 28ed106..9728598 100644
--- a/include/local.h
+++ b/include/local.h
@@ -50,13 +50,52 @@
 #include <sys/poll.h>
 #include <sys/types.h>
 #include <errno.h>
+#if defined(__linux__)
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#endif
 
 #ifndef EBADFD
 #define EBADFD EBADF
 #endif
 
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
 #ifdef SUPPORT_RESMGR
 #include <resmgr.h>
 #endif
-- 
2.7.1


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--3MwIy2ne0vdjdPXF--
