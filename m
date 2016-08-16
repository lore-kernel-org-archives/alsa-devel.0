From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] Baytrail followup patches
Date: Tue, 16 Aug 2016 18:28:20 -0500
Message-ID: <1471390103-915-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 82EB7265AC9
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 01:28:34 +0200 (CEST)
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
Cc: tiwai@suse.de, sfr@canb.auug.org.au, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

fixes for warnings detected by 0-Day
New quirk for Acer Aspire platforms
Resending clock framework support (for-next audio not working on all platforms
enabling MCLK if this patch is not applied)

Irina Tirdea (1):
  clk: x86: Add Atom PMC platform clocks

Pierre-Louis Bossart (2):
  ASoC: Intel: atom: fix 0-day warnings
  ASoC: Intel: bytcr_rt5640: quirk for Acer Aspire SWS-012

 arch/x86/Kconfig                      |   1 +
 arch/x86/include/asm/pmc_atom.h       |   6 +
 arch/x86/platform/atom/pmc_atom.c     |  55 ++++-
 drivers/clk/x86/Makefile              |   1 +
 drivers/clk/x86/clk-byt-plt.c         | 413 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +-
 sound/soc/intel/boards/bytcr_rt5640.c |  15 +-
 7 files changed, 487 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/x86/clk-byt-plt.c

-- 
2.7.4
