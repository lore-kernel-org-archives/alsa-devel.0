From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: spdif: Handle return value of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:00 +0100
Message-ID: <E1daN7U-0003VE-45@debutante>
References: <1500977674-27960-6-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-6-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: spdif: Handle return value of clk_prepare_enable.

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

>From 0f11daf10b4ac6a6c8ea6b39552f119c595b5406 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:32 +0530
Subject: [PATCH] ASoC: samsung: spdif: Handle return value of
 clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/spdif.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 779504f54bc0..cb59911e65c0 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -391,7 +391,9 @@ static int spdif_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err0;
 	}
-	clk_prepare_enable(spdif->pclk);
+	ret = clk_prepare_enable(spdif->pclk);
+	if (ret)
+		goto err0;
 
 	spdif->sclk = devm_clk_get(&pdev->dev, "sclk_spdif");
 	if (IS_ERR(spdif->sclk)) {
@@ -399,7 +401,9 @@ static int spdif_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err1;
 	}
-	clk_prepare_enable(spdif->sclk);
+	ret = clk_prepare_enable(spdif->sclk);
+	if (ret)
+		goto err1;
 
 	/* Request S/PDIF Register's memory region */
 	if (!request_mem_region(mem_res->start,
-- 
2.13.2
