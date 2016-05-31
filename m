From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 09/11] ALSA: sc6000: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:56:28 -0400
Message-ID: <430c8cb49ecb2b0247c61daa05caf68bd6d572eb.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/sc6000.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 51cfa76..b61a663 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -711,15 +711,4 @@ static struct isa_driver snd_sc6000_driver = {
 };
 
 
-static int __init alsa_card_sc6000_init(void)
-{
-	return isa_register_driver(&snd_sc6000_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_sc6000_exit(void)
-{
-	isa_unregister_driver(&snd_sc6000_driver);
-}
-
-module_init(alsa_card_sc6000_init)
-module_exit(alsa_card_sc6000_exit)
+module_isa_driver(snd_sc6000_driver, SNDRV_CARDS);
-- 
2.7.3
