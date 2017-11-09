From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: tlv320aic3x: Fix typo in DT
 binding documentation
Date: Thu, 9 Nov 2017 21:26:00 +0100
Message-ID: <CA+sos78vOjcY=9B3-pFthe9UUBqiEUps967UDEY=o=fUu230=Q@mail.gmail.com>
References: <20171108212505.28320-1-afd@ti.com> <20171108212505.28320-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171108212505.28320-3-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Dear Andrew F. Davis,

On Wed, Nov 8, 2017 at 10:24 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
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
> Fixes: c24fdc886fde ("ASoC: tlv320aic3x: Add device tree bindings")
>
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Do=
cumentation/devicetree/bindings/sound/tlv320aic3x.txt
> index ba5b45c483f5..9e8eaa08ce90 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> @@ -17,7 +17,7 @@ Required properties:
>
>  Optional properties:
>
> -- gpio-reset - gpio pin number used for codec reset
> +- reset-gpio - GPIO specification for the active low RESET input.
>  - ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Function=
ality
>                                     - Not supported on tlv320aic3104
>  - ai3x-micbias-vg - MicBias Voltage required.
> @@ -61,10 +61,14 @@ The pins can be used in referring sound node's audio-=
routing property.
>
>  Example:
>
> +#include <dt-bindings/gpio/gpio.h>
> +
>  tlv320aic3x: tlv320aic3x@1b {
>         compatible =3D "ti,tlv320aic3x";
>         reg =3D <0x1b>;
>
> +       reset-gpio =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> +
>         AVDD-supply =3D <&regulator>;
>         IOVDD-supply =3D <&regulator>;
>         DRVDD-supply =3D <&regulator>;

According to Documentation/devicetree/bindings/gpio/gpio.txt:
"GPIO properties should be named "[<name>-]gpios", with <name> being the pu=
rpose
of this GPIO for the device. While a non-existent <name> is considered vali=
d
for compatibility reasons (resolving to the "gpios" property), it is not al=
lowed
for new bindings. Also, GPIO properties named "[<name>-]gpio" are valid and=
 old
bindings use it, but are only supported for compatibility reasons and shoul=
d not
be used for newer bindings since it has been deprecated."

So it should be "reset-gpios" for new bindings.

Also, sound/soc/codecs/tlv320aic3x.c still uses "gpio-reset", and I do
not see any patch in your series changing this:
ret =3D of_get_named_gpio(np, "gpio-reset", 0);

Same remarks for your "[PATCH 6/9] ARM: dts: imx: Fix the audio
CODEC's reset pin". I don't know if there are other DTS files using
this, but they should all be updated accordingly. This would anyway
break all of the out-of-tree DTS files using this, which I think is
not allowed, so the driver should be changed in a way still allowing
the legacy naming besides the new one.

Best regards,
Beno=C3=AEt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
