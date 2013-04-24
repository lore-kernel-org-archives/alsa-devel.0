From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/4] ASoC: imx-sgtl5000: Do not enter the
	error path on success
Date: Wed, 24 Apr 2013 11:54:43 -0300
Message-ID: <1366815286-31820-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f175.google.com (mail-ye0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id B0F0726109E
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 16:55:08 +0200 (CEST)
Received: by mail-ye0-f175.google.com with SMTP id q7so219309yen.34
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 07:55:07 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Return on success instead of entering the error path.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Keep of_node_put in the success path.

 sound/soc/fsl/imx-sgtl5000.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 9584e78..5a6aaa3 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -174,6 +174,11 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, data);
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return 0;
+
 clk_fail:
 	clk_put(data->codec_clk);
 fail:
-- 
1.7.9.5
