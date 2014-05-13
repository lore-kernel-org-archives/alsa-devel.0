From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for getting "manufacturer" from
 snd_seq_client_info and/or snd_ctl_card_info
Date: Tue, 13 May 2014 11:24:40 +0200
Message-ID: <5371E4D8.3030406@ladisch.de>
References: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>	<536F2BB8.8060002@ladisch.de>
 <CAOf41Nka_a8Y08MwERBKrZdKCUFo5-NhxR0ULHtUye4aUaOKXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 567752651C0
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 11:24:40 +0200 (CEST)
In-Reply-To: <CAOf41Nka_a8Y08MwERBKrZdKCUFo5-NhxR0ULHtUye4aUaOKXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
> On Sun, May 11, 2014 at 12:50 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Adam Goode wrote:
> > > I am working on a seq implementation for Chrome, to replace the rawmidi
> > > implementation. I can retain the manufacturer extraction hack on the card,
> > > but seq requires yet another hack to guess the card for a particular seq
> > > client.
> > >
> > > A completely different solution would be to add all this info to sysfs
>
> > USB devices already have this information in sysfs.
>
> This is true. Unfortunately, here are the current steps to get this
> information:
> 1. Given a seq client, attempt to guess the card by making assumptions
>    about client->card numbering.
> 2. From the card, attempt to guess the manufacturer by making
>    assumptions about how longname is constructed. Or, attempt to
>    extract the usb information from the card info struct and then try
>    to get the info from /sys (but this gives us only the manufacturer
>    string from usb, not the quirk vendor name that the usb midi driver
>    knows about).
>
> What I would like to do is make these mappings explicit. Because Alsa
> is very ioctl driven, I was thinking the way to do this is through the
> existing ioctl API. But since I really just want to expose a lot more
> read-only info about the system, perhaps files in /sys would be an
> acceptable way to expose this information.

The ioctl API (and the library API on top of it) already exists.  Why
do you want to introduce another kind of API that cannot be used for
virtual devices?

> At least, I would like to take the rather detailed information stored
> in /prod/asound and expose this in a more sysfs way via /sys, then add
> more fields and info. Does this sound reasonable?

Almost all the information in /proc/asound is already available through
some ioctl, and the missing information can be added easily.


OK, here is my proposal:

1. Add the card number to snd_seq_client_info.  (For kernel drivers;
   user clients might have the PID here while we're at it.)

   (As long as you are interested only in USB devices, this might be all
   you need.)

2. Add the manufacturer name to snd_ctl_card_info.  For USB devices,
   this is almost always known, but most other drivers do not know the
   name of the card manufacturer (as opposed to the chip manufacturer).
   In those cases, the most informative name that a driver could provide
   would be based on a registered ID like "USB:0x1234", "PCI:0x5678", or
   "IEEE:0x9abcde".  (It's possible to look these up in usb.ids, pci.ids,
   and oui.txt, but I'm not sure if it would be a good idea to let
   alsa-lib do this lookup.)


Regards,
Clemens
