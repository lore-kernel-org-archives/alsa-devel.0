From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/4] ASoC: mxs-sgtl5000: Convert to
 devm_snd_soc_register_card
Date: Sun, 30 Aug 2015 17:20:01 +0800
Message-ID: <1440926401.19424.6.camel@ingics.com>
References: <1440926161.19424.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 630FA260425
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 11:20:06 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so106865985pac.2
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 02:20:05 -0700 (PDT)
In-Reply-To: <1440926161.19424.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 6e6fce6..2b23ffb 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -142,7 +142,7 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -154,12 +154,8 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 
 static int mxs_sgtl5000_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
 	mxs_saif_put_mclk(0);
 
-	snd_soc_unregister_card(card);
-
 	return 0;
 }
 
-- 
2.1.0
