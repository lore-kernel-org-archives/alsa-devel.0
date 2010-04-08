From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] imx-ssi: honor IMX_SSI_DMA flag
Date: Thu,  8 Apr 2010 11:31:24 +0200
Message-ID: <1270719086-23453-2-git-send-email-s.hauer@pengutronix.de>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 163B110381F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 11:31:29 +0200 (CEST)
In-Reply-To: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

When checking if we are DMA capable we have to check for the
IMX_SSI_DMA flag which is already set from platform_data instead
of setting it again when we want to do DMA.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-ssi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 6546b06..2a07fd3 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -653,7 +653,8 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	dai->private_data = ssi;
 
 	if ((cpu_is_mx27() || cpu_is_mx21()) &&
-			!(ssi->flags & IMX_SSI_USE_AC97)) {
+			!(ssi->flags & IMX_SSI_USE_AC97) &&
+			(ssi->flags & IMX_SSI_DMA)) {
 		ssi->flags |= IMX_SSI_DMA;
 		platform = imx_ssi_dma_mx2_init(pdev, ssi);
 	} else
-- 
1.7.0
