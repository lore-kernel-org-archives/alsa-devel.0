From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 2/2] clk: x86: Add Atom PMC platform clocks
Date: Thu, 8 Dec 2016 16:25:23 -0800
Message-ID: <20161209002523.GC5423@codeaurora.org>
References: <1481125406-29097-1-git-send-email-irina.tirdea@intel.com>
 <1481125406-29097-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481125406-29097-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/07, Irina Tirdea wrote:
> The BayTrail and CherryTrail platforms provide platform clocks
> through their Power Management Controller (PMC).
> 
> The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
> an a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
> are available for general system use, where appropriate, and each
> have Control & Frequency register fields associated with them.
> 
> For example, the usage for platform clocks suggested in the datasheet
> is the following:
>   PLT_CLK[2:0] - Camera
>   PLT_CLK[3] - Audio Codec
>   PLT_CLK[4] -
>   PLT_CLK[5] - COMMs
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/clk/x86/Makefile                      |   1 +
>  drivers/clk/x86/clk-byt-plt.c                 | 380 ++++++++++++++++++++++++++

Is it possible to split the clk part from the platform part? I'd
like to merge just the clk part if possible into the clk tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
