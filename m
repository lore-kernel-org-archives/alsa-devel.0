From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: Drop unnecessary debugfs ifdef
Date: Wed, 1 Feb 2017 15:37:35 +0200
Message-ID: <1485956255-19784-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, lars@metafoo.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This is a relict of 6553bf06a369 ("ASoC: Don't try to register debugfs
entries if the parent does not exist").

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9b589d6..a110d39 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4193,8 +4193,6 @@ static void __exit snd_soc_exit(void)
 	snd_soc_util_exit();
 	snd_soc_debugfs_exit();
 
-#ifdef CONFIG_DEBUG_FS
-#endif
 	platform_driver_unregister(&soc_driver);
 }
 module_exit(snd_soc_exit);
-- 
2.7.4
