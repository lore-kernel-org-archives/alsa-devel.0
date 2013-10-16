From: "Geyslan G. Bem" <geyslan@gmail.com>
Subject: [PATCH] sound: pci: emu10k1: Remove useless casting in emufx.c
Date: Wed, 16 Oct 2013 13:21:45 -0300
Message-ID: <1381940506-29855-1-git-send-email-geyslan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kernel-br@googlegroups.com, "Geyslan G. Bem" <geyslan@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Bill Pemberton <wfp5p@virginia.edu>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Casting (void *) value returned by kcalloc is useless
as mentioned in Documentation/CodingStyle, Chap 14.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 sound/pci/emu10k1/emufx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 0275209..3f51dac 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1183,9 +1183,8 @@ static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	mm_segment_t seg;
 
 	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL ||
-	    (icode->gpr_map = (u_int32_t __user *)
-	     kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
-		     GFP_KERNEL)) == NULL ||
+	    (icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
+				      GFP_KERNEL)) == NULL ||
 	    (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS,
 				sizeof(*controls), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
@@ -1815,10 +1814,9 @@ static int _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 
 	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	if ((icode->gpr_map = (u_int32_t __user *)
-	     kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t),
-		     GFP_KERNEL)) == NULL ||
-            (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS,
+	if ((icode->gpr_map = kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t),
+				      GFP_KERNEL)) == NULL ||
+	    (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS,
 				sizeof(struct snd_emu10k1_fx8010_control_gpr),
 				GFP_KERNEL)) == NULL ||
 	    (ipcm = kzalloc(sizeof(*ipcm), GFP_KERNEL)) == NULL) {
-- 
1.8.4
