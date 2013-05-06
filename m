From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ALSA: mips/hal2: Remove redundant
	platform_set_drvdata()
Date: Mon,  6 May 2013 10:16:15 +0530
Message-ID: <1367815576-11875-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DB68261A88
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 06:59:19 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id wz17so1804245pbc.3
 for <alsa-devel@alsa-project.org>; Sun, 05 May 2013 21:59:17 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, Thomas Bogendoerfer <tsbogend@alpha.fanken.de>
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.fanken.de>
---
 sound/mips/hal2.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 7420c59..2b7f6e8 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -922,7 +922,6 @@ static int hal2_remove(struct platform_device *pdev)
 	struct snd_card *card = platform_get_drvdata(pdev);
 
 	snd_card_free(card);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
