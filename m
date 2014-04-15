From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH v2 1/2] ALSA: sound/atmel/ac97c.c: Convert to
	module_platform_driver
Date: Tue, 15 Apr 2014 19:38:56 +0200
Message-ID: <1397583537-4222-1-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CB02264F02
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 19:39:10 +0200 (CEST)
In-Reply-To: <1397293707-26890-1-git-send-email-alexanders83@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

This reduces some boilerplate code.

Signed-off-by: Alexander Stein <alexanders83@web.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/atmel/ac97c.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 05ec049..a04d2317 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1198,6 +1198,7 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_ac97c_driver = {
+	.probe		= atmel_ac97c_probe,
 	.remove		= atmel_ac97c_remove,
 	.driver		= {
 		.name	= "atmel_ac97c",
@@ -1205,19 +1206,7 @@ static struct platform_driver atmel_ac97c_driver = {
 		.pm	= ATMEL_AC97C_PM_OPS,
 	},
 };
-
-static int __init atmel_ac97c_init(void)
-{
-	return platform_driver_probe(&atmel_ac97c_driver,
-			atmel_ac97c_probe);
-}
-module_init(atmel_ac97c_init);
-
-static void __exit atmel_ac97c_exit(void)
-{
-	platform_driver_unregister(&atmel_ac97c_driver);
-}
-module_exit(atmel_ac97c_exit);
+module_platform_driver(atmel_ac97c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for Atmel AC97 controller");
-- 
1.9.2
