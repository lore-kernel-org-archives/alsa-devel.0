From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Add depends on X86
Date: Mon, 23 Oct 2017 09:57:27 +0530
Message-ID: <1508732847-6679-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C7D30266FBD
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 06:23:21 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Make all Intel audio drivers dependent on X86 to avoid compilation
errors for s390 and xtensa architectures.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 1dcc9e456610..a59dda39007e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_ACPI_INTEL_MATCH
 
 config SND_SOC_INTEL_SST_TOPLEVEL
 	tristate "Intel ASoC SST drivers"
+	depends on X86
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
 
-- 
2.7.4
