From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] ACPI, ASoC, gpio: Add and use acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 14:24:41 +0100
Message-ID: <21372380.qzqCkU0TZy@aspire.rjw.lan>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Friday, January 5, 2018 5:09:32 PM CET Andy Shevchenko wrote:
> It appears that at least one current user (patch 3) and upcoming one
> (patch 2) need to get device name by ACPI HID.
> 
> Here we introduce acpi_dev_get_first_match_name() based on code
> done for acpi_dev_present() and reuse it where appropriate.
> 
> The series has been tested on Intel Edison with non-ACPI and
> ACPI enabled versions of U-Boot, while patches 1 and 3 were tested
> by Pierre.
> 
> Since patch 1 and cross subsystem nature of the series I think
> the best way is to push this (patches 1 and 2) via Rafael's linux-pm tree.
> 
> Taking into consideration that patch 3 requires not-yet-applied work
> from Pierre, I left it for reference, in particular to show the LOC
> statistics.
> 
> Changelog v3:
> - add Pierre's tag (I dared to do this for both patches 1 and 3)
> - address comment about function name (patch 1)
> - add a reference to the first user (patch 1)
> - consolidate pin control device possible names in one place (patch 2)
> - rebase ASoC patch on not-yet-applied series from Pierre (patch 3), and
> - thus reordered to make it last in the series (patch 3)
> 
> Andy Shevchenko (3):
>   ACPI / utils: Introduce acpi_dev_get_first_match_name()
>   gpio: merrifield: Add support of ACPI enabled platforms
>   ASoC: Intel - Convert to use acpi_dev_get_first_match_name()
> 
>  drivers/acpi/utils.c                    | 41 +++++++++++++++++++++++++++------
>  drivers/gpio/gpio-merrifield.c          | 11 ++++++++-
>  include/acpi/acpi_bus.h                 |  3 +++
>  include/linux/acpi.h                    |  6 +++++
>  include/sound/soc-acpi.h                |  7 ------
>  sound/soc/intel/boards/bytcht_da7213.c  |  2 +-
>  sound/soc/intel/boards/bytcht_es8316.c  |  2 +-
>  sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
>  sound/soc/intel/boards/bytcr_rt5651.c   |  2 +-
>  sound/soc/intel/boards/cht_bsw_rt5645.c |  2 +-
>  sound/soc/intel/boards/cht_bsw_rt5672.c |  2 +-
>  sound/soc/soc-acpi.c                    | 33 --------------------------
>  12 files changed, 59 insertions(+), 54 deletions(-)

[1-2/3] applied and I set up a git branch with them to pull from for Mark.

Thanks,
Rafael

