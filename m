From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add dependency to DW_DMAC for BDW
	platform
Date: Fri,  1 Aug 2014 22:54:19 +0800
Message-ID: <1406904859-30514-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B11E265474
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 16:53:22 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Add dependency to DW_DMAC for broadwell machine, which
have built in DW dma engines.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0b305f9..f5b4a9c7 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -61,7 +61,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC
 	select SND_SOC_INTEL_HASWELL
 	select SND_COMPRESS_OFFLOAD
 	select SND_SOC_RT286
-- 
1.8.3.2
