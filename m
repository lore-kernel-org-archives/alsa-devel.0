From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] use vmalloc in opl4_proc_read/write
Date: Mon, 03 Nov 2003 08:38:39 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311030833230.766-100000@studcom.urz.uni-halle.de>
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


use vmalloc instead of kmalloc for temp buffer in proc read()/write()


Index: alsa-kernel/drivers/opl4/opl4_proc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl4/opl4_proc.c,v
retrieving revision 1.1
diff -u -r1.1 opl4_proc.c
--- alsa-kernel/drivers/opl4/opl4_proc.c	23 May 2003 11:15:12 -0000	1.1
+++ alsa-kernel/drivers/opl4/opl4_proc.c	3 Nov 2003 07:31:23 -0000
@@ -18,6 +18,7 @@
  */

 #include "opl4_local.h"
+#include <linux/vmalloc.h>
 #include <sound/info.h>

 #ifdef CONFIG_PROC_FS
@@ -59,7 +60,7 @@
 	if (file->f_pos + size > entry->size)
 		size = entry->size - file->f_pos;
 	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
+		buf = vmalloc(size);
 		if (!buf)
 			return -ENOMEM;
 		snd_opl4_read_memory(opl4, buf, file->f_pos, size);
@@ -67,7 +68,7 @@
 			kfree(buf);
 			return -EFAULT;
 		}
-		kfree(buf);
+		vfree(buf);
 		file->f_pos += size;
 		return size;
 	}
@@ -85,7 +86,7 @@
 	if (file->f_pos + size > entry->size)
 		size = entry->size - file->f_pos;
 	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
+		buf = vmalloc(size);
 		if (!buf)
 			return -ENOMEM;
 		if (copy_from_user(buf, _buf, size)) {
@@ -93,7 +94,7 @@
 			return -EFAULT;
 		}
 		snd_opl4_write_memory(opl4, buf, file->f_pos, size);
-		kfree(buf);
+		vfree(buf);
 		file->f_pos += size;
 		return size;
 	}




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
