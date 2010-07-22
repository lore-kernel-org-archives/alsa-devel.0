From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Fix
 compile error when registering a DAI
Date: Thu, 22 Jul 2010 12:42:24 +0100
Message-ID: <1279798944.3083.41.camel@odin>
References: <4C47D3A3.9000102@samsung.com>
	<AANLkTiluZwni88uY6WtwKkB9Qpm2ECz_37z5_bUY1jII@mail.gmail.com>
	<4C47F723.4090506@samsung.com>
	<AANLkTiksuBsdZ7LslGhRqxoDyLry579OxNMJ7X3bhrAb@mail.gmail.com>
	<4C47FBAE.5040106@samsung.com>
	<AANLkTin660THXzF3MXTEMbscB84Axd-roKgZnIfcK1O3@mail.gmail.com>
	<1279793752.3083.40.camel@odin>
	<AANLkTikm9zVF-eiPZAkAsjcSo-6u_BRYKCROjX3lQUCK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E2D3E24386
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:42:27 +0200 (CEST)
Received: by wwb22 with SMTP id 22so1725447wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 04:42:27 -0700 (PDT)
In-Reply-To: <AANLkTikm9zVF-eiPZAkAsjcSo-6u_BRYKCROjX3lQUCK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-22 at 19:43 +0900, Seungwhan Youn wrote:
> On Thu, Jul 22, 2010 at 7:15 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Thu, 2010-07-22 at 17:26 +0900, Seungwhan Youn wrote:
> >> >>>>> +       return snd_soc_register_dai(dev, drv);
> >> >>>> How about s3c64xx-i2s? I think, if this patch fixes all errors in
> >> >>> Sorry, I confused your comment.
> >> >>> What do you mean "How about s3c64xx-i2s" ?
> >> >>
> >> >> Actually 'sound/soc/s3c24xx/s3c64xx-i2s.c' has same error.
> >> >>
> >> >> So, If this patch's purpose is to fix compile error, my opinion is
> >> >> that this patch fix all the same errors in 'sound/soc/s3c24xx/'.
> >> >
> >> > The 'sound/soc/s3c24xx/s3c64xx-i2s.c' haven't directly called
> >> > 'snd_soc_register_dai()' function.
> >> > It is call 's3c_i2sv2_register_dai()' in 'sound/soc/s3c24xx/s3c-i2s-v2.c'
> >> > to register a DAI.
> >> >
> >>
> >> Oh, I was confused about this even I modify this few days ago.
> >> I'm sorry that I make you to be confused.
> >>
> >
> > I'm confused too ;)
> >
> > Is this to be applied or not ?
> 
> I think this okay. :)
> 
All applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
