From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/43] ALSA: azt3328: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:58 +0200
Message-ID: <1413886279-18704-23-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1787A266653
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C411ADA2
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:24 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

... and reduce the open codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/azt3328.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 5a69e26cb2fb..fdbb9c05c77b 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -1034,11 +1034,6 @@ snd_azf3328_info_mixer_enum(struct snd_kcontrol *kcontrol,
 	const char * const *p = NULL;
 
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
-        uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-        uinfo->count = (reg.reg == IDX_MIXER_REC_SELECT) ? 2 : 1;
-        uinfo->value.enumerated.items = reg.enum_c;
-        if (uinfo->value.enumerated.item > reg.enum_c - 1U)
-                uinfo->value.enumerated.item = reg.enum_c - 1U;
 	if (reg.reg == IDX_MIXER_ADVCTL2) {
 		switch(reg.lchan_shift) {
 		case 8: /* modem out sel */
@@ -1051,12 +1046,12 @@ snd_azf3328_info_mixer_enum(struct snd_kcontrol *kcontrol,
 			p = texts4;
 			break;
 		}
-	} else
-	if (reg.reg == IDX_MIXER_REC_SELECT)
+	} else if (reg.reg == IDX_MIXER_REC_SELECT)
 		p = texts3;
 
-	strcpy(uinfo->value.enumerated.name, p[uinfo->value.enumerated.item]);
-        return 0;
+	return snd_ctl_enum_info(uinfo,
+				 (reg.reg == IDX_MIXER_REC_SELECT) ? 2 : 1,
+				 reg.enum_c, p);
 }
 
 static int
-- 
2.1.2
