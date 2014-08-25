From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/5] ASoC: fsl-asrc: Convert to use regmap framework's
 endianness method.
Date: Sun, 24 Aug 2014 19:13:50 -0700
Message-ID: <20140825021349.GC26651@Alpha>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-2-git-send-email-Li.Xiubo@freescale.com>
 <20140825012306.GA26651@Alpha>
 <ece08117aedf49eabd6660078432ed87@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ece08117aedf49eabd6660078432ed87-swgC6WJTr6EbUgZD/0KOGpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "timur-N01EOCouUvQ@public.gmane.org" <timur-N01EOCouUvQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 01:44:41AM +0000, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> Hi,
> 
> > Subject: Re: [PATCHv2 1/5] ASoC: fsl-asrc: Convert to use regmap framework's
> > endianness method.
> > 
> > On Tue, Aug 19, 2014 at 12:14:49PM +0800, Xiubo Li wrote:
> > > Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  sound/soc/fsl/fsl_asrc.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > index 8221104..3b14531 100644
> > > --- a/sound/soc/fsl/fsl_asrc.c
> > > +++ b/sound/soc/fsl/fsl_asrc.c
> > > @@ -802,10 +802,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
> > >
> > >  	asrc_priv->paddr = res->start;
> > >
> > > -	/* Register regmap and let it prepare core clock */
> > > -	if (of_property_read_bool(np, "big-endian"))
> > > -		fsl_asrc_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> > > -
> > 
> > What about the binding document? Could we also update that one
> > since this 'big-endian' is useless?
> > 
> > Thanks
> > Nicolin
> 
> No, the 'big-endian' is very useful still, deleting this because we are using
> The regmap framework's endianness method instead of its own here.
> 
> And the binding document, as we have discussed days ago, no need to update here.

Okay.. I think I've missed some topic here.

Thanks,
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
