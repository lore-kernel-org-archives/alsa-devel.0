From: Pavel Roskin <proski@gnu.org>
Subject: Simple patch for alsa-utils/cvscompile
Date: Thu, 01 May 2003 01:00:28 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305010056500.7539-100000@localhost.localdomain>
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

Hello!

When I compile alsa-utils from clean CVS checkout, alsa.m4 is not yet
installed in the system.  The attached patch checks if ../alsa-lib/utils
is a directory (that's where alsa.m4 should be), and if yes, it's added to
the search patch of aclocal.

==========================
--- alsa-utils/cvscompile
+++ alsa-utils/cvscompile
@@ -1,6 +1,10 @@
 #!/bin/bash
 
-aclocal $ACLOCAL_FLAGS
+if test -d ../alsa-lib/utils; then
+	alsa_m4_flags="-I ../alsa-lib/utils"
+fi
+
+aclocal $alsa_m4_flags $ACLOCAL_FLAGS
 autoheader
 automake --foreign --copy --add-missing
 touch depcomp		# for older automake
==========================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
