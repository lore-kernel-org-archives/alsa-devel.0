From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 10/11] ALSA: sh: aica: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:43 +0530
Message-ID: <1369039124-32590-10-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E7FD261A64
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:53:04 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id kl13so5479445pab.20
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:53:03 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, Adrian McMenamin <adrian@mcmen.demon.co.uk>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---
 sound/sh/aica.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index e59a73a..78a3697 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -598,7 +598,6 @@ static int snd_aica_remove(struct platform_device *devptr)
 		return -ENODEV;
 	snd_card_free(dreamcastcard->card);
 	kfree(dreamcastcard);
-	platform_set_drvdata(devptr, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
