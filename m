From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 03/11] ALSA: ml403-ac97cr: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:36 +0530
Message-ID: <1369039124-32590-3-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 20CE52610A9
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:37 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id t12so3496199pdi.16
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:37 -0700 (PDT)
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
 sound/drivers/ml403-ac97cr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 8125a7e..95ea4a1 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1325,7 +1325,6 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 static int snd_ml403_ac97cr_remove(struct platform_device *pfdev)
 {
 	snd_card_free(platform_get_drvdata(pfdev));
-	platform_set_drvdata(pfdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
