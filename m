From: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
Date: Fri, 15 Nov 2013 10:59:57 +0800
Message-ID: <20131115025956.GA745@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <20131115030247.GC11014@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131115030247.GC11014-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: timur-N01EOCouUvQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Shawn,
   
On Fri, Nov 15, 2013 at 11:02:49AM +0800, Shawn Guo wrote:
> On Thu, Nov 14, 2013 at 07:07:08PM +0800, Nicolin Chen wrote:
> > This series of patches need to be applied into one single tree because
> > the second patch depends on the first one. Without it, SSI would playback
> > constant noise to the right channel when playback monaural audio files on
> > i.MX6 Series board.
> 
> Let me try to understand if the dependency is true.
> 
> Saying I apply the DTS patch on IMX tree while Mark apply the fsl_ssi
> patch on his tree, will there be any regression on either IMX tree or
> Mark's tree?  The monaural playback on imx6qdl never worked, so it's not
> a regression.  If there is no regression on either tree, there is no
> dependency to maintain.

It's fair enough to understand in this way. It looks like I misunderstood
the dependency here.

Do I need to resend them separately?

Thank you.

> 
> Shawn
> 
> > 
> > We might also need to apply the iomux change to the other i.MX platforms,
> > just currently I don't have those boards so I drop their changes for now.
> > 
> > Nicolin Chen (2):
> >   ARM: dts: imx: specify the value of audmux pinctrl instead of
> >     0x80000000
> >   ASoC: fsl_ssi: Add monaural audio support for non-ac97 interface
> > 
> >  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
> >  sound/soc/fsl/fsl_ssi.c        | 22 +++++++++++++++++++---
> >  2 files changed, 30 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 1.8.4
> > 
> > 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
