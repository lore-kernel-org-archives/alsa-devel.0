From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx-spdif: Remove error message upon
	devm_kzalloc() failure
Date: Mon,  2 Dec 2013 00:41:24 -0200
Message-ID: <1385952084-20149-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
 [209.85.216.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 28BDD26165F
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 03:41:40 +0100 (CET)
Received: by mail-qa0-f41.google.com with SMTP id j5so3828633qaq.7
 for <alsa-devel@alsa-project.org>; Sun, 01 Dec 2013 18:41:39 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to have a specific OOM message, since there is generic MM out of memory
message in place.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-spdif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 8499d52..980dd1f 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -35,7 +35,6 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
 		ret = -ENOMEM;
 		goto end;
 	}
-- 
1.8.1.2
