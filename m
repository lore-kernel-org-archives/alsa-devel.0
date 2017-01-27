From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 2/5] clk: x86: Add Atom PMC platform clocks
Date: Thu, 26 Jan 2017 16:22:30 -0800
Message-ID: <20170127002230.GX8801@codeaurora.org>
References: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485194865-10400-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485194865-10400-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01/23, Pierre-Louis Bossart wrote:
> From: Irina Tirdea <irina.tirdea@intel.com>
> 
> The BayTrail and CherryTrail platforms provide platform clocks
> through their Power Management Controller (PMC).
> 
> The SoC supports up to 6 clocks (PMC_PLT_CLK[0..5]) with a
> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
> and a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
> are available for general system use, where appropriate, and each
> have Control & Frequency register fields associated with them.
> 
> Port from legacy by Pierre Bossart, integration in clock framework
> by Irina Tirdea
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
