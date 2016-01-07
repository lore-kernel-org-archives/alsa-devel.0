From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/5] ALSA: mts64: fix multiple blanklines
Date: Thu,  7 Jan 2016 14:02:47 +0530
Message-ID: <1452155569-6763-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

checkpatch complains about multiple blank lines.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/mts64.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index efecb6e..f00e938 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -159,7 +159,6 @@ static void mts64_write_command(struct parport *p, u8 c);
 static void mts64_write_data(struct parport *p, u8 c);
 static void mts64_write_midi(struct mts64 *mts, u8 c, int midiport);
 
-
 /*  Enables the readout procedure
  *
  *  Before we can read a midi byte from the device, we have to set
@@ -282,7 +281,6 @@ static u8 mts64_map_midi_input(u8 c)
 	return map[c];
 }
 
-
 /*  Probe parport for device
  *
  *  Do we have a Miditerminal 4140 on parport?
@@ -652,7 +650,6 @@ static struct snd_kcontrol_new mts64_ctl_smpte_fps = {
 	.put   = snd_mts64_ctl_smpte_fps_put
 };
 
-
 static int snd_mts64_ctl_create(struct snd_card *card,
 				struct mts64 *mts)
 {
@@ -1030,7 +1027,6 @@ static int snd_mts64_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 static struct platform_driver snd_mts64_driver = {
 	.probe  = snd_mts64_probe,
 	.remove = snd_mts64_remove,
-- 
1.9.1
