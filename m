From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 08/11] ALSA: gusclassic: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:56:09 -0400
Message-ID: <fe26ee3de64768cdfe34fce1f79d34866a656952.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/gus/gusclassic.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index f001971..c169be4 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -229,15 +229,4 @@ static struct isa_driver snd_gusclassic_driver = {
 	}
 };
 
-static int __init alsa_card_gusclassic_init(void)
-{
-	return isa_register_driver(&snd_gusclassic_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_gusclassic_exit(void)
-{
-	isa_unregister_driver(&snd_gusclassic_driver);
-}
-
-module_init(alsa_card_gusclassic_init);
-module_exit(alsa_card_gusclassic_exit);
+module_isa_driver(snd_gusclassic_driver, SNDRV_CARDS);
-- 
2.7.3
