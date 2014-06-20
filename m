From: Vincent Heuken <me@vincentheuken.com>
Subject: [PATCH] Sound: Core: fixed assignment in if condition style error in hwdep.c
Date: Fri, 20 Jun 2014 08:50:35 -0700
Message-ID: <1403279435-31231-1-git-send-email-me@vincentheuken.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Vincent Heuken <me@vincentheuken.com>
List-Id: alsa-devel@alsa-project.org

This is a patch to the hwdep.c file that fixes one instance of
the following error:
ERROR: do not use assignment in if condition

It also, incidentally, fixes one instance of the following warning:
WARNING: line over 80 characters

Signed-off-by: Vincent Heuken <me@vincentheuken.com>
---
 sound/core/hwdep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 69459e5..42d8324 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -527,7 +527,9 @@ static void __init snd_hwdep_proc_init(void)
 {
 	struct snd_info_entry *entry;
 
-	if ((entry = snd_info_create_module_entry(THIS_MODULE, "hwdep", NULL)) != NULL) {
+	entry = snd_info_create_module_entry(THIS_MODULE, "hwdep", NULL);
+
+	if (entry != NULL) {
 		entry->c.text.read = snd_hwdep_proc_read;
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
-- 
2.0.0
