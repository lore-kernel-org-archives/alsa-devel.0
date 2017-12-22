From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Thu, 21 Dec 2017 18:04:36 -0800
Message-ID: <20171222020436.GF7997@codeaurora.org>
References: <1512978390-8848-1-git-send-email-sriramx.periyasamy@intel.com>
 <1512978390-8848-2-git-send-email-sriramx.periyasamy@intel.com>
 <20171213223032.GO7997@codeaurora.org>
 <20171218035710.GA27559@subhransu-desktop>
 <20171218050109.GA27846@subhransu-desktop>
 <20171218191040.GW7997@codeaurora.org>
 <20171219054112.GB3492@subhransu-desktop>
 <20171219191727.GD7997@codeaurora.org>
 <20171220033318.GA6563@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220033318.GA6563@subhransu-desktop>
Sender: linux-clk-owner@vger.kernel.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/20, Subhransu S. Prusty wrote:
> On Tue, Dec 19, 2017 at 11:17:27AM -0800, Stephen Boyd wrote:
> >
> > But we can't figure out if the clk is already running when we
> > probe this driver, correct? It seems that we're relying on
> > knowing if the clk is already running by looking at the software
> > enable count that relates to if the clk is enabled in software by
> > some linux consumer.
> 
> So here are the details:
>  - clock is turned ON, when we send the IPC. At probe we don't send, so the
>    clock will be OFF.
>  - The clock is configured by DSP firmware and it will need an IPC to
>    trigger that. By default power up of HW and DSP fw bootup ensures clk
>    is OFF
> 

Ok great.

> > 
> > recalc_rate() is called whenever the clk rate could change. It
> > could be that clk_set_rate() is called directly on this clk, and
> > then recalc_rate() would be called. Or it could be that the
> > parent of this clk has its rate change, and then again
> > recalc_rate() would be called on this clk. set_parent is about
> > changing the parent of the clk, which also would cause the
> > framework to call recalc_rate() on a clk that gets a new parent.
> 
> Thanks for the explanation.
> 
> So, we have a parent of the clk which is fixed. so change of parent is not
> applicable here.

Yeah, let's ignore a changing parent frequency. recalc_rate() is
also called when *this* clk rate is changed. The parent rate is
passed in because that's usually helpful to calculate the rate
that this op is supposed to return.

> 
> For us, recalc_rate() doesn't mean much as we can only return current rate,
> if it is same otherwise 0. Pls do advise in this case if the behaviour needs
> to change, if so how?
> 

Can the DSP tell us what the rate of the clk is? Or what the rate
of the clk is configured for? What is that configuration out of
boot when it's OFF? Typically, recalc_rate() can tell us what the
rate of the clk is, even when its OFF, because we can read the
hardware and calculate the rate of the clk given the parent
frequency. We do have clk drivers out there that are like this
DSP and don't tell anything about the rate and we can't even ask.
In that case, we return 0 and cache the rate in the set_rate op.

Ideally, recalc_rate would always return the frequency of the clk
that's been configured in the hardware on the DSP side. If that
can't be done, I suppose faking it and caching the rate that the
set_rate op figures out would work. Or if enabling the clk let's
us know the rate we should cache it there too. But definitely
don't do any sort of rate caching in recalc_rate. It should just
blindly return the cached value if it can't read hardware.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
