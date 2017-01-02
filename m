From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/4] ASoC: Intel: clean up Kconfig
Date: Mon,  2 Jan 2017 17:20:13 +0200
Message-ID: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5670D2667F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 16:20:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Clean up Kconfig here:
- select DW_DMAC_CORE because it's mandatory for some modules
- remove redundant selects and dependencies
- rename MFLD_PLATFORM to MID_PLATFORM to show that it covers more than
  Medfield

Since v2:
- add three more patches
- rebase on top of latest linux-next

Andy Shevchenko (4):
  ASoC: Intel: select DW_DMAC_CORE since it's mandatory
  ASoC: Intel: remove redundant select SND_SOC_INTEL_SST
  ASoC: Intel: remove ignored dependencies
  ASoC: Intel: rename SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM

 sound/soc/intel/Kconfig       | 46 ++++++++++++++-----------------------------
 sound/soc/intel/Makefile      |  2 +-
 sound/soc/intel/atom/Makefile |  7 ++++---
 3 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.11.0
