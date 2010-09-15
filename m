From: Krzysztof Foltman <wdev@foltman.com>
Subject: proposed MPD16 latency workaround
Date: Thu, 16 Sep 2010 00:21:24 +0100
Message-ID: <4C9154F4.8040304@foltman.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050908080201000708020704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy1-pub.bluehost.com (cpoproxy1-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id CB8C82452A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 01:21:29 +0200 (CEST)
Received: from [188.141.103.78] (helo=[192.168.1.12])
	by box517.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <wdev@foltman.com>) id 1Ow1I6-00026F-S5
	for alsa-devel@alsa-project.org; Wed, 15 Sep 2010 17:21:27 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050908080201000708020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hi all,

I've played with USB MIDI driver and MPD16 a bit more. The problem is 
definitely triggered by submitting URBs on the configuration input 
endpoint - when these are killed, the latency disappears. Disabling the 
configuration port works, but is a bit heavy-handed, so I've implemented 
a workaround: initially, the URBs for the input configuration endpoint 
are not submitted until two conditions are met:

i) the control port is actually open (I check that using input_triggered 
bitmask)

ii) the driver is switched into config mode by sending a special SysEx 
message to the output port (which is intercepted by the driver and used 
to set a flag). This is to prevent programs that open all the MIDI ports 
in the system (JACK daemon with ALSA MIDI driver, a2jmidid etc.) from 
starting unwanted communication with configuration endpoints.

Any time one of these conditions is changed, the driver may either 
submit the URBs or kill them or do nothing - depending on the difference 
between expected and current "queuing state" of the URBs. This logic is 
only used for MPD16, for all the other devices the driver always submit 
their input URBs, no matter if any input is actually wanted or not.

The attached diff is relative to the Ubuntu 2.6.35 kernel, but I'm 
mostly interested in the review of the general approach - I have some 
doubts about thread-safety of calling snd_usbmidi_input_update_ep from 
send function and about the elegance of the SysEx approach (vs. ioctl or 
something else). If the approach is not too icky and doesn't have hidden 
flaws, I can try to create a diff relative to alsa-kernel or some other 
tree.

Any comments?
Krzysztof


--------------050908080201000708020704
Content-Type: text/x-diff;
 name="mpd16-control-port.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpd16-control-port.diff"

--- linux-source-2.6.35/sound/usb/midi.c	2010-08-01 23:11:14.000000000 +0100
+++ /home/kfoltman/midi.c	2010-09-16 00:03:12.000000000 +0100
@@ -70,6 +70,9 @@
 #define OUTPUT_URBS 7
 #define INPUT_URBS 7
 
+#define EP_UPDATE_MODE_OFF 0
+#define EP_UPDATE_MODE_AUTO 1
+#define EP_UPDATE_MODE_ON 2
 
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("USB Audio/MIDI helper module");
@@ -102,6 +105,7 @@
 	void (*output_packet)(struct urb*, uint8_t, uint8_t, uint8_t, uint8_t);
 	void (*init_out_endpoint)(struct snd_usb_midi_out_endpoint*);
 	void (*finish_out_endpoint)(struct snd_usb_midi_out_endpoint*);
+	int (*input_wanted)(struct snd_usb_midi_in_endpoint *);
 };
 
 struct snd_usb_midi {
@@ -125,6 +129,7 @@
 	unsigned long input_triggered;
 	unsigned int opened;
 	unsigned char disconnected;
+	unsigned char akai_config_mode;
 
 	struct snd_kcontrol *roland_load_ctl;
 };
@@ -171,11 +176,16 @@
 	} ports[0x10];
 	u8 seen_f5;
 	u8 error_resubmit;
+	u8 enabled;
+	u8 running;
 	int current_port;
 };
 
 static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint* ep);
 
+static void snd_usbmidi_input_update_ep(struct snd_usb_midi_in_endpoint* ep,
+					int mode);
+
 static const uint8_t snd_usbmidi_cin_length[] = {
 	0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1
 };
@@ -266,8 +276,10 @@
 		}
 	}
 
-	urb->dev = ep->umidi->dev;
-	snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+	if (ep->enabled) {
+		urb->dev = ep->umidi->dev;
+		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+	}
 }
 
 static void snd_usbmidi_out_urb_complete(struct urb* urb)
@@ -658,7 +670,30 @@
  * MIDI message (msg_len bytes long)
  *
  * Messages sent: Active Sense, Note On, Poly Pressure, Control Change.
+ *
+ * The control port should not be polled unless configuration operation is
+ * performed, as polling it tends to interfere with proper transfer on the
+ * data port (reducing polling rate to impractical values)
  */
