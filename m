From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 1/7] ASoC: davinci-mcbsp: add binding for McBSP
Date: Wed, 20 Apr 2016 08:49:20 +0200
Message-ID: <CAMuHMdVCW0zAxAZRTazVhXz72fkp_escQM2JTSX2J4Ertru==Q@mail.gmail.com>
References: <1460982766-18632-1-git-send-email-petr@barix.com>
	<1460982766-18632-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460982766-18632-2-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 18, 2016 at 2:32 PM, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
> @@ -0,0 +1,51 @@

> +Optional properties:
> +~~~~~~~~~~~~~~~~~~~~
> +- interrupts : Interrupt numbers for McBSP
> +- interrupt-names : Known interrupt names are "rx" and "tx"
> +
> +- pinctrl-0: Should specify pin control group used for this controller.
> +- pinctrl-names: Should contain only one value - "default", for more details
> +        please refer to pinctrl-bindings.txt
> +
> +Example (AM1808):
> +~~~~~~~~~~~~~~~~~
> +
> +mcbsp0: mcbsp@1d10000 {
> +       compatible = "ti,da850-mcbsp";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mcbsp0_pins>;
> +
> +       reg =   <0x00110000 0x1000>,
> +               <0x00310000 0x1000>;
> +       reg-names = "mpu", "dat";
> +       interrupts = <97 98>;
> +       interrupts-names = "rx", "tx";

interrupt-names

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
