From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] ASoC: pxa2xx-i2s: Convert to
 devm_snd_soc_register_component
Date: Fri, 28 Aug 2015 10:49:44 +0800
Message-ID: <1440730184.11149.1.camel@ingics.com>
References: <1440730115.11149.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FF1D265CF4
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 04:49:49 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so45956454pac.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 19:49:48 -0700 (PDT)
In-Reply-To: <1440730115.11149.0.camel@ingics.com>
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
 sound/soc/pxa/pxa2xx-i2s.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index e68290c..6b4e400 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -367,19 +367,12 @@ static const struct snd_soc_component_driver pxa_i2s_component = {
 
 static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev, &pxa_i2s_component,
-					  &pxa_i2s_dai, 1);
-}
-
-static int pxa2xx_i2s_drv_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &pxa_i2s_component,
+					       &pxa_i2s_dai, 1);
 }
 
 static struct platform_driver pxa2xx_i2s_driver = {
 	.probe = pxa2xx_i2s_drv_probe,
-	.remove = pxa2xx_i2s_drv_remove,
 
 	.driver = {
 		.name = "pxa2xx-i2s",
-- 
2.1.0
