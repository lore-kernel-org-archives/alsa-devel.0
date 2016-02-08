From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Revert "ASoC: Intel: fix ACPI
	probe regression with Atom DPCM driver"" to the asoc tree
Date: Mon, 08 Feb 2016 18:01:40 +0000
Message-ID: <E1aSq84-0002oL-Es@debutante>
References: <1454908539-14137-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E88AD261531
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:45 +0100 (CET)
In-Reply-To: <1454908539-14137-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Revert "ASoC: Intel: fix ACPI probe regression with Atom DPCM driver"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 902c136fe4f72dfc2a616ad755c72f1ee407f79a Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 8 Feb 2016 10:45:36 +0530
Subject: [PATCH] ASoC: Intel: Revert "ASoC: Intel: fix ACPI probe regression
 with Atom DPCM driver"

This reverts commit dc901a354171 ("ASoC: Intel: fix ACPI probe
regression with Atom DPCM driver") as the fix prevented the probe
on HSW/BDW if Atom-DPCM was selected

Acked-by: Jie Yang <yang.jie@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0.rc3
