From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 5/5] ASoC: imx-sgtl5000: lower log level for potential probe deferral cases
Date: Thu, 17 Jan 2019 10:06:40 +0100
Message-ID: <20190117090640.12972-5-stefan@agner.ch>
References: <20190117090640.12972-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

Not finding the codec/SSI instance can be due to probe deferral.
Do not print error messages in those cases.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 45969e6dfad7..b6cb80480b60 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -104,13 +104,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
-		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		dev_dbg(&pdev->dev, "failed to find SSI platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
-- 
2.20.1
