From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: txx9aclc_ac97: Fix kernel crash on probe
Date: Sat, 15 Feb 2014 23:28:29 +0400
Message-ID: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.176.129])
 by alsa0.perex.cz (Postfix) with ESMTP id D77DB261629
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 20:28:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This patch fixes a crash caused by commit af5b2d7519
(ASoC: txx9aclc_ac97: Convert to devm_ioremap_resource()).
This is an attempt to assign "drvdata->base" while memory
for "drvdata" is not already allocated.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/txx9/txx9aclc-ac97.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index e0305a1..9edd68d 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -183,14 +183,16 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
 	platform_set_drvdata(pdev, drvdata);
 	drvdata->physbase = r->start;
 	if (sizeof(drvdata->physbase) > sizeof(r->start) &&
-- 
1.8.3.2
