From: Andreas Pretzsch <apr@cn-eng.de>
Subject: [PATCH] ASoC: fsl: imx-wm8962: Fix missing audmux
	external port setup check
Date: Fri, 23 Aug 2013 16:37:51 +0200
Message-ID: <1377268671-678-1-git-send-email-apr@cn-eng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mars-solutions.de (mail.mars-solutions.de
 [213.239.212.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A11265587
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 16:38:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.mars-solutions.de (Postfix) with ESMTP id B450A2A409D
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 16:37:50 +0200 (CEST)
Received: from mail.mars-solutions.de ([127.0.0.1])
 by localhost (mars-solutions.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JiQMvpj3AAaK for <alsa-devel@alsa-project.org>;
 Fri, 23 Aug 2013 16:37:50 +0200 (CEST)
Received: from ws-apr.office.loc
 (HSI-KBW-109-193-024-214.hsi7.kabel-badenwuerttemberg.de [109.193.24.214])
 by mail.mars-solutions.de (Postfix) with ESMTP id 1143C2A409D
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 16:37:50 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Return value of imx_audmux_v2_configure_port(ext_port, ...) was not
assigned. Following check tested the preceding call (int_port).

Signed-off-by: Andreas Pretzsch <apr@cn-eng.de>
---
Fix not tested (no matching hardware), only noticed during code reading.

Patch against
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/wm8962

 sound/soc/fsl/imx-wm8962.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 52a36a9..e018632 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -192,7 +192,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "audmux internal port setup failed\n");
 		return ret;
 	}
-	imx_audmux_v2_configure_port(ext_port,
+	ret = imx_audmux_v2_configure_port(ext_port,
 			IMX_AUDMUX_V2_PTCR_SYN,
 			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
 	if (ret) {
-- 
1.7.10.4
