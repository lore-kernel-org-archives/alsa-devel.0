From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/3] ASoC: fsl_asrc: Use np variable
Date: Fri, 19 Aug 2016 10:31:00 -0300
Message-ID: <1471613461-21654-2-git-send-email-fabio.estevam@nxp.com>
References: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0080.outbound.protection.outlook.com [104.47.42.80])
 by alsa0.perex.cz (Postfix) with ESMTP id AE1C1267528
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 15:33:06 +0200 (CEST)
In-Reply-To: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

The 'np' variable is already assigned to 'pdev->dev.of_node', so use
it to improve readability.

No functional change.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 15f8ba5..a37339a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -879,7 +879,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx35-asrc")) {
+	if (of_device_is_compatible(np, "fsl,imx35-asrc")) {
 		asrc_priv->channel_bits = 3;
 		clk_map[IN] = input_clk_map_imx35;
 		clk_map[OUT] = output_clk_map_imx35;
-- 
1.9.1
