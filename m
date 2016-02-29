From: Brian Jones <g0ukb@ivarc.org.uk>
Subject: Re: ERROR: USB Sound card with unsafe characters
Date: Mon, 29 Feb 2016 10:27:00 +0000
Message-ID: <CADKQKXYyv6yuxEnn8be2jiTj4eBg_MHSGecSTb5eZ6PD-o-tJg@mail.gmail.com>
References: <CADKQKXYmcT8eOf9wH=Do_0RTk1RGBwMwTY0hvyNoXxVEwptWRg@mail.gmail.com>
 <56D41276.9080506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 926C0260524
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 11:27:00 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id n186so41954386wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 02:27:00 -0800 (PST)
In-Reply-To: <56D41276.9080506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens - thank you!!! I have been trying for several months to fix this. I
am now listening to the card via SPDIF for the first time!

My apologies over the two sends to alsa-dev - I sent the first one before
my registration to the mailing list was approved and hadn't seen it appear
on the list today after my registration had been complete for a day, so I
assumed it had got dumped because I was not a list member when I sent it.
So I resent it today. I will only send once for future problems, apologies.

Brian



On 29 February 2016 at 09:42, Clemens Ladisch <clemens@ladisch.de> wrote:

> Brian Jones wrote:
> > I don't know how to get this bug to the developers
>
> Just send it to the alsa-devel list.  Once.
>
> > My USB soundcard is an Asus Xonar U7 Echelon Edition
> > <https://www.asus.com/Sound-Cards/Xonar_U7_Echelon_Edition/> which
> > identifies itself to alsa as "Xonar U7 Echelon Ed." The card is supported
> > by alsa and works well in analog mode but I cannot get digital output via
> > alsa.
> >
> > Attempts to change the iec958 device in USB-Audio.conf fail because of
> the
> > period char and apparently my level of OS (Mint 17.3 based on Ubuntu
> 14.04,
> > kernel 3.19.0-32) does not have alsa supporting USB vendorid:productid
> > naming
>
> The vendor:product naming is used only for device that do not have a name.
> The newer version of alsa-lib would replace unsafe characters (like '.')
> with an underscore.
>
>
> Try changing /usr/share/alsa/cards/USB-Audio.conf.  Dont add an entry to
> the USB-Audio.pcm.iec958_device list near the top, but go to the bottom,
> to the USB-Audio.pcm.iec958.0 definition, and change this:
>
> USB-Audio.pcm.iec958.0 {
>         @args [ CARD AES0 AES1 AES2 AES3 ]
>         @args.CARD { type string }
>         @args.AES0 { type integer }
>         @args.AES1 { type integer }
>         @args.AES2 { type integer }
>         @args.AES3 { type integer }
>         @func refer
>         name {
>                 ...(lots of stuff)...
>         }
>         default {
>                 ...(lots of stuff)...
>         }
> }
>
> to this:
>
> USB-Audio.pcm.iec958.0 {
>         @args [ CARD AES0 AES1 AES2 AES3 ]
>         @args.CARD { type string }
>         @args.AES0 { type integer }
>         @args.AES1 { type integer }
>         @args.AES2 { type integer }
>         @args.AES3 { type integer }
>         type hw                         # no @func
>         card $CARD
>         device 1
> }
>
> (This will break S/PDIF on all other USB devices, but who cares ...)
>
>
> Regards,
> Clemens
>
