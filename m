From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] SC-D70 recording support
Date: Thu, 23 Jan 2003 19:05:53 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301231901570.17327-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


This finally adds support for capturing.

Contrary to what I've written earlier, the mixer controls (capture
selection etc.) *are* supported, because they're on the device's front
panel, not in software. :-)


--- alsa-kernel/usb/usbquirks.h.orig	2003-01-23 18:22:44.785700000 +0100
+++ alsa-kernel/usb/usbquirks.h	2003-01-23 18:38:23.808544000 +0100
@@ -398,6 +398,7 @@
 	}
 },
 {
+	/* thanks to Emiliano Grilli <emillo@libero.it> for helping researching this data */
 	USB_DEVICE(0x0582, 0x000c),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Roland",
@@ -423,6 +424,23 @@
 				}
 			},
 			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x81,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 44100,
+					.rate_max = 44100,
+				}
+			},
+			{
 				.ifnum = 2,
 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
 				.data = & (const snd_usb_midi_endpoint_info_t) {



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
