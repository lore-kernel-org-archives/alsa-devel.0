From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs: mxs-saif: Register the irq with the
	device name
Date: Mon, 10 Nov 2014 17:49:30 -0200
Message-ID: <1415648970-14383-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 15026265AF0
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 20:49:59 +0100 (CET)
Received: by mail-qa0-f48.google.com with SMTP id x12so5795891qac.7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:49:58 -0800 (PST)
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

Instead of registering the irq name with the driver name, it's better to pass
the device name so that we have a more explicit indication as to what saif
instance the irq is related:

$ cat /proc/interrupts 
           CPU0       
...
214:          4         -  59  80042000.saif
215:          0         -  58  80046000.saif

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index eade2742..d986508 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -773,7 +773,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 
 	saif->dev = &pdev->dev;
 	ret = devm_request_irq(&pdev->dev, saif->irq, mxs_saif_irq, 0,
-			       "mxs-saif", saif);
+			       dev_name(&pdev->dev), saif);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		return ret;
-- 
1.9.1
