From: Clemens Ladisch <clemens@ladisch.de>
Subject: [BUG] snd-usb-audio still crashes when unplugging
Date: Wed, 12 Mar 2003 11:01:41 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303121039460.11828-100000@studcom.urz.uni-halle.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Unplugging a currently playing USB audio (not MIDI) device results in a
big kernel oops.

When chip->shutdown is set, deactivate_urbs() doesn't do anything, but
that's the case where the URB unlinking is really needed.

And, in the shutdown case, the URBs must not be resubmitted. I'm not
really sure if reporting an xrun (like below) is a good idea; with the
changes below, aplay hangs (when draining?) after the device is unplugged.


Regards,
Clemens


--- usbaudio.c.orig	Tue Mar 11 22:14:48 2003
+++ usbaudio.c	Wed Mar 12 00:00:00 2003
@@ -545,6 +545,10 @@
 		return;
 	if (! subs->running) /* can be stopped during retire callback */
 		return;
+	if (subs->stream->chip->shutdown) {
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		return;
+	}
 	if ((err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
 	    (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
 		snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
@@ -570,6 +574,10 @@
 		return;
 	if (! subs->running) /* can be stopped during retire callback */
 		return;
+	if (subs->stream->chip->shutdown) {
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		return;
+	}
 	if ((err = subs->ops.prepare_sync(subs, substream->runtime, urb))  < 0 ||
 	    (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
 		snd_printd(KERN_ERR "cannot submit sync urb (err = %d)\n", err);
@@ -590,9 +598,6 @@
 	int alive;

 	subs->running = 0;
-
-	if (subs->stream->chip->shutdown) /* to be sure... */
-		return 0;

 #ifndef SND_USB_ASYNC_UNLINK
 	if (in_interrupt())





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
