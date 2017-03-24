From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: wm8903: add regulator handling
Date: Fri, 24 Mar 2017 10:30:57 -0500
Message-ID: <20170324153057.wuozajhcls667m2l@rob-hp-laptop>
References: <20170320091352.4115-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170320091352.4115-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2017 at 10:13:52AM +0100, Linus Walleij wrote:
> The WM8903 has four different voltage inputs: AVDD, CPVDD, DBVDD
> and DCVDD. On the Qualcomm APQ8060 Dragonboard these are all
> supplied from proper regulators and thus need activating and
> binding.
> 
> This is a quick-and-dirty solution just grabbing and enabling the
> regulator supplies on probe() and disabling them on remove() and
> the errorpath. More elaborate power management is likely possible.
> 
> I assume the nVidia designs using this codec have some hard-wired
> always-on power and will be happy with using the dummy regulators
> for this. But someone from the nVidia camp should probably check
> whether they can bind these to proper regulators instead.
> 
> We also amend the DT binding document. A small change like this
> does not warrant a separate patch for augmenting these.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Mark: I was thinking about adding runtime PM for disabling
> these regulators when unused, but I'm uncertain about the
> interaction with DAPM in that regard. This atleast gives us
> control over the supplies.
> ---
>  Documentation/devicetree/bindings/sound/wm8903.txt | 13 +++++++++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/codecs/wm8903.c                          | 31 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
