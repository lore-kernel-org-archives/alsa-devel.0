From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 05/11] ALSA: mtpav: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:38 +0530
Message-ID: <1369039124-32590-5-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f53.google.com (mail-da0-f53.google.com
 [209.85.210.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 902C526109E
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:45 +0200 (CEST)
Received: by mail-da0-f53.google.com with SMTP id t11so3768426daj.12
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:44 -0700 (PDT)
In-Reply-To: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/drivers/mtpav.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 9f1815b..e5ec7eb 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -749,7 +749,6 @@ static int snd_mtpav_probe(struct platform_device *dev)
 static int snd_mtpav_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
