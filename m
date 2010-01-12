From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] alsa: use subsys_initcall for sound core instead of module_init
Date: Tue, 12 Jan 2010 20:20:39 -0200
Message-ID: <1263334840-6118-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754330Ab0ALWWh@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: ibm-acpi@hmh.eng.br, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is needed for built-in drivers which are built before the sound directory,
like thinkpad_acpi.

Otherwise, registering a card fails.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 sound/core/sound.c |    4 ++--
 sound/sound_core.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/sound.c b/sound/core/sound.c
index 7872a02..563d196 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -468,5 +468,5 @@ static void __exit alsa_sound_exit(void)
 	unregister_chrdev(major, "alsa");
 }
 
-module_init(alsa_sound_init)
-module_exit(alsa_sound_exit)
+subsys_initcall(alsa_sound_init);
+module_exit(alsa_sound_exit);
diff --git a/sound/sound_core.c b/sound/sound_core.c
index dbca7c9..7c2d677 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -61,7 +61,7 @@ static void __exit cleanup_soundcore(void)
 	class_destroy(sound_class);
 }
 
-module_init(init_soundcore);
+subsys_initcall(init_soundcore);
 module_exit(cleanup_soundcore);
 
 
-- 
1.6.6
