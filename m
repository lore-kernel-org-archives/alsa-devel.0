From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] ASoC: ep93xx: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 14:39:22 +0530
Message-ID: <1367572164-19523-4-git-send-email-sachin.kamat@linaro.org>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD602652D7
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:30:34 +0200 (CEST)
Received: by mail-pa0-f41.google.com with SMTP id rl6so838934pac.0
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 02:30:33 -0700 (PDT)
In-Reply-To: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, Mika Westerberg <mika.westerberg@iki.fi>, broonie@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/cirrus/ep93xx-ac97.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 7798fbd..840c9b1 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -403,7 +403,6 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
-	platform_set_drvdata(pdev, NULL);
 	ep93xx_ac97_info = NULL;
 	dev_set_drvdata(&pdev->dev, NULL);
 	return ret;
@@ -418,7 +417,6 @@ static int ep93xx_ac97_remove(struct platform_device *pdev)
 	/* disable the AC97 controller */
 	ep93xx_ac97_write_reg(info, AC97GCR, 0);
 
-	platform_set_drvdata(pdev, NULL);
 	ep93xx_ac97_info = NULL;
 	dev_set_drvdata(&pdev->dev, NULL);
 
-- 
1.7.9.5
