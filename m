From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver for Cirrus
 Logic Madera codecs
Date: Tue, 11 Apr 2017 14:20:31 -0500
Message-ID: <CAL_JsqLYi8txm2xb5emGvbC0P2cvtW2wXLdA=2qCO-wt_4JXXA@mail.gmail.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170410174917.dlklrvw2sraeq6xs@rob-hp-laptop> <20170410181136.btpvcat2ijwiebvm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170410181136.btpvcat2ijwiebvm-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 10, 2017 at 1:11 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 10, 2017 at 12:49:17PM -0500, Rob Herring wrote:
>
>> Same question as Mark. Should this share bindings with arizona? The
>> arizona one looks a bit strange, so not sure we'd want to just copy it.
>
> In what way?  Other than the -gpios stuff (which would just be a trivial
> thing if we wanted to change it)?

That's mainly it. It's not clear which node wlf,ldoena goes in either.
In the parent? ldo1?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
