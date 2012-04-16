From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Fast Track Ultra mixer - opinions anyone?
Date: Mon, 16 Apr 2012 21:11:52 +1000
Message-ID: <CACckToVQ6Gm5th91-vyPugSGAPuWp9ZDDdZLqGerHWT==apHRQ@mail.gmail.com>
References: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 10418104094
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 13:11:53 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so3729871wgb.20
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 04:11:52 -0700 (PDT)
In-Reply-To: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2012 at 8:38 PM, Felix Homann <linuxaudio@showlabor.de>wrote:

> re-sending to everyone...
>
> [SNIP]
>
> ** Effects **
>
> Essentially, with the attached patch you can control everything but
> the effect program. The switch should not be too hard to implement.
> But before I put any more work on it I would like to ask wether it
> makes sense at all.
>
> IMO, the effect section on the FTUs really sucks. I can't believe that
> anybody can really use it in a reasonable way. So should we really add
> another 40 controls to the mixer which can cause a lot of pain when
> misadjusted (i.e. anything else but 0)?
>
> For those reasons I would prefer not to put effect support in the
> kernel. What do you think?
>

Nope it absolutely should be supported to fully support the device.

They're for monitoring if used as intended... ie: when doing hardware based
monitoring.

>
> ** dB values **
>
> Currently alsamixer does not report any dB changes when you change a
> control value. I  don't know how to fix it. Anyone else?
>
>
What does dB value mean in this context given there's a hardware volume
knob on the device? is it just the db difference or is supposed to be some
sort of dBm absolute output level

the specs say that the output at the rear of the device is +10 dBm balanced
and +1.8dBu unbalanced

and the headphones are 0dBm into 32 ohms


> ** Naming scheme again **
>
> Once again, is everyone pleased with the current naming scheme?
>
>
> I think it's ok. I still think we need some better tools. but with 16*8
controls now and another 4x8 for effects + effect select and misc controls
like clock select I think some better ui is necessary.

>
>
>
