From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 11/11] ALSA: sh_dac_audio: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:44 +0530
Message-ID: <1369039124-32590-11-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f47.google.com (mail-da0-f47.google.com
 [209.85.210.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 290EE261A72
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:53:08 +0200 (CEST)
Received: by mail-da0-f47.google.com with SMTP id k13so3766805dae.20
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:53:08 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, patches@linaro.org, Rafael Ignacio Zurita <rizurita@yahoo.com>
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rafael Ignacio Zurita <rizurita@yahoo.com>
---
 sound/sh/sh_dac_audio.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index e68c4fc..7c9422c 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -290,8 +290,6 @@ static int snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
 static int snd_sh_dac_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5
