From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] gus: add a check of the status of snd_ctl_add
Date: Tue, 25 Dec 2018 19:40:51 -0600
Message-ID: <20181226014052.70937-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_ctl_add() could fail, so let's check its status and issue an error
message if it indeed fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/isa/gus/gus_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 3b8a0c880db5..33c8b66d5c8a 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -92,8 +92,17 @@ static const struct snd_kcontrol_new snd_gus_joystick_control = {
 
 static void snd_gus_init_control(struct snd_gus_card *gus)
 {
-	if (!gus->ace_flag)
-		snd_ctl_add(gus->card, snd_ctl_new1(&snd_gus_joystick_control, gus));
+	int ret;
+
+	if (!gus->ace_flag) {
+		ret =
+			snd_ctl_add(gus->card,
+					snd_ctl_new1(&snd_gus_joystick_control,
+						gus));
+		if (ret)
+			snd_printk(KERN_ERR "gus: snd_ctl_add failed: %d\n",
+					ret);
+	}
 }
 
 /*
-- 
2.17.2 (Apple Git-113)
