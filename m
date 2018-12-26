From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] sound: line6: fix a missing check of snd_card_register
Date: Tue, 25 Dec 2018 21:31:40 -0600
Message-ID: <20181226033142.73180-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_card_register() may fail, so let's check its status and issue an
error message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/usb/line6/variax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index e8c852b2ce35..b0caa9ea1f5f 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -167,7 +167,8 @@ static void variax_startup6(struct work_struct *work)
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_SETUP);
 
 	/* ALSA audio interface: */
-	snd_card_register(variax->line6.card);
+	if (snd_card_register(variax->line6.card))
+		dev_err(variax->line6.ifcdev, "Failed to register variax card.\n");
 }
 
 /*
-- 
2.17.2 (Apple Git-113)
