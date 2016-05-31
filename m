From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 02/11] ALSA: jazz16: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:54:50 -0400
Message-ID: <01875b88c458ae8d0a189e8ef1db5046f3fda234.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/sb/jazz16.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 6b4884d..4d90997 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -387,15 +387,4 @@ static struct isa_driver snd_jazz16_driver = {
 	},
 };
 
-static int __init alsa_card_jazz16_init(void)
-{
-	return isa_register_driver(&snd_jazz16_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_jazz16_exit(void)
-{
-	isa_unregister_driver(&snd_jazz16_driver);
-}
-
-module_init(alsa_card_jazz16_init)
-module_exit(alsa_card_jazz16_exit)
+module_isa_driver(snd_jazz16_driver, SNDRV_CARDS);
-- 
2.7.3
