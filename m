From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 03/11] ASoC: samsung: pcm: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:30 +0530
Message-ID: <1500977674-27960-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/pcm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index d50a637..37f95ee 100644
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
1.9.1
