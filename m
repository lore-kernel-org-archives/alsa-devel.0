From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 8/9] ASoC: Intel: cnl: add dsp ops for
	cannonlake
Date: Wed,  2 Aug 2017 21:51:19 +0530
Message-ID: <20170802162120.8935-9-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 12849267346
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:49 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Add cannonlake dsp support by adding its dsp_ops.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index c6b60ee5b196..bfb3332a77ca 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -22,6 +22,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include "skl-sst-dsp.h"
+#include "cnl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 #include "skl.h"
 #include "../common/sst-dsp.h"
@@ -231,6 +232,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
+	{
+		.id = 0x9dc8,
+		.num_cores = 4,
+		.loader_ops = bxt_get_loader_ops,
+		.init = cnl_sst_dsp_init,
+		.init_fw = cnl_sst_init_fw,
+		.cleanup = cnl_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
-- 
2.13.0
