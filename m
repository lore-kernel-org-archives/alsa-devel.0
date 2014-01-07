From: Arnd Bergmann <arnd@arndb.de>
Subject: ASoC: fix new build warning in fsl_ssi
Date: Tue, 07 Jan 2014 13:09:48 +0100
Message-ID: <3842933.k0ltEqM7B8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id E324B2616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 13:09:51 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Commit 6873ee464a9f "ASoC: fsl_ssi: Fix printing return code on clk error"
changed a warning message but got the format string wrong, resulting in
a warning "sound/soc/fsl/fsl_ssi.c:1196:6: warning: format '%d' expects
argument of type 'int', but argument 3 has type 'long int' [-Wformat=]".

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please apply or fold into the original patch, whichever works for you.

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3d74477a..c9d567c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1192,7 +1192,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
 		if (IS_ERR(ssi_private->baudclk))
-			dev_warn(&pdev->dev, "could not get baud clock: %d\n",
+			dev_warn(&pdev->dev, "could not get baud clock: %ld\n",
 				 PTR_ERR(ssi_private->baudclk));
 		else
 			clk_prepare_enable(ssi_private->baudclk);
