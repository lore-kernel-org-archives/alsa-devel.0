From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
Date: Wed, 23 Nov 2016 11:10:37 -0800
Message-ID: <20161123191037.GE25626@codeaurora.org>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
 <146785219147.73491.2827268663638530377@resonance>
 <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
 <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-clk-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org, Linux-ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 11/16, Kuninori Morimoto wrote:
> 
> Hi Rob, Michael, Russell
> 
> 
> What is the conclusion of this patch ?
> We shouldn't add devm_of_clk_get() ? or can I continue ?
> 
> The problem of current [devm_]clk_get() handles *dev only,
> but I need to get clocks from DT node, not dev
> 
> 	sound_soc {
> 		...
> 		cpu {
> 			...
> =>			clocks = <&xxx>;
> 		};
> 		codec {
> 			...
> =>			clocks = <&xxx>;
> 		};
> 	};
> 

I've seen bindings that have the 'clocks' property at the top
level and the appropriate 'clock-names' property to relate the
clocks to a subnode.

 	sound_soc {
		clocks = <&xxx>, <&xxx>;
		clock-names = "cpu", "codec";
 		...
 		cpu {
 			...
 		};
 		codec {
 			...
 		};
 	};

Then the subnodes call clk_get() with the top level device and
the name of their node and things match up. I suppose this
binding is finalized though, so we can't really do that?

I see that the gpio framework has a similar design called
devm_get_gpiod_from_child(), so how about we add a
devm_get_clk_from_child() API? That would more closely match the
intent here, which is to restrict the clk_get() operation to
child nodes of the device passed as the first argument.

struct clk *devm_get_clk_from_child(struct device *dev,
				    const char *con_id,
				    struct device_node *child);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
