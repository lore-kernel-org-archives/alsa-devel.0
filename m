From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Wed, 03 Jul 2002 14:52:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D22F37D.14EE3DAB@ladisch.de>
References: <3D208C5C.36649172@ladisch.de> <s5hhejibem0.wl@alsa2.suse.de>
 <s5hznxarxmz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> - newly added virmidi registrations.
>   that means, snd-usb-midi will have its own rawmidi devices
>   automatically as /dev/snd/midiCxDx.
>   this will be good for applications which speak only with
>   rawmidi.
> 
> the latter one was not tested.
> can anyone update the cvs if it works?

Using the cable number as index for the rawmidi device will not work
if there is more than one endpoint (I don't think such a device exists;
my driver supports more than one endpoint only because the OSS and
NetBSD drivers do).

I changed it to use the sequencer port number instead.

There are devices with more output than input ports (e.g. MU1000),
and virmidi with SNDRV_VIRMIDI_SEQ_ATTACH doesn't support input anyway,
so I moved the rmidi pointer from usbmidi_in_port to usbmidi_out_port.
(The virmidi device applies to both input and output ports, so,
theoretically, it should go into a usbmidi_endpoint structure. That
one hasn't been needed until now.)


Index: usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.1
diff -u -r1.1 usbmidi.c
--- usbmidi.c	2 Jul 2002 14:43:37 -0000	1.1
+++ usbmidi.c	3 Jul 2002 12:19:42 -0000
@@ -202,6 +202,7 @@
 	int nports;
 	struct usbmidi_out_port {
 		usbmidi_out_endpoint_t* ep;
+		snd_rawmidi_t *rmidi;
 		uint8_t cable;		/* cable number << 4 */
 		uint8_t sysex_len;
 		uint8_t sysex[2];
@@ -213,7 +214,6 @@
 	urb_t* urb;
 	struct usbmidi_in_port {
 		int seq_port;
-		snd_rawmidi_t *rmidi;
 		snd_midi_event_t* midi_event;
 	} ports[0x10];
 };
@@ -573,12 +573,9 @@
 		}
 		usb_free_urb(ep->urb);
 	}
-	for (i = 0; i < 0x10; ++i) {
+	for (i = 0; i < 0x10; ++i)
 		if (ep->ports[i].midi_event)
 			snd_midi_event_free(ep->ports[i].midi_event);
-		if (ep->ports[i].rmidi)
-			snd_device_free(ep->umidi->card, ep->ports[i].rmidi);
-	}
 	snd_magic_kfree(ep);
 }
 
@@ -695,6 +692,11 @@
  */
 static void snd_usbmidi_out_endpoint_delete(usbmidi_out_endpoint_t* ep)
 {
+	int i;
+
+	for (i = 0; i < ep->nports; ++i)
+		if (ep->ports[i].rmidi)
+			snd_device_free(ep->umidi->card, ep->ports[i].rmidi);
 	if (ep->tasklet.func)
 		tasklet_kill(&ep->tasklet);
 	if (ep->urb) {
@@ -789,13 +791,14 @@
 
 /*
  * After input and output endpoints have been initialized, create
- * the ALSA port for each input/output port pair.
+ * the ALSA port for each input/output port pair in the endpoint.
+ * *port_idx is the port number, which must be unique over all endpoints.
  */
 static int snd_usbmidi_create_endpoint_ports(usbmidi_t* umidi, int ep,
 					     int* port_idx)
 {
 	usbmidi_endpoint_info_t* ep_info = &umidi->device_info.endpoints[ep];
-	int c, out_port;
+	int c, out_port, err;
 	int cap, type, port;
 	int out, in;
 	snd_seq_port_callback_t port_callback;
@@ -813,7 +816,6 @@
 		if (out) {
 			port_callback.event_input = snd_usbmidi_port_input;
 			port_callback.private_data = &umidi->out_endpoints[ep]->ports[out_port];
-			++out_port;
 			cap |= SNDRV_SEQ_PORT_CAP_WRITE |
 				SNDRV_SEQ_PORT_CAP_SUBS_WRITE;	
 		}
@@ -828,7 +830,7 @@
 		type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC;
 		/* TODO: read port name from jack descriptor */
 		sprintf(port_name, "%s Port %d",
-			umidi->device_info.product, (*port_idx)++);
+			umidi->device_info.product, *port_idx);
 		port = snd_seq_event_port_attach(umidi->seq_client,
 						 &port_callback,
 						 cap, type, port_name);
@@ -837,23 +839,27 @@
 		if (in)
 			umidi->in_endpoints[ep]->ports[c].seq_port = port;
 
-		if (c < SNDRV_MINOR_RAWMIDIS) {
+		if (out && *port_idx < SNDRV_MINOR_RAWMIDIS) {
 			snd_rawmidi_t *rmidi;
 			snd_virmidi_dev_t *rdev;
-			if (snd_virmidi_new(umidi->card, c, &rmidi) < 0)
-				continue;
-			umidi->in_endpoints[ep]->ports[c].rmidi = rmidi;
-			rdev = snd_magic_cast(snd_virmidi_dev_t, rmidi->private_data, continue);
+			err = snd_virmidi_new(umidi->card, *port_idx, &rmidi);
+			if (err < 0)
+				return err;
+			rdev = snd_magic_cast(snd_virmidi_dev_t, rmidi->private_data, return -ENXIO);
 			strcpy(rmidi->name, port_name);
 			rdev->seq_mode = SNDRV_VIRMIDI_SEQ_ATTACH;
 			rdev->client = umidi->seq_client;
 			rdev->port = port;
-			if (snd_device_register(umidi->card, rmidi) < 0) {
+			err = snd_device_register(umidi->card, rmidi);
+			if (err < 0) {
 				snd_device_free(umidi->card, rmidi);
-				continue;
+				return err;
 			}
-			umidi->in_endpoints[ep]->ports[c].rmidi = rmidi;
+			umidi->out_endpoints[ep]->ports[out_port].rmidi = rmidi;
 		}
+		if (out)
+			++out_port;
+		++*port_idx;
 	}
 	return 0;
 }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
