From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl_spdif: Drop hard code in
	clk_get() for rxclk
Date: Fri, 25 Apr 2014 19:58:20 +0800
Message-ID: <bf607f313232705658df1043c78319f4e8aa60e8.1398427055.git.Guangyu.Chen@freescale.com>
References: <cover.1398427055.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E045261A12
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:56:51 +0200 (CEST)
In-Reply-To: <cover.1398427055.git.Guangyu.Chen@freescale.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Then we will no longer need to change the name in dev_err() if one day
we are going to change the DEFAULT_RXCLK_SRC.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4ce4ffa..29b5da2 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1165,9 +1165,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	/* Select clock source for rx/tx clock */
-	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
+	sprintf(tmp, "rxtx%d", DEFAULT_RXCLK_SRC);
+	spdif_priv->rxclk = devm_clk_get(&pdev->dev, tmp);
 	if (IS_ERR(spdif_priv->rxclk)) {
-		dev_err(&pdev->dev, "no rxtx1 clock in devicetree\n");
+		dev_err(&pdev->dev, "no %s clock in devicetree\n", tmp);
 		return PTR_ERR(spdif_priv->rxclk);
 	}
 	spdif_priv->rxclk_src = DEFAULT_RXCLK_SRC;
-- 
1.8.4
