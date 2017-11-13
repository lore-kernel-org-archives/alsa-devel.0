From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/9] ASoC: cs42l56: bindings: sound: Fix reset GPIO name
 in example DT binding
Date: Mon, 13 Nov 2017 15:20:47 -0600
Message-ID: <20171113212047.dx6n2ko4q42fcznz@rob-hp-laptop>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171108212505.28320-4-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 03:24:59PM -0600, Andrew F. Davis wrote:
> The binding states the reset GPIO property shall be named
> "cirrus,gpio-nreset" and this is what the driver looks for,
> but the example uses "gpio-reset". Fix this here.
> 
> Fixes: 3bb40619aca8 ("ASoC: cs42l56: bindings: sound: Add bindings for CS42L56 CODEC")
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/cs42l56.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt b/Documentation/devicetree/bindings/sound/cs42l56.txt
> index 4feb0eb27ea4..4ba520a28ae8 100644
> --- a/Documentation/devicetree/bindings/sound/cs42l56.txt
> +++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
> @@ -55,7 +55,7 @@ Example:
>  codec: codec@4b {
>  	compatible = "cirrus,cs42l56";
>  	reg = <0x4b>;
> -	gpio-reset = <&gpio 10 0>;
> +	cirrus,gpio-nreset = <&gpio 10 0>;

Can we deprecate this and use reset-gpios instead?

>  	cirrus,chgfreq-divisor = <0x05>;
>  	cirrus.ain1_ref_cfg;
>  	cirrus,micbias-lvl = <5>;
> -- 
> 2.15.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
