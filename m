From: Clemens Ladisch <clemens@ladisch.de>
Subject: [Alsa-devel][Patch] usbmidi fixes
Date: Wed, 31 Jul 2002 12:02:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D47B5A1.752946D6@ladisch.de>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de>
 <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de>
 <20020730181834.GA494@tuba.home>
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
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Below is the final version of my changes to usbmidi.c.
I used the opportunity to make some further fixes.

These changes are desirable even if (apparently) they don't fix
Martin's problem.


- enlarged vendor/device name strings
- fixed buffer overflow for card->shortname
- added error messages if initialization fails
- made information messages more consistent
- fixed module_setup comment


Index: usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.4
diff -u -r1.4 usbmidi.c
--- usb/usbmidi.c	5 Jul 2002 13:39:28 -0000	1.4
+++ usb/usbmidi.c	31 Jul 2002 10:00:51 -0000
@@ -167,8 +167,8 @@
  * or is supplied explicitly for broken devices.
  */
 struct usbmidi_device_info {
-	char vendor[24];		/* vendor name */
-	char product[24];		/* device name */
+	char vendor[32];		/* vendor name */
+	char product[32];		/* device name */
 	int16_t ifnum;			/* interface number */
 	struct usbmidi_endpoint_info {
 		int16_t epnum;		/* endpoint number,
@@ -803,7 +803,7 @@
 	int cap, type, port;
 	int out, in;
 	snd_seq_port_callback_t port_callback;
-	char port_name[40];
+	char port_name[48];
 
 	for (c = 0; c < 0x10; ++c) {
 		out = ep_info->out_cables & (1 << c);
@@ -834,8 +834,10 @@
 		port = snd_seq_event_port_attach(umidi->seq_client,
 						 &port_callback,
 						 cap, type, port_name);
-		if (port < 0)
+		if (port < 0) {
+			snd_printk(KERN_ERR "cannot create port (error code %d)\n", port);
 			return port;
+		}
 		if (in)
 			umidi->endpoints[ep].in->ports[c].seq_port = port;
 
@@ -889,7 +891,7 @@
 		err = snd_usbmidi_create_endpoint_ports(umidi, i, &port_idx);
 		if (err < 0)
 			return err;
-		printk(KERN_INFO "snd-usb-midi: endpoint %d: %d output and %d input ports\n",
+		printk(KERN_INFO "snd-usb-midi: endpoint %d: created %d output and %d input ports\n",
 		       ep_info->epnum,
 		       snd_usbmidi_count_bits(ep_info->out_cables),
 		       snd_usbmidi_count_bits(ep_info->in_cables));
@@ -972,12 +974,12 @@
 		return -ENOMEM;
 	}
 	strcpy(card->driver, "USB MIDI");
-	sprintf(card->shortname, "%s %s",
-		device_info->vendor, device_info->product);
-	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
-		card->shortname, usb_device->descriptor.idVendor,
-		usb_device->descriptor.idProduct, device_info->ifnum,
-		usb_device->bus->busnum, usb_device->devnum);
+	snprintf(card->shortname, sizeof(card->shortname), "%s %s",
+		 device_info->vendor, device_info->product);
+	snprintf(card->longname, sizeof(card->longname), "%s %s at %03d/%03d if %d",
+		 device_info->vendor, device_info->product,
+		 usb_device->bus->busnum, usb_device->devnum,
+		 device_info->ifnum);
 	card->private_data = (void*)dev;
 
 	err = snd_seq_device_new(card, 0, SNDRV_SEQ_DEV_ID_USBMIDI,
@@ -1084,14 +1086,16 @@
 	usb_ms_endpoint_descriptor_t* ms_ep;
 	int i, epidx;
 
+	memset(device_info, 0, sizeof(*device_info));
+
 	if (usb_device->descriptor.iManufacturer == 0 ||
 	    usb_string(usb_device, usb_device->descriptor.iManufacturer,
 		       device_info->vendor, sizeof(device_info->vendor)) < 0)
-		strcpy(device_info->vendor, "Unknown Vendor");
+		sprintf(device_info->vendor, "Unknown Vendor %x", usb_device->descriptor.idVendor);
 	if (usb_device->descriptor.iProduct == 0 ||
 	    usb_string(usb_device, usb_device->descriptor.iProduct,
 		       device_info->product, sizeof(device_info->product)) < 0)
-		strcpy(device_info->product, "Unknown Device");
+		sprintf(device_info->product, "Unknown Device %x", usb_device->descriptor.idProduct);
 
 	intf = usb_ifnum_to_if(usb_device, ifnum);
 	if (!intf)
@@ -1140,7 +1144,7 @@
 		} else {
 			device_info->endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
 		}
-		printk(KERN_INFO "snd-usb-midi: using %d %s jack(s) on endpoint %d\n",
+		printk(KERN_INFO "snd-usb-midi: detected %d %s jack(s) on endpoint %d\n",
 		       ms_ep->bNumEmbMIDIJack,
 		       ep->bEndpointAddress & USB_DIR_IN ? "input" : "output",
 		       device_info->endpoints[epidx].epnum);
@@ -1180,12 +1184,15 @@
 {
 	usbmidi_device_info_t device_info;
 	snd_card_t* card = NULL;
+	int err;
 
 	if (snd_usbmidi_get_device_info(device, ifnum, device_id,
 					&device_info) == 0) {
 		printk(KERN_INFO "snd-usb-midi: detected %s %s\n",
 		       device_info.vendor, device_info.product);
-		snd_usbmidi_card_create(device, &device_info, &card);
+		err = snd_usbmidi_card_create(device, &device_info, &card);
+		if (err < 0)
+			snd_printk(KERN_ERR "cannot create card (error code %d)\n", err);
 	}
 	return card;
 }
@@ -1369,7 +1376,8 @@
 #ifndef MODULE
 
 /*
- * format is snd-usb-midi=snd_enable,snd_index,snd_id,snd_pid,snd_int_transfer
+ * format is snd-usb-midi=snd_enable,snd_index,snd_id,
+ *                        snd_vid,snd_pid,snd_int_transfer
  */
 static int __init snd_usbmidi_module_setup(char* str)
 {


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
