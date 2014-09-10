From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCHv3 3/3] ASoC: simple-card: binding: update binding to
 support the new style.
Date: Wed, 10 Sep 2014 02:51:16 +0000
Message-ID: <755d5dc6d85243c0bd209aea49eef6c0@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409711021-19277-1-git-send-email-Li.Xiubo@freescale.com>
 <1409711021-19277-4-git-send-email-Li.Xiubo@freescale.com>
 <20140909120948.GZ2601@sirena.org.uk> <540EFFC9.4050207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540EFFC9.4050207-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "moinejf-GANU6spQydw@public.gmane.org" <moinejf-GANU6spQydw@public.gmane.org>, "andrew-g2DYL2Zd6BY@public.gmane.org" <andrew-g2DYL2Zd6BY@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> Subject: Re: [PATCHv3 3/3] ASoC: simple-card: binding: update binding to
> support the new style.
> 
> On 09/09/2014 03:09 PM, Mark Brown wrote:
> > On Wed, Sep 03, 2014 at 10:23:41AM +0800, Xiubo Li wrote:
> >> This update patch will split the DT node into old style and new style:
> >> The new style will will be easier to add muti DAI links from old single
> >> DAI link DTs.
> >
> >> This patch will maintian compatibility with the old DTs.
> >
> > Is everyone happy with this new style binding?
> >
> 
> If I read the diff correctly the only change in the syntax is moving the
> bitclock-inversion and frame-inversion properties to DAI nodes also for
> the new style bindings.
> 
> I am Ok with that.
> 
> The document does not indicate that the same properties could be also
> placed to DAI link level like they used to, from where they would apply
> to both DAI nodes.
> 

I will post one new version of this patch with some very small fix, and
I will also add this.

> I am Ok with this too, but this breaks the backwards compatibility,
> which I guess is generally considered a problem. However, I doubt anyone
> but me has yet used this part of the new syntax and I am happy to fix my
> dts files.
> 
> Best regards,
> Jyri
> 
> ps. I could not find the corresponding code changes in the previous
> patch, so I assume they are coming later.

Yes, I have one patch about the new style in my local machine, for some
reason I will post it later.

Thanks,

BRs
Xiubo



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
