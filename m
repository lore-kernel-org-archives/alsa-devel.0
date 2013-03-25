From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: imx-sgtl5000: use of_node to match cpu
	dai
Date: Mon, 25 Mar 2013 11:19:12 +0800
Message-ID: <1364181552-29521-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A4B2615EC
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 04:18:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Since imx-sgtl5000 is only used on DT platform, it makes more sense to
use cpu_of_node rather than cpu_dai_name to match cpu dai.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/imx-sgtl5000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 424347e..9584e78 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -148,7 +148,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	data->dai.stream_name = "HiFi";
 	data->dai.codec_dai_name = "sgtl5000";
 	data->dai.codec_of_node = codec_np;
-	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
+	data->dai.cpu_of_node = ssi_np;
 	data->dai.platform_name = "imx-pcm-audio";
 	data->dai.init = &imx_sgtl5000_dai_init;
 	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-- 
1.7.9.5
