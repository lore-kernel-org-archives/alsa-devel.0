From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 06/11] ALSA: gusmax: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:55:48 -0400
Message-ID: <3849ddf107c646dc3f59de3788c0d3b1d14e0c40.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/gus/gusmax.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 8216e8d..dd88c9d 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -370,15 +370,4 @@ static struct isa_driver snd_gusmax_driver = {
 	},
 };
 
-static int __init alsa_card_gusmax_init(void)
-{
-	return isa_register_driver(&snd_gusmax_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_gusmax_exit(void)
-{
-	isa_unregister_driver(&snd_gusmax_driver);
-}
-
-module_init(alsa_card_gusmax_init)
-module_exit(alsa_card_gusmax_exit)
+module_isa_driver(snd_gusmax_driver, SNDRV_CARDS);
-- 
2.7.3
