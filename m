From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.6.4
Date: Mon, 21 Jun 2004 08:05:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406210805.03061.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Oqn1AJbBYeub1n3"
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


--Boundary-00=_Oqn1AJbBYeub1n3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi

This lets midi in work after usb-set-interface() on kernel 2.6.7 and doesn't 
disturb otherwise.
snd-usb-usx2x calls usb-set-interface() to set the sample format.
Please commit, if you agree with the changes to usbmidi.c, with comments:

	- resubmit midi in urb after usb-set-interface(), called by snd-usb-usx2x to
	  set the sample format. needed for usb compatibility with kernel 2.6.7.

I think, it is also a good time to move snd-usb-usx2y over to alsa-kernel now.

Best Regards
Karsten

--Boundary-00=_Oqn1AJbBYeub1n3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.6.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.6.4"

Index: alsa-driver/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.12
diff -u -r1.12 usbmidi.c
--- alsa-driver/usb/usbmidi.c	23 Mar 2004 12:48:18 -0000	1.12
+++ alsa-driver/usb/usbmidi.c	21 Jun 2004 05:58:16 -0000
@@ -38,4 +38,5 @@
 #endif
 
 EXPORT_SYMBOL(snd_usb_create_midi_interface);
+EXPORT_SYMBOL(snd_usbmidi_in_urb_retry);
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.11
diff -u -r1.11 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	15 Jun 2004 10:55:39 -0000	1.11
+++ alsa-driver/usb/usx2y/usbusx2y.c	21 Jun 2004 05:58:18 -0000
@@ -1,6 +1,13 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2004-06-19 Karsten Wiese
+	Version 0.6.4:
+	with kernelversion > 2.6.6 (maybe before also)
+	snd-usb-midi cannot resubmit the in_urb when we switch the usb interface.
+	work around that be calling snd_usbmidi_in_urb_retry()
+	after usb_set_interface().
+
 2004-06-12 Karsten Wiese
 	Version 0.6.3:
 	Made it thus the following rule is enforced:
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.11
diff -u -r1.11 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	15 Jun 2004 10:55:40 -0000	1.11
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	21 Jun 2004 05:58:20 -0000
@@ -993,6 +993,7 @@
 
 	if (usX2Y_stream->usX2Y->format != format) {
 		int alternate, unlink_err;
+		struct list_head* p;
 		if (format == SNDRV_PCM_FORMAT_S24_3LE) {
 			alternate = 2;
 			usX2Y_stream->usX2Y->stride = 6;
@@ -1009,6 +1010,9 @@
 			usX2Y_stream->usX2Y->In04urb->dev = usX2Y_stream->usX2Y->chip.dev;
 			err = usb_submit_urb(usX2Y_stream->usX2Y->In04urb, GFP_KERNEL);
 		}
+		list_for_each(p, &usX2Y_stream->usX2Y->chip.midi_list) {
+			snd_usbmidi_in_urb_retry(p);
+		}
 		usX2Y_stream->usX2Y->format = format;
 		usX2Y_stream->usX2Y->rate = 0;
 	}
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.31
diff -u -r1.31 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	14 Apr 2004 17:11:21 -0000	1.31
+++ alsa-kernel/usb/usbaudio.h	21 Jun 2004 05:58:27 -0000
@@ -206,6 +206,7 @@
 
 int snd_usb_create_midi_interface(snd_usb_audio_t *chip, struct usb_interface *iface, const snd_usb_audio_quirk_t *quirk);
 void snd_usbmidi_disconnect(struct list_head *p, struct usb_driver *driver);
+void snd_usbmidi_in_urb_retry(struct list_head* p);
 
 /*
  * retrieve usb_interface descriptor from the host interface
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.28
diff -u -r1.28 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	18 Mar 2004 14:50:54 -0000	1.28
+++ alsa-kernel/usb/usbmidi.c	21 Jun 2004 05:58:29 -0000
@@ -113,6 +113,7 @@
 struct snd_usb_midi_in_endpoint {
 	snd_usb_midi_t* umidi;
 	struct urb* urb;
+	struct urb* urb_retry;
 	struct usbmidi_in_port {
 		snd_rawmidi_substream_t* substream;
 	} ports[0x10];
@@ -138,8 +139,13 @@
 /*
  * Error handling for URB completion functions.
  */
-static int snd_usbmidi_urb_error(int status)
+static int snd_usbmidi_urb_error(snd_usb_midi_in_endpoint_t* ep, int status)
 {
+	if (status == -ESHUTDOWN)
+		if (ep) {
+			ep->urb_retry = ep->urb;
+			return status;
+		}
 	if (status == -ENOENT)
 		return status; /* killed */
 	if (status == -EILSEQ ||
@@ -185,7 +191,7 @@
 			if (buffer[i] != 0)
 				snd_usbmidi_input_packet(ep, &buffer[i]);
 	} else {
-		if (snd_usbmidi_urb_error(urb->status) < 0)
+		if (snd_usbmidi_urb_error(ep, urb->status) < 0)
 			return;
 	}
 
@@ -232,7 +238,7 @@
 	snd_usb_midi_out_endpoint_t* ep = snd_magic_cast(snd_usb_midi_out_endpoint_t, urb->context, return);
 
 	if (urb->status < 0) {
-		if (snd_usbmidi_urb_error(urb->status) < 0)
+		if (snd_usbmidi_urb_error((snd_usb_midi_in_endpoint_t*)NULL, urb->status) < 0)
 			return;
 	}
 	snd_usbmidi_do_output(ep);
@@ -698,6 +704,31 @@
 	snd_magic_kfree(umidi);
 }
 
+static void snd_usbmidi_in_urb_retry_do(snd_usb_midi_in_endpoint_t* ep)
+{
+	if (ep) {
+		struct urb* urb = ep->urb; 
+		snd_printd("\n");
+		if (urb && urb == ep->urb_retry && usb_pipe_needs_resubmit(urb->pipe)) {
+			snd_printd("\n");
+			urb->dev = ep->umidi->chip->dev;
+			snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+		}
+	}
+}
+
+void snd_usbmidi_in_urb_retry(struct list_head* p)
+{
+	snd_usb_midi_t* umidi;
+	int i;
+
+	umidi = list_entry(p, snd_usb_midi_t, list);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
+		snd_usbmidi_in_urb_retry_do(ep->in);
+	}
+}
+
 /*
  * Unlinks all URBs (must be done before the usb_device is deleted).
  */

--Boundary-00=_Oqn1AJbBYeub1n3--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
