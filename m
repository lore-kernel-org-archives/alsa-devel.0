From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix seq device driver locking
Date: Mon, 9 Dec 2002 09:12:20 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212090902480.1348-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


In my disconnect patch, I forgot to unlock the driver.
This prevented it from being freed properly.

-- 
Clemens


Index: core/seq/seq_device.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_device.c,v
retrieving revision 1.9
diff -u -r1.9 seq_device.c
--- core/seq/seq_device.c	29 Nov 2002 14:38:57 -0000	1.9
+++ core/seq/seq_device.c	9 Dec 2002 08:10:00 -0000
@@ -283,6 +283,8 @@
 		return -ENOENT;

 	free_device(dev, ops);
+
+	unlock_driver(ops);
 	return 0;
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
