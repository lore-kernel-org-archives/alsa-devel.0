From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] ASoC: pxa-ssp: Convert to
 devm_snd_soc_register_component
Date: Fri, 28 Aug 2015 10:48:35 +0800
Message-ID: <1440730115.11149.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FECE260469
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 04:48:41 +0200 (CEST)
Received: by padfo6 with SMTP id fo6so7205467pad.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 19:48:40 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/pxa/pxa-ssp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index fbe2e93..3da485e 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -813,14 +813,8 @@ static const struct of_device_id pxa_ssp_of_ids[] = {
 
 static int asoc_ssp_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev, &pxa_ssp_component,
-					  &pxa_ssp_dai, 1);
-}
-
-static int asoc_ssp_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &pxa_ssp_component,
+					       &pxa_ssp_dai, 1);
 }
 
 static struct platform_driver asoc_ssp_driver = {
@@ -830,7 +824,6 @@ static struct platform_driver asoc_ssp_driver = {
 	},
 
 	.probe = asoc_ssp_probe,
-	.remove = asoc_ssp_remove,
 };
 
 module_platform_driver(asoc_ssp_driver);
-- 
2.1.0
