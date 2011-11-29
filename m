From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Kernel: snd-usb-audio: probe of 2-2:1.0 failed
 with error -5
Date: Tue, 29 Nov 2011 20:23:18 +0100
Message-ID: <4ED53126.7000708@ladisch.de>
References: <4ED4D58D.60109@nixbits.org>
	<CA+55aFxjrCZTEzznjEK_FjadortNS9GPtcDH=D8-HebKKhQ8Bg@mail.gmail.com>
	<4ED51463.6050005@gmail.com> <4ED52DE4.4040507@ladisch.de>
	<CA+55aFwA5JxUn0_kWPt7R1zTbYHzi27gW9982RQtQEkiKRD86A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DF1B224465
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 20:23:34 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4D8B923EB8
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 14:23:32 -0500 (EST)
In-Reply-To: <CA+55aFwA5JxUn0_kWPt7R1zTbYHzi27gW9982RQtQEkiKRD86A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: admin@nixbits.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Linus Torvalds wrote:
> On Tue, Nov 29, 2011 at 11:09 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> N.A., please try the patch below.
>
> I don't think that will compile. At a minimum, there's a missing comma
> there, afaik.

Oops, indeed.  Now compile-tested:

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -157,7 +157,13 @@
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
-	USB_DEVICE(0x046d, 0x0990),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x046d,
+	.idProduct = 0x0990,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "Logitech, Inc.",
 		.product_name = "QuickCam Pro 9000",
