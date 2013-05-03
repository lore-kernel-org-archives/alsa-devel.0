From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] ASoC: Samsung: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 14:39:19 +0530
Message-ID: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C7BB2652D7
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:28:58 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id t10so831210pdi.39
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 02:28:57 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@kernel.org, Sangbeom Kim <sbkim73@samsung.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/smdk_wm8580pcm.c |    1 -
 sound/soc/samsung/smdk_wm8994pcm.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index e43bd42..23a9204 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -176,7 +176,6 @@ static int snd_smdk_probe(struct platform_device *pdev)
 static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 3688a32..0c84ca0 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -146,7 +146,6 @@ static int snd_smdk_probe(struct platform_device *pdev)
 static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
