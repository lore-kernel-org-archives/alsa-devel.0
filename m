From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v3] clk: x86: Add Atom PMC platform clocks
Date: Thu, 6 Oct 2016 18:09:04 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F36B1A9@irsmsx105.ger.corp.intel.com>
References: <1473427417-9166-1-git-send-email-irina.tirdea@intel.com>
 <20160914213025.GE7243@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160914213025.GE7243@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: linux-clk-owner@vger.kernel.org [mailto:linux-clk-owner@vger.kernel.org] On Behalf Of Stephen Boyd
> Sent: 15 September, 2016 0:30
> To: Tirdea, Irina
> Cc: linux-clk@vger.kernel.org; Michael Turquette; alsa-devel@alsa-project.org; Mark Brown; Takashi Iwai; Bossart, Pierre-louis; Pierre-
> Louis Bossart
> Subject: Re: [PATCH v3] clk: x86: Add Atom PMC platform clocks
> 
> On 09/09, Irina Tirdea wrote:
> > The BayTrail and CherryTrail platforms provide platform clocks
> > through their Power Management Controller (PMC).
> >
> > The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
> > frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
> > an a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
> > are available for general system use, where appropriate, and each
> > have Control & Frequency register fields associated with them.
> >
> > For example, the usage for platform clocks suggested in the datasheet
> > is the following:
> >   PLT_CLK[2:0] - Camera
> >   PLT_CLK[3] - Audio Codec
> >   PLT_CLK[4] -
> >   PLT_CLK[5] - COMMs
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >
> > Notes:
> >     Submitting this patch through the clock tree as requested by
> >     Mark Brown. This patch specifically enables the audio MCLK
> >     required by Baytrail CR devices (support already merged in
> >     Mark's tree)
> >
> > Changes from v2:
> >  - move clk platform data structures to a separate include file
> >  - store clk_hw pointer for the fixed rate clocks
> >
> > Changes from v1:
> >  - register the clk device as child of pmc device
> >  - pass iomem pointer from pmc driver to clk driver to avoid using
> > pmc_atom_read()/write() and use readl/writel API instead
> >  - use devm_clk_hw_register/clkdev_hw_create instead of
> > clk_register/clkdev_create
> >
> >  arch/x86/Kconfig                          |   1 +
> >  arch/x86/include/asm/pmc_atom.h           |   3 +
> >  arch/x86/platform/atom/pmc_atom.c         |  78 +++++-
> 
> Will there be problems if this merges through clk tree? If so we
> could take the clk driver part and the platform data include part
> could be duplicated into both trees. Or clk tree could be pulled
> into x86?
> 
> The patch looks fine to me.

Adding the x86 list and maintainers to this thread, as they should be able
to answer this question. I already sent a new version of this patch, this
time also including the x86 platform list and maintainers [1].

Thanks,
Irina

[1] http://www.spinics.net/lists/linux-clk/msg12169.html

