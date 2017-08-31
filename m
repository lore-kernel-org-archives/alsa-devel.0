From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 10:23:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708311020340.3243@hadrien>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id CA985267256
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 10:23:46 +0200 (CEST)
In-Reply-To: <20170831081021.g4luo557ggtnyfyg@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, garsilva@embeddedor.com, kernel-janitors@vger.kernel.org, nicolas.ferre@microchip.com, tiwai@suse.com, broonie@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, arvind.yadav.cs@gmail.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org



On Thu, 31 Aug 2017, Alexandre Belloni wrote:

> On 31/08/2017 at 06:40:42 +0200, Christophe JAILLET wrote:
> > If 'clk_prepare_enable()' fails, we must release some resources before
> > returning. Add a new label in the existing error handling path and 'goto'
> > there.
> >
> > Fixes: 260ea95cc027 ("ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> And here is the fallout of the stupid, brainless "fixing" of issues
> reported by static analysis tools.
>
> This clk_prepare_enable will never fail. If it was going to fail, the
> platform would never boot to a point were it is able to execute that
> code. It is really annoying to have so much churn for absolutely 0
> benefit.

Would it be more productive to put the code back like it was before, ie no
return value and no check, and add a comment to the definition of
clk_prepare_enable indicating that there are many case where the call
cannot fail?  Grepping through the code suggests that it is about 50-50 on
checking the return value or not doing so, which might suggest that
checking the value is often not required.

julia

>
> Anyway,
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> > ---
> >  sound/atmel/ac97c.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> > index 30c64ab210d9..5ffefac2fa8f 100644
> > --- a/sound/atmel/ac97c.c
> > +++ b/sound/atmel/ac97c.c
> > @@ -785,7 +785,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
> >  	}
> >  	retval = clk_prepare_enable(pclk);
> >  	if (retval)
> > -		return retval;
> > +		goto err_prepare_enable;
> >
> >  	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
> >  			      SNDRV_DEFAULT_STR1, THIS_MODULE,
> > @@ -881,6 +881,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
> >  	snd_card_free(card);
> >  err_snd_card_new:
> >  	clk_disable_unprepare(pclk);
> > +err_prepare_enable:
> >  	clk_put(pclk);
> >  	return retval;
> >  }
> > --
> > 2.11.0
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
