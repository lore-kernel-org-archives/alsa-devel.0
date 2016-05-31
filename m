From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 04/11] ALSA: cmi8328: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:55:12 -0400
Message-ID: <a9309efe8e276205e38a98d4fc9d84d7178ca81a.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/cmi8328.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index 2c89d95..7874750 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -469,15 +469,4 @@ static struct isa_driver snd_cmi8328_driver = {
 	},
 };
 
-static int __init alsa_card_cmi8328_init(void)
-{
-	return isa_register_driver(&snd_cmi8328_driver, CMI8328_MAX);
-}
-
-static void __exit alsa_card_cmi8328_exit(void)
-{
-	isa_unregister_driver(&snd_cmi8328_driver);
-}
-
-module_init(alsa_card_cmi8328_init)
-module_exit(alsa_card_cmi8328_exit)
+module_isa_driver(snd_cmi8328_driver, CMI8328_MAX);
-- 
2.7.3
