From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix typo in configure.in
Date: Mon, 19 May 2003 18:37:50 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305191835560.8349-100000@studcom.urz.uni-halle.de>
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


Index: alsa-driver/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.167
diff -u -r1.167 configure.in
--- alsa-driver/configure.in	19 May 2003 12:44:16 -0000	1.167
+++ alsa-driver/configure.in	19 May 2003 16:27:30 -0000
@@ -202,7 +202,7 @@
   my_compiler="gcc $my_compiler"
 fi
 AC_MSG_RESULT(Kernel compiler: $kernel_compiler Used compiler: $my_compiler);
-if test -z "$kernel_compier"; then
+if test -z "$kernel_compiler"; then
   echo
   echo "*** NO PREDEFINED KERNEL COMPILER IS DETECTED"
   echo "*** Assuming the same compiler is used with the current system compiler."




-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
