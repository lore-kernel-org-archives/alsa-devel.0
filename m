From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ep93xx: Remove redundant
	dev_set_drvdata() calls
Date: Wed, 26 Jun 2013 12:02:47 +0100
Message-ID: <1372244567-9770-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B03B2654E9
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 13:02:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The driver core does this and it's never legal to rely on the value of
drvdata if not set in probe() anyway.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/cirrus/ep93xx-ac97.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 3f4f888..f193701 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -398,7 +398,6 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 
 fail:
 	ep93xx_ac97_info = NULL;
-	dev_set_drvdata(&pdev->dev, NULL);
 	return ret;
 }
 
@@ -412,7 +411,6 @@ static int ep93xx_ac97_remove(struct platform_device *pdev)
 	ep93xx_ac97_write_reg(info, AC97GCR, 0);
 
 	ep93xx_ac97_info = NULL;
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
-- 
1.8.3.1
