From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] [v2] ALSA: line6: fix check on snd_card_register
Date: Sun,  6 Jan 2019 11:01:47 -0600
Message-ID: <20190106170148.9938-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The fix checks if snd_card_register() fails, and if so logs the error
via dev_err() consistent with other patches.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/usb/line6/pod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 020c81818951..ce45b6dab651 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -320,7 +320,8 @@ static void pod_startup4(struct work_struct *work)
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
 
 	/* ALSA audio interface: */
-	snd_card_register(line6->card);
+	if (snd_card_register(line6->card))
+		dev_err(line6->ifcdev, "Failed to register POD card.\n");
 }
 
 /* POD special files: */
-- 
2.17.1
