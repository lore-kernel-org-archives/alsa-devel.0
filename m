From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: tascam us-122 midi in does not work
Date: Fri, 18 Jun 2004 06:09:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406180609.02388.annabellesgarden@yahoo.de>
References: <200406131307.21072.ws@seh.de> <200406150110.31355.annabellesgarden@yahoo.de> <200406161920.53116.ws@seh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_drm0A5bQo93tVrJ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406161920.53116.ws@seh.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Werner Schweer <ws@seh.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_drm0A5bQo93tVrJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch 16 Juni 2004 19:20 schrieb Werner Schweer:
> On Tuesday 15 June 2004 01:10, Karsten Wiese wrote:
> > Am Sonntag 13 Juni 2004 13:07 schrieb Werner Schweer:
> > > Hello,
> > >
> > > Some strange effect occurs on my tascam us-122 audio/midi usb
> > > device:
> > >    After starting JACK the midi input does not work anymore. Not even
> > > the midi in led on the us-122 flashes. Midi output is always fine.
> > > After stopping JACK midi input still does not work. Midi input works
> > > again after disconnect/reconnect the usb cable.
> > > I'm using current ALSA cvs and kernel 2.6.7rc3.
<snip>
>
> and after loading jack the logfile has an "urb status" message of -108
> (ESHUTDOWN?) followed by a "usb_submit_urb: -32" (EPIPE) message.
> From the above code i assume snd_usbmidi_urb_error() returns 0 for
> status -108.
>
Attachached is a raw-fix@cvs-head .
Proofs here using aplay on 2.6.7 on fc1.
PLease try it.

Karsten

--Boundary-00=_drm0A5bQo93tVrJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="snd-usb-usx2y.patch.0.6.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.6.4"

? .directory
? alsa-driver/cscope.files
? alsa-driver/cscope.out
? alsa-driver/usb/.directory
? alsa-kernel/cscope.files
? alsa-kernel/cscope.out
? alsa-kernel/usb/cscope.out
Index: alsa-driver/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.12
diff -u -r1.12 usbmidi.c
--- alsa-driver/usb/usbmidi.c	23 Mar 2004 12:48:18 -0000	1.12
+++ alsa-driver/usb/usbmidi.c	18 Jun 2004 03:53:50 -0000
@@ -38,4 +38,5 @@
 #endif
 
 EXPORT_SYMBOL(snd_usb_create_midi_interface);
+EXPORT_SYMBOL(snd_usbmidi_in_urb_submit);
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.11
diff -u -r1.11 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	15 Jun 2004 10:55:40 -0000	1.11
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	18 Jun 2004 03:53:52 -0000
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
+			snd_usbmidi_in_urb_submit(p);
+		}
 		usX2Y_stream->usX2Y->format = format;
 		usX2Y_stream->usX2Y->rate = 0;
 	}
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.28
diff -u -r1.28 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	18 Mar 2004 14:50:54 -0000	1.28
+++ alsa-kernel/usb/usbmidi.c	18 Jun 2004 03:53:57 -0000
@@ -78,7 +78,6 @@
 	const snd_usb_audio_quirk_t *quirk;
 	snd_rawmidi_t* rmidi;
 	struct list_head list;
