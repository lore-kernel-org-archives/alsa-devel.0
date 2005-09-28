From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Wed, 28 Sep 2005 14:03:17 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509281356340.3203-100000@studcom.urz.uni-halle.de>
References: <2c746f620509271752528aa59a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620509271752528aa59a@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eric Shattow wrote:
> I have a Hercules PC DJ Console (Windows Edition) that I would like to
> work with ALSA. The device outputs some sound at 48kHz after asoundrc
> configuration,

It should just work without an .asoundrc.  What did you put in there?

> MIDI is not functional.

Please try the patch below (against the current CVS).
How many ports does it have? -- Eight is probably too much ... :-)


HTH
Clemens


--- alsa-kernel/usb/usbquirks.h	26 Sep 2005 07:55:01 -0000	1.54
+++ alsa-kernel/usb/usbquirks.h	28 Sep 2005 11:58:56 -0000
@@ -1066,6 +1066,21 @@
 	/* TODO: add Edirol UM-3 support */
 	/* TODO: add Edirol MD-P1 support */

+/* Guillemot devices */
+{
+	USB_DEVICE_VENDOR_SPEC(0x06f8, 0xb000),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Hercules",
+		.product_name = "DJ Console",
+		.ifnum = 4,
+		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x00ff,
+			.in_cables  = 0x00ff
+		}
+	}
+},
+
 /* Midiman/M-Audio devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1002),



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
