From: Adam Goode <agoode@chromium.org>
Subject: Re: Support for getting "manufacturer" from
 snd_seq_client_info and/or snd_ctl_card_info
Date: Tue, 20 May 2014 23:23:58 -0400
Message-ID: <CAOf41NkVoCiUruSZyAPYB4PzEjPLRtU2g2byhn6F_OJ7LgCVrw@mail.gmail.com>
References: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>
 <536F2BB8.8060002@ladisch.de>
 <CAOf41Nka_a8Y08MwERBKrZdKCUFo5-NhxR0ULHtUye4aUaOKXg@mail.gmail.com>
 <5371E4D8.3030406@ladisch.de> <s5hegzxiv0t.wl%tiwai@suse.de>
 <CAOf41N=cvQZv8ZaTKL6fhj98gywws0x+78CAYKuQJTh+YFBJ1w@mail.gmail.com>
 <5375BD8A.2040201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5967726552A
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 05:24:00 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id at1so1456548iec.28
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 20:23:59 -0700 (PDT)
In-Reply-To: <5375BD8A.2040201@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Adam Goode <agoode@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 16, 2014 at 3:26 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Adam Goode wrote:
> >> Clemens Ladisch wrote:
> >>> 2. Add the manufacturer name to snd_ctl_card_info.  For USB devices,
> >>>    this is almost always known, but most other drivers do not know the
> >>>    name of the card manufacturer (as opposed to the chip manufacturer).
> >>>    In those cases, the most informative name that a driver could
> provide
> >>>    would be based on a registered ID like "USB:0x1234", "PCI:0x5678",
> or
> >>>    "IEEE:0x9abcde".
> >
> > One question I have for step 2 above: snd_ctl_card_info is full. I
> > don't see a way of adding to it without introducing a new ioctl
> > (SNDRV_CTL_IOCTL_CARD_INFO2 + struct snd_ctl_card_info2?)
>
> If you really want to avoid adding a new ioctl:  The numerical IDs are
> just numbers, for which there is enough space in snd_ctl_card_info.  For
> USB devices, the manufacturer name is part of the longname, so you'd
> just need offset/length values.
>
> And I'm not sure if it would be a good idea to expose the manufacturer
> ID as a string.  Is that value supposed to be shown to the user, or just
> some unique ID?
>
>
For Web MIDI, we don't actually need the USB ids, but it is good to have
these available. snd_ctl_card_info already has these encoded via the
components field:

$ ./alsa-lib/test/control

Soundcard #1:
  card - 0
  id - 'UX16'
  driver - 'USB-Audio'
  name - 'UX16'
  longname - 'Yamaha UX16 at usb-0000:00:14.0-10, full speed'
  mixername - ''
  components - 'USB0499:1009'
RAWMIDI info, device #0:
  device - 0
  subdevice - 0
  stream - 0
  card - 0
  flags - 0x7
  id - 'USB MIDI'
  name - 'UX16'
  subname - 'UX16 MIDI 1'
  subdevices count - 1
  subdevices avail - 0
 ...

For getting manufacturer, it is an interesting idea to encode the offset
and length for extraction from longname. I have no problem with creating a
new ioctl though, which seems cleaner, if that is acceptable.

The manufacturer string is just a string, to be presented to the user. It
is not a unique/opaque id.



Adam
