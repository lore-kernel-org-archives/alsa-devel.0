From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/9] ARM: dts: am335x-pepper: Fix the audio CODEC's
 reset pin
Date: Thu, 09 Nov 2017 15:25:21 +0100
Message-ID: <1510237521.7659.11.camel@pengutronix.de>
References: <20171108212505.28320-1-afd@ti.com>
         <20171108212505.28320-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171108212505.28320-5-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-11-08 at 15:25 -0600, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpio", fix this here.
> 
> Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 03c7d77023c6..d652abd76333 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -139,7 +139,7 @@
>  &audio_codec {
>  	status = "okay";
>  
> -	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +	reset-gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;

This potentially breaks audio on am335x-pepper until the driver patches
are applied, same for the other device trees. To make this bisectable,
add support for the new property name to the driver before changing the
device trees.

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
