From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: imx-sgtl5000: Delete unneeded
	test before of_node_put
Date: Tue, 7 Oct 2014 15:13:25 -0300
Message-ID: <1412705605-13646-2-git-send-email-fabio.estevam@freescale.com>
References: <1412705605-13646-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 by alsa0.perex.cz (Postfix) with ESMTP id C00D52604AC
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:13:44 +0200 (CEST)
In-Reply-To: <1412705605-13646-1-git-send-email-fabio.estevam@freescale.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

of_node_put() supports NULL as its argument, so the initial test is not
necessary.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 1cb22dd..1dab963 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -175,10 +175,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 fail:
 	if (data && !IS_ERR(data->codec_clk))
 		clk_put(data->codec_clk);
-	if (ssi_np)
-		of_node_put(ssi_np);
-	if (codec_np)
-		of_node_put(codec_np);
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
 
 	return ret;
 }
-- 
1.9.1
