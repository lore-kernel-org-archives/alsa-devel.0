From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: use devm_get_clk_from_child()
Date: Thu, 8 Dec 2016 16:28:37 -0800
Message-ID: <20161209002837.GE5423@codeaurora.org>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
 <20161208220942.GO5423@codeaurora.org>
 <877f7aymxu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877f7aymxu.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 12/09, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> > > @@ -111,14 +112,13 @@ int asoc_simple_card_parse_clk(struct device_node *node,
> > >  	 *  or "system-clock-frequency = <xxx>"
> > >  	 *  or device's module clock.
> > >  	 */
> > > -	clk = of_clk_get(node, 0);
> > > +	clk = devm_get_clk_from_child(dev, node, NULL);
> > >  	if (!IS_ERR(clk)) {
> > >  		simple_dai->sysclk = clk_get_rate(clk);
> > > -		simple_dai->clk = clk;
> > >  	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
> > >  		simple_dai->sysclk = val;
> > >  	} else {
> > > -		clk = of_clk_get(dai_of_node, 0);
> > > +		clk = devm_get_clk_from_child(dev, dai_of_node, NULL);
> > 
> > 
> > I was confused for a minute about how the second of_clk_get()
> > call with the dai_link node could work. Is that documented
> > anywhere or used by anyone? It seems like it's at least another
> > child node of the sound node (which is dev here) so it seems ok.
> 
> Documentation/devicetree/bindings/sound/simple-card.txt
> explains 1st of_clk_get will be used as "if needed",
> 2nd of_clk_get will be used as "not needed pattern".
> 1st pattern will use specific clock, 2nd pattern will use
> "cpu" or "codec" clock.
> 2nd one was added by someone (I forgot), and many driver is
> based on this feature.
> 

Can you point to some dts file in the kernel that falls into the
devm_get_clk_from_child(dev, dai_of_node, NULL) part?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
