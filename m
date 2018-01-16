From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [alsa-devel] [PATCH v7 0/6] ASoC: Intel: Skylake: Add a clk
 driver to enable ssp clks early
Date: Tue, 16 Jan 2018 16:54:07 +0530
Message-ID: <20180116112407.GA4786@intel.com>
References: <1515065119-1683-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515065119-1683-1-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 04, 2018 at 04:55:13PM +0530, Sriram Periyasamy wrote:
> For certain platforms, clocks (mclk/sclk/fs) are required to be up before
> the stream start. Example: some codecs needs the mclk/sclk/fs to be
> enabled early for a successful clock synchronization. Some platforms
> require clock to be enabled at boot and be always ON.
> 
> By sending set_dma_control IPC (with the i2s blobs queried from NHLT),
> these clocks can be enabled early after the firmware is downloaded.
> 
> With this series, a virtual clock driver is created which provides
> interface to send the required IPCs from machine driver to enable the
> clocks. NHLT is parsed during probe and the clock information is populated.
> The pointer to blob is cached and sent along with the set_dma_control IPC
> structure during the clk prepare/unprepare callback. Clocks are created for
> a ssp if the nhlt table has endpoint configuration for that particular ssp.
> 
> Kabylake machine driver uses the clock interface to enable the clocks early
> as it is required by the rt5663 driver for clock synchronization.
> 
> v6 -> v7

Hi Mark,

Is this in your review queue? Stephen has given his "Reviewed-by", in case
you are waiting for his ack.

Thanks,
Sriram.

> 	- Remove the check to deny set_rate when clock is enabled and
> 	  instead use framework flag CLK_SET_RATE_GATE
> 
> v5 -> v6
> 	- Remove unwanted checks from clk ops
> 
> 	- Modify recalc_rate to return just the cached rate and remove the 
> 	  rate calculations
> 
-- 
