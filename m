From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: don't need compress offload for
	broadwell
Date: Sat, 30 May 2015 15:58:47 +0800
Message-ID: <1432972727-9602-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B91B2605C1
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 09:54:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We don't need compress offload feature for broadwell broadwell machine,
here remove the non exist dependency.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ee03dbd..3a08f79 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -79,7 +79,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \
 		   I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_INTEL_HASWELL
-	select SND_COMPRESS_OFFLOAD
 	select SND_SOC_RT286
 	help
 	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
-- 
1.9.1
