From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 32/43] ALSA: pcxhr: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:08 +0200
Message-ID: <1413886279-18704-33-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C871266659
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A0A55ADAE
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
 sound/pci/pcxhr/pcxhr_mixer.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr_mixer.c b/sound/pci/pcxhr/pcxhr_mixer.c
index 95c9571780d8..63136c4f3f3d 100644
--- a/sound/pci/pcxhr/pcxhr_mixer.c
+++ b/sound/pci/pcxhr/pcxhr_mixer.c
@@ -660,14 +660,7 @@ static int pcxhr_audio_src_info(struct snd_kcontrol *kcontrol,
 		if (chip->mgr->board_has_mic)
 			i = 5;	/* Mic and MicroMix available */
 	}
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = i;
-	if (uinfo->value.enumerated.item > (i-1))
-		uinfo->value.enumerated.item = i-1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, i, texts);
 }
 
 static int pcxhr_audio_src_get(struct snd_kcontrol *kcontrol,
@@ -756,14 +749,7 @@ static int pcxhr_clock_type_info(struct snd_kcontrol *kcontrol,
 		texts = textsPCXHR;
 		snd_BUG_ON(clock_items > (PCXHR_CLOCK_TYPE_MAX+1));
 	}
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = clock_items;
-	if (uinfo->value.enumerated.item >= clock_items)
-		uinfo->value.enumerated.item = clock_items-1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, clock_items, texts);
 }
 
 static int pcxhr_clock_type_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
