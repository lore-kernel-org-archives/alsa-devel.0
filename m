From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Build files
Date: Fri, 15 Sep 2006 14:17:32 +0100
Message-ID: <1158326252.22950.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-81t/owuoCQRr/AV48ZIQ"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-81t/owuoCQRr/AV48ZIQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for building the ASoC core and the dynamic audio
power management support.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-81t/owuoCQRr/AV48ZIQ
Content-Disposition: attachment; filename=asoc-build.patch
Content-Type: text/x-patch; name=asoc-build.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/Kconfig
===================================================================
--- alsa-kernel.orig/Kconfig
+++ alsa-kernel/Kconfig
@@ -76,6 +76,8 @@ source "sound/sparc/Kconfig"
 
 source "sound/parisc/Kconfig"
 
+source "sound/soc/Kconfig"
+
 endmenu
 
 menu "Open Sound System"
Index: alsa-kernel/Makefile
===================================================================
--- alsa-kernel.orig/Makefile
+++ alsa-kernel/Makefile
@@ -4,7 +4,7 @@
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ soc/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 ifeq ($(CONFIG_SND),y)
Index: alsa-kernel/soc/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/Kconfig
@@ -0,0 +1,18 @@
+#
+# SoC audio configuration
+#
+
+menu "SoC audio support"
+
+config SND_SOC
+	tristate "SoC audio support"
+	---help---
+
+	  If you want SoC support, you should say Y here and also to the
+	  specific driver for your SoC below. You will also need to select the
+	  specific codec(s) attached to the SoC
+
+	  This SoC audio support can also be built as a module.  If so, the module
+	  will be called snd-soc-core.
+
+endmenu
Index: alsa-kernel/soc/Makefile
===================================================================
--- /dev/null
+++ alsa-kernel/soc/Makefile
@@ -0,0 +1,4 @@
+snd-soc-core-objs := soc-core.o soc-dapm.o
+
+obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
+

--=-81t/owuoCQRr/AV48ZIQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-81t/owuoCQRr/AV48ZIQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-81t/owuoCQRr/AV48ZIQ--
