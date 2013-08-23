From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: simple-card: Provide owner and
	MODULE_ALIAS()
Date: Fri, 23 Aug 2013 14:35:17 -0300
Message-ID: <1377279317-32175-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f178.google.com (mail-gh0-f178.google.com
 [209.85.160.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A5B2615AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 19:35:27 +0200 (CEST)
Received: by mail-gh0-f178.google.com with SMTP id g15so213804ghb.23
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 10:35:26 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add .owner field and also MODULE_ALIAS(), so that auto module loading can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/generic/simple-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6cf8355..8c49147 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -105,6 +105,7 @@ static int asoc_simple_card_remove(struct platform_device *pdev)
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name	= "asoc-simple-card",
+		.owner = THIS_MODULE,
 	},
 	.probe		= asoc_simple_card_probe,
 	.remove		= asoc_simple_card_remove,
@@ -112,6 +113,7 @@ static struct platform_driver asoc_simple_card = {
 
 module_platform_driver(asoc_simple_card);
 
+MODULE_ALIAS("platform:asoc-simple-card");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ASoC Simple Sound Card");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
1.8.1.2
