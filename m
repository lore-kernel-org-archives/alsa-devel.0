From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 05/11] ALSA: cs4231: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:55:29 -0400
Message-ID: <f72790ad724818a5d9c8788972c288722b3246c2.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/cs423x/cs4231.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 282cd75..ef7448e 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -186,15 +186,4 @@ static struct isa_driver snd_cs4231_driver = {
 	}
 };
 
-static int __init alsa_card_cs4231_init(void)
-{
-	return isa_register_driver(&snd_cs4231_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_cs4231_exit(void)
-{
-	isa_unregister_driver(&snd_cs4231_driver);
-}
-
-module_init(alsa_card_cs4231_init);
-module_exit(alsa_card_cs4231_exit);
+module_isa_driver(snd_cs4231_driver, SNDRV_CARDS);
-- 
2.7.3
