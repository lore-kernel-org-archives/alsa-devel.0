From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Quattro MIDI
Date: Wed, 23 Oct 2002 09:37:31 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210230913550.5856-100000@studcom.urz.uni-halle.de>
References: <s5hbs5m30yi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA23719
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 09:37:34 +0200
In-reply-to: <s5hbs5m30yi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > It seems the USB subsystem only loads the first id_table entry it finds
> > for each interface. As a quick fix, remove the Quattro entry from
> > usbquirks.h, but I'm going to write a patch to use both pcm and MIDI.
>
> ok, i'll remove it.

The Quattro id_table entry matches both PCM and MIDI interfaces because I
removed the interface class from most entries nine days ago. I did this
because my Roland SC-8820 didn't hotplug because the kernel didn't pass
the interface class to the hotplug scripts because the device class isn't
zero. However, devices with different interfaces do have device class zero
(well, I hope they do :), so using the interface class for matching
shouldn't prevent hotplugging for these devices.

This patch adds interface class matching for some devices with both PCM
and MIDI interfaces.


Regards,
Clemens


Index: usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.4
diff -u -r1.4 usbquirks.h
--- usbquirks.h	22 Oct 2002 16:17:55 -0000	1.4
+++ usbquirks.h	23 Oct 2002 07:11:51 -0000
@@ -72,7 +72,7 @@
 	}
 },
 {
-	USB_DEVICE(0x0499, 0x1004),
+	USB_DEVICE_VENDOR_SPEC(0x0499, 0x1004),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "UW500",
@@ -126,7 +126,7 @@
 	}
 },
 {
-	USB_DEVICE(0x0499, 0x100a),
+	USB_DEVICE_VENDOR_SPEC(0x0499, 0x100a),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "Yamaha",
 		.product_name = "EOS BX",
@@ -464,9 +464,8 @@
 		.data = (void*) 9
 	}
 },
-#if 0 // FIXME
 {
-	USB_DEVICE(0x0763, 0x2001),
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2001),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
@@ -475,9 +474,8 @@
 		.data = (void*) 1
 	}
 },
-#endif // FIXME
 {
-	USB_DEVICE(0x0763, 0x2003),
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2003),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
