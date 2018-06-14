From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH v3] ALSA: sonicvibes: add error handling for snd_ctl_add
Date: Thu, 14 Jun 2018 19:41:37 +0800
Message-ID: <1528976499-52071-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Check the return value of snd_sonicvibes_create_gameport.
v2->v3:
- Fix the code style.
---
 sound/pci/sonicvibes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index a8abb15..7fbdb70 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1188,6 +1188,7 @@ SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 {
 	struct gameport *gp;
+	int err;
 
 	sonic->gameport = gp = gameport_allocate_port();
 	if (!gp) {
@@ -1203,7 +1204,10 @@ static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 
 	gameport_register_port(gp);
 
-	snd_ctl_add(sonic->card, snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	err = snd_ctl_add(sonic->card,
+		snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	if (err < 0)
+		return err;
 
 	return 0;
 }
@@ -1515,7 +1519,11 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	snd_sonicvibes_create_gameport(sonic);
+	err = snd_sonicvibes_create_gameport(sonic);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-- 
2.7.4
