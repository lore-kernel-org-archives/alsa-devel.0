From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ACPI, ASoC, gpio: Introduce and use
 acpi_dev_get_dev_name()
Date: Thu, 4 Jan 2018 11:33:33 -0600
Message-ID: <c8c6acfa-4dfa-9567-a7a6-49be33ecf4e8@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/4/18 10:47 AM, Andy Shevchenko wrote:
> It appears that at least one current user (patch 2) and upcoming one
> (patch 3) need to get device name by ACPI HID.
> 
> Here we introduce acpi_dev_get_dev_name() based on code done for
> acpi_dev_present() and reuse it where appropriate.
> 
> The series has been tested on Intel Edison with ACPI enabled U-Boot,
> while patch 2 wasn't tested anyhow (Pierre, can you help with it?).

Yes I'll try to test later this week. I just have to figure out which of 
my devices needs this (been a while since I worked on this).

> 
> Since patch 1 and cross subsystem nature of the series I think the best
> way is to push this via Rafael's linux-pm tree.
> 
> In worst case, if, Rafael, you have no objection, push at least first
> patch for this cycle to allow utilization in the future.
> 
> Andy Shevchenko (3):
>    ACPI / utils: Introduce acpi_dev_get_dev_name()
>    ASoC: Intel - Convert users to use acpi_dev_get_dev_name()
>    gpio: merrifield: Add support of ACPI enabled platforms
> 
>   drivers/acpi/utils.c                    | 40 +++++++++++++++++++++++++++------
>   drivers/gpio/gpio-merrifield.c          | 11 ++++++++-
>   include/acpi/acpi_bus.h                 |  1 +
>   include/linux/acpi.h                    |  6 +++++
>   include/sound/soc-acpi.h                |  7 ------
>   sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
>   sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
>   sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
>   sound/soc/intel/boards/cht_bsw_rt5645.c |  2 +-
>   sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
>   sound/soc/soc-acpi.c                    | 33 ---------------------------
>   11 files changed, 55 insertions(+), 53 deletions(-)
> 

