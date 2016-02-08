From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Revert "ASoC: Intel: fix ACPI
	probe regression with Atom DPCM driver"
Date: Mon,  8 Feb 2016 10:45:36 +0530
Message-ID: <1454908539-14137-2-git-send-email-vinod.koul@intel.com>
References: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 782EA2604A1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 06:12:09 +0100 (CET)
In-Reply-To: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This reverts commit dc901a354171 ("ASoC: Intel: fix ACPI probe
regression with Atom DPCM driver") as the fix prevented the probe
on HSW/BDW if Atom-DPCM was selected

Acked-by: Jie Yang <yang.jie@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 668fdeee195e..3b9332e7a094 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,10 +1,5 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
-ifneq ($(CONFIG_SND_SST_IPC_ACPI),)
-snd-soc-sst-acpi-objs := sst-match-acpi.o
-else
 snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
-endif
-
 snd-soc-sst-ipc-objs := sst-ipc.o
 
 snd-soc-sst-dsp-$(CONFIG_DW_DMAC_CORE) += sst-firmware.o
-- 
1.9.1
