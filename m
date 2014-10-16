From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: intel: turn off COMPILE_TEST for medfield
Date: Thu, 16 Oct 2014 13:54:29 +0530
Message-ID: <1413447869-23494-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 082BB261524
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 11:00:07 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Since medfield machine uses SCU_IPC which is not availble for all archs, so
compile test fails on these

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 726f7d8..f5b4a9c 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -1,6 +1,6 @@
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
-	depends on INTEL_SCU_IPC || COMPILE_TEST
+	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	select SND_SST_MFLD_PLATFORM
 	help
-- 
1.7.0.4
