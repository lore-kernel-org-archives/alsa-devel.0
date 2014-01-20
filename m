From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl_ssi: We do support master mode
	now
Date: Mon, 20 Jan 2014 17:35:40 -0200
Message-ID: <1390246540-23082-2-git-send-email-festevam@gmail.com>
References: <1390246540-23082-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f180.google.com (mail-gg0-f180.google.com
 [209.85.161.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 52FFB2619D0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 20:35:58 +0100 (CET)
Received: by mail-gg0-f180.google.com with SMTP id q3so2283586gge.11
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 11:35:56 -0800 (PST)
In-Reply-To: <1390246540-23082-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit aafa85e71a (ASoC: fsl_ssi: Add DAI master mode support for SSI on
i.MX series) master mode is supported, so update the comments and code to
reflect that.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3155611..e24c7fe 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1278,18 +1278,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	hw_type = (enum fsl_ssi_type) of_id->data;
 
-	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop) {
 		dev_err(&pdev->dev, "fsl,mode property is necessary\n");
 		return -EINVAL;
 	}
-	if (!strcmp(sprop, "ac97-slave")) {
+	if (!strcmp(sprop, "ac97-slave"))
 		ac97 = true;
-	} else if (strcmp(sprop, "i2s-slave")) {
-		dev_notice(&pdev->dev, "mode %s is unsupported\n", sprop);
-		return -ENODEV;
-	}
 
 	/* The DAI name is the last part of the full name of the node. */
 	p = strrchr(np->full_name, '/') + 1;
-- 
1.8.1.2
