From: Dave Dillow <dave@thedillows.org>
Subject: [PATCH v3 2/2] sis7019: add support to driver package
Date: Thu, 13 Dec 2007 23:06:55 -0500
Message-ID: <1197605215.3628.12.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id A5919103888
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 05:07:01 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lBE46uca026455
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 23:06:56 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lBE46tfs004645
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 23:06:55 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lBE46tuo004642
	for alsa-devel@alsa-project.org; Thu, 13 Dec 2007 23:06:55 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The sis7019 driver uses __ffs(), which first became available in kernel
2.5.2.6.  This adds that compatibility function for x86 to adriver.h,
and adds a more useful error message for other platforms that try to use
it. 

Signed-off-by: David Dillow <dave@thedillows.org>
---
This is against the alsa-driver hg repo. It builds against 2.6.23, but
I've not tested against earlier versions.

 pci/sis7019.c     |    2 ++
 include/adriver.h |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff -r 9eda190b55c3 include/adriver.h
--- a/include/adriver.h	Tue Dec 04 12:46:46 2007 +0100
+++ b/include/adriver.h	Thu Dec 13 22:50:16 2007 -0500
@@ -1445,4 +1445,22 @@ static inline unsigned char snd_pci_revi
 #endif
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 3)
+#if defined(__i386__)
+static inline unsigned long __ffs(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"rm" (word));
+	return word;
+}
+#else
+static inline unsigned long __ffs(unsigned long word)
+{
+	__asm__("need_asm_for_your_arch_in_adriver.h");
+	return word;
+}
+#endif
+#endif
+
 #endif /* __SOUND_LOCAL_DRIVER_H */
diff -r 9eda190b55c3 pci/sis7019.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/sis7019.c	Thu Dec 13 22:50:16 2007 -0500
@@ -0,0 +1,2 @@
+#include "../alsa-kernel/pci/sis7019.c"
+EXPORT_NO_SYMBOLS;
