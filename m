From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/43] ALSA: hda: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:04 +0200
Message-ID: <1413886279-18704-29-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0463326664B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 748F0ADAA
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
 sound/pci/hda/hda_codec.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 15e0089492f7..259fbeaa37bd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2927,16 +2927,8 @@ static int vmaster_mute_mode_info(struct snd_kcontrol *kcontrol,
 	static const char * const texts[] = {
 		"On", "Off", "Follow Master"
 	};
-	unsigned int index;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	index = uinfo->value.enumerated.item;
-	if (index >= 3)
-		index = 2;
-	strcpy(uinfo->value.enumerated.name, texts[index]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int vmaster_mute_mode_get(struct snd_kcontrol *kcontrol,
@@ -5195,14 +5187,7 @@ int snd_hda_enum_helper_info(struct snd_kcontrol *kcontrol,
 		texts = texts_default;
 	}
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = num_items;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_items, texts);
 }
 EXPORT_SYMBOL_GPL(snd_hda_enum_helper_info);
 
-- 
2.1.2
