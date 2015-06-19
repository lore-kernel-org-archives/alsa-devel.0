From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/6] ASoC: Intel: fix kconfig,
	symbols and sparse
Date: Fri, 19 Jun 2015 23:55:25 +0530
Message-ID: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C466260627
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:23:58 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

So this series has two parts
part 1, first three patches which fix the issue of BYT driver not getting
compiled in -next and then cleans up symbol usage in various driver
Second part fixes (next three) spare warnings on drivers

Vinod Koul (6):
  ASoC: Intel: use CONFIG_SND_SOC for intel boards
  ASoC: Intel: kconfig - Move DW_DMAC_CORE dependency to machines
  ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt
  ASOC: intel - hsw: fix sparse unused varible warn
  ASoC: intel - atom: statify sst_slot_enum_info
  ASoC: Intel -atom: fix sst_platform_compr_ops declaration

 sound/soc/intel/Kconfig                      | 24 +++++++++++++-----------
 sound/soc/intel/Makefile                     |  2 +-
 sound/soc/intel/atom/sst-atom-controls.c     |  2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  1 -
 sound/soc/intel/atom/sst-mfld-platform.h     |  1 +
 sound/soc/intel/haswell/sst-haswell-pcm.c    |  1 -
 6 files changed, 16 insertions(+), 15 deletions(-)

-- 
1.9.1
