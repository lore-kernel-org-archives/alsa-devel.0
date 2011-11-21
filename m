From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: ALSA Support for Roland Gaia SH-01
Date: Mon, 21 Nov 2011 23:37:59 +1100
Message-ID: <CACckToWK3kr4tfWjAOXnpVxH792tOZekeCVT8=g7zPCD31gm5Q@mail.gmail.com>
References: <1321835088.14960.22.camel@darkside>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C7EAF24690
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 13:38:01 +0100 (CET)
Received: by eyz10 with SMTP id 10so5469056eyz.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 04:38:00 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2011 at 11:24 AM, John F Leach <jfleach@jfleach.com> wrote:

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
>        /* Roland Gaia SH-01 */
>        USB_DEVICE(0x0582, 0x0111),
>        .driver_info = (unsigned long) & (const struct
> snd_usb_audio_quirk) {
>                .vendor_name = "Roland",
>                .product_name = "Gaia",
>                .ifnum = QUIRK_ANY_INTERFACE,
>                .type = QUIRK_COMPOSITE,
>                .data = (const struct snd_usb_audio_quirk[]) {
>                        {
>                                .ifnum = 0,
>                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                        },
>                        {
>                                .ifnum = 1,
>                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
>                        },
>                        {
>                                .ifnum = 2,
>                                .type = QUIRK_STANDARD_MIDI_INTERFACE,
>                                }
>                        },
>                        {
>                                .ifnum = -1
>                        }
>                }
>        }
>
>
>
> I've looked at this a little and from my poor understanding I may have
given John a red herring wrt:

>                                 .type = QUIRK_STANDARD_MIDI_INTERFACE,

>From the looks of interface 2 which I'm guessing is the midi subinterface
it doesn't seem to conform to the UAC spec

     bInterfaceNumber        2
     bAlternateSetting       0
     bNumEndpoints           2
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass      3


This might need to be QUIRK_FIXED_MIDI_ENDPOINT maybe?
