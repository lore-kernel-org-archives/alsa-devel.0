From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: mfld: Use devm_snd_soc_register_card
Date: Tue, 17 Sep 2013 09:49:04 +0530
Message-ID: <1379391544-6262-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id ED208261AEC
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 06:37:22 +0200 (CEST)
Received: by mail-pb0-f49.google.com with SMTP id xb4so4938102pbc.8
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 21:37:22 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_card makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/mid-x86/mfld_machine.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index ee36384..d3d4c32 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -400,7 +400,7 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 	}
 	/* register the soc card */
 	snd_soc_card_mfld.dev = &pdev->dev;
-	ret_val = snd_soc_register_card(&snd_soc_card_mfld);
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_mfld);
 	if (ret_val) {
 		pr_debug("snd_soc_register_card failed %d\n", ret_val);
 		return ret_val;
@@ -410,20 +410,12 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int snd_mfld_mc_remove(struct platform_device *pdev)
-{
-	pr_debug("snd_mfld_mc_remove called\n");
-	snd_soc_unregister_card(&snd_soc_card_mfld);
-	return 0;
-}
-
 static struct platform_driver snd_mfld_mc_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "msic_audio",
 	},
 	.probe = snd_mfld_mc_probe,
-	.remove = snd_mfld_mc_remove,
 };
 
 module_platform_driver(snd_mfld_mc_driver);
-- 
1.7.9.5
