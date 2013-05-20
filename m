From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 08/11] ALSA: virmidi: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:41 +0530
Message-ID: <1369039124-32590-8-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A63A261A67
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:55 +0200 (CEST)
Received: by mail-pb0-f52.google.com with SMTP id um15so376873pbc.25
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:54 -0700 (PDT)
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
 sound/drivers/virmidi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index cc4be88..ace3879 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -132,7 +132,6 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 static int snd_virmidi_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
