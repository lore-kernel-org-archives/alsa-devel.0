From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] more URB unlinking fixes
Date: Mon, 08 Dec 2003 16:02:11 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312081553110.24628-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


deactivate_urbs didn't return the number of still-active URBs when not
unlinking asynchronously, which would prevent calling wait_clear_urbs
when some URBs actually are being unlinked asynchronously, so these
URBs would be freed while still in use.

I removed deactivate_urb's return value because wait_clear_urbs does
its own counting anyway.


Regards,
Clemens

-- 
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.73
diff -u -r1.73 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	26 Nov 2003 18:50:14 -0000	1.73
+++ alsa-kernel/usb/usbaudio.c	8 Dec 2003 13:14:10 -0000
@@ -612,12 +612,11 @@

 /*
  * unlink active urbs.
- * return the number of active urbs.
  */
 static int deactivate_urbs(snd_usb_substream_t *subs, int force, int can_sleep)
 {
 	unsigned int i;
-	int alive, async;
+	int async;

 	subs->running = 0;

@@ -629,10 +628,8 @@
 	if (! async && in_interrupt())
 		return 0;

-	alive = 0;
 	for (i = 0; i < subs->nurbs; i++) {
 		if (test_bit(i, &subs->active_mask)) {
-			alive++;
 			if (! test_and_set_bit(i, &subs->unlink_mask)) {
 				struct urb *u = subs->dataurb[i].urb;
 				if (async)
@@ -646,7 +643,6 @@
 	if (subs->syncpipe) {
 		for (i = 0; i < SYNC_URBS; i++) {
 			if (test_bit(i+16, &subs->active_mask)) {
-				alive++;
  				if (! test_and_set_bit(i+16, &subs->unlink_mask)) {
 					struct urb *u = subs->syncurb[i].urb;
 					if (async)
@@ -658,7 +654,7 @@
 			}
 		}
 	}
-	return async ? alive : 0;
+	return 0;
 }


@@ -803,8 +799,8 @@
 	int i;

 	/* stop urbs (to be sure) */
-	if (deactivate_urbs(subs, force, 1) > 0)
-		wait_clear_urbs(subs);
+	deactivate_urbs(subs, force, 1);
+	wait_clear_urbs(subs);

 	for (i = 0; i < MAX_URBS; i++)
 		release_urb_ctx(&subs->dataurb[i]);
@@ -1277,8 +1273,8 @@
 	subs->phase = 0;

 	/* clear urbs (to be sure) */
-	if (deactivate_urbs(subs, 0, 0) > 0)
-		wait_clear_urbs(subs);
+	deactivate_urbs(subs, 0, 1);
+	wait_clear_urbs(subs);

 	return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
