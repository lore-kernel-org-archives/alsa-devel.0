From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 3/4] sound/soc/mxs/mxs-saif.c: add missing
	kfree
Date: Sun, 21 Aug 2011 12:57:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108211257040.4072@ask.diku.dk>
References: <1313820761-12042-3-git-send-email-julia@diku.dk>
	<20110820134439.GA2266@pengutronix.de>
	<Pine.LNX.4.64.1108201718200.30651@ask.diku.dk>
	<65EE16ACC360FA4D99C96DC085B3F7722212DF@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 08D452461A
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 12:57:26 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722212DF@039-SN1MPN1-001.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 21 Aug 2011, Dong Aisheng-B29396 wrote:

> > -----Original Message-----
> > From: Julia Lawall [mailto:julia@diku.dk]
> > Sent: Saturday, August 20, 2011 11:19 PM
> > To: Wolfram Sang
> > Cc: Liam Girdwood; kernel-janitors@vger.kernel.org; Mark Brown; Jaroslav
> > Kysela; Takashi Iwai; Dong Aisheng-B29396; alsa-devel@alsa-project.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/4] sound/soc/mxs/mxs-saif.c: add missing kfree
> > 
> > From: Julia Lawall <julia@diku.dk>
> > 
> > Move the test on pdev->id before the kzalloc to avoid requiring kfree
> > when the test fails.  This fix was suggested by Wolfram Sang.
> > 
> > A simplified version of the semantic match that finds this problem is as
> > follows: (http://coccinelle.lip6.fr/)
> > 
> > // <smpl>
> > @@
> > identifier x;
> > expression E1!=0,E2,E3,E4;
> > statement S;
> > iterator I;
> > @@
> > 
> > (
> > if (...) { ... when != kfree(x)
> >                when != x = E3
> >                when != E3 = x
> > *  return ...;
> >  }
> > ... when != x = E2
> >     when != I(...,x,...) S
> > if (...) { ... when != x = E4
> >  kfree(x); ... return ...; }
> > )
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> > 
> > ---
> > diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c index
> > 0b3adae..e9a90e4 100644
> > --- a/sound/soc/mxs/mxs-saif.c
> > +++ b/sound/soc/mxs/mxs-saif.c
> > @@ -519,12 +519,11 @@ static int mxs_saif_probe(struct platform_device
> > *pdev)
> >  	struct mxs_saif *saif;
> >  	int ret = 0;
> > 
> > +	if (pdev->id >= ARRAY_SIZE(mxs_saif))
> > +		return -EINVAL;
> >  	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
> >  	if (!saif)
> >  		return -ENOMEM;
> > -
> > -	if (pdev->id >= ARRAY_SIZE(mxs_saif))
> > -		return -EINVAL;
> >  	mxs_saif[pdev->id] = saif;
> > 
> >  	saif->clk = clk_get(&pdev->dev, NULL);
> 
> Thanks for the finding, Julia.
> It's ok to me.
> 
> BTW I guess you may need to resend a new version patch instead of following it
> in this mail thread. :)
> If yes, one minus thing, add one blank line below the line of 'return -ENOMEM'
> may look more comfortable.

OK, I will do both.

Thanks,
julia
