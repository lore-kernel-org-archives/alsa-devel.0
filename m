From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] iecset makefile fix
Date: Tue, 28 Oct 2003 17:28:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310281727270.8214-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


fix wrong SOURCES in Makefile.am


Index: alsa-utils/iecset/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/iecset/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- alsa-utils/iecset/Makefile.am	23 Oct 2003 16:54:33 -0000	1.1
+++ alsa-utils/iecset/Makefile.am	28 Oct 2003 16:26:28 -0000
@@ -4,6 +4,7 @@
 # CFLAGS += -g -Wall

 bin_PROGRAMS = iecset
-amixer_SOURCES = iecset.c iecbits.c
+iecset_SOURCES = iecset.c
+EXTRA_iecset_SOURCES = iecbits.c
 man_MANS = iecset.1
 EXTRA_DIST = iecset.1




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
