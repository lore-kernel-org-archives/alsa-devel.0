From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Wed, 20 Dec 2017 09:03:26 +0530
Message-ID: <20171220033318.GA6563@subhransu-desktop>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
 <20171213223032.GO7997@codeaurora.org>
 <20171218035710.GA27559@subhransu-desktop>
 <20171218050109.GA27846@subhransu-desktop>
 <20171218191040.GW7997@codeaurora.org>
 <20171219054112.GB3492@subhransu-desktop>
 <20171219191727.GD7997@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171219191727.GD7997@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 19, 2017 at 11:17:27AM -0800, Stephen Boyd wrote:
> On 12/19, Subhransu S. Prusty wrote:
> > On Mon, Dec 18, 2017 at 11:10:40AM -0800, Stephen Boyd wrote:
> > > On 12/18, Subhransu S. Prusty wrote:
> > > > On Mon, Dec 18, 2017 at 09:27:16AM +0530, Subhransu S. Prusty wrote:
> > > > > On Wed, Dec 13, 2017 at 02:30:32PM -0800, Stephen Boyd wrote:
> > > > > > On 12/11, Sriram Periyasamy wrote:
> > > > > > 
> > > > > > > +
> > > > > > > +	if (!rate)
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	if (__clk_is_enabled(hw->clk) && (clkdev->rate != rate))
> > > > > > 
> > > > > > Any chance you can directly read the hardware instead of going
> > > > > > through the framework to find out if the clk is enabled? Seems
> > > > > 
> > > > > No. This involves sending an IPC to DSP to enable clock and interpreting the
> > > > > return error code. I would like to avoid doing this here in set_rate.
> > > > > 
> > > 
> > > Ok. So we're checking to see if software has already enabled the
> > > clk and then checking to see if the rate the consumer is
> > > requesting is the same as the rate it previously requested? I'm
> > 
> > The second check is not required, will remove it.
> > 
> > > still confused what's going on here. Does skl_fill_clk_ipc()
> > > change the rate of the clk? Is there any way to ask the DSP what
> > 
> > skl_fill_clk_ipc() prepares the IPC message based on the rate request by the
> > consumer. This IPC will be sent to DSP during a call to clock enable.
> > 
> > > the rate would be if we were to use some rate configuration?
> > 
> > No. If the clock is already running, reconfiguration is not allowed. So the
> > above check is invalid.
> 
> But we can't figure out if the clk is already running when we
> probe this driver, correct? It seems that we're relying on
> knowing if the clk is already running by looking at the software
> enable count that relates to if the clk is enabled in software by
> some linux consumer.

So here are the details:
 - clock is turned ON, when we send the IPC. At probe we don't send, so the
   clock will be OFF.
 - The clock is configured by DSP firmware and it will need an IPC to
   trigger that. By default power up of HW and DSP fw bootup ensures clk
   is OFF

> 
> > 
> > > 
> > > > > > circular to do it this way.
> > > > > > 
> > > > > > > +		return -EBUSY;
> > > > > > > +
> > > > > > > +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> > > > > > > +							rate);
> > > > > > > +	if (!rcfg)
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	clk_type = skl_get_clk_type(clkdev->id);
> > > > > > > +	if (clk_type < 0)
> > > > > > > +		return clk_type;
> > > > > > > +
> > > > > > > +	skl_fill_clk_ipc(rcfg, clk_type);
> > > > > > > +	clkdev->rate = rate;
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
> > > > > > > +				unsigned long parent_rate)
> > > > > > > +{
> > > > > > > +	struct skl_clk *clkdev = to_skl_clk(hw);
> > > > > > > +	struct skl_clk_rate_cfg_table *rcfg;
> > > > > > > +	int clk_type;
> > > > > > > +
> > > > > > > +	if (!clkdev)
> > > > > > > +		return 0;
> > > > > > > +
> > > > > > > +	if (clkdev->rate)
> > > > > > > +		return clkdev->rate;
> > > > > > 
> > > > > > Why is the rate being cached? We should always be able to
> > > > > > calculate the rate based on parent_rate that gets passed to this
> > > > > > function?
> > > > > 
> > > > > Will check and get back.
> > > > 
> > > > If I understand correctly, you refer to deriving the rate from parent_rate
> > > > using ratios. But since only the DSP is aware of the ratios and not the
> > > > driver, the driver can't derive the rate from the parent_rate and thus
> > > > cached.
> > > > 
> > > 
> > > I was thinking the code would do what's below all the time.
> > 
> > I think we interpreted incorrectly. As recalc_rate is meant to be used only
> > when parent_rate changes, so this can be removed as the set_parent is not
> > supported for this driver. Please let me know if I understand correctly.
> 
> recalc_rate() is called whenever the clk rate could change. It
> could be that clk_set_rate() is called directly on this clk, and
> then recalc_rate() would be called. Or it could be that the
> parent of this clk has its rate change, and then again
> recalc_rate() would be called on this clk. set_parent is about
> changing the parent of the clk, which also would cause the
> framework to call recalc_rate() on a clk that gets a new parent.

Thanks for the explanation.

So, we have a parent of the clk which is fixed. so change of parent is not
applicable here.

For us, recalc_rate() doesn't mean much as we can only return current rate,
if it is same otherwise 0. Pls do advise in this case if the behaviour needs
to change, if so how?

Regards,
Subhransu

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
