From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl: imx-audmux: Use devm_clk_get()
Date: Tue, 12 Mar 2013 20:51:28 -0300
Message-ID: <1363132289-15211-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7ED265DCF
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 00:51:46 +0100 (CET)
Received: by mail-ee0-f41.google.com with SMTP id c13so190048eek.28
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 16:51:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

By using devm_clk_get() we can save a call to clk_put().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 3f333e5..47f046a 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -262,7 +262,7 @@ static int imx_audmux_probe(struct platform_device *pdev)
 		return PTR_ERR(pinctrl);
 	}
 
-	audmux_clk = clk_get(&pdev->dev, "audmux");
+	audmux_clk = devm_clk_get(&pdev->dev, "audmux");
 	if (IS_ERR(audmux_clk)) {
 		dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
 				PTR_ERR(audmux_clk));
@@ -282,7 +282,6 @@ static int imx_audmux_remove(struct platform_device *pdev)
 {
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_remove();
-	clk_put(audmux_clk);
 
 	return 0;
 }
-- 
1.7.9.5
