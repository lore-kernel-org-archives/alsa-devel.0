From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/5] ASoC: fsl_spdif: don't print EPROBE_DEFER
	as error
Date: Thu, 17 Jan 2019 10:06:36 +0100
Message-ID: <20190117090640.12972-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by alsa0.perex.cz (Postfix) with ESMTP id C5ABD266A7C
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 10:06:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Stefan Agner <stefan@agner.ch>, lgirdwood@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Signed-off-by: Stefan Agner <stefan@agner.ch>
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
