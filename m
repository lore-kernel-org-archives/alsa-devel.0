From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
Date: Tue, 29 Nov 2016 13:05:56 -0800
Message-ID: <20161129210556.GC6095@codeaurora.org>
References: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
 <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
 <20161123191037.GE25626@codeaurora.org>
 <87a8cpejn5.wl%kuninori.morimoto.gx@renesas.com>
 <87y409cw71.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87y409cw71.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 11/24, Kuninori Morimoto wrote:
> 
> Hi Stephen, again
> 
> > > I've seen bindings that have the 'clocks' property at the top
> > > level and the appropriate 'clock-names' property to relate the
> > > clocks to a subnode.
> > > 
> > >  	sound_soc {
> > > 		clocks = <&xxx>, <&xxx>;
> > > 		clock-names = "cpu", "codec";
> > >  		...
> > >  		cpu {
> > >  			...
> > >  		};
> > >  		codec {
> > >  			...
> > >  		};
> > >  	};
> > > 
> > > Then the subnodes call clk_get() with the top level device and
> > > the name of their node and things match up. I suppose this
> > > binding is finalized though, so we can't really do that?
> > > 
> > > I see that the gpio framework has a similar design called
> > > devm_get_gpiod_from_child(), so how about we add a
> > > devm_get_clk_from_child() API? That would more closely match the
> > > intent here, which is to restrict the clk_get() operation to
> > > child nodes of the device passed as the first argument.
> > > 
> > > struct clk *devm_get_clk_from_child(struct device *dev,
> > > 				    const char *con_id,
> > > 				    struct device_node *child);
> 
> Thanks, but, my point is that Linux already have "of_clk_get()",
> but we don't have its devm_ version.
> The point is that of_clk_get() can get clock from "device_node".
> Why having devm_ version become so problem ?

The problem is that it encourages the use of of_clk_get() when
clk_get() is more desirable. Ideally of_clk_get() is never used
when a device exists. In this case, it seems like we need to
support it though, hence the suggestion of having a
devm_get_clk_from_child() API, that explicitly reads as "get a
clock from a child node of this device". The distinction is
important, because of_clk_get() should rarely be used.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
