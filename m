From: floyd@unpunk.com (Matt Mercer)
Subject: [PATCH] athlon/crusoe compiler options
Date: Thu, 6 Mar 2003 21:05:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030307050513.GA5413@unpunk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

This trivial patch alters compile options for athlon and crusoe cpu-types to be compatible with gcc-3.x.x.

Matt Mercr

Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.142
diff -u -r1.142 configure.in
--- configure.in        5 Mar 2003 20:04:33 -0000       1.142
+++ configure.in        6 Mar 2003 09:19:10 -0000
@@ -430,11 +430,11 @@
     if $CC -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
       c_opts="-march=athlon"
     else
-      c_opts="-march=i686 -malign-functions=4"
+      c_opts="-march=i686 -falign-functions=4"
     fi
     ;;
   crusoe)
-    c_opts="-march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0"
+    c_opts="-march=i686 -falign-functions=0 -falign-jumps=0 -falign-loops=0"
     ;;
   ia64)
     c_opts="-Wa,-x -ffixed-r13 -mfixed-range=f10-f15,f32-f127 -funwind-tables -falign-functions=32"



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
