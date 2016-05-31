From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 01/11] ALSA: sb8: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:54:40 -0400
Message-ID: <3d016d3b3353f020d966b26c05f77b3698e3d037.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/sb/sb8.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index b8e2391..ad42d23 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -251,15 +251,4 @@ static struct isa_driver snd_sb8_driver = {
 	},
 };
 
-static int __init alsa_card_sb8_init(void)
-{
-	return isa_register_driver(&snd_sb8_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_sb8_exit(void)
-{
-	isa_unregister_driver(&snd_sb8_driver);
-}
-
-module_init(alsa_card_sb8_init)
-module_exit(alsa_card_sb8_exit)
+module_isa_driver(snd_sb8_driver, SNDRV_CARDS);
-- 
2.7.3
