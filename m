From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: imx-sgtl5000: Do a sanity check on
	the codec clock
Date: Wed, 17 Apr 2013 20:55:20 -0300
Message-ID: <1366242921-16376-3-git-send-email-festevam@gmail.com>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 641D02625D4
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 01:55:51 +0200 (CEST)
Received: by mail-gh0-f179.google.com with SMTP id z12so269975ghb.38
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 16:55:50 -0700 (PDT)
In-Reply-To: <1366242921-16376-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Only turn on the codec clock if it is within the valid range.

Also, disable the codec clock on the clk_fail path.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 9c286e6..18af815 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -56,6 +56,15 @@ static const struct snd_soc_dapm_widget imx_sgtl5000_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
+static int sgtl5000_is_valid_sysclk(int freq)
+{
+
+	if (freq < 8000000 || freq > 27000000)
+		return -EINVAL;
+	else
+		return 0;
+}
+
 static int imx_sgtl5000_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -135,9 +144,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->clk_frequency = clk_get_rate(data->codec_clk);
-	clk_prepare_enable(data->codec_clk);
+	data->clk_frequency = clk_get_rate(data->codec_clk);
+	ret = sgtl5000_is_valid_sysclk(data->clk_frequency);
+	if (ret)
+		goto fail;
 
+	clk_prepare_enable(data->codec_clk);
+
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
 	data->dai.codec_dai_name = "sgtl5000";
@@ -172,6 +185,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	return 0;
 
 clk_fail:
+	clk_disable_unprepare(data->codec_clk);
 	clk_put(data->codec_clk);
 fail:
 	if (ssi_np)
-- 
1.7.9.5
