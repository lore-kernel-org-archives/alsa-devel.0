From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/5] ASoC: nuc900: Convert to
	devm_snd_soc_register_platform
Date: Thu, 27 Aug 2015 09:12:17 +0800
Message-ID: <1440637937.18698.4.camel@ingics.com>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D8B46265923
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 03:12:22 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so5689077pab.1
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 18:12:22 -0700 (PDT)
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Xia Kaixu <kaixu.xia@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/nuc900/nuc900-pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 5ae5ca1..e093261 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -308,13 +308,7 @@ static struct snd_soc_platform_driver nuc900_soc_platform = {
 
 static int nuc900_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
-}
-
-static int nuc900_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
 }
 
 static struct platform_driver nuc900_pcm_driver = {
@@ -323,7 +317,6 @@ static struct platform_driver nuc900_pcm_driver = {
 	},
 
 	.probe = nuc900_soc_platform_probe,
-	.remove = nuc900_soc_platform_remove,
 };
 
 module_platform_driver(nuc900_pcm_driver);
-- 
2.1.0
