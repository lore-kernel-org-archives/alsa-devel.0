From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbmidi printk changes
Date: Wed, 05 Mar 2003 10:09:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303051007220.26029-100000@studcom.urz.uni-halle.de>
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


- removed old module name "snd-usb-midi" from messages
- use snd_printk
- improved debugging output


Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.19
diff -u -r1.19 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	3 Feb 2003 09:58:14 -0000	1.19
+++ alsa-kernel/usb/usbmidi.c	5 Mar 2003 09:03:57 -0000
@@ -131,7 +131,7 @@
 {
 	int err = usb_submit_urb(urb, flags);
 	if (err < 0 && err != -ENODEV)
-		printk(KERN_ERR "snd-usb-midi: usb_submit_urb: %d\n", err);
+		snd_printk(KERN_ERR "usb_submit_urb: %d\n", err);
 	return err;
 }

@@ -146,7 +146,7 @@
 	    status == -EILSEQ ||
 	    status == -ETIMEDOUT)
 		return -ENODEV; /* device removed */
-	printk(KERN_ERR "snd-usb-midi: urb status %d\n", status);
+	snd_printk(KERN_ERR "urb status %d\n", status);
 	return 0; /* continue */
 }

@@ -435,8 +435,10 @@
 					port = &umidi->endpoints[i].out->ports[j];
 					break;
 				}
-	if (!port)
+	if (!port) {
+		snd_BUG();
 		return -ENXIO;
+	}
 	substream->runtime->private_data = port;
 	port->state = STATE_UNKNOWN;
 	return 0;
@@ -526,6 +528,8 @@
 	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
 		return NULL;

+	snd_printdd(KERN_INFO "switching to altsetting %d with int ep\n",
+		    intfd->bAlternateSetting);
 	usb_set_interface(umidi->chip->dev, intfd->bInterfaceNumber,
 			  intfd->bAlternateSetting);
 	return get_endpoint(hostif, 1);
@@ -774,8 +778,8 @@
 			}
 		}
 	}
-	printk(KERN_INFO "snd-usb-midi: created %d output and %d input ports\n",
-	       out_ports, in_ports);
+	snd_printdd(KERN_INFO "created %d output and %d input ports\n",
+		    out_ports, in_ports);
 	return 0;
 }

@@ -804,10 +808,10 @@
 	    ms_header->bLength >= 7 &&
 	    ms_header->bDescriptorType == USB_DT_CS_INTERFACE &&
 	    ms_header->bDescriptorSubtype == HEADER)
-		printk(KERN_INFO "snd-usb-midi: MIDIStreaming version %02x.%02x\n",
-		       ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
+		snd_printdd(KERN_INFO "MIDIStreaming version %02x.%02x\n",
+			    ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
 	else
-		printk(KERN_WARNING "snd-usb-midi: MIDIStreaming interface descriptor not found\n");
+		snd_printk(KERN_WARNING "MIDIStreaming interface descriptor not found\n");

 	epidx = 0;
 	for (i = 0; i < intfd->bNumEndpoints; ++i) {
@@ -824,25 +828,25 @@
 		if ((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT) {
 			if (endpoints[epidx].out_ep) {
 				if (++epidx >= MIDI_MAX_ENDPOINTS) {
-					printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
+					snd_printk(KERN_WARNING "too many endpoints\n");
 					break;
 				}
 			}
 			endpoints[epidx].out_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
-			printk(KERN_INFO "snd-usb-midi: EP %02X: %d jack(s)\n",
-			       ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
+			snd_printdd(KERN_INFO "EP %02X: %d jack(s)\n",
+				    ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
 		} else {
 			if (endpoints[epidx].in_ep) {
 				if (++epidx >= MIDI_MAX_ENDPOINTS) {
-					printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
+					snd_printk(KERN_WARNING "too many endpoints\n");
 					break;
 				}
 			}
 			endpoints[epidx].in_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
-			printk(KERN_INFO "snd-usb-midi: EP %02X: %d jack(s)\n",
-			       ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
+			snd_printdd(KERN_INFO "EP %02X: %d jack(s)\n",
+				    ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
 		}
 	}
 	return 0;




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
