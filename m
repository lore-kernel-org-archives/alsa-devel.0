From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: x86: add "mclk" alias for Baytrail/Cherrytrail
Date: Wed, 15 Feb 2017 16:56:23 -0800
Message-ID: <20170216005623.GY25384@codeaurora.org>
References: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20170214190456.GV25384@codeaurora.org>
 <bc29984e-cc58-69ed-d6ca-b4808d6514dc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bc29984e-cc58-69ed-d6ca-b4808d6514dc@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/14, Pierre-Louis Bossart wrote:
> On 2/14/17 1:04 PM, Stephen Boyd wrote:
> >
> >This leaks an alias when the driver is removed. Honestly,
> >clk_add_alias() doesn't work well because of that problem. Can
> >you just add another lookup with the pointer you already have
> >instead of passing a NULL device to do a global lookup?
> 
> This is a builtin driver that cannot be configured as a module, is
> the leaked alias problematic?

Well we don't suppress driver unbinding via sysfs here, unless I
missed something, so the leak could be triggered that way.

> I don't mind trying something different but I am not familiar enough
> with the framework to understand what you are hinting at. Are you
> suggesting a change on the last parameter such as:
> 
> clk_add_alias("mclk", dev_name(&pdev->dev), "pmc_plt_clk_3", &pdev->dev)
> 

I mean:

 lookup = clkdev_hw_create(data->clks[3].hw, "mclk", NULL);

and then freeing that lookup with clkdev_drop in the remove of
the driver. "mclk" is really generic for a connection name
without an associated device id, so you may want to pass some
device as the last argument here, but dev_name(&pdev->dev) seems
odd because that's the clock controller device, not whatever
device would be calling clk_get() with this created lookup in
mind.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
