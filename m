From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 1/4] ASoC: imx-spdif: add snd_soc_pm_ops for
	spdif machine driver
Date: Fri, 18 Sep 2015 17:18:48 +0800
Message-ID: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 2565D2604D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:17:16 +0200 (CEST)
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
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

Add snd_soc_pm_ops in machine driver to make the trigger suspend/resume
be called in suspend/resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/imx-spdif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 33da26a..a407e83 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -89,6 +89,7 @@ MODULE_DEVICE_TABLE(of, imx_spdif_dt_ids);
 static struct platform_driver imx_spdif_driver = {
 	.driver = {
 		.name = "imx-spdif",
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_spdif_dt_ids,
 	},
 	.probe = imx_spdif_audio_probe,
-- 
1.9.1
