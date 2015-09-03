From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 1/1] ASoC: fsl_sai: Add missing
	MODULE_DEVICE_TABLE
Date: Thu,  3 Sep 2015 08:04:08 +0200
Message-ID: <1441260248-29170-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 2297526061A
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 08:04:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

This enables module auto-loading when using device tree.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Change in v2:
* Added "Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>"

 sound/soc/fsl/fsl_sai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c73bea..ec14427 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -801,6 +801,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx6sx-sai", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, fsl_sai_ids);
 
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
-- 
2.4.6
