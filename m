From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: imx-sgtl5000: fix error return code in imx_sgtl5000_probe()
Date: Tue, 16 Jul 2013 20:05:07 +0800
Message-ID: <CAPgLHd-cXmWwMq8DMhXbOhykZvnMzxb4HHZ-5ayNnkPU1fqfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, shawn.guo@linaro.org, fabio.estevam@freescale.com, wfp5p@virginia.edu, LW@KARO-electronics.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 7a8bc12..25f310d 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -129,8 +129,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
-	if (IS_ERR(data->codec_clk))
+	if (IS_ERR(data->codec_clk)) {
+		ret = PTR_ERR(data->codec_clk);
 		goto fail;
+	}
 
 	data->clk_frequency = clk_get_rate(data->codec_clk);
 
