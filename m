From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix alsa-utils installation docs
Date: Tue, 03 Dec 2002 09:26:26 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212030918110.17800-100000@studcom.urz.uni-halle.de>
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


In the list of commands for CVS compilation, autoheader was missing.


Index: alsa-utils/INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/INSTALL,v
retrieving revision 1.3
diff -u -r1.3 INSTALL
--- alsa-utils/INSTALL	26 Nov 2001 18:39:49 -0000	1.3
+++ alsa-utils/INSTALL	3 Dec 2002 08:15:31 -0000
@@ -25,6 +25,7 @@
 For compilation you can use these commands:

 	aclocal
+	autoheader
 	automake --foreign --copy --add-missing
 	autoconf
 	./configure



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
