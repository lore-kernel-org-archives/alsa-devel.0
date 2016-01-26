From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: imx-spdif: Fix crash on suspend
Date: Tue, 26 Jan 2016 13:54:15 +0100
Message-ID: <1453812855-23654-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-233.synserver.de (smtp-out-188.synserver.de
 [212.40.185.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 19BF1260412
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 13:54:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

When registering a ASoC card the driver data of the parent device is set to
point to the card. This driver data is used in the
snd_soc_suspend()/resume() callbacks.

The imx-spdif driver overwrites the driver data with custom data which
causes snd_soc_suspend() to crash.  Since the custom driver is not used
anywhere simply deleting the line which sets the custom driver data fixes
the issue.

Fixes: 43ac946922b3 ("ASoC: imx-spdif: add snd_soc_pm_ops for spdif machine driver")
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/imx-spdif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index a407e83..fb896b2 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -72,8 +72,6 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 	}
 
-	platform_set_drvdata(pdev, data);
-
 end:
 	of_node_put(spdif_np);
 
-- 
2.1.4
