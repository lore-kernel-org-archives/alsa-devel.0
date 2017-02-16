From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] clk: x86: add "mclk" alias for Baytrail/Cherrytrail
Date: Thu, 16 Feb 2017 04:05:19 +0200
Message-ID: <CAHp75Vdm3v6UdKgVhUjQebQ8QYrughezuxbaZXmM9gw=qgJ2VQ@mail.gmail.com>
References: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20170214190456.GV25384@codeaurora.org> <bc29984e-cc58-69ed-d6ca-b4808d6514dc@linux.intel.com>
 <20170216005623.GY25384@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170216005623.GY25384@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 16, 2017 at 2:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/14, Pierre-Louis Bossart wrote:
>> On 2/14/17 1:04 PM, Stephen Boyd wrote:

>> This is a builtin driver that cannot be configured as a module, is
>> the leaked alias problematic?
>
> Well we don't suppress driver unbinding via sysfs here, unless I
> missed something, so the leak could be triggered that way.

It has ->remove() hook, so, definitely it's possible to unbind.

>  lookup = clkdev_hw_create(data->clks[3].hw, "mclk", NULL);
>
> and then freeing that lookup with clkdev_drop in the remove of
> the driver. "mclk" is really generic for a connection name
> without an associated device id, so you may want to pass some
> device as the last argument here, but dev_name(&pdev->dev) seems
> odd because that's the clock controller device, not whatever
> device would be calling clk_get() with this created lookup in
> mind.

Here is the problem with CLK framework since it's (was?) too oriented
to ARM and clock trees.

The best option for x86 is to place it in some platform code, which is
bad idea per se.
For example, GPIO, PWM, etc have static look up tables and glue
drivers (like PCI part of the driver, or I2C, or similar) can fill
that table based on ID.

My personal opinion that the best place is not the clock driver for
that, rather converting existing drivers to take clock name based on
some (platform related) ID.

-- 
With Best Regards,
Andy Shevchenko
