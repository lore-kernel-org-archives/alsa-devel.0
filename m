From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Adding a new architecture to alsa-driver
Date: Sat, 08 Apr 2006 21:16:54 -0400
Message-ID: <1144545416.22490.184.camel@mindpipe>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144542208.10642.9.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-09 at 01:23 +0100, Adrian McMenamin wrote:
> On Sat, 2006-04-08 at 12:03 -0400, Lee Revell wrote:
> > On Sat, 2006-04-08 at 16:35 +0100, Adrian McMenamin wrote:
> > > I've now wasted two days of my life trying to do this and I have had no
> > > luck, can someone explain the steps needed to added SH (ie
> > > CONFIG_SUPERH) to the alsa-driver build. I am sure somebody knows the
> > > steps needed to make this happen
> > 
> > I already explained it.  What *exactly* does not work if you change the
> > Makefiles as I explained?
> 
> The changes you suggest simply are inadequate. There is no makefile
> without configure and even though I have managed to patch the configure
> file so it will create a Makefile, a make simply builds the alsa core
> and doesn't touch the sh sub directory despite having this in the
> makefile:
> 
> ifeq (y,$(CONFIG_SUPERH))
> SUBDIRS += sh
> endif
> 
> 
> 

OK, how does this work - try this patch against a clean alsa-driver CVS
checkout, then add your driver.  Replace c_opts with whatever CFLAGS you
need.

Index: Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile,v
retrieving revision 1.121
diff -u -r1.121 Makefile
--- Makefile	17 Nov 2005 11:15:20 -0000	1.121
+++ Makefile	9 Apr 2006 01:15:23 -0000
@@ -6,7 +6,7 @@
 ifneq ($(KERNELRELEASE),)
 # call from 2.6 kernel build system
 
-obj-m += acore/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/
+obj-m += acore/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ sh/
 
 else
 
@@ -99,6 +99,9 @@
 ifeq (y,$(CONFIG_PARISC))
 SUBDIRS  += parisc
 endif
+ifeq (y,$(CONFIG_SUPERH))
+SUBDIRS  += sh 
+endif
 CSUBDIRS += include test utils
 
 KCONFIG_FILES = $(shell find $(SND_TOPDIR) -name Kconfig) $(shell find $(SND_TOPDIR)/alsa-kernel/ -name Kconfig)
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.358
diff -u -r1.358 configure.in
--- configure.in	29 Mar 2006 16:52:47 -0000	1.358
+++ configure.in	9 Apr 2006 01:15:24 -0000
@@ -872,6 +872,8 @@
 	fprintf(file, "amba");
 #elif defined(CONFIG_PARISC)
 	fprintf(file, "parisc");
+#elif defined(CONFIG_SUPERH)
+	fprintf(file, "sh");
 #elif defined(CONFIG_MVIAC3_2)
 	fprintf(file, "viac3_2");
 #else
@@ -1117,6 +1119,11 @@
     c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200 -mdisable-fpregs"
     test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
     ;;
+  sh)
+    ARCH=sh
+    c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200 -mdisable-fpregs"
+    test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
+    ;;
   viac3_2)
     ARCH=i386
     if $KCC -march=c3-2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
@@ -1259,6 +1266,7 @@
 AC_SUBST(CONFIG_ISA)
 AC_SUBST(CONFIG_ISA_DMA_API)
 AC_SUBST(CONFIG_PARISC)
+AC_SUBST(CONFIG_SUPERH)
 test "$CONFIG_ISA" = "y" && AC_DEFINE(CONFIG_SND_ISA)
 
 dnl Check for SMP...




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
