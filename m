From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: quattro usb-audio endianess conversion layer
Date: Thu, 10 Jun 2004 19:04:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406101848280.3148-100000@studcom.urz.uni-halle.de>
References: <40C76A13.4080002@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40C76A13.4080002@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> It turns out the reason for the noise in the input channels all this
> time is due to the quattro only reading big endian at input.

Does this happen all of the time?  There is a bug report which says
that it works sometimes.

> Has anyone had ideas on how to implement a layer that works to
> automatically convert the quattros big endian input into little endian
> to enable ease of use with most Linux audio apps?

With the patch below, it should work with plughw:X.  Does it?


HTH
Clemens

-- 
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.100
diff -u -r1.100 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	5 May 2004 08:50:45 -0000	1.100
+++ alsa-kernel/usb/usbaudio.c	10 Jun 2004 17:00:40 -0000
@@ -2182,6 +2182,24 @@


 /*
+ * check if the device uses big-endian samples
+ */
+static int is_big_endian_format(struct usb_device *dev, struct audioformat *fp)
+{
+	/* M-Audio */
+	if (dev->descriptor.idVendor == 0x0763) {
+		/* Quattro: captured data only */
+		if (dev->descriptor.idProduct == 0x2001 &&
+		    fp->endpoint & USB_DIR_IN)
+			return 1;
+		/* Audiophile USB */
+		if (dev->descriptor.idProduct == 0x2003)
+			return 1;
+	}
+	return 0;
+}
+
+/*
  * parse the audio format type I descriptor
  * and returns the corresponding pcm format
  *
@@ -2217,17 +2235,13 @@
 			pcm_format = SNDRV_PCM_FORMAT_S8;
 			break;
 		case 2:
-			/* M-Audio audiophile USB workaround */
-			if (dev->descriptor.idVendor == 0x0763 &&
-			    dev->descriptor.idProduct == 0x2003)
+			if (is_big_endian_format(dev, fp))
 				pcm_format = SNDRV_PCM_FORMAT_S16_BE; /* grrr, big endian!! */
 			else
 				pcm_format = SNDRV_PCM_FORMAT_S16_LE;
 			break;
 		case 3:
-			/* M-Audio audiophile USB workaround */
-			if (dev->descriptor.idVendor == 0x0763 &&
-			    dev->descriptor.idProduct == 0x2003)
+			if (is_big_endian_format(dev, fp))
 				pcm_format = SNDRV_PCM_FORMAT_S24_3BE; /* grrr, big endian!! */
 			else
 				pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.33
diff -u -r1.33 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	12 May 2004 06:29:22 -0000	1.33
+++ alsa-kernel/usb/usbquirks.h	10 Jun 2004 17:00:40 -0000
@@ -830,11 +830,42 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
-		.ifnum = 9,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			/*
+			 * Interfaces 0-2 are "Windows-compatible", 16-bit only,
+			 * and share endpoints with the other interfaces.
+			 * Ignore them.  The other interfaces can do 24 bits,
+			 * but captured samples are big-endian (see usbaudio.c).
+			 */
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 5,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 7,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 8,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 9,
+				.type = QUIRK_MIDI_MIDIMAN,
+				.data = & (const snd_usb_midi_endpoint_info_t) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
 		}
 	}
 },




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
