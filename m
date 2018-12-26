From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] line6: add a  check for snd_card_register
Date: Tue, 25 Dec 2018 21:39:31 -0600
Message-ID: <20181226033933.73306-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The fix checks if snd_card_register() fails, and if so, issues a
warning.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/usb/line6/pod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 020c81818951..da8837bc5a5b 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -320,7 +320,8 @@ static void pod_startup4(struct work_struct *work)
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
 
 	/* ALSA audio interface: */
-	snd_card_register(line6->card);
+	if (snd_card_register(line6->card))
+		pr_warn("Failed to register ALSA card.\n");
 }
 
 /* POD special files: */
-- 
2.17.2 (Apple Git-113)
