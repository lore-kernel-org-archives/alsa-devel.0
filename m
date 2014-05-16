From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for getting "manufacturer" from
 snd_seq_client_info and/or snd_ctl_card_info
Date: Fri, 16 May 2014 09:26:02 +0200
Message-ID: <5375BD8A.2040201@ladisch.de>
References: <CAOf41NnbBTYrfN10GUcxzdHmKZJj0YT=DC3ntfjuhpb=fa+o=A@mail.gmail.com>	<536F2BB8.8060002@ladisch.de>	<CAOf41Nka_a8Y08MwERBKrZdKCUFo5-NhxR0ULHtUye4aUaOKXg@mail.gmail.com>	<5371E4D8.3030406@ladisch.de>	<s5hegzxiv0t.wl%tiwai@suse.de>
 <CAOf41N=cvQZv8ZaTKL6fhj98gywws0x+78CAYKuQJTh+YFBJ1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B9125261663
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 09:26:03 +0200 (CEST)
In-Reply-To: <CAOf41N=cvQZv8ZaTKL6fhj98gywws0x+78CAYKuQJTh+YFBJ1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@chromium.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
>> Clemens Ladisch wrote:
>>> 2. Add the manufacturer name to snd_ctl_card_info.  For USB devices,
>>>    this is almost always known, but most other drivers do not know the
>>>    name of the card manufacturer (as opposed to the chip manufacturer).
>>>    In those cases, the most informative name that a driver could provide
>>>    would be based on a registered ID like "USB:0x1234", "PCI:0x5678", or
>>>    "IEEE:0x9abcde".
>
> One question I have for step 2 above: snd_ctl_card_info is full. I
> don't see a way of adding to it without introducing a new ioctl
> (SNDRV_CTL_IOCTL_CARD_INFO2 + struct snd_ctl_card_info2?)

If you really want to avoid adding a new ioctl:  The numerical IDs are
just numbers, for which there is enough space in snd_ctl_card_info.  For
USB devices, the manufacturer name is part of the longname, so you'd
just need offset/length values.

And I'm not sure if it would be a good idea to expose the manufacturer
ID as a string.  Is that value supposed to be shown to the user, or just
some unique ID?


Regards,
Clemens
