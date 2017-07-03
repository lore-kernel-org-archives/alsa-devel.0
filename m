From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: explicitly add the
	headers sst-dsp.h
Date: Mon,  3 Jul 2017 13:54:46 +0530
Message-ID: <20170703082447.2304-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5305C266884
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 10:25:02 +0200 (CEST)
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

From: Vinod Koul <vinod.koul@intel.com>

Commit bdd0384a5ada ("ASoC: Intel: Skylake: Add support to read firmware
registers") introduced firmware register read so added sst-dsp-priv.h but
missed adding sst-dsp.h as that leads to below compiler warning:

   In file included from sound/soc/intel/skylake/skl-debug.c:23:0:
>> sound/soc/intel/skylake/../common/sst-dsp-priv.h:63:42: warning:
'struct sst_pdata' declared inside parameter list [enabled by default]
     int (*init)(struct sst_dsp *sst, struct sst_pdata *pdata);
                                             ^
>> sound/soc/intel/skylake/../common/sst-dsp-priv.h:63:42: warning:
its scope is only this definition or declaration, which is probably
not what you want [enabled by default]

So add the missing header.

Fixes: bdd0384a5ada ("ASoC: Intel: Skylake: Add support to read firmware registers")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 75497b1fda45..34d06abbf796 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -20,6 +20,7 @@
 #include "skl-sst-ipc.h"
 #include "skl-tplg-interface.h"
 #include "skl-topology.h"
+#include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
 
 #define MOD_BUF		PAGE_SIZE
-- 
2.13.0
