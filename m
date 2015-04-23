From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: fix the makefile for atom code
Date: Thu, 23 Apr 2015 14:38:13 +0530
Message-ID: <1429780093-11783-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CE43E2614F4
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 11:11:01 +0200 (CEST)
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

The tom code should be using SND_SST_MFLD_PLATFORM and not the baytrail one.
So fix it now

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index cd9aee9871a3..3853ec2ddbc7 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
-obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += atom/
+obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
 
 # Machine support
 obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
-- 
1.7.9.5
