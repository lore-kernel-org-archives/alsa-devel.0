From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Mon, 18 Dec 2017 10:31:14 +0530
Message-ID: <20171218050109.GA27846@subhransu-desktop>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
 <20171213223032.GO7997@codeaurora.org>
 <20171218035710.GA27559@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218035710.GA27559@subhransu-desktop>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 18, 2017 at 09:27:16AM +0530, Subhransu S. Prusty wrote:
> On Wed, Dec 13, 2017 at 02:30:32PM -0800, Stephen Boyd wrote:
> > On 12/11, Sriram Periyasamy wrote:
> > > +
> > > +static int skl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> > > +					unsigned long parent_rate)
> > > +{
> > > +	struct skl_clk *clkdev = to_skl_clk(hw);
> > > +	struct skl_clk_rate_cfg_table *rcfg;
> > > +	int clk_type;
> > > +
> > > +	if (!clkdev)
> > > +		return -ENODEV;
> > 
> > These checks don't make sense. container_of() on clk_hw
> > structures returning NULL wouldn't happen.
> 
> Sure. will remove.
> 
> > 
> > > +
> > > +	if (!rate)
> > > +		return -EINVAL;
> > > +
> > > +	if (__clk_is_enabled(hw->clk) && (clkdev->rate != rate))
> > 
> > Any chance you can directly read the hardware instead of going
> > through the framework to find out if the clk is enabled? Seems
> 
> No. This involves sending an IPC to DSP to enable clock and interpreting the
> return error code. I would like to avoid doing this here in set_rate.
> 
> > circular to do it this way.
> > 
> > > +		return -EBUSY;
> > > +
> > > +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> > > +							rate);
> > > +	if (!rcfg)
> > > +		return -EINVAL;
> > > +
> > > +	clk_type = skl_get_clk_type(clkdev->id);
> > > +	if (clk_type < 0)
> > > +		return clk_type;
> > > +
> > > +	skl_fill_clk_ipc(rcfg, clk_type);
> > > +	clkdev->rate = rate;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
> > > +				unsigned long parent_rate)
> > > +{
> > > +	struct skl_clk *clkdev = to_skl_clk(hw);
> > > +	struct skl_clk_rate_cfg_table *rcfg;
> > > +	int clk_type;
> > > +
> > > +	if (!clkdev)
> > > +		return 0;
> > > +
> > > +	if (clkdev->rate)
> > > +		return clkdev->rate;
> > 
> > Why is the rate being cached? We should always be able to
> > calculate the rate based on parent_rate that gets passed to this
> > function?
> 
> Will check and get back.

If I understand correctly, you refer to deriving the rate from parent_rate
using ratios. But since only the DSP is aware of the ratios and not the
driver, the driver can't derive the rate from the parent_rate and thus
cached.

> 
> Regards,
> Subhransu
> 
> > 
> > > +
> > > +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> > > +					parent_rate);
> > > +	if (!rcfg)
> > > +		return 0;
> > > +
> > > +	clk_type = skl_get_clk_type(clkdev->id);
> > > +	if (clk_type < 0)
> > > +		return 0;
> > > +
> > > +	skl_fill_clk_ipc(rcfg, clk_type);
> > > +	clkdev->rate = rcfg->rate;
> > > +
> > > +	return clkdev->rate;
> > > +}
> > > +
> > > +/* Not supported by clk driver. Implemented to satisfy clk fw */
> > > +long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> > > +				unsigned long *parent_rate)
> > > +{
> > > +	return rate;
> > > +}
> > 
> > -- 
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> 
> -- 

-- 
