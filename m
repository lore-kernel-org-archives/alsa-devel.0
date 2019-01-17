From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/5] ASoC: imx-spdif: don't print EPROBE_DEFER as error
Date: Thu, 17 Jan 2019 10:06:37 +0100
Message-ID: <20190117090640.12972-2-stefan@agner.ch>
References: <20190117090640.12972-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Removing the goto would not be strictly necessary. However, if
code gets added later, the cleanup in the EPROBE_DEFER case likely
would get missed.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/fsl/imx-spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index fb896b2c9ba3..797d66e43d49 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -67,10 +67,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
-	if (ret) {
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
-		goto end;
-	}
 
 end:
 	of_node_put(spdif_np);
-- 
2.20.1
