From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Fri, 05 Jul 2002 09:55:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2550EF.7A013E11@ladisch.de>
References: <Pine.HPX.4.33n.0207041308380.15122-100000@studcom.urz.uni-halle.de>
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

I wrote:
> I think I'll be able to submit a patch for storing rmidi independently of
> the input/output structures tomorrow.

And here it is.

- moved rmidi to new structure usbmidi_endpoint
- moved call to snd_virmidi_receive to snd_usbmidi_input_packet
- renamed snd_usbmidi_port_input to snd_usbmidi_event_input
- removed dynamic allocation of usbmidi_out_port structures


Index: usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.3
diff -u -r1.3 usbmidi.c
--- usbmidi.c	4 Jul 2002 09:46:36 -0000	1.3
+++ usbmidi.c	5 Jul 2002 07:42:21 -0000
@@ -155,6 +155,7 @@
 typedef struct usbmidi usbmidi_t;
 typedef struct usbmidi_device_info usbmidi_device_info_t;
 typedef struct usbmidi_endpoint_info usbmidi_endpoint_info_t;
+typedef struct usbmidi_endpoint usbmidi_endpoint_t;
 typedef struct usbmidi_out_endpoint usbmidi_out_endpoint_t;
 typedef struct usbmidi_out_port usbmidi_out_port_t;
 typedef struct usbmidi_in_endpoint usbmidi_in_endpoint_t;
@@ -183,9 +184,11 @@
 	int dev;
 	int seq_client;
 	usbmidi_device_info_t device_info;
-
-	usbmidi_out_endpoint_t* out_endpoints[MAX_ENDPOINTS];
-	usbmidi_in_endpoint_t* in_endpoints[MAX_ENDPOINTS];
+	struct usbmidi_endpoint {
+		usbmidi_out_endpoint_t* out;
+		usbmidi_in_endpoint_t* in;
+		snd_rawmidi_t* rmidi[0x10];
+	} endpoints[MAX_ENDPOINTS];
 };
 
 struct usbmidi_out_endpoint {
@@ -199,18 +202,17 @@
 	int data_size;
 	spinlock_t buffer_lock;
 
-	int nports;
 	struct usbmidi_out_port {
 		usbmidi_out_endpoint_t* ep;
-		snd_rawmidi_t *rmidi;
 		uint8_t cable;		/* cable number << 4 */
 		uint8_t sysex_len;
 		uint8_t sysex[2];
-	} ports[0];
+	} ports[0x10];
 };
 
 struct usbmidi_in_endpoint {
 	usbmidi_t* umidi;
+	usbmidi_endpoint_t* ep;
 	urb_t* urb;
 	struct usbmidi_in_port {
 		int seq_port;
@@ -258,7 +260,8 @@
 	static const uint8_t cin_length[] = {
 		0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1
 	};
-	usbmidi_in_port_t* port = &ep->ports[packet[0] >> 4];
+	int cable = packet[0] >> 4;
+	usbmidi_in_port_t* port = &ep->ports[cable];
 	snd_seq_event_t ev;
 
 	if (!port->midi_event)
@@ -271,6 +274,8 @@
 		ev.dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
 		snd_seq_kernel_client_dispatch(ep->umidi->seq_client,
 					       &ev, 1, 0);
+		if (ep->ep->rmidi[cable])
+			snd_virmidi_receive(ep->ep->rmidi[cable], &ev);
 	}
 }
 
@@ -454,8 +459,8 @@
 /*
  * Converts an ALSA sequencer event into USB MIDI packets.
  */
-static int snd_usbmidi_port_input(snd_seq_event_t* ev, int direct,
-				  void* private_data, int atomic, int hop)
+static int snd_usbmidi_event_input(snd_seq_event_t* ev, int direct,
+				   void* private_data, int atomic, int hop)
 {
 	usbmidi_out_port_t* port = (usbmidi_out_port_t*)private_data;
 	int err;
@@ -554,7 +559,6 @@
 	default:
 		return 0;
 	}
