From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: [PATCH] usbmidi (0.9.0rc7) output endpoints detection for MIDIStreaming protocol
Date: Mon, 3 Feb 2003 00:56:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302030056.26089.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_26HP45J1F3KWCGCVRV0I"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_26HP45J1F3KWCGCVRV0I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi,

Attached is a patch to solve a little mistake with output endpoints detection 
for standard USB MIDI devices. Midisport devices are affected only if using 
Lars Doelle firmware.

Typical syslog output was like this:

kernel: snd-usb-midi: MIDIStreaming version 01.00
kernel: snd-usb-midi: EP 01: 2 jack(s)
kernel: snd-usb-midi: EP 81: 2 jack(s)
kernel: snd-usb-midi: created 0 output and 4 input ports
kernel: usb-uhci.c: ENXIO c0008480, flags 0, urb c1b665a0, burb c1b664a0
kernel: snd-usb-midi: usb_submit_urb: -6

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com

--------------Boundary-00=_26HP45J1F3KWCGCVRV0I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch.usbmidi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.usbmidi"

--- alsa-kernel/usb/usbmidi.c.old	Mon Jan 13 10:50:26 2003
+++ alsa-kernel/usb/usbmidi.c	Mon Feb  3 00:41:36 2003
@@ -821,7 +821,7 @@
 		    ms_ep->bDescriptorType != USB_DT_CS_ENDPOINT ||
 		    ms_ep->bDescriptorSubtype != MS_GENERAL)
 			continue;
-		if ((ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK) == USB_DIR_OUT) {
+		if ((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT) {
 			if (endpoints[epidx].out_ep) {
 				if (++epidx >= MIDI_MAX_ENDPOINTS) {
 					printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");

--------------Boundary-00=_26HP45J1F3KWCGCVRV0I--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
