From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: my first usb-midi experiment ends with segmentation
 fault
Date: Tue, 30 Jul 2002 15:09:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D469011.855453A7@ladisch.de>
References: <20020728213924.GA522@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA00608
	for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2002 15:09:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: martin-langer@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> my new USB-MIDI-Keyboard has two USB subclasses usb-midi and usb-audio.
> Evolution, the manufacturer, told me "it's an Audio Class compliant device",
> but I don't find a new entry in /proc/asound/seq/clients after loading the
> modules.
> 
> usb.c: registered new driver snd-usb-midi
> snd-usb-midi: using interface 1
> snd-usb-midi: MIDIStreaming version 01.00
> snd-usb-midi: using 1 input jack(s) on endpoint 1
> snd-usb-midi: using 1 output jack(s) on endpoint 2
> snd-usb-midi: detected Evolution Electronics L MK-249C USB MIDI keyboa
> usb.c: snd-usb-midi driver claimed interface dfe688d8
> 
> It's not typical to have a midi-keyboard with two subclasses, or?

As Pedro said, subclass 1 is an AudioControl interface. There should be
two cards, one created by snd-usb-audio, and the other one created by
snd-usb-midi (see /proc/asound/cards). The contents of the control
interface (if there are any controls) should be visible in the output
of the "lsusb" command.

Your keyboard is unusual in two respects: it's an Audio Class compliant
device (yes, this _is_ unusual for USB MIDI devices :-) , and it uses
two endpoints, one for each direction. The combination of these two
triggers an ugly bug in the descriptor parsing code (device_info isn't
initialized).

Please try the following patch (the current taciturnity of the driver
is somewhat inconvenient, so it adds some error messages as well).


Index: usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.4
diff -u -r1.4 usbmidi.c
--- usb/usbmidi.c	5 Jul 2002 13:39:28 -0000	1.4
+++ usb/usbmidi.c	30 Jul 2002 12:39:00 -0000
@@ -834,8 +834,10 @@
 		port = snd_seq_event_port_attach(umidi->seq_client,
 						 &port_callback,
 						 cap, type, port_name);
-		if (port < 0)
+		if (port < 0) {
+			snd_printk(KERN_ERR "cannot create port (error code %d)\n", err);
 			return port;
+		}
 		if (in)
 			umidi->endpoints[ep].in->ports[c].seq_port = port;
 
@@ -1084,6 +1086,8 @@
 	usb_ms_endpoint_descriptor_t* ms_ep;
 	int i, epidx;
 
+	memset(device_info, 0, sizeof(*device_info));
+
 	if (usb_device->descriptor.iManufacturer == 0 ||
 	    usb_string(usb_device, usb_device->descriptor.iManufacturer,
 		       device_info->vendor, sizeof(device_info->vendor)) < 0)
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


> ... and doing rmmod snd-usb-midi and rmmod snd-usb-audio ends here with
> Segmentation fault:
> 
> Jul 28 22:28:10 tuba kernel: usb.c: deregistering driver snd-usb-midi
> Jul 28 22:28:10 tuba kernel: Unable to handle kernel paging request at
> virtual address 29323034
> 
> a small bug or a big hole?

A small bug which results in a big mess.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
