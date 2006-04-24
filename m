From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [patch] Use configured kernel compiler on 2.6
Date: Mon, 24 Apr 2006 23:58:53 +0200
Message-ID: <20060424215852.GA26469@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Compile the modules for 2.6 with the configured kernel compiler instead of
the compiler specified in the kernel Makefile. If the kernel was
compiled with the default compiler (gcc) and gcc later was upgraded or
changed to an incompatible gcc version used to compile the alsa modules,
would otherwise lead to unusable modules.


Signed-off-by: Mikael Magnusson <mikma@users.sourceforge.net>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-kernel-compiler.patch"

Index: alsa-driver/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile,v
retrieving revision 1.121
diff -u -u -r1.121 Makefile
--- alsa-driver/Makefile	17 Nov 2005 11:15:20 -0000	1.121
+++ alsa-driver/Makefile	24 Apr 2006 21:34:34 -0000
@@ -137,7 +137,7 @@
 .PHONY: compile
 compile: include/sound/version.h include/sndversions.h
 ifdef NEW_KBUILD
-	$(MAKE) -C $(CONFIG_SND_KERNELDIR) SUBDIRS=$(MAINSRCDIR) $(MAKE_ADDS) modules
+	$(MAKE) -C $(CONFIG_SND_KERNELDIR) SUBDIRS=$(MAINSRCDIR) $(MAKE_ADDS) CPP="$(CPP)" CC="$(CC)" modules
 	utils/link-modules $(SND_TOPDIR)
 else
 	@for d in $(SUBDIRS); do if ! $(MAKE) -C $$d; then exit 1; fi; done
Index: alsa-driver/Makefile.conf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile.conf.in,v
retrieving revision 1.67
diff -u -u -r1.67 Makefile.conf.in
--- alsa-driver/Makefile.conf.in	15 Apr 2005 13:09:33 -0000	1.67
+++ alsa-driver/Makefile.conf.in	24 Apr 2006 21:34:35 -0000
@@ -11,6 +11,8 @@
 CROSS_COMPILE   ?= @CROSS_COMPILE@
 ARCH            ?= @ARCH@
 ifdef NEW_KBUILD
+CC		= $(CROSS_COMPILE)@CC@
+CPP		= $(CROSS_COMPILE)@CPP@
 export CROSS_COMPILE ARCH
 else
 AS		= $(CROSS_COMPILE)@AS@

--G4iJoqBmSsgzjUCe--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
