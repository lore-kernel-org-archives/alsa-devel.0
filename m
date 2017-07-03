From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: explicitly add the
	headers sst-dsp.h" to the asoc tree
Date: Mon, 03 Jul 2017 16:51:12 +0100
Message-ID: <E1dS3d2-0002iu-DN@debutante>
References: <20170703082447.2304-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D51FB26680F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 17:51:23 +0200 (CEST)
In-Reply-To: <20170703082447.2304-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: explicitly add the headers sst-dsp.h

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

>From 58be77537aa12ca0c6c91eaf37902ad5f8c812bd Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 3 Jul 2017 13:54:46 +0530
Subject: [PATCH] ASoC: Intel: Skylake: explicitly add the headers sst-dsp.h

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.1
