From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
Date: Sat, 2 Dec 2017 19:17:47 -0200
Message-ID: <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
References: <20171201224425.5477-1-peda@axentia.se> <20171201224425.5477-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171201224425.5477-2-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 1, 2017 at 8:44 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
> Add record for NXP TFA9879 Mono BTL Class D audio amplifier.
>
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index af284fbd4d23..4cf30ce4e71f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -157,6 +157,7 @@ nxp,pcf2127         Real-time clock
>  nxp,pcf2129            Real-time clock
>  nxp,pcf8563            Real-time clock/calendar
>  nxp,pcf85063           Tiny Real-Time Clock
> +nxp,tfa9879            Mono BTL Class D audio amplifier

This is already described at Documentation/devicetree/bindings/sound/tfa9879.txt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
