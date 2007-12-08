From: Dave Dillow <dave@thedillows.org>
Subject: [PATCH 2/2] sis7019: add support for pre-2.6 kernels
Date: Sat, 08 Dec 2007 18:54:03 -0500
Message-ID: <1197158043.3588.52.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 4683A1038B2
	for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2007 00:54:08 +0100 (CET)
Received: from obelisk.thedillows.org (obelisk.thedillows.org [192.168.0.10])
	by shed.thedillows.org (8.13.8/8.13.8) with ESMTP id lB8Ns3Yw022144
	for <alsa-devel@alsa-project.org>; Sat, 8 Dec 2007 18:54:03 -0500
Received: from obelisk.thedillows.org (localhost.localdomain [127.0.0.1])
	by obelisk.thedillows.org (8.14.1/8.13.8) with ESMTP id lB8Ns3cE007838
	for <alsa-devel@alsa-project.org>; Sat, 8 Dec 2007 18:54:03 -0500
Received: (from il1@localhost)
	by obelisk.thedillows.org (8.14.1/8.14.1/Submit) id lB8Ns3na007835
	for alsa-devel@alsa-project.org; Sat, 8 Dec 2007 18:54:03 -0500
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
This is against the alsa-driver hg repo. It has been compiled and tested
under 2.6.23.

 pci/sis7019.patch   |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 pci/Makefile        |    3 ++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff -r 9eda190b55c3 pci/Makefile
--- a/pci/Makefile	Tue Dec 04 12:46:46 2007 +0100
+++ b/pci/Makefile	Sat Dec 08 18:45:46 2007 -0500
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
diff -r 9eda190b55c3 pci/sis7019.patch
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pci/sis7019.patch	Sat Dec 08 18:45:46 2007 -0500
@@ -0,0 +1,52 @@
+--- sis7019.c.orig	2007-12-08 18:32:09.000000000 -0500
++++ sis7019.c	2007-12-08 18:31:35.000000000 -0500
+@@ -31,7 +31,17 @@
+ #include <sound/core.h>
+ #include <sound/ac97_codec.h>
+ #include <sound/initval.h>
+-#include "sis7019.h"
++#include "../alsa-kernel/pci/sis7019.h"
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
++static inline unsigned long sis_ffs(unsigned long word)
++{
++	__asm__("bsfl %1,%0"
++		:"=r" (word)
++		:"rm" (word));
++	return word;
++}
++#endif
+ 
+ MODULE_AUTHOR("David Dillow <dave@thedillows.org>");
+ MODULE_DESCRIPTION("SiS 7019");
+@@ -290,7 +300,11 @@
+ 	int bit;
+ 
+ 	while (status) {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
++		bit = sis_ffs(status);
++#else
+ 		bit = __ffs(status);
++#endif
+ 		status >>= bit + 1;
+ 		voice += bit;
+ 		sis_update_voice(voice);
+@@ -791,9 +805,9 @@
+ 
+ 	/* The following variables are only used if there is a timing channel.
+ 	 */
+-	u32 uninitialized_var(timing_ctrl);
+-	u32 uninitialized_var(sso_eso);
+-	u32 uninitialized_var(delta);
++	u32 timing_ctrl = 0;
++	u32 sso_eso = 0;
++	u32 delta = 0;
+ 
+ 	/* We rely on the PCM core to ensure that the parameters for this
+ 	 * substream do not change on us while we're programming the HW.
+@@ -1460,3 +1474,5 @@
+ 
+ module_init(sis7019_init);
+ module_exit(sis7019_exit);
++
++EXPORT_NO_SYMBOLS
