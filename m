From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Date: Sat, 20 Apr 2019 15:41:04 +0000
Message-ID: <20190420154038.14576-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 566E4F807B6
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2019 17:41:06 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SAI provide multiple master clock source options selectable
via bit MSEL of TCR2/RCR2.

All possible master clock sources are stored in sai->mclk_clk
array. Current implementation assumes that MCLK0 source is always
busclk, but this is wrong!

For example, on i.MX8QM we have:

00b - Bus Clock selected.
01b - Master Clock (MCLK) 1 option selected.
10b - Master Clock (MCLK) 2 option selected.
11b - Master Clock (MCLK) 3 option selected.

while on i.MX6SX we have:

00b - Master Clock (MCLK) 1 option selected.
01b - Master Clock (MCLK) 1 option selected.
10b - Master Clock (MCLK) 2 option selected.
11b - Master Clock (MCLK) 3 option selected.

So, this patch will read mclk0 source clock from device tree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d2a4dc744fd7..faa8de87ff83 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->bus_clk = NULL;
 	}
 
-	sai->mclk_clk[0] = sai->bus_clk;
-	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
+	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
 		sprintf(tmp, "mclk%d", i);
 		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
 		if (IS_ERR(sai->mclk_clk[i])) {
-- 
2.17.1
