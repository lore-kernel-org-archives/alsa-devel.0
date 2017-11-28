From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 0/7] ASoC: Intel: Skylake: Add a clk
 driver to enable ssp clks early
Date: Tue, 28 Nov 2017 21:55:51 +0530
Message-ID: <20171128162550.GX3187@localhost>
References: <1511352592-4006-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511352592-4006-1-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 22, 2017 at 05:39:45PM +0530, Sriram Periyasamy wrote:
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
> Skylake driver creates a platform driver with the clock information and
> register the clk ops callback.
> 
> Kabylake machine driver uses the clock interface to enable the clocks early
> as it is required by the rt5663 driver for clock synchronization.

All:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
