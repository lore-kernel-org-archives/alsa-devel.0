From: Daniel Mack <zonque@gmail.com>
Subject: Re: ALSA Support for Roland Gaia SH-01
Date: Mon, 21 Nov 2011 12:10:16 +0100
Message-ID: <4ECA3198.3040707@gmail.com>
References: <1321835088.14960.22.camel@darkside>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 135AE24465
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 12:10:23 +0100 (CET)
Received: by bkat8 with SMTP id t8so6376825bka.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 03:10:22 -0800 (PST)
In-Reply-To: <1321835088.14960.22.camel@darkside>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John F Leach <jfleach@jfleach.com>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On 11/21/2011 01:24 AM, John F Leach wrote:
> All,
> 
> Can someone please help to add ALSA support for the Roland Gaia (SH-01)
> Synthesizer?
> 
> http://www.rolandus.com/products/productdetails.php?ProductId=1074
> 
> I started a sample patch for usbquirks.h (see below) but am not sure if
> the USB_DEVICE address is correct or what to use for the types.  What
> should the quirk table entry look like for this device?  Does quirks.c
> need a special case added?
> 
> {
>         /* Roland Gaia SH-01 */
>         USB_DEVICE(0x0582, 0x0111),
>         .driver_info = (unsigned long) & (const struct
> snd_usb_audio_quirk) {
>                 .vendor_name = "Roland",
>                 .product_name = "Gaia",
>                 .ifnum = QUIRK_ANY_INTERFACE,
>                 .type = QUIRK_COMPOSITE,
>                 .data = (const struct snd_usb_audio_quirk[]) {
>                         {
>                                 .ifnum = 0,
>                                 .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                         },
>                         {
>                                 .ifnum = 1,
>                                 .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                         },
>                         {
>                                 .ifnum = 2,
>                                 .type = QUIRK_STANDARD_MIDI_INTERFACE,
>                                 }
>                         },
>                         {
>                                 .ifnum = -1
>                         }
>                 }
>         }

That doesn't look too bad except for a syntactial error in the MIDI
block (an extra "}"). Did you try it? What was the result?



Daniel
