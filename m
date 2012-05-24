From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] [emu10k1]: remove the kcallloc cast (reported from make coccicheck's drop_kmalloc_cast.cocci)
Date: Thu, 24 May 2012 19:32:29 +0530
Message-ID: <1337868149-17783-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 sound/pci/emu10k1/emufx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index dae4050..272f8ac 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1815,7 +1815,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 
 	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	if ((icode->gpr_map = (u_int32_t __user *)
+	if ((icode->gpr_map =
 	     kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t),
 		     GFP_KERNEL)) == NULL ||
             (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS,
-- 
1.7.9.5
