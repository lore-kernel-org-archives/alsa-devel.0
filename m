From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ASoC: ux500: do not moan on deferrals
Date: Fri, 20 Jan 2017 14:20:11 +0100
Message-ID: <20170120132011.1147-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FB87265A82
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 14:20:15 +0100 (CET)
Received: by mail-lf0-f53.google.com with SMTP id k86so57984914lfi.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 05:20:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

This removes the "error" print on probe deferral, it's
unnecessary and confusing. Also cut a few debug prints we do
not need.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/ux500/mop500.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index ba9fc099cf67..c5a9e98ddd7f 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -103,8 +103,6 @@ static int mop500_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
-
 	mop500_card.dev = &pdev->dev;
 
 	if (np) {
@@ -113,22 +111,12 @@ static int mop500_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
-		__func__, mop500_card.name);
 	platform_set_drvdata(pdev, &mop500_card);
 
 	snd_soc_card_set_drvdata(&mop500_card, NULL);
 
-	dev_dbg(&pdev->dev, "%s: Card %s: num_links = %d\n",
-		__func__, mop500_card.name, mop500_card.num_links);
-	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: name = %s\n",
-		__func__, mop500_card.name, mop500_card.dai_link[0].name);
-	dev_dbg(&pdev->dev, "%s: Card %s: DAI-link 0: stream_name = %s\n",
-		__func__, mop500_card.name,
-		mop500_card.dai_link[0].stream_name);
-
 	ret = snd_soc_register_card(&mop500_card);
-	if (ret)
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev,
 			"Error: snd_soc_register_card failed (%d)!\n", ret);
 
@@ -139,8 +127,6 @@ static int mop500_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
 
-	pr_debug("%s: Enter.\n", __func__);
-
 	snd_soc_unregister_card(mop500_card);
 	mop500_ab8500_remove(mop500_card);
 	mop500_of_node_put();
-- 
2.9.3
