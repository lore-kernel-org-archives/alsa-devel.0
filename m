From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/3] ASoC: Intel - Convert to use
 acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 22:21:07 +0200
Message-ID: <1515788467.7000.978.camel@linux.intel.com>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
         <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
         <20180112190312.GD21458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180112190312.GD21458@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2018-01-12 at 19:03 +0000, Mark Brown wrote:
> On Fri, Jan 05, 2018 at 06:09:35PM +0200, Andy Shevchenko wrote:
> > Instead of home grown snd_soc_acpi_find_name_from_hid() use
> > acpi_dev_get_first_match_name().
> 
> This doesn't apply against current code (even after pulling Raphael's
> pull request) - can you please check and resend?

It requires Pierre's series #2 [1] to be applied first.

[1]: https://www.spinics.net/lists/alsa-devel/msg72463.html


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
