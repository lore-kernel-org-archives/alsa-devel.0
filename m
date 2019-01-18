From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/5] ASoC: imx-sgtl5000: lower log level for potential probe deferral cases
Date: Fri, 18 Jan 2019 10:06:53 +0100
Message-ID: <20190118090656.14201-2-stefan@agner.ch>
References: <20190118090656.14201-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc: fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Not finding the codec/SSI instance can be due to probe deferral.
Do not print error messages in those cases.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 594bde3b0ded..9790a2a8ec2d 100644
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
