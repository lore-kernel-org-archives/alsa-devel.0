From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 1/5] clk: Make x86/ conditional on CONFIG_COMMON_CLK
Date: Thu, 26 Jan 2017 16:22:27 -0800
Message-ID: <20170127002227.GW8801@codeaurora.org>
References: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485194865-10400-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485194865-10400-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01/23, Pierre-Louis Bossart wrote:
> Fix Makefile for x86 support, dependency on CONFIG_COMMON_CLK
> was not explicit
> 
> Fixes: 701190fd7419 ('clk: x86: add support for Lynxpoint LPSS clocks')
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
