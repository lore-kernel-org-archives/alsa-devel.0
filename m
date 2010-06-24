From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: uda134x: replace a macro with a
 value in platform struct.
Date: Thu, 24 Jun 2010 17:39:23 +0100
Message-ID: <1277397563.3100.235.camel@odin>
References: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
	<1277387370.3100.214.camel@odin>
	<AANLkTikquGAdo2gnKeIjF-KqJGoaLWTVEcG0peGiTZh3@mail.gmail.com>
	<1277395558.3100.224.camel@odin>
	<AANLkTikoYKDxeTlsD3TL7SgJnPnWGmBQF29phfcuCfDb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EDBC010382E
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 18:39:21 +0200 (CEST)
Received: by wwb39 with SMTP id 39so320427wwb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 09:39:21 -0700 (PDT)
In-Reply-To: <AANLkTikoYKDxeTlsD3TL7SgJnPnWGmBQF29phfcuCfDb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-24 at 20:21 +0400, Vladimir Zapolskiy wrote:
> On Thu, Jun 24, 2010 at 8:05 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Thu, 2010-06-24 at 19:54 +0400, Vladimir Zapolskiy wrote:
> >> Hi,
> >>
> >> On Thu, Jun 24, 2010 at 5:49 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> >> > On Thu, 2010-06-24 at 17:38 +0400, Vladimir Zapolskiy wrote:
> >
> >> >> @@ -559,9 +546,11 @@ static int uda134x_soc_probe(struct platform_device *pdev)
> >> >>       codec->num_dai = 1;
> >> >>       codec->read = uda134x_read_reg_cache;
> >> >>       codec->write = uda134x_write;
> >> >> -#ifdef POWER_OFF_ON_STANDBY
> >> >> -     codec->set_bias_level = uda134x_set_bias_level;
> >> >> -#endif
> >> >> +
> >> >> +     if (!pd->is_powered_on_standby) {
> >> >> +             codec->set_bias_level = uda134x_set_bias_level;
> >> >
> >> > The codec ops pointers have moved in multi-component. Can you put this
> >> > check in your uda134x_set_bias_level() instead.
> >> >
> >> Not sure I understand the problem, and I do not see a simple solution
> >> for actual bugfix in patch 2/2, if this check is placed in
> >> uda134x_set_bias_level(). Please could you provide me with a hint or
> >> link to some codec source file?
> >
> > I was meaning something like :-
> >
> > uda134x_set_bias_level()
> > {
> >        if (pd->is_powered_on_standby)
> >                return
> >
> >        /* rest of func */
> >
> > }
> >
> Thank you, good that I meant the same. But that makes quite impossible
> to set a mandatory bias level on initialization without additional code
> complication.
> 

Sorry, I'm just trying to make the multi-component merge simpler here.

The multi-component branch is here :-

http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-2.6.git;a=shortlog;h=refs/heads/topic/multi-component

I'll merge this myself later.

> > The multi-component branch makes codec->set_bias_level a driver level
> > operation (that can be shared amongst other uda134x codec devices so we
> > cant change this at runtime)
> >
> Looks like I miss something, because in codec drivers I observe
> codec->set_bias_level is set in probe function, like it is in uda134x.
> 
> Would it be better just to drop a condition of pd->is_powered_on_standby?
> What do you think?

Both looks fine.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
