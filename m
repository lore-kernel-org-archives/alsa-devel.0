From: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx: specify the value of audmux pinctrl
 instead of 0x80000000
Date: Fri, 15 Nov 2013 14:40:09 +0800
Message-ID: <20131115064009.GD745@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-2-git-send-email-b42378@freescale.com>
 <20131115064159.GG11014@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131115064159.GG11014-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: timur-N01EOCouUvQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2013 at 02:42:01PM +0800, Shawn Guo wrote:
> On Thu, Nov 14, 2013 at 07:07:09PM +0800, Nicolin Chen wrote:
> > We must specify the value of audmux pinctrl if we want to use pinctrl_pm().
> > Thus change bypass value 0x80000000 to what we exactly need.
> > 
> > This patch also seperately unset PUE bit for TXD so that IOMUX won't pull
> > up/down the pin after turning into tristate. When we use SSI normal mode to
> > playback monaural audio via I2S signal, there'd be a pulled curve occur to
> > its signal at the second slot if setting PUE bit for TXD. And it will make
> > the second channel to play a constant noise. So by keeping the signal level
> > in the second slot, we can get a constant high level signal (-1) or a low
> > level one (0).
> > 
> > Signed-off-by: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> We have moved all pin groups settings into
> arch/arm/boot/dts/imx6qdl-pingrp.h.  I just rebased and applied the
> patch.  Please check my imx/dt branch and ensure I applied the changes
> correctly.

Simply perfect. Thank you.
Nicolin

---


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
