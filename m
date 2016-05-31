From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 07/11] ALSA: gusextreme: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:55:58 -0400
Message-ID: <17133725c1f50aaddc924df8db466d04f202498c.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/gus/gusextreme.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 693d95f..77ac2fd 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -358,15 +358,4 @@ static struct isa_driver snd_gusextreme_driver = {
 	}
 };
 
-static int __init alsa_card_gusextreme_init(void)
-{
-	return isa_register_driver(&snd_gusextreme_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_gusextreme_exit(void)
-{
-	isa_unregister_driver(&snd_gusextreme_driver);
-}
-
-module_init(alsa_card_gusextreme_init);
-module_exit(alsa_card_gusextreme_exit);
+module_isa_driver(snd_gusextreme_driver, SNDRV_CARDS);
-- 
2.7.3
