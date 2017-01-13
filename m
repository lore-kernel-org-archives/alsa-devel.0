From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 0/4] SoC: Intel: clean up Kconfig
Date: Fri, 13 Jan 2017 14:20:47 +0200
Message-ID: <20170113122051.77831-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B91EE2676D4
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 13:20:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Clean up Kconfig here:
- select DW_DMAC_CORE because it's mandatory for some modules
- remove redundant selects and dependencies
- rename MFLD_PLATFORM to ATOM_HIFI2_PLATFORM to show that it covers more than *Field

Since v4:
- append Vinod's and Liam's ACKs

Since v3:
- use proposed name as SND_SST_ATOM_HIFI2_PLATFORM (Pierre-Louis)
- append Keyon's tag

Since v2:
- add three more patches
- rebase on top of latest linux-next

Andy Shevchenko (4):
  ASoC: Intel: select DW_DMAC_CORE since it's mandatory
  ASoC: Intel: remove redundant select SND_SOC_INTEL_SST
  ASoC: Intel: remove ignored dependencies
  ASoC: Intel: rename SND_SST_MFLD_PLATFORM to
    SND_SST_ATOM_HIFI2_PLATFORM

 sound/soc/intel/Kconfig                      | 46 +++++++++-------------------
 sound/soc/intel/Makefile                     |  2 +-
 sound/soc/intel/atom/Makefile                |  7 +++--
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  1 +
 4 files changed, 21 insertions(+), 35 deletions(-)

-- 
2.11.0