-
 	struct snd_usb_midi_endpoint {
 		snd_usb_midi_out_endpoint_t *out;
 		snd_usb_midi_in_endpoint_t *in;
@@ -90,7 +89,6 @@
 	struct urb* urb;
 	int max_transfer;		/* size of urb buffer */
 	struct tasklet_struct tasklet;
-
 	spinlock_t buffer_lock;
 
 	struct usbmidi_out_port {
@@ -113,6 +111,8 @@
 struct snd_usb_midi_in_endpoint {
 	snd_usb_midi_t* umidi;
 	struct urb* urb;
+//	struct tasklet_struct in_urb_complete_tq;
+	void (*in_urb_complete_tq)(struct urb* urb/* unsigned long ul */);
 	struct usbmidi_in_port {
 		snd_rawmidi_substream_t* substream;
 	} ports[0x10];
@@ -138,8 +138,25 @@
 /*
  * Error handling for URB completion functions.
  */
-static int snd_usbmidi_urb_error(int status)
+static void snd_usbmidi_in_urb_complete_tq(struct urb* urb/* unsigned long ul */)
 {
+//	struct urb* urb = (struct urb*)ul;
+	snd_printd("\n");
+	if (urb && usb_pipe_needs_resubmit(urb->pipe)) {
+		snd_usb_midi_in_endpoint_t* ep = snd_magic_cast(snd_usb_midi_in_endpoint_t, urb->context, return);
+		snd_printd("\n");
+		urb->dev = ep->umidi->chip->dev;
+		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+	}
+}
+static int snd_usbmidi_urb_error(snd_usb_midi_in_endpoint_t* ep, int status)
+{
+	if (status == -ESHUTDOWN)
+		if (ep) {
+			//tasklet_schedule(&ep->in_urb_complete_tq); /* we'll do this later */
+			ep->in_urb_complete_tq = snd_usbmidi_in_urb_complete_tq;
+			return status;
+		}
 	if (status == -ENOENT)
 		return status; /* killed */
 	if (status == -EILSEQ ||
@@ -185,7 +202,7 @@
 			if (buffer[i] != 0)
 				snd_usbmidi_input_packet(ep, &buffer[i]);
 	} else {
-		if (snd_usbmidi_urb_error(urb->status) < 0)
+		if (snd_usbmidi_urb_error(ep, urb->status) < 0)
 			return;
 	}
 
@@ -194,7 +211,6 @@
 		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
 	}
 }
-
 /*
  * Converts the data read from a Midiman device to standard USB MIDI packets.
  */
@@ -232,7 +248,7 @@
 	snd_usb_midi_out_endpoint_t* ep = snd_magic_cast(snd_usb_midi_out_endpoint_t, urb->context, return);
 
 	if (urb->status < 0) {
-		if (snd_usbmidi_urb_error(urb->status) < 0)
+		if (snd_usbmidi_urb_error((snd_usb_midi_in_endpoint_t*)NULL, urb->status) < 0)
 			return;
 	}
 	snd_usbmidi_do_output(ep);
@@ -698,6 +714,21 @@
 	snd_magic_kfree(umidi);
 }
 
+void snd_usbmidi_in_urb_submit(struct list_head* p)
+{
+	snd_usb_midi_t* umidi;
+	int i;
+
+	umidi = list_entry(p, snd_usb_midi_t, list);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
+		if (ep->in && ep->in->in_urb_complete_tq) {
+			(*ep->in->in_urb_complete_tq)(ep->in->urb);
+			ep->in->in_urb_complete_tq = NULL;
+		}
+	}
+}
+
 /*
  * Unlinks all URBs (must be done before the usb_device is deleted).
  */
@@ -1126,6 +1157,8 @@
 	snd_rawmidi_t* rmidi;
 	int err;
 
+//	tasklet_init(&umidi->in_urb_complete_tq, snd_usbmidi_in_urb_complete_tq (unsigned long)chip);
+
 	err = snd_rawmidi_new(umidi->chip->card, "USB MIDI",
 			      umidi->chip->next_midi_device++,
 			      out_ports, in_ports, &rmidi);
@@ -1219,8 +1252,10 @@
 	list_add(&umidi->list, &umidi->chip->midi_list);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		if (umidi->endpoints[i].in)
+		if (umidi->endpoints[i].in) {
+//			tasklet_init(&umidi->endpoints[i].in->in_urb_complete_tq, snd_usbmidi_in_urb_complete_tq, (unsigned long)umidi->endpoints[i].in->urb);
 			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
 					       GFP_KERNEL);
+		}
 	return 0;
 }

--Boundary-00=_drm0A5bQo93tVrJ--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
