From: Christoph Jaeger <christophjaeger@linux.com>
Subject: [PATCH] sound: dmasound: use module_platform_driver_probe()
Date: Wed,  9 Apr 2014 09:43:53 +0200
Message-ID: <1397029433-30934-1-git-send-email-christophjaeger@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Christoph Jaeger <christophjaeger@linux.com>
List-Id: alsa-devel@alsa-project.org

Eliminate boilerplate code by using module_platform_driver_probe().

Signed-off-by: Christoph Jaeger <christophjaeger@linux.com>
---
 sound/oss/dmasound/dmasound_paula.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_paula.c b/sound/oss/dmasound/dmasound_paula.c
index 87910e9..c2d45a5 100644
--- a/sound/oss/dmasound/dmasound_paula.c
+++ b/sound/oss/dmasound/dmasound_paula.c
@@ -733,19 +733,7 @@ static struct platform_driver amiga_audio_driver = {
 	},
 };
 
-static int __init amiga_audio_init(void)
-{
-	return platform_driver_probe(&amiga_audio_driver, amiga_audio_probe);
-}
-
-module_init(amiga_audio_init);
-
-static void __exit amiga_audio_exit(void)
-{
-	platform_driver_unregister(&amiga_audio_driver);
-}
-
-module_exit(amiga_audio_exit);
+module_platform_driver_probe(amiga_audio_driver, amiga_audio_probe);
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:amiga-audio");
-- 
1.9.0