+static int snd_usbmidi_akai_input_wanted(struct snd_usb_midi_in_endpoint* ep)
+{
+	/* only one port for an endpoint */
+	struct usbmidi_in_port* port = &ep->ports[0];
+
+	if (!port->substream) {
+		snd_printd("unexpected port %d!\n", portidx);
+		return 0;
+	}
+	if (port->substream->number > 0)
+		return 1;
+	/* do not poll the config endpoint until:
+	  1) config mode is switched on (via fake SysEx)
+	  2) the port is open
+	 */
+	return ep->umidi->akai_config_mode && 
+		test_bit(port->substream->number, &ep->umidi->input_triggered);
+}
+
 static void snd_usbmidi_akai_input(struct snd_usb_midi_in_endpoint *ep,
 				   uint8_t *buffer, int buffer_length)
 {
@@ -719,6 +754,14 @@
 		}
 		/* SysEx complete */
 		if (end < count && tmp[end] == 0xF7) {
+			/* Fake SysEx to enable/disable polling of the control port */
+			if (count == 9 &&
+			    !memcmp(tmp, "\xF0\x47\x62\x60\x10\x7F", 6)) {
+				ep->umidi->akai_config_mode = tmp[6];
+				snd_usbmidi_input_update_ep(ep->umidi->endpoints[0].in, EP_UPDATE_MODE_AUTO);
+				snd_rawmidi_transmit_ack(substream, end + 1);
+				continue;
+			}
 			/* queue it, ack it, and get the next one */
 			count = end + 1;
 			msg[0] = 0x10 | count;
@@ -741,6 +784,7 @@
 static struct usb_protocol_ops snd_usbmidi_akai_ops = {
 	.input = snd_usbmidi_akai_input,
 	.output = snd_usbmidi_akai_output,
+	.input_wanted = snd_usbmidi_akai_input_wanted
 };
 
 /*
@@ -1124,11 +1168,21 @@
 static void snd_usbmidi_input_trigger(struct snd_rawmidi_substream *substream, int up)
 {
 	struct snd_usb_midi* umidi = substream->rmidi->private_data;
-
+	int i;
+	unsigned long old_value = umidi->input_triggered;
+	
 	if (up)
 		set_bit(substream->number, &umidi->input_triggered);
 	else
 		clear_bit(substream->number, &umidi->input_triggered);
+
+	if (old_value != umidi->input_triggered) {
+		for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+			struct snd_usb_midi_in_endpoint* ep = umidi->endpoints[i].in;
+			if (ep)
+				snd_usbmidi_input_update_ep(ep, EP_UPDATE_MODE_AUTO);
+		}
+	}
 }
 
 static struct snd_rawmidi_ops snd_usbmidi_output_ops = {
@@ -2013,33 +2067,56 @@
 	return 0;
 }
 
+static void snd_usbmidi_input_update_ep(struct snd_usb_midi_in_endpoint* ep,
+					int mode)
+{
+	unsigned int i;
+	int (*input_wanted)(struct snd_usb_midi_in_endpoint *);
+	
+	if (!ep)
+		return;
+
+	input_wanted = ep->umidi->usb_protocol_ops->input_wanted;
+	if (mode == EP_UPDATE_MODE_AUTO && input_wanted)
+		ep->enabled = input_wanted(ep);
+	else
+		ep->enabled = (mode != EP_UPDATE_MODE_OFF);
+
+	snd_printk(KERN_ERR "Before EP %p Card %s Enabled %d running %d\n", ep, ep->umidi->card->shortname, (int)ep->enabled, (int)ep->running);
+	
+	/* if just switched off, kill the URBs */
+	if (ep->running && !ep->enabled) {
+		snd_printk(KERN_ERR "Killing URBs\n");
+		for (i = 0; i < INPUT_URBS; ++i)
+			usb_kill_urb(ep->urbs[i]);
+		ep->running = 0;
+	}
+	/* if just switched on, submit the URBs */
+	if (!ep->running && ep->enabled) {
+		snd_printk(KERN_ERR "Submitting URBs\n");
+		for (i = 0; i < INPUT_URBS; ++i) {
+			struct urb* urb = ep->urbs[i];
+			urb->dev = ep->umidi->dev;
+			snd_usbmidi_submit_urb(urb, GFP_KERNEL);
+		}
+		ep->running = 1;
+	}
+	snd_printk(KERN_ERR "After EP %p Card %s Enabled %d running %d\n", ep, ep->umidi->card->shortname, (int)ep->enabled, (int)ep->running);
+}
+
 /*
  * Temporarily stop input.
  */
 void snd_usbmidi_input_stop(struct list_head* p)
 {
 	struct snd_usb_midi* umidi;
-	unsigned int i, j;
+	unsigned int i;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
-		struct snd_usb_midi_endpoint* ep = &umidi->endpoints[i];
-		if (ep->in)
-			for (j = 0; j < INPUT_URBS; ++j)
-				usb_kill_urb(ep->in->urbs[j]);
-	}
-}
-
-static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
-{
-	unsigned int i;
-
-	if (!ep)
-		return;
-	for (i = 0; i < INPUT_URBS; ++i) {
-		struct urb* urb = ep->urbs[i];
-		urb->dev = ep->umidi->dev;
-		snd_usbmidi_submit_urb(urb, GFP_KERNEL);
+		struct snd_usb_midi_in_endpoint* ep = umidi->endpoints[i].in;
+		if (ep)
+			snd_usbmidi_input_update_ep(ep, EP_UPDATE_MODE_OFF);
 	}
 }
 
@@ -2052,8 +2129,11 @@
 	int i;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
-	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		struct snd_usb_midi_in_endpoint* ep = umidi->endpoints[i].in;
+		if (ep)
+			snd_usbmidi_input_update_ep(ep, EP_UPDATE_MODE_AUTO);
+	}
 }
 
 /*
@@ -2181,7 +2261,8 @@
 	list_add_tail(&umidi->list, midi_list);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+		snd_usbmidi_input_update_ep(umidi->endpoints[i].in,
+					    EP_UPDATE_MODE_AUTO);
 	return 0;
 }
 

--------------050908080201000708020704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050908080201000708020704--
