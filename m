From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 10/11] ALSA: galaxy: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:56:41 -0400
Message-ID: <5ed9fcaafd3cd8c261b5096c813802d8671f5001.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/galaxy/galaxy.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 3227884..379abe2 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -634,15 +634,4 @@ static struct isa_driver snd_galaxy_driver = {
 	}
 };
 
-static int __init alsa_card_galaxy_init(void)
-{
-	return isa_register_driver(&snd_galaxy_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_galaxy_exit(void)
-{
-	isa_unregister_driver(&snd_galaxy_driver);
-}
-
-module_init(alsa_card_galaxy_init);
-module_exit(alsa_card_galaxy_exit);
+module_isa_driver(snd_galaxy_driver, SNDRV_CARDS);
-- 
2.7.3
