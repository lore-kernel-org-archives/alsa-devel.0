From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: pcm: Handle return value of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:06 +0100
Message-ID: <E1daN7a-0003XG-AM@debutante>
References: <1500977674-27960-4-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-4-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: pcm: Handle return value of clk_prepare_enable.

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

>From a7ad9a88300c813a945793e9dae84ceaf7809141 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:30 +0530
Subject: [PATCH] ASoC: samsung: pcm: Handle return value of
 clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/pcm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index d50a6377c23d..37f95eee1558 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -522,7 +522,9 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get audio-bus clock\n");
 		return PTR_ERR(pcm->cclk);
 	}
-	clk_prepare_enable(pcm->cclk);
+	ret = clk_prepare_enable(pcm->cclk);
+	if (ret)
+		return ret;
 
 	/* record our pcm structure for later use in the callbacks */
 	dev_set_drvdata(&pdev->dev, pcm);
@@ -533,7 +535,9 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 		ret = PTR_ERR(pcm->pclk);
 		goto err_dis_cclk;
 	}
-	clk_prepare_enable(pcm->pclk);
+	ret = clk_prepare_enable(pcm->pclk);
+	if (ret)
+		goto err_dis_cclk;
 
 	s3c_pcm_stereo_in[pdev->id].addr = mem_res->start + S3C_PCM_RXFIFO;
 	s3c_pcm_stereo_out[pdev->id].addr = mem_res->start + S3C_PCM_TXFIFO;
-- 
2.13.2
