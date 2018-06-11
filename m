From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 16:04:06 +0800
Message-ID: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/fm801.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 73a67bc..e3fb9c6 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1068,11 +1068,19 @@ static int snd_fm801_mixer(struct fm801 *chip)
 		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_sec)) < 0)
 			return err;
 	}
-	for (i = 0; i < FM801_CONTROLS; i++)
-		snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls[i], chip));
+	for (i = 0; i < FM801_CONTROLS; i++) {
+		err = snd_ctl_add(chip->card,
+			snd_ctl_new1(&snd_fm801_controls[i], chip));
+		if (err < 0)
+			return err;
+	}
 	if (chip->multichannel) {
-		for (i = 0; i < FM801_CONTROLS_MULTI; i++)
-			snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+		for (i = 0; i < FM801_CONTROLS_MULTI; i++) {
+			err = snd_ctl_add(chip->card,
+				snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }
-- 
2.7.4
