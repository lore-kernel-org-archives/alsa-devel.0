From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 3/4] ASoC: esai: Add VF610+ compatibles
	support.
Date: Fri, 4 Apr 2014 15:10:28 +0800
Message-ID: <1396595429-16629-4-git-send-email-Li.Xiubo@freescale.com>
References: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 1467D265756
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 09:54:57 +0200 (CEST)
In-Reply-To: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, Guangyu.Chen@freescale.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 67d5417..b49b78d 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -818,6 +818,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 
 static const struct of_device_id fsl_esai_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esai", },
+	{ .compatible = "fsl,vf610-esai", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
-- 
1.8.4
