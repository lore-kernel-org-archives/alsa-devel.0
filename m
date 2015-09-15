From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [PATCH alsa-lib] build: Do not try to detect
	cross-compiler
Date: Tue, 15 Sep 2015 18:48:02 +0300
Message-ID: <1442332082-18220-1-git-send-email-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id CF63A2602F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 17:49:15 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 0871723582
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 11:49:15 -0400 (EDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Khem Raj <raj.khem@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Khem Raj <raj.khem@gmail.com>

cross compilers are passed via path may not be a gcc based cross
compiler in such cases this check fails and try's to force gcc based
cross compiler detection, This code is a convenience that limits the
build system

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index a482b3e..a14e52d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,20 +27,6 @@ AC_PREFIX_DEFAULT(/usr)
 
 dnl Checks for programs.
 
-dnl try to gues cross-compiler if not set
-if test "x$host" != "x$build" -a -z "`echo $CC | grep -e '-gcc'`";
-then
-  AC_MSG_CHECKING(for cross-compiler)
-
-  which ${program_prefix}gcc >/dev/null 2>&1 && CC=${program_prefix}gcc
-  which ${host_cpu}-${host_os}-gcc >/dev/null 2>&1 \
-  && CC=${host_cpu}-${host_os}-gcc
-  which ${host_cpu}-${host_vendor}-${host_os}-gcc >/dev/null 2>&1 \
-  && CC=${host_cpu}-${host_vendor}-${host_os}-gcc
-
-  AC_MSG_RESULT($CC)
-fi
-	    
 CFLAGS="$CFLAGS -D_GNU_SOURCE"
 
 
-- 
2.5.1
