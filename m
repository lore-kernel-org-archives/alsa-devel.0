From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 0/3] clkdev: add devm_get_clk_from_child()
Date: Thu, 8 Dec 2016 14:08:24 -0800
Message-ID: <20161208220824.GM5423@codeaurora.org>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-clk-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-DT <devicetree@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org, Linux-ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/05, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> This is v5 of "clkdev: add devm_of_clk_get()", but new series.
> I hope my understanding was correct with your idea.

Yes this looks good. Given that we're so close to the merge
window, perhaps I should just merge the first patch into clk-next
and then it will be ready for anyone who wants to use it? The
sound patches can be left up to others to handle.

> 
> Kuninori Morimoto (3):
>   1) clkdev: add devm_get_clk_from_child()
>   2) ASoC: simple-card: use devm_get_clk_from_child()
>   3) ASoC: simple-card-utils: enable clocks/clock-names/clock-ranges

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
