From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/17] Baytrail audio fixes
Date: Fri, 12 Aug 2016 16:27:43 -0500
Message-ID: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id BFB19265919
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

This second set of patches solves problems with Baytrail-CR,
specifically the auto-detection of IRQ index and SSP0 routing.
These patches enable sound on the Asus T100TAF with the support
of the MCLK handled by the clock framework (Credits to Irina Tirdea)

If you prefer git access, the patches are available at
https://github.com/plbossart/sound/commits/t100taf-6

The corresponding UCM file is at 
https://github.com/plbossart/UCM/commits/t100-test

Thanks to Luka Karinja and Antonio Ospite for early tests and suggestions,
as well as Liam Girdwood and Vinod Koul for internal code reviews.

Additional fixes for UCM files will be coming soon to support mono speakers,
IN3 input and other fixes.

Irina Tirdea (3):
  clk: x86: Add Atom PMC platform clocks
  ASoC: Intel: bytcr_rt5640: add MCLK support
  AsoC: Intel: Add quirks for MinnowBoard MAX

Pierre-Louis Bossart (14):
  ASoC: Intel: bytcr-rt5640: add Asus T100TAF quirks
  ASoC: Intel: bytcr_rt5640: quirk for mono speaker
  ASoC: Intel: bytcr_rt5640: enable differential mic quirk
  ASoC: Intel: Atom: auto-detection of Baytrail-CR
  ASoC: Intel: Atom: add definitions for modem/SSP0 interface
  ASoC: Intel: atom: enable configuration of SSP0
  ASoC: Intel: bytcr_rt5640: add SSP2_AIF2 routing
  ASoC: Intel: bytcr_rt56040: additional routing quirks
  ASoC: Intel: bytcr_rt5640: fix dai/clock setup for SSP0 routing
  ASoC: Intel: bytcr_rt5640: default routing and quirks on Baytrail-CR
  ASoC: Intel: bytcr_rt5640: add IN3 map
  ASoC: rt5640: add internal clock source support
  ASoC: bytcr_rt5640: Add quirk for Teclast X98 Air 3G tablet
  ASoC: Intel: bytcr_rt5640: log quirks

 arch/x86/Kconfig                         |   1 +
 arch/x86/include/asm/pmc_atom.h          |   6 +
 arch/x86/platform/atom/pmc_atom.c        |  55 +++-
 drivers/clk/x86/Makefile                 |   1 +
 drivers/clk/x86/clk-byt-plt.c            | 413 +++++++++++++++++++++++++
 sound/soc/codecs/rt5640.c                |   3 +
 sound/soc/codecs/rt5640.h                |   1 +
 sound/soc/intel/atom/sst-atom-controls.c |  32 +-
 sound/soc/intel/atom/sst-atom-controls.h |   6 +
 sound/soc/intel/atom/sst/sst_acpi.c      |  82 ++++-
 sound/soc/intel/boards/bytcr_rt5640.c    | 496 ++++++++++++++++++++++++++++---
 11 files changed, 1036 insertions(+), 60 deletions(-)
 create mode 100644 drivers/clk/x86/clk-byt-plt.c

-- 
2.5.0
