From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: cht_bsw_nau8824: Replace
	GFP_ATOMIC with GFP_KERNEL
Date: Fri, 20 Apr 2018 16:14:29 +0530
Message-ID: <1524221072-11040-5-git-send-email-vinod.koul@intel.com>
References: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id CD8642673D2
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 12:40:09 +0200 (CEST)
In-Reply-To: <1524221072-11040-1-git-send-email-vinod.koul@intel.com>
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

In snd_cht_mc_probe which is not atomic context, we use GFP_ATOMIC
flag with memory allocation, fix that by using GFP_KERNEL.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 680f2b3a24f9..072e94b69e57 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -248,7 +248,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct cht_mc_private *drv;
 	int ret_val;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
-- 
2.7.4
