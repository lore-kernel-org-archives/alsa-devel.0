From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Bad configure test for vmalloc_to_page() in CVS
Date: Sun, 9 Mar 2003 15:30:08 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030309153008.15065.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

I have just tried to compile the latest alsa-driver
from CVS and was surprised to see lots of
"vmalloc_to_page redefined" warnings. A quick check
showed that 2.4.20 does define vmalloc_to_page(), but
that ALSA was trying to provide a "compatibility
function" anyway.

The problem seems to be in the configure script, and
this patch seems to fix it:

$ cvsalsa diff -u configure.in
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.145
diff -u -u -r1.145 configure.in
--- configure.in        8 Mar 2003 14:24:32 -0000     
 1.145
+++ configure.in        9 Mar 2003 15:28:47 -0000
@@ -732,7 +732,7 @@
 AC_TRY_COMPILE([
 #include <linux/config.h>
 #include <linux/time.h>
-#include <linux/mm.h>
+#include <linux/slab.h>
 ],[
  vmalloc_to_page(NULL);
 ],

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
