From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.7.3
Date: Mon, 20 Sep 2004 13:25:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409201325.45029.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_54rTB0JOU3NSOjb"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_54rTB0JOU3NSOjb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

Kernel 2.6.9-rc2 stops barking with this.
The patch changes snd_usb-lib and snd-usb-usx2y.

Comment:
	Use usb_kill_urb() instead of deprecated (kernel 2.6.9) usb_unlink_urb().

thanks,
Karsten

--Boundary-00=_54rTB0JOU3NSOjb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.7.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.7.3"

Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.33
diff -u -r1.33 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	3 Aug 2004 15:24:22 -0000	1.33
+++ alsa-kernel/usb/usbmidi.c	20 Sep 2004 11:13:26 -0000
@@ -715,9 +715,9 @@
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
 		if (ep->out && ep->out->urb)
-			usb_unlink_urb(ep->out->urb);
+			usb_kill_urb(ep->out->urb);
 		if (ep->in && ep->in->urb)
-			usb_unlink_urb(ep->in->urb);
+			usb_kill_urb(ep->in->urb);
 	}
 }
 
@@ -1161,7 +1161,7 @@
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
 		if (ep->in)
-			usb_unlink_urb(ep->in->urb);
+			usb_kill_urb(ep->in->urb);
 	}
 }
 
Index: alsa-kernel/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.2
diff -u -r1.2 usbusx2y.c
--- alsa-kernel/usb/usx2y/usbusx2y.c	15 Sep 2004 10:18:02 -0000	1.2
+++ alsa-kernel/usb/usx2y/usbusx2y.c	20 Sep 2004 11:13:27 -0000
@@ -1,6 +1,10 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2004-09-20 Karsten Wiese
+	Version 0.7.3:
+	Use usb_kill_urb() instead of deprecated (kernel 2.6.9) usb_unlink_urb().
+
 2004-07-13 Karsten Wiese
 	Version 0.7.1:
 	Don't sleep in START/STOP callbacks anymore.
@@ -115,7 +119,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.7.2");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.7.3");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
@@ -277,7 +281,7 @@
 	int	i;
 	for (i = 0; i < URBS_AsyncSeq; ++i) {
 		if (S[i].urb) {
-			usb_unlink_urb(S->urb[i]);
+			usb_kill_urb(S->urb[i]);
 			usb_free_urb(S->urb[i]);
 			S->urb[i] = NULL;
 		}
@@ -408,7 +412,7 @@
 		usX2Y->chip.shutdown = 1;
 		usX2Y->chip_status = USX2Y_STAT_CHIP_HUP;
 		usX2Y_unlinkSeq(&usX2Y->AS04);
-		usb_unlink_urb(usX2Y->In04urb);
+		usb_kill_urb(usX2Y->In04urb);
 		snd_card_disconnect((snd_card_t*)ptr);
 		/* release the midi resources */
 		list_for_each(p, &usX2Y->chip.midi_list) {
Index: alsa-kernel/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.3
diff -u -r1.3 usbusx2yaudio.c
--- alsa-kernel/usb/usx2y/usbusx2yaudio.c	15 Sep 2004 10:18:02 -0000	1.3
+++ alsa-kernel/usb/usx2y/usbusx2yaudio.c	20 Sep 2004 11:13:29 -0000
@@ -656,7 +656,7 @@
 		if (us) {
 			us->submitted =	2*NOOF_SETRATE_URBS;
 			for (i = 0; i < NOOF_SETRATE_URBS; ++i) {
-				usb_unlink_urb(us->urb[i]);
+				usb_kill_urb(us->urb[i]);
 				usb_free_urb(us->urb[i]);
 			}
 			usX2Y->US04 = NULL;
@@ -671,7 +671,7 @@
 
 static int usX2Y_format_set(usX2Ydev_t *usX2Y, snd_pcm_format_t format)
 {
-	int alternate, unlink_err, err;
+	int alternate, err;
 	struct list_head* p;
 	if (format == SNDRV_PCM_FORMAT_S24_3LE) {
 		alternate = 2;
@@ -683,15 +683,13 @@
 	list_for_each(p, &usX2Y->chip.midi_list) {
 		snd_usbmidi_input_stop(p);
 	}
-	unlink_err = usb_unlink_urb(usX2Y->In04urb);
+	usb_kill_urb(usX2Y->In04urb);
 	if ((err = usb_set_interface(usX2Y->chip.dev, 0, alternate))) {
 		snd_printk("usb_set_interface error \n");
 		return err;
 	}
-	if (0 == unlink_err) {
-		usX2Y->In04urb->dev = usX2Y->chip.dev;
-		err = usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
-	}
+	usX2Y->In04urb->dev = usX2Y->chip.dev;
+	err = usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
 	list_for_each(p, &usX2Y->chip.midi_list) {
 		snd_usbmidi_input_start(p);
 	}
@@ -824,20 +822,20 @@
 			subs->prepared = 1;
 		}
 		while (subs->submitted_urbs)
-		for (u = 0; u < NRURBS; u++) {
-			snd_printdd("%i\n", subs->urb[u]->status);
-			while(subs->urb[u]->status  ||  NULL != subs->urb[u]->hcpriv) {
-				signed long timeout;
-				snd_printdd("ep=%i waiting for urb=%p status=%i hcpriv=%p\n",
-					   subs->endpoint, subs->urb[u],
-					   subs->urb[u]->status, subs->urb[u]->hcpriv);
-				set_current_state(TASK_INTERRUPTIBLE);
-				timeout = schedule_timeout(HZ/10);
-				if (signal_pending(current)) {
-					return -ERESTARTSYS;
+			for (u = 0; u < NRURBS; u++) {
+				snd_printdd("%i\n", subs->urb[u]->status);
+				while(subs->urb[u]->status  ||  NULL != subs->urb[u]->hcpriv) {
+					signed long timeout;
+					snd_printdd("ep=%i waiting for urb=%p status=%i hcpriv=%p\n",
+						    subs->endpoint, subs->urb[u],
+						    subs->urb[u]->status, subs->urb[u]->hcpriv);
+					set_current_state(TASK_INTERRUPTIBLE);
+					timeout = schedule_timeout(HZ/10);
+					if (signal_pending(current)) {
+						return -ERESTARTSYS;
+					}
 				}
 			}
-		}
 		subs->completed_urb = NULL;
 		subs->next_urb_complete = -1;
 		subs->stalled = 0;

--Boundary-00=_54rTB0JOU3NSOjb--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
