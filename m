From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] typos in configure build system
Date: Wed, 29 Jan 2003 12:38:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m265s8i3tf.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/x-patch
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: attachment; filename=alsa-driver-configure.diff
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

Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.137
diff -u -w -p -r1.137 configure.in
--- configure.in	29 Jan 2003 10:39:19 -0000	1.137
+++ configure.in	29 Jan 2003 11:40:46 -0000
@@ -817,10 +817,10 @@ AC_SUBST(CONFIG_USB)
 
 dnl PCMCIA stuff
 AC_ARG_WITH(pcmcia,
-  [  --with-pcmcai=kernel,external   support kernel PCMCIA driver or external PCMCIA driver],
+  [  --with-pcmcia=kernel,external   support kernel PCMCIA driver or external PCMCIA driver],
   pcmcia="$withval", pcmcia="kernel")
 AC_ARG_WITH(pcmcia_root,
-  [  --with-pcmcai-root=dir  specify the root directory of external PCMCIA source-tree],
+  [  --with-pcmcia-root=dir  specify the root directory of external PCMCIA source-tree],
   pcmciaroot="$withval", pcmciaroot="")
 EXTRA_INCLUDES=""
 if test "$pcmcia" = "kernel"; then



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
