From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: snd-msnd-pinnacle only builds.....
Date: Sat, 15 May 2004 11:34:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405151134.13680.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

... if i apply those two patches:

>>>>>
Index: alsa-driver/Makefile.conf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile.conf.in,v
retrieving revision 1.62
diff -u -r1.62 Makefile.conf.in
--- alsa-driver/Makefile.conf.in	5 Mar 2004 11:49:44 -0000	1.62
+++ alsa-driver/Makefile.conf.in	15 May 2004 08:51:04 -0000
@@ -44,6 +44,7 @@
 CONFIG_SND_MVERSION	= @CONFIG_SND_MVERSION@
 CONFIG_ISAPNP_KERNEL	= @CONFIG_ISAPNP_KERNEL@
 CONFIG_PNP_KERNEL	= @CONFIG_PNP_KERNEL@
+CONFIG_X86		= @CONFIG_X86@
 
 ifndef NEW_KBUILD
 INCLUDE		= -I$(TOPDIR)/include @EXTRA_INCLUDES@ @KERNEL_INC@
Index: alsa-driver/isa/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/Makefile,v
retrieving revision 1.13
diff -u -r1.13 Makefile
--- alsa-driver/isa/Makefile	4 Feb 2004 19:32:52 -0000	1.13
+++ alsa-driver/isa/Makefile	15 May 2004 08:51:05 -0000
@@ -9,7 +9,7 @@
 # ALSA extra code
 #
 ifeq (y,$(CONFIG_X86))
-obj-y	+= msnd/
+obj-$(CONFIG_SND) += msnd/
 endif
 
 isapnp-files := als100.isapnp azt2320.isapnp dt019x.isapnp opl3sa2.isapnp \
<<<<<

I'm not shure if the change in alsa-driver/Makefile.conf.in is correct. 
Here on a Fedora Core 1 Planet CCRMA Box (Kernel 2.4) it was necessary though.

Thanks,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
