From: Allan Klinbail <aklinbail@gmail.com>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 00:14:44 +0000
Message-ID: <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 06BC3264F0D
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 02:14:54 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id n3so106817621wmn.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 17:14:53 -0700 (PDT)
In-Reply-To: <57181862.6060501@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi ,

It was my understanding that FFADO would eventually be deprecated,  so am
trying to provide test feedback for my device.  I thought comparable
performance would be a goal.

It was late last night when I was testing so I apologise if I sounded
ungrateful.

Using ALSA is desirable as I have a large number of MIDI devices (2*AMT 8)
and 3 other control devices..  Using ALSA provides better connectivity than
a2jmidi..

I will try alsa in,  plug.. I am concerned though this is not an ideal
solution due to trying to sync multiple devices which in reality share a
clock..  Adding even more latency..

I will continue using FFADO for production work,  but am happy to keep
testing if you believe improvements can be made
On Thu, 21 Apr 2016 10:01 am Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Apr 21 2016 01:03, Allan Klinbail wrote:
> > It provides this as separate devices so I cannot access all channels at
> > the same time in jack as in FFADO.
> >
> > Although I don't typically use the ADAT ports other might, however I am
> > always using a combination of channels 1-16 and channels 17 & 18
> > combined, sometimes all of them.
> > The device is a hardware mixing desk and all ports are designed to be
> > used simultaneously..
>
> Use 'alsa_in' and 'alsa_out' as JACK clients, to use several ALSA PCM
> character devices in one JACK session. See:
> http://jackaudio.org/faq/multiple_devices.html
>
>
> > Latency performance is also much worse. FFADO will allow a buffer size
> > of 64, ALSA will not start below 256.
> > I prefer to work at 128 or lower.
>
> If you think that FFADO implementation is suitable to your usage, and
> you believe that it's really proper for IEC 61883-1/6, please use it.
> ALSA firewire stack is just one of your available options in Linux-based
> system.
>
>
> > root@kxdaw:/home/allan/Downloads#  cat /proc/asound/card1/dice
> > sections:
> >   global: offset 10, size 95
> > ...
> > global:
> > ...
> >   version: 1.0.11.0
>
> Hm. The global register has 95 quadlets. It has extra 5 quadlets as what
> we know. What information is in the extra fields, I don't know exactly,
> but I can confirm it in my Focusrite Saffire Pro 26 (interface version
> 1.0.12.0).
>
> On Saffire Pro 26:
> $ cat /proc/asound/card1/dice
> sections:
>   global: offset 10, size 95
> ...
> global:
> ...
>   version: 1.0.12.0
>
> $ ./firewire-request /dev/fw1 read 0xffffe0000190 14
> result: 000: 00 00 00 07 00 00 00 02 00 00 00 00 00 00 00 00
> result: 010: 00 00 00 00
>
> In short:
> 0x'ffff'e000'0190: 0x00000007
> 0x'ffff'e000'0194: 0x00000002
> 0x'ffff'e000'0198: 0x00000000
> 0x'ffff'e000'019c: 0x00000000
> 0x'ffff'e000'01a0: 0x00000000
>
> If you can't have enough consideration about this kind of work, I'd like
> you to use FFADO, by blacklisting snd-dice, please.
>
>
> Regards
>
> Takashi Sakamoto
>
