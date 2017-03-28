From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk cleanup
Date: Tue, 28 Mar 2017 11:58:52 +0300
Message-ID: <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 513FA266703
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 10:59:04 +0200 (CEST)
In-Reply-To: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Resource managed devm_clk_get only works with platform's device dev.

Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/imx-wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 3d894d9..52659fa 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
+	codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(codec_clk)) {
 		ret = PTR_ERR(codec_clk);
 		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
@@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	}
 
 	data->clk_frequency = clk_get_rate(codec_clk);
+	clk_put(codec_clk);
 
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
-- 
2.7.4
