From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 0/5] Add platform clock for BayTrail platforms
Date: Mon, 23 Jan 2017 23:47:21 +0200
Message-ID: <1485208041.2133.293.camel@linux.intel.com>
References: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-01-23 at 12:07 -0600, Pierre-Louis Bossart wrote:
> These patches specifically enable the audio MCLK required by Baytrail
> CR devices. It is the remaining part of a bigger set of patches
> (already merged in Mark Brown's tree) that enable sound for Baytrail
> CR
> devices (especially Asus T100TAF) [1]. They include the clock driver
> and clock enabling in the pmc_atom code (along with moving of the
> non-architectural pmc_atom driver code into drivers/platform/x86 as
> suggested by Thomas Gleixner [2]). This move includes a new header in
> include/linux/platform_data/x86/. While there is an agreement that the
> definitions for PMC clocks are not really platform data this location
> is seen as a good-enough compromise with an agreement between Darren
> Hart and Andy Shevchenko [3]
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-
> August/111704.html
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/
> 113936.html
> [3] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-December
> /115892.html
> 
> Changes from v7:
>  - Replaced clk-readl/writel by regular readl/writel
>  - Fixed two nitpick comments (newline and driver name string)
>  - Fixed [5:0] to [0..5] in comment (missed in v6)
> 
> Changes from v6:
>  - Addressed comments from Stephen Boyd, Andy Shevchenko and Vinod
> Koul
>  - Renamed clk-byt-plt to clk-pmc-atom
>  - Rebase to 4.10-rc3 (broonie/for-next)
>  - Added helper functions to make error handling more compact
>  - Removed module-related code since it's not possible/supported
>  - Removed useless tests on remove
>  - PMC_CLK_OFFSET move to clk-pcm-atom (more logical)
>  - Split typo correction and makefile fix in separate patches
>  - small fixes (spaces, defaults in switches, alphabetical order, use
> of
> clk_writel/readl and no test on write, simpler error handling, use of
> while(i--), unsigned loop variables, kernel doc fields, format-patch
> -M
>  -C -D, use of PLATFORM_DEVID_NONE)
> 


> Changes from v5:
>  - fix build error reported by kbuild test robot
>  - split the clk driver code from x86 platform changes
> 
> Changes from v4:
>  - move the pmc_atom driver from arch/x86/platform/atom to
> drivers/platform/x86
> 
> Changes from v3:
>  - replace devm_kzalloc with devm_kcalloc
>  - add x86 architecture maintainers
> 
> Changes from v2:
>  - move clk platform data structures to a separate include file
>  - store clk_hw pointer for the fixed rate clocks
> 
> Changes from v1:
>  - register the clk device as child of pmc device
>  - pass iomem pointer from pmc driver to clk driver to avoid using
> pmc_atom_read()/write() and use readl/writel API instead
>  - use devm_clk_hw_register/clkdev_hw_create instead of
> clk_register/clkdev_create
> 
> Irina Tirdea (3):
>   clk: x86: Add Atom PMC platform clocks
>   arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
>   platform/x86: Enable Atom PMC platform clocks
> 
> Pierre-Louis Bossart (2):
>   clk: Make x86/ conditional on CONFIG_COMMON_CLK
>   platform/x86: fix typo in comment
> 
>  arch/x86/Kconfig                                   |   4 -
>  arch/x86/platform/atom/Makefile                    |   1 -
>  drivers/acpi/acpi_lpss.c                           |   2 +-
>  drivers/clk/Makefile                               |   2 +
>  drivers/clk/x86/Makefile                           |   1 +
>  drivers/clk/x86/clk-pmc-atom.c                     | 371
> +++++++++++++++++++++
>  drivers/platform/x86/Kconfig                       |   5 +
>  drivers/platform/x86/Makefile                      |   1 +
>  .../atom => drivers/platform/x86}/pmc_atom.c       |  88 ++++-
>  include/linux/platform_data/x86/clk-pmc-atom.h     |  44 +++
>  .../linux/platform_data/x86}/pmc_atom.h            |   2 +-
>  11 files changed, 506 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/clk/x86/clk-pmc-atom.c
>  rename {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c
> (87%)
>  create mode 100644 include/linux/platform_data/x86/clk-pmc-atom.h
>  rename {arch/x86/include/asm =>
> include/linux/platform_data/x86}/pmc_atom.h (98%)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
