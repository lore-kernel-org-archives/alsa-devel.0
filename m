From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Use
	devm_snd_soc_register_card()
Date: Thu, 19 Dec 2013 11:59:54 +0800
Message-ID: <1387425594-32469-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F2D82652C7
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 05:51:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7a9b6b4..3d190d0 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -234,14 +234,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	cinfo->snd_card.num_links	= 1;
 	cinfo->snd_card.dev		= &pdev->dev;
 
-	return snd_soc_register_card(&cinfo->snd_card);
-}
-
-static int asoc_simple_card_remove(struct platform_device *pdev)
-{
-	struct asoc_simple_card_info *cinfo = pdev->dev.platform_data;
-
-	return snd_soc_unregister_card(&cinfo->snd_card);
+	return devm_snd_soc_register_card(&pdev->dev, &cinfo->snd_card);
 }
 
 static const struct of_device_id asoc_simple_of_match[] = {
@@ -257,7 +250,6 @@ static struct platform_driver asoc_simple_card = {
 		.of_match_table = asoc_simple_of_match,
 	},
 	.probe		= asoc_simple_card_probe,
-	.remove		= asoc_simple_card_remove,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
1.8.4
