From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_ssi: Use '%ld' to print 'long
	int'
Date: Tue,  7 Jan 2014 08:00:13 -0200
Message-ID: <1389088813-14405-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f52.google.com (mail-yh0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 01606261689
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 11:00:31 +0100 (CET)
Received: by mail-yh0-f52.google.com with SMTP id i7so3842753yha.25
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 02:00:29 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shc_work@mail.ru
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 6873ee464a (ASoC: fsl_ssi: Fix printing return code on clk error) caused
the following build warning:

sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:1196:6: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat]

Fix it by using '%ld' to print the 'long int' format.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.1.2
