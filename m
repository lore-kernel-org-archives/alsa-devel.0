From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Wed, 13 Dec 2017 14:30:32 -0800
Message-ID: <20171213223032.GO7997@codeaurora.org>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/11, Sriram Periyasamy wrote:
> +
> +static int skl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +	struct skl_clk_rate_cfg_table *rcfg;
> +	int clk_type;
> +
> +	if (!clkdev)
> +		return -ENODEV;

These checks don't make sense. container_of() on clk_hw
structures returning NULL wouldn't happen.

> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	if (__clk_is_enabled(hw->clk) && (clkdev->rate != rate))

Any chance you can directly read the hardware instead of going
through the framework to find out if the clk is enabled? Seems
circular to do it this way.

> +		return -EBUSY;
> +
> +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> +							rate);
> +	if (!rcfg)
> +		return -EINVAL;
> +
> +	clk_type = skl_get_clk_type(clkdev->id);
> +	if (clk_type < 0)
> +		return clk_type;
> +
> +	skl_fill_clk_ipc(rcfg, clk_type);
> +	clkdev->rate = rate;
> +
> +	return 0;
> +}
> +
> +static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +	struct skl_clk_rate_cfg_table *rcfg;
> +	int clk_type;
> +
> +	if (!clkdev)
> +		return 0;
> +
> +	if (clkdev->rate)
> +		return clkdev->rate;

Why is the rate being cached? We should always be able to
calculate the rate based on parent_rate that gets passed to this
function?

> +
> +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> +					parent_rate);
> +	if (!rcfg)
> +		return 0;
> +
> +	clk_type = skl_get_clk_type(clkdev->id);
> +	if (clk_type < 0)
> +		return 0;
> +
> +	skl_fill_clk_ipc(rcfg, clk_type);
> +	clkdev->rate = rcfg->rate;
> +
> +	return clkdev->rate;
> +}
> +
> +/* Not supported by clk driver. Implemented to satisfy clk fw */
> +long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	return rate;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
