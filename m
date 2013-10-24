From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: fsl: Add missing pm to current machine
	drivers
Date: Thu, 24 Oct 2013 18:15:29 +0800
Message-ID: <1382609729-21954-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 068A32608D8
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 12:15:31 +0200 (CEST)
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Add missing pm to current machine drivers so that all of them would
correctly do suspend/resume.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/imx-mc13783.c  | 1 +
 sound/soc/fsl/imx-sgtl5000.c | 1 +
 sound/soc/fsl/imx-wm8962.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index a3d60d4..8ded5ad 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -160,6 +160,7 @@ static struct platform_driver imx_mc13783_audio_driver = {
 	.driver = {
 		.name = "imx_mc13783",
 		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
 	},
 	.probe = imx_mc13783_probe,
 	.remove = imx_mc13783_remove
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 6f4bdc8..4b65c04 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -201,6 +201,7 @@ static struct platform_driver imx_sgtl5000_driver = {
 	.driver = {
 		.name = "imx-sgtl5000",
 		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_sgtl5000_dt_ids,
 	},
 	.probe = imx_sgtl5000_probe,
diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 6c60666..72064e9 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -310,6 +310,7 @@ static struct platform_driver imx_wm8962_driver = {
 	.driver = {
 		.name = "imx-wm8962",
 		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_wm8962_dt_ids,
 	},
 	.probe = imx_wm8962_probe,
-- 
1.8.4
