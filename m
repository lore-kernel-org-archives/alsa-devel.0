From: Dave Dillow <dave@thedillows.org>
Subject: [PATCH 2/2] sis7019: add support for pre-2.6 kernels
Date: Wed, 28 Nov 2007 02:19:12 -0500
Message-ID: <1196234352.7017.32.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (unknown [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 8010A24B0A
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 08:19:27 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lAS7JDHV021264
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 02:19:13 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lAS7JDX7007942
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 02:19:13 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lAS7JDrW007939
	for alsa-devel@alsa-project.org; Wed, 28 Nov 2007 02:19:13 -0500
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

The sis7019 driver uses __ffs(), which is available in 2.6 kernels, but
not in most earlier ones. This patches the driver to use a local version
assembly version, as the hardware is SiS 55x only (i486/Pentium-ish).

Signed-off-by: David Dillow <dave@thedillows.org>
---
This is against the alsa-driver hg repo. I've not build tested this
version, as the build system currently hates me. However, this is 95%
identical to what I was using against 1.0.13. Only the location of the
__ffs -> sis_ffs change is different.

 pci/sis7019.patch   |   32 ++++++++++++++++++++++++++++++++
 pci/Makefile        |    3 ++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff -r ab42d23439ef pci/Makefile
--- a/pci/Makefile	Tue Nov 27 16:05:25 2007 +0100
+++ b/pci/Makefile	Wed Nov 28 01:39:04 2007 -0500
@@ -10,7 +10,7 @@ include $(SND_TOPDIR)/Makefile.conf
 #
 
 clean-files := ad1889.c atiixp.c atiixp_modem.c bt87x.c cmipci.c ens1370.c \
-	fm801.c intel8x0.c maestro3.c via82xx.c via82xx_modem.c
+	fm801.c intel8x0.c maestro3.c sis7019.c via82xx.c via82xx_modem.c
 
 obj-$(CONFIG_SND) += pdplus/ asihpi/ oxygen/
 
@@ -31,5 +31,6 @@ fm801.c: fm801.patch $(SND_TOPDIR)/alsa-
 fm801.c: fm801.patch $(SND_TOPDIR)/alsa-kernel/pci/fm801.c
 intel8x0.c: intel8x0.patch $(SND_TOPDIR)/alsa-kernel/pci/intel8x0.c
 maestro3.c: maestro3.patch $(SND_TOPDIR)/alsa-kernel/pci/maestro3.c
+sis7019.c: sis7019.patch $(SND_TOPDIR)/alsa-kernel/pci/sis7019.c
 via82xx.c: via82xx.patch $(SND_TOPDIR)/alsa-kernel/pci/via82xx.c
 via82xx_modem.c: via82xx_modem.patch $(SND_TOPDIR)/alsa-kernel/pci/via82xx_modem.c
diff -r ab42d23439ef pci/sis7019.patch
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/sis7019.patch	Wed Nov 28 01:39:04 2007 -0500
@@ -0,0 +1,32 @@
+--- ../alsa-kernel/pci/sis7019.c	2007-11-28 01:02:26.000000000 -0500
++++ sis7019.c	2007-11-28 01:36:27.000000000 -0500
+@@ -33,6 +33,14 @@
+ #include <sound/initval.h>
+ #include "sis7019.h"
+ 
++static inline unsigned long sis_ffs(unsigned long word)
++{
++	__asm__("bsfl %1,%0"
++		:"=r" (word)
++		:"rm" (word));
++	return word;
++}
++
+ MODULE_AUTHOR("David Dillow <dave@thedillows.org>");
+ MODULE_DESCRIPTION("SiS 7019");
+ MODULE_LICENSE("GPL");
+@@ -289,7 +297,7 @@
+ 	int bit;
+ 
+ 	while (status) {
+-		bit = __ffs(status);
++		bit = sis_ffs(status);
+ 		status >>= bit + 1;
+ 		voice += bit;
+ 		sis_update_voice(voice);
+@@ -1464,3 +1472,5 @@
+ 
+ module_init(sis7019_init);
+ module_exit(sis7019_exit);
++
++EXPORT_NO_SYMBOLS
