From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: ice1712: wm8766.c:  Cleaning up uninitialized variables
Date: Sun,  1 Jun 2014 16:02:51 +0200
Message-ID: <1401631371-21145-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a risk that the variable will be used without being initialized.

This was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/ice1712/wm8766.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/wm8766.c b/sound/pci/ice1712/wm8766.c
index 21b373b..788a31c 100644
--- a/sound/pci/ice1712/wm8766.c
+++ b/sound/pci/ice1712/wm8766.c
@@ -237,7 +237,7 @@ static int snd_wm8766_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_wm8766 *wm = snd_kcontrol_chip(kcontrol);
 	int n = kcontrol->private_value;
-	u16 val1, val2;
+	u16 val1 = 0, val2 = 0;
 
 	if (wm->ctl[n].get)
 		wm->ctl[n].get(wm, &val1, &val2);
-- 
1.7.10.4
