From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix snd_ctl_elem_list_free_space
Date: Mon, 03 Nov 2003 08:38:23 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311030835470.766-100000@studcom.urz.uni-halle.de>
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


clear element count when freeing space in element list


Index: alsa-lib/src/control/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control.c,v
retrieving revision 1.100
diff -u -r1.100 control.c
--- alsa-lib/src/control/control.c	21 Oct 2003 17:39:14 -0000	1.100
+++ alsa-lib/src/control/control.c	3 Nov 2003 07:31:57 -0000
@@ -781,6 +781,7 @@
 {
 	free(obj->pids);
 	obj->pids = NULL;
+	obj->space = 0;
 }

 /**




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
