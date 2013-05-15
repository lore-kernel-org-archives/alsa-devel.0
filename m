From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 7/8] Avoid including sys/io.h on architectures
	that lack it.
Date: Wed, 15 May 2013 19:19:10 +0200
Message-ID: <1368638351-29200-8-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id DFC312652EF
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:23 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 370FC62A0B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:23 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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

Extend the check for PowerPC to the rest of official and unofficial
Debian linux-based architectures that lack sys/io.h, based on EGLIBC 2.17.
sys/io.h is available, at the time of this writing, on the alpha, i386,
ia64, and arm Linux targets.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 hda-verb/hda-verb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hda-verb/hda-verb.c b/hda-verb/hda-verb.c
index bd746ad..2b85923 100644
--- a/hda-verb/hda-verb.c
+++ b/hda-verb/hda-verb.c
@@ -13,7 +13,11 @@
 #include <ctype.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
-#ifndef __PPC__
+/* EGLIBC 2.17 supports sys/io.h for alpha, i386, ia64, arm,
+   hurd-i386, and kfreebsd-i386. */
+#if !defined (__powerpc__) && !defined (__sparc__) && !defined (__s390__) && \
+    !defined (__mips__) && !defined (__hppa__) && !defined (__m68k__) && \
+    !defined (__sh__)
 #include <sys/io.h>
 #endif
 #include <sys/types.h>
-- 
1.7.10.4
