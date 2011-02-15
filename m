From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 5/5] ASoC: mfld_machine: make use of
	soc_register_card API
Date: Tue, 15 Feb 2011 18:28:55 +0530
Message-ID: <1297774735-32184-6-git-send-email-vinod.koul@intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 93BD41038AC
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:13 +0100 (CET)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch removes the old method of soc-audio device creation in mfld machine
and makes use of new soc_register_card API to register the card

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 96487fb..429aa1b 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -392,25 +392,17 @@ static int __devinit snd_mfld_mc_probe(struct platform_device *pdev)
 		pr_err("cannot register IRQ\n");
 		goto unalloc;
 	}
-	/* create soc device */
-	mc_drv_ctx->socdev = platform_device_alloc("soc-audio", -1);
-	if (!mc_drv_ctx->socdev) {
-		pr_err("soc-audio device allocation failed\n");
-		ret_val = -ENOMEM;
-		goto freeirq;
-	}
-	platform_set_drvdata(mc_drv_ctx->socdev, &snd_soc_card_mfld);
-	ret_val = platform_device_add(mc_drv_ctx->socdev);
+	/* register the soc card */
+	snd_soc_card_mfld.dev = &pdev->dev;
+	ret_val = snd_soc_register_card(&snd_soc_card_mfld);
 	if (ret_val) {
-		pr_err("Unable to add soc-audio device, err %d\n", ret_val);
-		goto unregister;
+		pr_debug("snd_soc_register_card failed %d\n", ret_val);
+		goto freeirq;
 	}
 	platform_set_drvdata(pdev, mc_drv_ctx);
 	pr_debug("successfully exited probe\n");
 	return ret_val;
 
-unregister:
-	platform_device_put(mc_drv_ctx->socdev);
 freeirq:
 	free_irq(irq, mc_drv_ctx);
 unalloc:
@@ -424,7 +416,7 @@ static int __devexit snd_mfld_mc_remove(struct platform_device *pdev)
 
 	pr_debug("snd_mfld_mc_remove called\n");
 	free_irq(platform_get_irq(pdev, 0), mc_drv_ctx);
-	platform_device_unregister(mc_drv_ctx->socdev);
+	snd_soc_unregister_card(&snd_soc_card_mfld);
 	kfree(mc_drv_ctx);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
-- 
1.7.2.3
