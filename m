From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbaudio fixes
Date: Mon, 24 Nov 2003 08:46:08 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311240842140.2835-100000@studcom.urz.uni-halle.de>
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


- don't clear active_mask bits until it's clear that the URB is _not_
  resubmitted, to prevent a race with unlinking
- initialize active_mask and unlink_mask each time before URBs are
  started
- don't call sleeping functions in trigger callback


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.70
diff -u -r1.70 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	20 Nov 2003 16:08:26 -0000	1.70
+++ alsa-kernel/usb/usbaudio.c	24 Nov 2003 07:40:19 -0000
@@ -573,21 +573,18 @@
 	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
 	snd_usb_substream_t *subs = ctx->subs;
 	snd_pcm_substream_t *substream = ctx->subs->pcm_substream;
-	int err;
+	int err = 0;

-	clear_bit(ctx->index, &subs->active_mask);
-	clear_bit(ctx->index, &subs->unlink_mask);
-	if (subs->running && subs->ops.retire(subs, substream->runtime, urb))
-		return;
-	if (! subs->running) /* can be stopped during retire callback */
-		return;
-	if ((err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
+	if ((subs->running && subs->ops.retire(subs, substream->runtime, urb)) ||
+	    ! subs->running || /* can be stopped during retire callback */
+	    (err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
 	    (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
-		snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		return;
+		clear_bit(ctx->index, &subs->active_mask);
+		if (err < 0) {
+			snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
+			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		}
 	}
-	set_bit(ctx->index, &subs->active_mask);
 }


@@ -599,21 +596,18 @@
 	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
 	snd_usb_substream_t *subs = ctx->subs;
 	snd_pcm_substream_t *substream = ctx->subs->pcm_substream;
-	int err;
+	int err = 0;

-	clear_bit(ctx->index + 16, &subs->active_mask);
-	clear_bit(ctx->index + 16, &subs->unlink_mask);
-	if (subs->running && subs->ops.retire_sync(subs, substream->runtime, urb))
-		return;
-	if (! subs->running) /* can be stopped during retire callback */
-		return;
-	if ((err = subs->ops.prepare_sync(subs, substream->runtime, urb))  < 0 ||
+	if ((subs->running && subs->ops.retire_sync(subs, substream->runtime, urb)) ||
+	    ! subs->running || /* can be stopped during retire callback */
+	    (err = subs->ops.prepare_sync(subs, substream->runtime, urb)) < 0 ||
 	    (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
-		snd_printd(KERN_ERR "cannot submit sync urb (err = %d)\n", err);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		return;
+		clear_bit(ctx->index + 16, &subs->active_mask);
+		if (err < 0) {
+			snd_printd(KERN_ERR "cannot submit sync urb (err = %d)\n", err);
+			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		}
 	}
-	set_bit(ctx->index + 16, &subs->active_mask);
 }


@@ -694,9 +688,11 @@
 		}
 	}

+	subs->active_mask = 0;
+	subs->unlink_mask = 0;
 	subs->running = 1;
 	for (i = 0; i < subs->nurbs; i++) {
-		if ((err = usb_submit_urb(subs->dataurb[i].urb, GFP_KERNEL)) < 0) {
+		if ((err = usb_submit_urb(subs->dataurb[i].urb, GFP_ATOMIC)) < 0) {
 			snd_printk(KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
 			goto __error;
 		}
@@ -704,7 +700,7 @@
 	}
 	if (subs->syncpipe) {
 		for (i = 0; i < SYNC_URBS; i++) {
-			if ((err = usb_submit_urb(subs->syncurb[i].urb, GFP_KERNEL)) < 0) {
+			if ((err = usb_submit_urb(subs->syncurb[i].urb, GFP_ATOMIC)) < 0) {
 				snd_printk(KERN_ERR "cannot submit syncpipe for urb %d, err = %d\n", i, err);
 				goto __error;
 			}
@@ -843,8 +839,6 @@
 	subs->hwptr_done = 0;
 	subs->transfer_sched = 0;
 	subs->transfer_done = 0;
-	subs->active_mask = 0;
-	subs->unlink_mask = 0;

 	/* calculate the max. size of packet */
 	maxsize = ((subs->freqmax + 0x3fff) * (frame_bits >> 3)) >> 14;
@@ -1282,9 +1276,6 @@
 	/* some unit conversions in runtime */
 	subs->maxframesize = bytes_to_frames(runtime, subs->maxpacksize);
 	subs->curframesize = bytes_to_frames(runtime, subs->curpacksize);
-
-	/* deactivate urbs to be sure */
-	deactivate_urbs(subs, 0, 0);

 	return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
