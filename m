From: Brent Cook <busterbcook@yahoo.com>
Subject: Support for EDIROL UM-3ex
Date: Sat, 31 Dec 2005 21:54:35 -0600
Message-ID: <200512312154.35173.busterbcook@yahoo.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7J1tDihvX+bssMF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_7J1tDihvX+bssMF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

This is my naive attempt at adding ALSA device support. The attached patch 
provides support for the EDIROL UM-3ex. This is a 3-port USB midi interface 
with a built-in USB hub and the ability to chain 2 other UM-3x's in a 
master-slave configuration. I only have one, so I do not know how this works 
in practice.

Though this is a 3-port device, I had to throw in that 4th 'Control' interface 
to the definition in order to make the 3rd port work. If I set in/out_cables 
to 0x000b, a 3rd interface appears on the driver, but it does nothing. 
Changing it to 0x000f allows the 3rd interface to work, but of course 
interface 4 does not work because it does not exist.

 - Brent

--Boundary-00=_7J1tDihvX+bssMF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="edirol_um-3ex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="edirol_um-3ex.patch"

diff -urN linux-2.6.15-rc7/sound/usb/usbmidi.c linux-2.6.15-rc7.dev/sound/usb/usbmidi.c
--- linux-2.6.15-rc7/sound/usb/usbmidi.c	2005-12-31 20:14:15.000000000 -0600
+++ linux-2.6.15-rc7.dev/sound/usb/usbmidi.c	2005-12-31 21:47:23.000000000 -0600
@@ -1095,6 +1095,8 @@
 	{ USB_ID(0x086a, 0x0001), 8, "%s Broadcast" },
 	{ USB_ID(0x086a, 0x0002), 8, "%s Broadcast" },
 	{ USB_ID(0x086a, 0x0003), 4, "%s Broadcast" },
+	/* Edirol UM-3ex */
+	{ USB_ID(0x0582, 0x009a), 3, "%s Control" },
 };
 
 static void snd_usbmidi_init_substream(snd_usb_midi_t* umidi,
diff -urN linux-2.6.15-rc7/sound/usb/usbquirks.h linux-2.6.15-rc7.dev/sound/usb/usbquirks.h
--- linux-2.6.15-rc7/sound/usb/usbquirks.h	2005-12-31 20:14:15.000000000 -0600
+++ linux-2.6.15-rc7.dev/sound/usb/usbquirks.h	2005-12-31 21:40:15.000000000 -0600
@@ -204,6 +204,28 @@
 	}
 },
 {
+	USB_DEVICE(0x0582, 0x009a),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-3ex",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const snd_usb_midi_endpoint_info_t) {
+					.out_cables = 0x000f,
+					.in_cables  = 0x000f
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+{
 	USB_DEVICE(0x0582, 0x0002),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",

--Boundary-00=_7J1tDihvX+bssMF--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
