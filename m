From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix timer resolution calculations
Date: Mon, 06 Oct 2003 17:54:16 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310061752540.26227-100000@studcom.urz.uni-halle.de>
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


Some functions assumed that timer->hw.resolution is in Hz, while it's
actually in ns/tick.


Index: alsa-kernel/core/timer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/timer.c,v
retrieving revision 1.47
diff -u -r1.47 timer.c
--- alsa-kernel/core/timer.c	30 Sep 2003 09:28:26 -0000	1.47
+++ alsa-kernel/core/timer.c	6 Oct 2003 15:49:12 -0000
@@ -1381,8 +1381,8 @@
 		if (t->hw.precise_resolution) {
 			t->hw.precise_resolution(t, &gstatus.resolution_num, &gstatus.resolution_den);
 		} else {
-			gstatus.resolution_num = 1;
-			gstatus.resolution_den = gstatus.resolution;
+			gstatus.resolution_num = gstatus.resolution;
+			gstatus.resolution_den = 1000000000uL;
 		}
 	} else {
 		err = -ENODEV;
Index: alsa-kernel/core/seq/seq_timer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_timer.c,v
retrieving revision 1.17
diff -u -r1.17 seq_timer.c
--- alsa-kernel/core/seq/seq_timer.c	11 Mar 2003 15:02:26 -0000	1.17
+++ alsa-kernel/core/seq/seq_timer.c	6 Oct 2003 15:49:12 -0000
@@ -335,7 +335,7 @@
 		if (! r && t->hw.c_resolution)
 			r = t->hw.c_resolution(t);
 		if (r) {
-			tmr->ticks = (unsigned int)(tmr->preferred_resolution / r);
+			tmr->ticks = (unsigned int)(1000000000uL / (r * tmr->preferred_resolution));
 			if (! tmr->ticks)
 				tmr->ticks = 1;
 		}
Index: alsa-kernel/core/seq/seq_timer.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_timer.h,v
retrieving revision 1.5
diff -u -r1.5 seq_timer.h
--- alsa-kernel/core/seq/seq_timer.h	4 Feb 2003 13:25:09 -0000	1.5
+++ alsa-kernel/core/seq/seq_timer.h	6 Oct 2003 15:49:12 -0000
@@ -47,7 +47,7 @@
 	snd_timer_id_t		alsa_id;	/* ALSA's timer ID */
 	snd_timer_instance_t	*timeri;	/* timer instance */
 	unsigned int		ticks;
-	unsigned long		preferred_resolution; /* timer resolution */
+	unsigned long		preferred_resolution; /* timer resolution, ticks/sec */

 	unsigned int skew;
 	unsigned int skew_base;




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
