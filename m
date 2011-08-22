From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Mon, 22 Aug 2011 13:49:12 +0200
Message-ID: <CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B7F11038C7
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 13:49:13 +0200 (CEST)
Received: by pzk1 with SMTP id 1so9194474pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2011 04:49:12 -0700 (PDT)
In-Reply-To: <4E52401C.8030605@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 1:40 PM, Kristian Amlie <kristian@amlie.name> wrote:
> On 08/22/11 12:54, Daniel Mack wrote:
>> On Mon, Aug 22, 2011 at 12:52 PM, Kristian Amlie <kristian@amlie.name> wrote:
>>> I have just received a new MIDI instrument (Starr Labs Z7S) which is not
>>> recognized by the kernel, and I'd like to add support for it. I'm hoping
>>> that it uses a standard MIDI interface and it's just a matter of adding
>>> the correct entry in the table of devices.
>>>
>>> I have tried to add an entry to sound/usb/usbquirks.h
>>> (sound/usb/quirks-table.h in later kernels), but so far I haven't
>>> succeeded. Is there any documentation for how to do this, and which
>>> options to use? Google hasn't really turned up anything...
>>
>> The USB descriptors should give us a hint. Can you send your "lsusb
>> -v" output, please?
>
> Sure! Here is the lsusb -v output for the device:

It doesn't seem to be using a standard MIDI interface, but there's a
chance that it accepts raw MIDI byte streams. Can you check the patch
below?


Daniel


diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index a42e3ef..0f8aa11 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -39,6 +39,16 @@
        .idProduct = prod, \
        .bInterfaceClass = USB_CLASS_VENDOR_SPEC

+/* Starr Labs MIDI USB device */
+{
+       USB_DEVICE(0x0403, 0xb8d8),
+       .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+               /* .vendor_name = "STARR LABS", */
+               /* .product_name = "Starr Labs MIDI USB device", */
+               .ifnum = 0,
+               .type = QUIRK_MIDI_RAW_BYTES
+       }
+},
 /* Creative/Toshiba Multimedia Center SB-0500 */
 {
        USB_DEVICE(0x041e, 0x3048),
