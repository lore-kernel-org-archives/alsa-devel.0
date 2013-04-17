From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: imx-sgtl5000: Do not enter the error
	path on success
Date: Wed, 17 Apr 2013 20:55:18 -0300
Message-ID: <1366242921-16376-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f180.google.com (mail-gg0-f180.google.com
 [209.85.161.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E294C261986
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 01:55:47 +0200 (CEST)
Received: by mail-gg0-f180.google.com with SMTP id e5so346727ggk.39
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 16:55:45 -0700 (PDT)
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

Return on success instead of entering the error path.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 9584e78..88fc02c 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -174,6 +174,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, data);
+
+	return 0;
+
 clk_fail:
 	clk_put(data->codec_clk);
 fail:
-- 
1.7.9.5
