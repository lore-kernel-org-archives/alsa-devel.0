From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] OmniStudio MIDI quirk
Date: Wed, 08 Oct 2003 15:27:00 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310081525320.3748-100000@studcom.urz.uni-halle.de>
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


add support for M-Audio OmniStudio MIDI


--- alsa-kernel/usb/usbquirks.h.org	2003-10-08 11:12:13.636616000 +0200
+++ alsa-kernel/usb/usbquirks.h	2003-10-08 15:23:41.059987000 +0200
@@ -638,6 +638,19 @@
 		}
 	}
 },
+{
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x200d),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "M-Audio",
+		.product_name = "OmniStudio",
+		.ifnum = 9,
+		.type = QUIRK_MIDI_MIDIMAN,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
+	}
+},

 /* Mark of the Unicorn devices */
 {




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
