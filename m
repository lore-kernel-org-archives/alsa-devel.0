From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Fri, 22 Dec 2017 10:22:30 +0530
Message-ID: <20171222045229.GC21872@subhransu-desktop>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
 <20171213223032.GO7997@codeaurora.org>
 <20171218035710.GA27559@subhransu-desktop>
 <20171218050109.GA27846@subhransu-desktop>
 <20171218191040.GW7997@codeaurora.org>
 <20171219054112.GB3492@subhransu-desktop>
 <20171219191727.GD7997@codeaurora.org>
 <20171220033318.GA6563@subhransu-desktop>
 <20171222020436.GF7997@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171222020436.GF7997@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 21, 2017 at 06:04:36PM -0800, Stephen Boyd wrote:
> On 12/20, Subhransu S. Prusty wrote:
> > On Tue, Dec 19, 2017 at 11:17:27AM -0800, Stephen Boyd wrote:
> > applicable here.
> 
> Yeah, let's ignore a changing parent frequency. recalc_rate() is
> also called when *this* clk rate is changed. The parent rate is
> passed in because that's usually helpful to calculate the rate
> that this op is supposed to return.
> 
> > 
> > For us, recalc_rate() doesn't mean much as we can only return current rate,
> > if it is same otherwise 0. Pls do advise in this case if the behaviour needs
> > to change, if so how?
> > 
> 
> Can the DSP tell us what the rate of the clk is? Or what the rate
> of the clk is configured for? What is that configuration out of
> boot when it's OFF? Typically, recalc_rate() can tell us what the

No, the DSP clock is programmed using configuration parameters which are
sent from driver. DSP doesn't have any mechanism to report the clock
configuration back to driver. So the rate is cached.

> rate of the clk is, even when its OFF, because we can read the
> hardware and calculate the rate of the clk given the parent
> frequency. We do have clk drivers out there that are like this
> DSP and don't tell anything about the rate and we can't even ask.
> In that case, we return 0 and cache the rate in the set_rate op.
> 
> Ideally, recalc_rate would always return the frequency of the clk
> that's been configured in the hardware on the DSP side. If that
> can't be done, I suppose faking it and caching the rate that the
> set_rate op figures out would work. Or if enabling the clk let's
> us know the rate we should cache it there too. But definitely

Yes, this behavior is applicable for this driver. I will remove the
recalculation part and resubmit the patch by returning the cached rate
already done in set_rate.

Regards,
Subhransu

> don't do any sort of rate caching in recalc_rate. It should just
> blindly return the cached value if it can't read hardware.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
