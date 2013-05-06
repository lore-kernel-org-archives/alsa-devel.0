From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] Input: mips/sgio2audio: Remove redundant
	platform_set_drvdata()
Date: Mon,  6 May 2013 10:16:16 +0530
Message-ID: <1367815576-11875-2-git-send-email-sachin.kamat@linaro.org>
References: <1367815576-11875-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE7D261A89
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 06:59:21 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id kp6so1811381pab.21
 for <alsa-devel@alsa-project.org>; Sun, 05 May 2013 21:59:20 -0700 (PDT)
In-Reply-To: <1367815576-11875-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, Vivien Chappelier <vivien.chappelier@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Vivien Chappelier <vivien.chappelier@linux-mips.org>
---
 sound/mips/sgio2audio.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 01a03ef..cfe99ae 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -963,7 +963,6 @@ static int snd_sgio2audio_remove(struct platform_device *pdev)
 	struct snd_card *card = platform_get_drvdata(pdev);
 
 	snd_card_free(card);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
