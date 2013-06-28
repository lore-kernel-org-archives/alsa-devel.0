From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: mfld: Remove unused variable
Date: Fri, 28 Jun 2013 12:11:46 +0100
Message-ID: <1372417906-25873-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 730452617A5
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 13:11:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/mid-x86/mfld_machine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index aec29a8..ee36384 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -412,8 +412,6 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 static int snd_mfld_mc_remove(struct platform_device *pdev)
 {
-	struct mfld_mc_private *mc_drv_ctx = platform_get_drvdata(pdev);
-
 	pr_debug("snd_mfld_mc_remove called\n");
 	snd_soc_unregister_card(&snd_soc_card_mfld);
 	return 0;
-- 
1.8.3.1
