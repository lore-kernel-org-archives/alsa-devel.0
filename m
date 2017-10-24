From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/6] ASoC: Intel: Skylake: Add ssp clock driver
Date: Tue, 24 Oct 2017 07:15:17 -0700
Message-ID: <20171024141517.GF15990@codeaurora.org>
References: <1504794565-19168-6-git-send-email-subhransu.s.prusty@intel.com>
 <20170907164642.GX3053@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170907164642.GX3053@localhost>
Sender: linux-clk-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, broonie@kernel.org, mturquette@baylibre.com, alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/07, Vinod Koul wrote:
> On Thu, Sep 07, 2017 at 07:59:24PM +0530, Subhransu S. Prusty wrote:
> > From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> > 
> > For certain platforms it is required to start the clocks (mclk/sclk/fs)
> > before the stream start. Example: for few chrome systems, codec needs the
> > mclk/sclk to be enabled early for a successful clock synchronization and
> > for few IVI platforms, clock need to be enabled at boot and should be ON
> > always.
> > 
> > This patch creates virtual clock driver, which allows the machine driver to
> > use the clock interface to send IPCs to DSP to enable/disable the clocks.
> 
> Mark, Michael, Stephen,
> 
> So this one adds a 'virtual' clock driver for audio clocks (mclk, bclk...)
> and we have DSP configuring them.  The SW (driver) sends messages to DSP for
> controlling these clocks, that is why we decided to keep this in ASoC, do
> let us know if that is okay.
> 

I know there's a v2 and I'm replying here but this is fine from
clk perspective. I tend to think of it as a "remote" driver
instead where the clk control is done by a non-linux processor or
"remote" processor, in this case the DSP. I'll ack v2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
