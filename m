From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] fix for us428 and 2.4.19
Date: Mon, 15 Sep 2003 21:21:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030915192123.GB524@tuba.home>
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

fix for us428 plus the prehistoric 2.4.19 kernel.

martin


PS: time for holidays now....


--- usbus428.h.ORIGINAL	Mon Sep 15 20:43:37 2003
+++ usbus428.h	Mon Sep 15 20:49:59 2003
@@ -7,8 +7,10 @@
 #define NRURBS	        2	/* */
 #define NRPACKS		1	/* usb-frames/ms per urb */
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 4, 19)
 typedef struct urb urb_t;
 typedef struct urb* purb_t;
+#endif
 
 #define URBS_AsyncSeq 10
 #define URB_DataLen_AsyncSeq 32


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
