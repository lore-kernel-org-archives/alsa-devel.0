From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] fix configure.in typo
Date: Mon, 11 Apr 2005 15:33:50 -0400
Message-ID: <1113248031.5226.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

fix cosmetic typo

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>`

Index: alsa/alsa-driver/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.300
diff -u -r1.300 configure.in
--- alsa/alsa-driver/configure.in	4 Apr 2005 06:50:48 -0000	1.300
+++ alsa/alsa-driver/configure.in	11 Apr 2005 19:32:46 -0000
@@ -2009,7 +2009,7 @@
 
 dnl New unlocked/compat_ioctl
 if test "$kversion.$kpatchlevel" = "2.6"; then
-  AC_MSG_CHECKING(for new unlocked/comapt_ioctl)
+  AC_MSG_CHECKING(for new unlocked/compat_ioctl)
   new_ioctl="0"
   ac_save_CFLAGS="$CFLAGS"
   ac_save_CC="$CC"




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
