From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: emagic mt4
Date: Fri, 20 Feb 2004 12:36:26 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402201214340.13625-100000@studcom.urz.uni-halle.de>
References: <1077208889.5720.1.camel@ian-lnx.ycrdi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077208889.5720.1.camel@ian-lnx.ycrdi.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ian esten <deviant@custard.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ian esten wrote:
> On Thu, 2004-02-19 at 03:28, Clemens Ladisch wrote:
> > Please post the output of "lsusb -v".
>
> Bus 001 Device 040: ID 086a:0003 Emagic Soft-und Hardware GmbH
> .
> .
> .

These descriptors look very much like those of earlier Edirol devices.
It may be possible that the MT4 is similar enough to speak the same
protocol.

Please apply the patch below and recompile ALSA.  The device and its
ports will show up in ALSA, but I'm not sure if sending/receiving MIDI
data will work.


HTH
Clemens


-- 
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.28
diff -u -r1.28 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	18 Feb 2004 16:24:55 -0000	1.28
+++ alsa-kernel/usb/usbquirks.h	20 Feb 2004 11:15:09 -0000
@@ -714,4 +714,19 @@

 },

+/* Emagic devices */
+{
+	USB_DEVICE(0x086a, 0x0003),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Emagic",
+		.product_name = "MT4",
+		.ifnum = 2,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x000f,
+			.in_cables  = 0x0003
+		}
+	}
+},
+
 {




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
