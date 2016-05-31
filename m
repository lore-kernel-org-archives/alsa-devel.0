From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 11/11] ALSA: adlib: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:56:52 -0400
Message-ID: <1f9a641b808cf28fbb330362aac9602fe1781d46.1464709438.git.vilhelm.gray@gmail.com>
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
 sound/isa/adlib.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 120c524..8d3060f 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -112,15 +112,4 @@ static struct isa_driver snd_adlib_driver = {
 	}
 };
 
-static int __init alsa_card_adlib_init(void)
-{
-	return isa_register_driver(&snd_adlib_driver, SNDRV_CARDS);
-}
-
-static void __exit alsa_card_adlib_exit(void)
-{
-	isa_unregister_driver(&snd_adlib_driver);
-}
-
-module_init(alsa_card_adlib_init);
-module_exit(alsa_card_adlib_exit);
+module_isa_driver(snd_adlib_driver, SNDRV_CARDS);
-- 
2.7.3
