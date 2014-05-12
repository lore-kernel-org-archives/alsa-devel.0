From: Adam Goode <agoode@chromium.org>
Subject: Re: Support for getting "manufacturer" from
 snd_seq_client_info and/or snd_ctl_card_info
Date: Mon, 12 May 2014 12:29:17 -0700
Message-ID: <CAOf41Nka_a8Y08MwERBKrZdKCUFo5-NhxR0ULHtUye4aUaOKXg@mail.gmail.com>
References: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>
 <536F2BB8.8060002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F872650CE
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 21:29:19 +0200 (CEST)
Received: by mail-ig0-f177.google.com with SMTP id l13so4293590iga.16
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 12:29:18 -0700 (PDT)
In-Reply-To: <536F2BB8.8060002@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Adam Goode <agoode@chromium.org>
List-Id: alsa-devel@alsa-project.org

tl;dr Is anyone against me exposing all the stuff currently in /proc/asound
via sysfs files? And then can I add more stuff?


On Sun, May 11, 2014 at 12:50 AM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Adam Goode wrote:
> > I am working on a seq implementation for Chrome, to replace the rawmidi
> > implementation. I can retain the manufacturer extraction hack on the
> card,
> > but seq requires yet another hack to guess the card for a particular seq
> > client.
>
> Did you test this with anything besides USB devices?
>
>
No, this heuristic only works for USB devices.


> And software clients do not have a card.
>
>
That's fine. The manufacturer field is optional when exposed to Web MIDI
clients. But it would be great if we could expose the information when it
is already present in the kernel.



> > Any suggestions on how to extract the manufacturer more easily? The best
> > solution would be to add a manufacturer (or vendor) field to the
> > snd_seq_client_info ioctl struct.
>
> Old clients would not know to set this field.
>
>
That's fine, I am not worried about type=user clients. In most cases there
isn't really a useful manufacturer there.



> The Core MIDI documentation says:
> | kMIDIPropertyManufacturer
> |   Drivers *should* set this property on their devices.
> |   Creators of virtual endpoints *may* set this property on their
> endpoints.
>
> So what happens on OS X if this is not set?
>
>
In this case, we don't expose the manufacturer via Web MIDI.



> > A completely different solution would be to add all this info to sysfs
>
> USB devices already have this information in sysfs.
>
>
This is true. Unfortunately, here are the current steps to get this
information:
1. Given a seq client, attempt to guess the card by making assumptions
about client->card numbering.
2. From the card, attempt to guess the manufacturer by making assumptions
about how longname is constructed. Or, attempt to extract the usb
information from the card info struct and then try to get the info from
/sys (but this gives us only the manufacturer string from usb, not the
quirk vendor name that the usb midi driver knows about).

What I would like to do is make these mappings explicit. Because Alsa is
very ioctl driven, I was thinking the way to do this is through the
existing ioctl API. But since I really just want to expose a lot more
read-only info about the system, perhaps files in /sys would be an
acceptable way to expose this information. At least, I would like to take
the rather detailed information stored in /prod/asound and expose this in a
more sysfs way via /sys, then add more fields and info. Does this sound
reasonable?



>
> How about an easy solution: just use "Linux".
> (IIRC this is what Microsoft's MME/WDM bridge driver does.)
>
>
Yes, that is a solution. :) But I think we can do better here.


>
> Regards,
> Clemens
>

Thanks,
Adam
