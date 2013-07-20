From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: fsl: fsl_ssi: Add MODULE_ALIAS
Date: Sat, 20 Jul 2013 16:16:01 -0300
Message-ID: <1374347763-18261-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f171.google.com (mail-gh0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id ECFD42608CA
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 21:16:10 +0200 (CEST)
Received: by mail-gh0-f171.google.com with SMTP id f15so1676164ghb.30
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 12:16:10 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add MODULE_ALIAS, so that auto module loading can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c9974a4..429fbfd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -900,6 +900,7 @@ static struct platform_driver fsl_ssi_driver = {
 
 module_platform_driver(fsl_ssi_driver);
 
+MODULE_ALIAS("platform:fsl-ssi-dai");
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.2
