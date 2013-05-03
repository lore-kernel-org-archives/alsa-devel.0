From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/6] ASoC: mid-x86: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 14:39:21 +0530
Message-ID: <1367572164-19523-3-git-send-email-sachin.kamat@linaro.org>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F35772652CD
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:28:44 +0200 (CEST)
Received: by mail-pd0-f169.google.com with SMTP id 14so830445pdc.0
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 02:28:42 -0700 (PDT)
In-Reply-To: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 4139116..78d5825 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -425,7 +425,6 @@ static int snd_mfld_mc_remove(struct platform_device *pdev)
 	free_irq(platform_get_irq(pdev, 0), mc_drv_ctx);
 	snd_soc_unregister_card(&snd_soc_card_mfld);
 	kfree(mc_drv_ctx);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
