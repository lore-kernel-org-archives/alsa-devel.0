From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: No need call
	of_device_is_available()
Date: Thu,  7 May 2015 23:24:16 -0300
Message-ID: <1431051856-22476-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DD9D2610A6
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 04:24:42 +0200 (CEST)
Received: by ykft189 with SMTP id t189so16795567ykf.1
 for <alsa-devel@alsa-project.org>; Thu, 07 May 2015 19:24:41 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The comment and the call to of_device_is_available() are not really
needed.

It is the expected behaviour to probe only the ssi nodes that are
enabled in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0d48804..c7647e0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1292,13 +1292,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	void __iomem *iomem;
 	char name[64];
 
-	/* SSIs that are not connected on the board should have a
-	 *      status = "disabled"
-	 * property in their device tree nodes.
-	 */
-	if (!of_device_is_available(np))
-		return -ENODEV;
-
 	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
-- 
1.9.1
