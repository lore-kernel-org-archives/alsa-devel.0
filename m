From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/9] ASoC: tlv320aic31xx: Fix typo in DT binding
 documentation
Date: Thu, 09 Nov 2017 15:25:17 +0100
Message-ID: <1510237517.7659.10.camel@pengutronix.de>
References: <20171108212505.28320-1-afd@ti.com>
         <20171108212505.28320-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171108212505.28320-2-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Andrew,

On Wed, 2017-11-08 at 15:24 -0600, Andrew F. Davis wrote:
> The property used to specify a GPIO intended for reset is "reset-gpio",
> this binding uses "gpio-reset", as almost all other bindings use the
> former name this use of the latter is certainly not intended and
> was a typo. It is not compatible with newer methods used to fetch
> GPIO pins and to prevent the spread of this error to other bindings
> lets fix this here.
> 
> We also standardize the pin as active-low, different device trees have
> marked the GPIO different ways, luckily the driver currently uses the
> low-level GPIO set function which does not respect the active-low flag,
> but future changes may change this. This is an active-low reset, mark
> it as such.
> 
> Lastly, add an example of use for this property.
> 
> Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> index 6fbba562eaa7..4c4e77f97d87 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> @@ -22,7 +22,7 @@ Required properties:
>  
>  Optional properties:
>  
> -- gpio-reset - gpio pin number used for codec reset

I would move this into a "Deprecated properties:" section instead of
just hiding it away.

> +- reset-gpio - GPIO specification for the active low RESET input.

This should be "reset-gpios". For reference, see
Documentation/devicetree/bindings/gpio/gpio.txt.

>  - ai31xx-micbias-vg - MicBias Voltage setting
>          1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
>          2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
> @@ -48,6 +48,7 @@ CODEC input pins:
>  The pins can be used in referring sound node's audio-routing property.
>  
>  Example:
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/sound/tlv320aic31xx-micbias.h>
>  
>  tlv320aic31xx: tlv320aic31xx@18 {
> @@ -56,6 +57,8 @@ tlv320aic31xx: tlv320aic31xx@18 {
>  
>  	ai31xx-micbias-vg = <MICBIAS_OFF>;
>  
> +	reset-gpio = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +
>  	HPVDD-supply = <&regulator>;
>  	SPRVDD-supply = <&regulator>;
>  	SPLVDD-supply = <&regulator>;

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
