From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] ASoC: Intel: fix
	cross-compilation/COMPILE_TEST issues
Date: Thu, 30 May 2019 06:50:10 -0500
Message-ID: <20190530115015.5677-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7045EF8065A
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 13:50:35 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The Intel code has dependencies that aren't defined on all platforms
and prevent COMPILE_TEST from working.

The first patch was submitted as an RFC and includes Takashi
Reviewed-by tag. The second patch was submitted by Randy Dunlap, I
only corrected minor issues to make it more generic. The rest are just
simple fixes to remove useless asm/ headers, make sure all machine
drivers use COMPILE_TEST and add dependencies on CONFIG_PCI to let the
SOF code support COMPILE_TEST.

Tested for the following ARCH: x86_64, i386, ia64, arm, arm64, sh,
mips, openrisc, sparc, m68k, s390

Pierre-Louis Bossart (4):
  ASoC: Intel: use common helpers to detect CPUs
  ASoC: Intel: boards: remove dependency on asm/platform_sst_audio.h
  ASoC: Intel: boards: Add COMPILE_TEST for new machine drivers
  ASoC: SOF: add COMPILE_TEST for PCI options

Randy Dunlap (1):
  ASoc: fix sound/soc/intel/skylake/slk-ssp-clk.c build error on IA64

 sound/soc/intel/Kconfig                       |   9 ++
 sound/soc/intel/atom/sst/sst_acpi.c           |  65 +---------
 sound/soc/intel/boards/Kconfig                |   7 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c |  11 +-
 sound/soc/intel/boards/bytcht_cx2072x.c       |   1 -
 sound/soc/intel/boards/bytcht_da7213.c        |   1 -
 sound/soc/intel/boards/bytcht_es8316.c        |  13 +-
 sound/soc/intel/boards/bytcr_rt5640.c         |  16 +--
 sound/soc/intel/boards/bytcr_rt5651.c         |  17 +--
 sound/soc/intel/boards/cht_bsw_rt5645.c       |  16 +--
 sound/soc/intel/boards/sof_rt5682.c           |  11 +-
 sound/soc/intel/common/soc-intel-quirks.h     | 115 ++++++++++++++++++
 sound/soc/sof/Kconfig                         |   2 +-
 sound/soc/sof/intel/hda.c                     |  13 +-
 sound/soc/sof/sof-acpi-dev.c                  |  57 +--------
 sound/soc/sof/sof-pci-dev.c                   |   4 +
 16 files changed, 164 insertions(+), 194 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-intel-quirks.h

-- 
2.20.1
