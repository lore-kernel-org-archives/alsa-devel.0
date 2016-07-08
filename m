From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: cht: fix uninit variable
	warning
Date: Fri,  8 Jul 2016 18:30:17 +0530
Message-ID: <1467982818-4528-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 753B2265930
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:53:13 +0200 (CEST)
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

Kbuild bot reports that we might use dai_index uninitialized.

sound/soc/intel/boards/cht_bsw_rt5645.c:391:37: warning: 'dai_index' may be used uninitialized in this function [-Wmaybe-uninitialized]

Since it is theoretically possible, set it while initializing.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f26c7b8545ae..56056ed7fcfd 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -357,7 +357,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	char codec_name[16];
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
-	int dai_index;
+	int dai_index = 0;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
-- 
1.9.1
