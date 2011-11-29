From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Kernel: snd-usb-audio: probe of 2-2:1.0 failed
 with error -5
Date: Tue, 29 Nov 2011 20:09:24 +0100
Message-ID: <4ED52DE4.4040507@ladisch.de>
References: <4ED4D58D.60109@nixbits.org>	<CA+55aFxjrCZTEzznjEK_FjadortNS9GPtcDH=D8-HebKKhQ8Bg@mail.gmail.com>
	<4ED51463.6050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 08CFF2440A
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 20:09:41 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A09EC22BA7
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 14:09:38 -0500 (EST)
In-Reply-To: <4ED51463.6050005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, admin@nixbits.org, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On 11/29/2011 05:58 PM, Linus Torvalds wrote:
>> On Tue, Nov 29, 2011 at 4:52 AM, Nixbits Admin <admin@nixbits.org> wrote:
>>> https://forums.gentoo.org/viewtopic-p-6885908.html#6885908
>>
>>   Nov 29 07:21:21  kernel: skipping empty audio interface (v1)
>>   Nov 29 07:21:21  kernel: snd-usb-audio: probe of 2-3:1.0 failed with error -5
>
> If the driver bails out at this point, there's something wrong with the
> descriptors, or the interface has no audio support at all (which would
> be odd as it could have been omitted entirely in the first place).
>
> We might have to add a quirk for the device, let's see.

Actually, this error message could be prevented by removing the quirk
that is already there.

That quirk does nothing more than providing a nice user-visible name for
the device.  In doing so, it uses the USB_DEVICE macro, which makes the
USB core trying to attach it to all interfaces, including the video ones.
Because of all the crap descriptors out there, the audio driver trusts
the quirk, is not fazed by an interface not labeled as "audio", and
happily begins to parse the interface's descriptors.

The quirk should just be restricted to the audio interfaces (like all
the other Logitech quirks).


N.A., please try the patch below.


Regards,
Clemens


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
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "Logitech, Inc.",
 		.product_name = "QuickCam Pro 9000",
