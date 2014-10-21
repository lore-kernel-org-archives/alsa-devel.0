From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/43] ALSA: msnd: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:49 +0200
Message-ID: <1413886279-18704-14-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D245E26663D
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0E5F2AD7F
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

... and reduce the open codes.  Also add missing const to the text array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/msnd/msnd_pinnacle_mixer.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle_mixer.c b/sound/isa/msnd/msnd_pinnacle_mixer.c
index 031dc69b7470..17e49a071af4 100644
--- a/sound/isa/msnd/msnd_pinnacle_mixer.c
+++ b/sound/isa/msnd/msnd_pinnacle_mixer.c
@@ -55,20 +55,13 @@
 static int snd_msndmix_info_mux(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {
+	static const char * const texts[3] = {
 		"Analog", "MASS", "SPDIF",
 	};
 	struct snd_msnd *chip = snd_kcontrol_chip(kcontrol);
 	unsigned items = test_bit(F_HAVEDIGITAL, &chip->flags) ? 3 : 2;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = items;
-	if (uinfo->value.enumerated.item >= items)
-		uinfo->value.enumerated.item = items - 1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, items, texts);
 }
 
 static int snd_msndmix_get_mux(struct snd_kcontrol *kcontrol,
-- 
2.1.2
