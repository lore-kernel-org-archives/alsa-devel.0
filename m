From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 03/11] ALSA: ad1848: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:55:01 -0400
Message-ID: <9eaa96c6c96de1275fc575683e4dee7ddd7bfb6d.1464709438.git.vilhelm.gray@gmail.com>
References: <cover.1464709438.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464709438.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver does not do anything special in module init/exit. This patch
eliminates the module init/exit boilerplate code by utilizing the
module_isa_driver macro.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 sound/isa/ad1848/ad1848.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index f159da4e..a302d1f 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -170,15 +170,4 @@ static struct isa_driver snd_ad1848_driver = {
 	}
 };
 
-static int __init alsa_card_ad1848_init(void)
-{
-	return isa_register_driver(&snd_ad1848_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_ad1848_exit(void)
-{
-	isa_unregister_driver(&snd_ad1848_driver);
-}
-
-module_init(alsa_card_ad1848_init);
-module_exit(alsa_card_ad1848_exit);
+module_isa_driver(snd_ad1848_driver, SNDRV_CARDS);
-- 
2.7.3
