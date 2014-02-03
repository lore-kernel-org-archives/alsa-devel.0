From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] devicetree: Add devicetree bindings documentation for
 the ADAU1977
Date: Mon, 3 Feb 2014 16:15:24 +0100
Message-ID: <CAMuHMdVQGZE+1YuWCnJefzy08kb6vNmRN8k+1-K82BubOBAOxQ@mail.gmail.com>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391439428-3198-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 3, 2014 at 3:57 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> + - adi,micbias: Configures the voltage setting for the MICBIAS pin. If not
> +   specified the default value will be 8.5 Volts. This property is only valid
> +   for the ADAU1977.
> +   Valid values for this property are:
> +       0: 5.0V
> +       1: 5.5V
> +       2: 6.0V
> +       3: 6.5V
> +       4: 7.0V
> +       5: 7.5V
> +       6: 8.0V
> +       7: 8.5V
> +       8: 9.0V

This means the casual DTS reader need to know about the meaning of
the values. You can avoid that by:
  1. Using preprocessor defines. Drawback is that you have to add an
     include file.
  2. Using mV, and specify minimum, maximum, and incrementals in the
     bindings, cfr.
Documentation/devicetree/bindings/power_supply/ti,bq24735.txt
     Drawback is that the user can easily specify invalid values.

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