-	snd_virmidi_receive(port->rmidi, ev);
 	tasklet_hi_schedule(&port->ep->tasklet);
 	return 0;
 }
@@ -617,7 +621,7 @@
  */
 static int snd_usbmidi_in_endpoint_create(usbmidi_t* umidi,
 					  usbmidi_endpoint_info_t* ep_info,
-					  usbmidi_in_endpoint_t** rep)
+					  usbmidi_endpoint_t* rep)
 {
 	usbmidi_in_endpoint_t* ep;
 	int do_int_transfer;
@@ -626,11 +630,12 @@
 	unsigned int pipe;
 	int length, i, err;
 
-	*rep = NULL;
+	rep->in = NULL;
 	ep = snd_magic_kcalloc(usbmidi_in_endpoint_t, 0, GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
+	ep->ep = rep;
 	for (i = 0; i < 0x10; ++i)
 		ep->ports[i].seq_port = -1;
 
@@ -674,7 +679,7 @@
 			}
 		}
 
-	*rep = ep;
+	rep->in = ep;
 	return 0;
 }
 
@@ -693,11 +698,6 @@
  */
 static void snd_usbmidi_out_endpoint_delete(usbmidi_out_endpoint_t* ep)
 {
-	int i;
-
-	for (i = 0; i < ep->nports; ++i)
-		if (ep->ports[i].rmidi)
-			snd_device_free(ep->umidi->card, ep->ports[i].rmidi);
 	if (ep->tasklet.func)
 		tasklet_kill(&ep->tasklet);
 	if (ep->urb) {
@@ -716,17 +716,15 @@
  */
 static int snd_usbmidi_out_endpoint_create(usbmidi_t* umidi,
 					   usbmidi_endpoint_info_t* ep_info,
-			 		   usbmidi_out_endpoint_t** rep)
+			 		   usbmidi_endpoint_t* rep)
 {
 	usbmidi_out_endpoint_t* ep;
-	int nports, i;
+	int i;
 	unsigned int pipe;
 	void* buffer;
 
-	*rep = NULL;
-	nports = snd_usbmidi_count_bits(ep_info->out_cables);
-	ep = snd_magic_kcalloc(usbmidi_out_endpoint_t,
-			       nports * sizeof(usbmidi_out_port_t), GFP_KERNEL);
+	rep->out = NULL;
+	ep = snd_magic_kcalloc(usbmidi_out_endpoint_t, 0, GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -749,16 +747,13 @@
 	spin_lock_init(&ep->buffer_lock);
 	tasklet_init(&ep->tasklet, snd_usbmidi_out_tasklet, (unsigned long)ep);
 
-	ep->nports = nports;
-	nports = 0;
 	for (i = 0; i < 0x10; ++i)
 		if (ep_info->out_cables & (1 << i)) {
-			ep->ports[nports].ep = ep;
-			ep->ports[nports].cable = i << 4;
-			++nports;
+			ep->ports[i].ep = ep;
+			ep->ports[i].cable = i << 4;
 		}
 
-	*rep = ep;
+	rep->out = ep;
 	return 0;
 }
 
@@ -768,7 +763,7 @@
 static int snd_usbmidi_seq_device_delete(snd_seq_device_t* seq_device)
 {
 	usbmidi_t* umidi;
-	int i;
+	int i, j;
 
 	umidi = (usbmidi_t*)SNDRV_SEQ_DEVICE_ARGPTR(seq_device);
 
@@ -776,16 +771,21 @@
 		snd_seq_delete_kernel_client(umidi->seq_client);
 		umidi->seq_client = -1;
 	}
-
 	for (i = 0; i < MAX_ENDPOINTS; ++i) {
-		if (umidi->out_endpoints[i]) {
-			snd_usbmidi_out_endpoint_delete(umidi->out_endpoints[i]);
-			umidi->out_endpoints[i] = NULL;
-		}
-		if (umidi->in_endpoints[i]) {
-			snd_usbmidi_in_endpoint_delete(umidi->in_endpoints[i]);
-			umidi->in_endpoints[i] = NULL;
-		}
+		usbmidi_endpoint_t* ep = &umidi->endpoints[i];
+		if (ep->out) {
+			snd_usbmidi_out_endpoint_delete(ep->out);
+			ep->out = NULL;
+		}
+		if (ep->in) {
+			snd_usbmidi_in_endpoint_delete(ep->in);
+			ep->in = NULL;
+		}
+		for (j = 0; j < 0x10; ++j)
+			if (ep->rmidi[j]) {
+				snd_device_free(umidi->card, ep->rmidi[j]);
+				ep->rmidi[j] = NULL;
+			}
 	}
 	return 0;
 }
@@ -799,13 +799,12 @@
 					     int* port_idx)
 {
 	usbmidi_endpoint_info_t* ep_info = &umidi->device_info.endpoints[ep];
-	int c, out_port, err;
+	int c, err;
 	int cap, type, port;
 	int out, in;
 	snd_seq_port_callback_t port_callback;
 	char port_name[40];
 
-	out_port = 0;
 	for (c = 0; c < 0x10; ++c) {
 		out = ep_info->out_cables & (1 << c);
 		in = ep_info->in_cables & (1 << c);
@@ -815,8 +814,8 @@
 		memset(&port_callback, 0, sizeof(port_callback));
 		port_callback.owner = THIS_MODULE;
 		if (out) {
-			port_callback.event_input = snd_usbmidi_port_input;
-			port_callback.private_data = &umidi->out_endpoints[ep]->ports[out_port];
+			port_callback.event_input = snd_usbmidi_event_input;
+			port_callback.private_data = &umidi->endpoints[ep].out->ports[c];
 			cap |= SNDRV_SEQ_PORT_CAP_WRITE |
 				SNDRV_SEQ_PORT_CAP_SUBS_WRITE;	
 		}
@@ -838,9 +837,9 @@
 		if (port < 0)
 			return port;
 		if (in)
-			umidi->in_endpoints[ep]->ports[c].seq_port = port;
+			umidi->endpoints[ep].in->ports[c].seq_port = port;
 
-		if (out && *port_idx < SNDRV_MINOR_RAWMIDIS) {
+		if (*port_idx < SNDRV_MINOR_RAWMIDIS) {
 			snd_rawmidi_t *rmidi;
 			snd_virmidi_dev_t *rdev;
 			err = snd_virmidi_new(umidi->card, *port_idx, &rmidi);
@@ -856,10 +855,8 @@
 				snd_device_free(umidi->card, rmidi);
 				return err;
 			}
-			umidi->out_endpoints[ep]->ports[out_port].rmidi = rmidi;
+			umidi->endpoints[ep].rmidi[c] = rmidi;
 		}
-		if (out)
-			++out_port;
 		++*port_idx;
 	}
 	return 0;
@@ -879,13 +876,13 @@
 			continue;
 		if (ep_info->out_cables) {
 			err = snd_usbmidi_out_endpoint_create(umidi, ep_info,
-							      &umidi->out_endpoints[i]);
+							      &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
 		if (ep_info->in_cables) {
 			err = snd_usbmidi_in_endpoint_create(umidi, ep_info,
-							     &umidi->in_endpoints[i]);
+							     &umidi->endpoints[i]);
 			if (err < 0)
 				return err;
 		}
@@ -936,8 +933,8 @@
 	}
 
 	for (i = 0; i < MAX_ENDPOINTS; ++i)
-		if (umidi->in_endpoints[i])
-			snd_usbmidi_submit_urb(umidi->in_endpoints[i]->urb,
+		if (umidi->endpoints[i].in)
+			snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
 					       GFP_KERNEL);
 	return 0;
 }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
