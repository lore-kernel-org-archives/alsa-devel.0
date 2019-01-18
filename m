From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 4/5] ASoC: fsl_spdif: don't print EPROBE_DEFER as error
Date: Fri, 18 Jan 2019 10:06:55 +0100
Message-ID: <20190118090656.14201-4-stefan@agner.ch>
References: <20190118090656.14201-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 740b90df44bb..a26686e7281c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1320,7 +1320,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
-	if (ret)
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
 
 	return ret;
-- 
2.20.1
