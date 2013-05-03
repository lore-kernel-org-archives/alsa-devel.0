From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: atmel: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 12:26:28 +0530
Message-ID: <1367564188-14674-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 26004261646
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 09:09:24 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id rr4so758154pbb.41
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 00:09:24 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, nicolas.ferre@atmel.com, egtvedt@samfundet.no
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/atmel/abdac.c |    2 --
 sound/atmel/ac97c.c |    2 --
 2 files changed, 4 deletions(-)

diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index 071ce1b..872d59e 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -583,8 +583,6 @@ static int atmel_abdac_remove(struct platform_device *pdev)
 	free_irq(dac->irq, dac);
 	snd_card_free(card);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 6b7e2b5..ae63d22 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1199,8 +1199,6 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 	snd_card_set_dev(card, NULL);
 	snd_card_free(card);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5
