From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 04/11] ALSA: mpu401: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:37 +0530
Message-ID: <1369039124-32590-4-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f50.google.com (mail-da0-f50.google.com
 [209.85.210.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 228A8261675
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:40 +0200 (CEST)
Received: by mail-da0-f50.google.com with SMTP id i23so2870443dad.9
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:40 -0700 (PDT)
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
 sound/drivers/mpu401/mpu401.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index da1a29b..90a3a7b 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -129,7 +129,6 @@ static int snd_mpu401_probe(struct platform_device *devptr)
 static int snd_mpu401_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
