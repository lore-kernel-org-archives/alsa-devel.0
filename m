From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/6] ASoC: Intel: use CONFIG_SND_SOC for intel
	boards
Date: Fri, 19 Jun 2015 23:55:26 +0530
Message-ID: <1434738331-12518-2-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 12D14260629
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:23:58 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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

The Intel boards directory was under CONFIG_SND_SOC_INTEL_SST so the
machines which don't need these were not allowed to be
selected/compiled without enabling this symbol The machine should be
allowed to selected by ASoC and then they should select rest of
symbols required

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 3853ec2ddbc7..6de5d5cd3280 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
 
 # Machine support
-obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
+obj-$(CONFIG_SND_SOC) += boards/
-- 
1.9.1
