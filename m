From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.6.4
Date: Mon, 21 Jun 2004 11:56:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406211156.15096.annabellesgarden@yahoo.de>
References: <Pine.HPX.4.33n.0406210939370.7655-100000@studcom.urz.uni-halle.de> <200406211030.30993.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/Cr1AzAND8YMpxT"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406211030.30993.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_/Cr1AzAND8YMpxT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag 21 Juni 2004 10:30 schrieb Karsten Wiese:
> Am Montag 21 Juni 2004 10:02 schrieb Clemens Ladisch:
> > Karsten Wiese wrote:
> > > snd-usb-usx2x calls usb-set-interface() to set the sample format.
> >
> > ... and the USx2y devices use the same interface for MIDI, it seems.
>
> Yes.
> It is impossible to use different interfaces on one usb_device at the same
> time. Or not?
>
> > > This lets midi in work after usb-set-interface() on kernel 2.6.7 and
> > > doesn't disturb otherwise.
> > >
> > > +  if (urb && urb == ep->urb_retry
> >
> > It's not obvious why urb_retry is needed.  Isn't it always the same
> > as ep->urb?
>
> ep->urb_retry is normally NULL and only set to ep->urb, if ep->urb comes
> back with -ESHUTDOWN.
> Thus ep->urb_retry serves as a flag to show that resubmission is needed.
>
> > > +      && usb_pipe_needs_resubmit(urb->pipe))
> >
> > Won't this prevent it from working with interrupt pipes on 2.4?
> >
> > > +  snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
> >
> > I think we can use GFP_KERNEL here.
> >
> >
> > I don't like this solution too much, it's just a device-specific
> > kludge.  A more general solution would be to have two functions
> > snd_usbmidi_stop/start_input() and calling them before/after changing
> > the sample format.  (The start function could be used at the end of
> > snd_usb_create_midi_interface(), too.)
>
> Agreed.
>
> > And what should happen to data that is being output when the sample
> > format is changed?
>
> There was no out midi urb missed so far. It looks as if there is no special
> handling needed.
>

This Patch implements snd_usbmidi_in_stop() and snd_usbmidi_in_start().
Comment for commit would be:
	- new functions snd_usbmidi_in_stop() and snd_usbmidi_in_start().
	  Needed by snd-usb-usx2y to usb-set-interface() in between.

Thanks & Regards,
Karsten


--Boundary-00=_/Cr1AzAND8YMpxT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="snd-usb-usx2y.patch.0.6.4.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.6.4.1"

Index: alsa-driver/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.12
diff -u -r1.12 usbmidi.c
--- alsa-driver/usb/usbmidi.c	23 Mar 2004 12:48:18 -0000	1.12
+++ alsa-driver/usb/usbmidi.c	21 Jun 2004 09:36:58 -0000
@@ -38,4 +38,6 @@
 #endif
 
 EXPORT_SYMBOL(snd_usb_create_midi_interface);
+EXPORT_SYMBOL(snd_usbmidi_in_start);
+EXPORT_SYMBOL(snd_usbmidi_in_stop);
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.11
diff -u -r1.11 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	15 Jun 2004 10:55:39 -0000	1.11
+++ alsa-driver/usb/usx2y/usbusx2y.c	21 Jun 2004 09:36:59 -0000
@@ -1,6 +1,11 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2004-06-21 Karsten Wiese
+	Version 0.6.4:
+	Temporarely suspend midi in
+	to sanely call usb_set_interface() when setting format.
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
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	21 Jun 2004 09:37:01 -0000
@@ -993,6 +993,7 @@
 
 	if (usX2Y_stream->usX2Y->format != format) {
 		int alternate, unlink_err;
+		struct list_head* p;
 		if (format == SNDRV_PCM_FORMAT_S24_3LE) {
 			alternate = 2;
 			usX2Y_stream->usX2Y->stride = 6;
@@ -1000,6 +1001,9 @@
 			alternate = 1;
 			usX2Y_stream->usX2Y->stride = 4;
 		}
+		list_for_each(p, &usX2Y_stream->usX2Y->chip.midi_list) {
+			snd_usbmidi_in_stop(p);
+		}
 		unlink_err = usb_unlink_urb(usX2Y_stream->usX2Y->In04urb);
 		if ((err = usb_set_interface(usX2Y_stream->usX2Y->chip.dev, 0, alternate))) {
 			snd_printk("usb_set_interface error \n");
@@ -1009,6 +1013,9 @@
 			usX2Y_stream->usX2Y->In04urb->dev = usX2Y_stream->usX2Y->chip.dev;
 			err = usb_submit_urb(usX2Y_stream->usX2Y->In04urb, GFP_KERNEL);
 		}
+		list_for_each(p, &usX2Y_stream->usX2Y->chip.midi_list) {
+			snd_usbmidi_in_start(p);
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
+++ alsa-kernel/usb/usbaudio.h	21 Jun 2004 09:37:04 -0000
@@ -206,6 +206,8 @@
 
 int snd_usb_create_midi_interface(snd_usb_audio_t *chip, struct usb_interface *iface, const snd_usb_audio_quirk_t *quirk);
 void snd_usbmidi_disconnect(struct list_head *p, struct usb_driver *driver);
+void snd_usbmidi_in_start(struct list_head* p);
+void snd_usbmidi_in_stop(struct list_head* p);
 
 /*
  * retrieve usb_interface descriptor from the host interface
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.28
diff -u -r1.28 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	18 Mar 2004 14:50:54 -0000	1.28
+++ alsa-kernel/usb/usbmidi.c	21 Jun 2004 09:37:06 -0000
@@ -1144,6 +1144,43 @@
 	return 0;
 }
 
+static void snd_usbmidi_in_start_do(snd_usb_midi_in_endpoint_t* ep)
+{
+	if (ep) {
+		struct urb* urb = ep->urb; 
+		urb->dev = ep->umidi->chip->dev;
+		snd_usbmidi_submit_urb(urb, GFP_KERNEL);
+	}
+}
+
+void snd_usbmidi_in_start(struct list_head* p)
+{
+	snd_usb_midi_t* umidi;
+	int i;
+
+	umidi = list_entry(p, snd_usb_midi_t, list);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
+		snd_usbmidi_in_start_do(ep->in);
+	}
+}
+
+/*
+ * Temporarely stop input. 
+ */
+void snd_usbmidi_in_stop(struct list_head* p)
+{
+	snd_usb_midi_t* umidi;
+	int i;
+
+	umidi = list_entry(p, snd_usb_midi_t, list);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
+		if(ep->in)
+			usb_unlink_urb(ep->in->urb);
+	}
+}
+
 /*
  * Creates and registers everything needed for a MIDI streaming interface.
  */
@@ -1219,8 +1256,6 @@
 	list_add(&umidi->list, &umidi->chip->midi_list);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		if (umidi->endpoints[i].in)
-			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
-					       GFP_KERNEL);
+		snd_usbmidi_in_start_do(umidi->endpoints[i].in);
 	return 0;
 }

--Boundary-00=_/Cr1AzAND8YMpxT--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
