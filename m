From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for getting "manufacturer" from
 snd_seq_client_info and/or snd_ctl_card_info
Date: Sun, 11 May 2014 09:50:16 +0200
Message-ID: <536F2BB8.8060002@ladisch.de>
References: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CC0CC261A2C
 for <alsa-devel@alsa-project.org>; Sun, 11 May 2014 09:50:37 +0200 (CEST)
In-Reply-To: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
> I am doing a bit of work on the Alsa Web MIDI implementation in Chrome:
> https://code.google.com/p/chromium/issues/detail?id=344410
>
> Web MIDI likes to know the "manufacturer" field as part of its API:
> http://webaudio.github.io/web-midi-api/#attributes-3
>
> The current implementation in Chrome uses rawmidi, and then tries to parse
> out the manufacturer from the longname of the card. This works reasonably
> well, but is brittle and results in a lot of code.
>
> I am working on a seq implementation for Chrome, to replace the rawmidi
> implementation. I can retain the manufacturer extraction hack on the card,
> but seq requires yet another hack to guess the card for a particular seq
> client.

Did you test this with anything besides USB devices?

And software clients do not have a card.

> Any suggestions on how to extract the manufacturer more easily? The best
> solution would be to add a manufacturer (or vendor) field to the
> snd_seq_client_info ioctl struct.

Old clients would not know to set this field.

The Core MIDI documentation says:
| kMIDIPropertyManufacturer
|   Drivers *should* set this property on their devices.
|   Creators of virtual endpoints *may* set this property on their endpoints.

So what happens on OS X if this is not set?

> A completely different solution would be to add all this info to sysfs

USB devices already have this information in sysfs.


How about an easy solution: just use "Linux".
(IIRC this is what Microsoft's MME/WDM bridge driver does.)


Regards,
Clemens
