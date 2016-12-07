From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v5 0/2] Add platform clock for BayTrail platforms
Date: Wed,  7 Dec 2016 17:43:24 +0200
Message-ID: <1481125406-29097-1-git-send-email-irina.tirdea@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Irina Tirdea <irina.tirdea@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These patches specifically enable the audio MCLK required by Baytrail CR
devices. It is the remaining part of a bigger set of patches
(already merged in Mark's tree) that enable sound for Baytrail CR devices
(especially Asus T100TAF) [1]. They include the clock driver and a move
of the non-architectural pmc_atom driver code into drivers/platform/x86.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111704.html

Changes from v4:
 - move the pmc_atom driver from arch/x86/platform/atom to
drivers/platform/x86

Changes from v3:
 - replace devm_kzalloc with devm_kcalloc
 - add x86 architecture maintainers

Changes from v2:
 - move clk platform data structures to a separate include file
 - store clk_hw pointer for the fixed rate clocks

Changes from v1:
 - register the clk device as child of pmc device
 - pass iomem pointer from pmc driver to clk driver to avoid using
pmc_atom_read()/write() and use readl/writel API instead
 - use devm_clk_hw_register/clkdev_hw_create instead of
clk_register/clkdev_create

Irina Tirdea (2):
  arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
  clk: x86: Add Atom PMC platform clocks

 arch/x86/Kconfig                                   |   4 -
 arch/x86/platform/atom/Makefile                    |   1 -
 drivers/acpi/acpi_lpss.c                           |   2 +-
 drivers/clk/x86/Makefile                           |   1 +
 drivers/clk/x86/clk-byt-plt.c                      | 380 +++++++++++++++++++++
 drivers/platform/x86/Kconfig                       |   6 +
 drivers/platform/x86/Makefile                      |   1 +
 .../atom => drivers/platform/x86}/pmc_atom.c       |  81 ++++-
 include/linux/platform_data/x86/clk-byt-plt.h      |  31 ++
 .../linux/platform_data/x86}/pmc_atom.h            |   3 +
 10 files changed, 499 insertions(+), 11 deletions(-)
 create mode 100644 drivers/clk/x86/clk-byt-plt.c
 rename {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c (88%)
 create mode 100644 include/linux/platform_data/x86/clk-byt-plt.h
 rename {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h (98%)

-- 
1.9.1
