From: Vicentiu Ciorbaru <cvicentiu@gmail.com>
Subject: [PATCH] emu10k1: Fix coccicheck warning
Date: Sun, 10 Mar 2013 14:37:47 +0200
Message-ID: <1362919067-17250-1-git-send-email-cvicentiu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, wfp5p@virginia.edu, cvicentiu@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Removed redundant cast of kmalloc return pointer.

Signed-off-by: Vicentiu Ciorbaru <cvicentiu@gmail.com>
---
 sound/pci/emu10k1/emufx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 0275209..a0f7502 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1183,9 +1183,8 @@ static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	mm_segment_t seg;
 
 	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL ||
-	    (icode->gpr_map = (u_int32_t __user *)
-	     kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
-		     GFP_KERNEL)) == NULL ||
+	    (icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024,
+				sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
 	    (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS,
 				sizeof(*controls), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
-- 
1.7.10.4
