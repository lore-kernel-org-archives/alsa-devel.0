From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/5] ASoC: fsl-asrc: Convert to use regmap framework's
 endianness method.
Date: Sun, 24 Aug 2014 19:48:24 -0700
Message-ID: <20140825024823.GB28441@Alpha>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-2-git-send-email-Li.Xiubo@freescale.com>
 <20140825012306.GA26651@Alpha>
 <ece08117aedf49eabd6660078432ed87@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140825021349.GC26651@Alpha>
 <12fb3eca298842929a782e80a9cf6fbc@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <12fb3eca298842929a782e80a9cf6fbc-swgC6WJTr6EbUgZD/0KOGpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "timur-N01EOCouUvQ@public.gmane.org" <timur-N01EOCouUvQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 02:29:32AM +0000, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> > > No, the 'big-endian' is very useful still, deleting this because we are
> > using
> > > The regmap framework's endianness method instead of its own here.
> > >
> > > And the binding document, as we have discussed days ago, no need to update
> > here.
> > 
> > Okay.. I think I've missed some topic here.
> > 
> 
> Please refer to the following patches about this:
> 
> regmap: add DT endianness binding support.
> regmap: Add the DT binding documentation for endianness
> And also two of other patches to fix some bugs of these.
> 

Great. Thank you :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
