From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] M-Audio Audiophile USB MIDI fix
Date: Mon, 24 Mar 2003 09:24:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303240911020.19990-100000@studcom.urz.uni-halle.de>
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


The first version of this quirk was based on some obscure entry in the
Quattro driver's .inf file. The Audiophile .inf file actually knows the
right number.

(There still isn't a firmware loader for the Audiophile.)


Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.18
diff -u -r1.18 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	28 Feb 2003 14:54:40 -0000	1.18
+++ alsa-kernel/usb/usbquirks.h	24 Mar 2003 07:59:53 -0000
@@ -717,7 +717,7 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",
-		.ifnum = 9,
+		.ifnum = 6,
 		.type = QUIRK_MIDI_MIDIMAN,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
 			.out_cables = 0x0001,




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
