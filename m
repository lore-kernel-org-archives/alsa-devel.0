From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 01/11] ALSA: pxa2xx-ac97: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:34 +0530
Message-ID: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D5D26109E
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:31 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id x11so1295776pdj.29
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:30 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org, Eric Miao <eric.y.miao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 sound/arm/pxa2xx-ac97.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index ec54be4..ce431e6 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -230,7 +230,6 @@ static int pxa2xx_ac97_remove(struct platform_device *dev)
 
 	if (card) {
 		snd_card_free(card);
-		platform_set_drvdata(dev, NULL);
 		pxa2xx_ac97_hw_remove(dev);
 	}
 
-- 
1.7.9.5
