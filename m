From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 1/2] ASoC: fsl_ssi: Remove unneeded
	'i2s-slave' property
Date: Mon, 29 Sep 2014 23:25:29 -0300
Message-ID: <1412043930-15243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 428B12606B2
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 04:26:49 +0200 (CEST)
Received: by mail-yk0-f180.google.com with SMTP id q9so1358930ykb.39
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 19:26:48 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to use 'i2s-slave' property, since master/slave configuration
are passed via machine layer.

This change does not break existing users because they do check for slave
mode inside sound/soc/fsl/mpc8610_hpcd.c/p1022_ds.c/p1022_rdk.c

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Timur Tabi <timur@tabi.org>
---
Changes since v2:
- Added Timur's Ack and CC the alsa-list
Changes since v1:
- None

 sound/soc/fsl/fsl_ssi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2fc3e66..0e7ce50 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1285,9 +1285,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
 			ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
-		else if (!strcmp(sprop, "i2s-slave"))
-			ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
-				SND_SOC_DAIFMT_CBM_CFM;
 	}
 
 	ssi_private->use_dma = !of_property_read_bool(np,
-- 
1.9.1
