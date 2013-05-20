From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 06/11] ALSA: pcsp: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:39 +0530
Message-ID: <1369039124-32590-6-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E092610B0
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:49 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id 10so4112682pdc.11
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:48 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org, Stas Sergeev <stsp@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stas Sergeev <stsp@users.sourceforge.net>
---
 sound/drivers/pcsp/pcsp.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 7a5fdb9..1c19cd7 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -189,7 +189,6 @@ static int pcsp_remove(struct platform_device *dev)
 	struct snd_pcsp *chip = platform_get_drvdata(dev);
 	alsa_card_pcsp_exit(chip);
 	pcspkr_input_remove(chip->input_dev);
-	platform_set_drvdata(dev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
