From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Sun, 30 Aug 2015 21:54:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1508302152300.2062@localhost6.localdomain6>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr> <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr> <55E35169.3000703@bfs.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <55E35169.3000703@bfs.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: walter harms <wharms@bfs.de>
Cc: Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Sun, 30 Aug 2015, walter harms wrote:

> 
> 
> Am 30.08.2015 20:05, schrieb Julia Lawall:
> > Apply PTR_ERR to the value that was recently assigned.
> > 
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @@
> > expression x,y;
> > @@
> > 
> > if (IS_ERR(x) || ...) {
> >   ... when any
> >       when != IS_ERR(...)
> > (
> >    PTR_ERR(x)
> > |
> > *  PTR_ERR(y)
> > )
> >   ... when any
> > }
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > ---
> >  sound/soc/qcom/lpass-cpu.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> > index 23f3d59..94beb99 100644
> > --- a/sound/soc/qcom/lpass-cpu.c
> > +++ b/sound/soc/qcom/lpass-cpu.c
> > @@ -438,7 +438,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
> >  		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
> >  			dev_err(&pdev->dev,
> >  				"%s() error getting mi2s-bit-clk: %ld\n",
> > -				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
> > +				__func__,
> > +				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
> >  			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
> >  		}
> >  	}
> > 
> 
> just a note:
> using a shorter name instead of drvdata->mi2s_bit_clk[dai_id] whould help to make the code
> more readable (yes, the other code is alike). something like:
> 
> struct clk *tmp =  devm_clk_get(&pdev->dev,clk_name);

Where do you suggest to put this?

Maybe it would be reasonable to declare a variable struct clk *clk; at the 
top of the function, and then use that as a temporary variable for all 
three calls.

However, now I see that the first call, unlike the other two doesn't cause 
a return from the function.

                if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
                        dev_warn(&pdev->dev,
                                "%s() error getting mi2s-osr-clk: %ld\n",
				__func__,
		                PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
                }

Is that intentional?

thanks,
julia

> if (IS_ERR(tmp)) {
> 	dev_err(&pdev->dev,"%s() error getting mi2s-bit-clk: %ld\n",__func__, PTR_ERR(tmp));
>         return PTR_ERR(tmp);
> }
> drvdata->mi2s_bit_clk[dai_id]=tmp;
> 
> 
> just one minor:
> the dev_warn() just before says: " error getting mi2s-osr-clk" may be it should be "warnig ..."
> That will make it more easy to rep for real error in a log.
> 
> re,
>  wh
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
