From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix OPL4 patch
Date: Tue, 04 Nov 2003 09:31:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311040930280.23879-100000@studcom.urz.uni-halle.de>
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


oops - use vfree in error paths, too


Index: alsa-kernel/drivers/opl4/opl4_proc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl4/opl4_proc.c,v
retrieving revision 1.2
diff -u -r1.2 opl4_proc.c
--- alsa-kernel/drivers/opl4/opl4_proc.c	3 Nov 2003 10:30:47 -0000	1.2
+++ alsa-kernel/drivers/opl4/opl4_proc.c	4 Nov 2003 08:29:44 -0000
@@ -65,7 +65,7 @@
 			return -ENOMEM;
 		snd_opl4_read_memory(opl4, buf, file->f_pos, size);
 		if (copy_to_user(_buf, buf, size)) {
-			kfree(buf);
+			vfree(buf);
 			return -EFAULT;
 		}
 		vfree(buf);
@@ -90,7 +90,7 @@
 		if (!buf)
 			return -ENOMEM;
 		if (copy_from_user(buf, _buf, size)) {
-			kfree(buf);
+			vfree(buf);
 			return -EFAULT;
 		}
 		snd_opl4_write_memory(opl4, buf, file->f_pos, size);




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
