From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] davinci-evm: extend it to support DM81xx
	and derivatives
Date: Mon, 31 Jul 2017 11:18:31 +0200
Message-ID: <CAMJBoFNFAWkcaDJnPAW8AVynvFDkDob=A9EHdUD+a14EtmdZ6w@mail.gmail.com>
References: <20170712124318.39e5941b49d0da45602bd1c1@gmail.com>
 <c439ed79-1961-1781-1853-bcdc758592d3@ti.com>
 <CAMJBoFNxPsg8pjbWSc-vQQGKMPQOUQZ93=6NxY1YtzY1q16DfA@mail.gmail.com>
 <20170717145109.bwujyk66he2ehijc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 by alsa0.perex.cz (Postfix) with ESMTP id BD37A266CD2
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 11:18:34 +0200 (CEST)
Received: by mail-ua0-f196.google.com with SMTP id w45so23049264uac.3
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 02:18:34 -0700 (PDT)
In-Reply-To: <20170717145109.bwujyk66he2ehijc@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, trini@konsulko.com, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Jyri Sarah <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

2017-07-17 16:51 GMT+02:00 Mark Brown <broonie@kernel.org>:

> On Thu, Jul 13, 2017 at 07:26:43PM +0200, Vitaly Wool wrote:
> > 2017-07-13 10:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>
> > > While there are some users of davinci-evm.c, I think a majority are
> > > using simple-audio-card instead. Curious on why you chose not to use
> > > that. It sounds like codec is not the bitclock and frame-sync master in
> > > your case. Did that end up creating issues ?
>
> > Well, one of the problems with simple-audio-card is that you can't
> > snd_soc_dai_set_clkdiv() from it, neither you can set SND_SOC_CLK_OUT
> > for a codec, so for some codecs this just doesn't fit.
>
> That's no excuse, the CODEC drivers *really* shouldn't use _set_clkdiv()
> - fix the drivers to work normally.
>

Well that's not the only problem. CPU driver (davinci-mcasp) doesn't work
well with simple-audio-card either.

There's no good way to set SND_SOC_CLK_OUT for it if the clock is
fixed-rate. asoc_simple_card_init_dai()
initializes clocks to SND_SOCK_CLK_IN, and the only way you can change it
later is by calling asoc_simple_card_hw_params(). But that's not a real
match either, since it won't work with a fixed-rate clock.

So basically I can see 2 ways out here:
* extend davinci-evm driver to handle DM81xx (which is implemented in the
patch I've sent before)
* fix simple-card-utils so that it's possible to set SND_SOC_CLK_OUT in
asoc_simple_card_init_dai().

I would personally go the first way but if you prefer the 2nd, I can pursue
that track too.

Thanks in advance,

Best regards,
   Vitaly
