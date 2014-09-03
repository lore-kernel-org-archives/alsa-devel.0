From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [alsa-devel] [PATCHv2 3/4] ASoC: simple-card: Adjust the comments
 of simple card.
Date: Wed, 3 Sep 2014 02:24:07 +0000
Message-ID: <92afbaa4e7fd40f0a9a26dd89d350f53@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
	<1409649969-15759-4-git-send-email-Li.Xiubo@freescale.com>
	<20140902124438.36da4b85@armhf>
	<37e5ba204cb340bc9fe01b7473721a9d@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <87zjeh5u2o.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zjeh5u2o.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "andrew-g2DYL2Zd6BY@public.gmane.org" <andrew-g2DYL2Zd6BY@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jsarha-l0cyMroinI0@public.gmane.org" <jsarha-l0cyMroinI0@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [alsa-devel] [PATCHv2 3/4] ASoC: simple-card: Adjust the comments
> of simple card.
> 
> 
> Hi Xiubo
> 
> > > >  	/*
> > > > -	 * soc_bind_dai_link() will check cpu name
> > > > -	 * after of_node matching if dai_link has cpu_dai_name.
> > > > -	 * but, it will never match if name was created by
> fmt_single_name()
> > > > -	 * remove cpu_dai_name to escape name matching.
> > > > -	 * see
> > > > +	 * In soc_bind_dai_link() will check cpu name after
> > > > +	 * of_node matching if dai_link has cpu_dai_name.
> > > > +	 * but, it will never match if name was created by
> > > > +	 * fmt_single_name() remove cpu_dai_name to escape
> > > > +	 * name matching. Please see:
> > > >  	 *	fmt_single_name()
> > > >  	 *	fmt_multiple_name()
> > > >  	 */
> > >
> > > The patch done by Kuninori, setting the cpu_dai_name to NULL in all
> > > cases, does not work. This sequence should be replaced where is was
> > > previously.
> > >
> >
> > If so, it should be another issue here, should we send another patch for
> > It ?
> 
> I posted patch yesterday, and Jean tested it
> 
> Subject: [PATCH][RFC] ASoC: simple-card: fixup cpu_dai_name clear case
> Date: Tue, 02 Sep 2014 20:05:32 +0900
> 

Nice.

I think I just missed it.

Thanks,

BRs
Xiubo


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
