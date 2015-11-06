From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] sound: fix check for error condition of register_chrdev()
Date: Sat,  7 Nov 2015 01:56:05 +0300
Message-ID: <1446850565-8451-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

init_oss_soundcore() compares returned value of register_chrdev()
with -1, while other error codes can be returned.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/sound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 11e953a1fa45..99b73c675743 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -655,7 +655,7 @@ static void cleanup_oss_soundcore(void)
 static int __init init_oss_soundcore(void)
 {
 	if (preclaim_oss &&
-	    register_chrdev(SOUND_MAJOR, "sound", &soundcore_fops) == -1) {
+	    register_chrdev(SOUND_MAJOR, "sound", &soundcore_fops) < 0) {
 		printk(KERN_ERR "soundcore: sound device already in use.\n");
 		return -EBUSY;
 	}
-- 
1.9.1
