From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] RPM building broken in CVS
Date: Sun, 6 Oct 2002 23:53:57 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210062253.g96MrvdA001361@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I have finally managed to build the alsa-lib and alsa-utils RPMs on my test machine, having upgraded to
RedHat 7.3. The highlights of this patch are:

- the Versions linker script was not being tarred up
- using $(AMTAR) instead or $(TAR) in the Makefile.am
- using -j instead of -I to compress using bzip2 rather than gzip

As they say, "it works for me" :-)

Cheers,
Chris

Index: alsa-lib/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/Makefile.am,v
retrieving revision 1.16
diff -u -u -r1.16 Makefile.am
--- alsa-lib/Makefile.am	20 Nov 2001 09:32:19 -0000	1.16
+++ alsa-lib/Makefile.am	6 Oct 2002 18:48:23 -0000
@@ -8,7 +8,7 @@
 
 dist-hook:
 	-chmod -R a+r $(distdir)
-	$(TAR) cvIf $(distdir).tar.bz2 $(distdir)
+	$(AMTAR) cvjf $(distdir).tar.bz2 $(distdir)
 
 doc-dummy:
 
Index: alsa-lib/src/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/Makefile.am,v
retrieving revision 1.38
diff -u -u -r1.38 Makefile.am
--- alsa-lib/src/Makefile.am	17 Sep 2002 12:33:05 -0000	1.38
+++ alsa-lib/src/Makefile.am	6 Oct 2002 18:48:23 -0000
@@ -1,4 +1,5 @@
 SUBDIRS=control mixer pcm rawmidi timer hwdep seq instr compat conf
+EXTRA_DIST=Versions
 COMPATNUM=@LIBTOOL_VERSION_INFO@
 
 lib_LTLIBRARIES = libasound.la
Index: alsa-utils/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/Makefile.am,v
retrieving revision 1.15
diff -u -u -r1.15 Makefile.am
--- alsa-utils/Makefile.am	20 Nov 2001 09:05:27 -0000	1.15
+++ alsa-utils/Makefile.am	6 Oct 2002 18:48:23 -0000
@@ -7,4 +7,4 @@
 
 dist-hook:
 	-chmod -R a+r $(distdir)
-	$(TAR) cvIf $(distdir).tar.bz2 $(distdir)
+	$(AMTAR) cvjf $(distdir).tar.bz2 $(distdir)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
