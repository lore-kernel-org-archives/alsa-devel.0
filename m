From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 07/11] ALSA: serial-u16550: Remove redundant
	platform_set_drvdata()
Date: Mon, 20 May 2013 14:08:40 +0530
Message-ID: <1369039124-32590-7-git-send-email-sachin.kamat@linaro.org>
References: <1369039124-32590-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCED2610B8
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 10:52:52 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id hz10so5485018pad.2
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 01:52:51 -0700 (PDT)
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
 sound/drivers/serial-u16550.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 7425dd8..e0bf5e7 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -985,7 +985,6 @@ static int snd_serial_probe(struct platform_device *devptr)
 static int snd_serial_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
 	return 0;
 }
 
-- 
1.7.9.5
