From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 29/43] ALSA: ice1712: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:05 +0200
Message-ID: <1413886279-18704-30-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2FB266657
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8061EADAB
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
 sound/pci/ice1712/ews.c     | 16 ++--------------
 sound/pci/ice1712/ice1712.c | 27 ++++-----------------------
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index 817a1bc50a60..5cb587cf360e 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -580,13 +580,7 @@ static int snd_ice1712_ewx_io_sense_info(struct snd_kcontrol *kcontrol, struct s
 	static const char * const texts[2] = {
 		"+4dBu", "-10dBV",
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= 2)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ice1712_ewx_io_sense_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -903,13 +897,7 @@ static int snd_ice1712_6fire_select_input_info(struct snd_kcontrol *kcontrol, st
 	static const char * const texts[4] = {
 		"Internal", "Front Input", "Rear Input", "Wave Table"
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= 4)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
      
 static int snd_ice1712_6fire_select_input_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 206ed2cbcef9..48a0c330da24 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -1839,13 +1839,7 @@ static int snd_ice1712_pro_internal_clock_info(struct snd_kcontrol *kcontrol,
 		"96000",	/* 12: 7 */
 		"IEC958 Input",	/* 13: -- */
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 14;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 14, texts);
 }
 
 static int snd_ice1712_pro_internal_clock_get(struct snd_kcontrol *kcontrol,
@@ -1930,13 +1924,7 @@ static int snd_ice1712_pro_internal_clock_default_info(struct snd_kcontrol *kcon
 		"96000",	/* 12: 7 */
 		/* "IEC958 Input",	13: -- */
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 13;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 13, texts);
 }
 
 static int snd_ice1712_pro_internal_clock_default_get(struct snd_kcontrol *kcontrol,
@@ -2057,15 +2045,8 @@ static int snd_ice1712_pro_route_info(struct snd_kcontrol *kcontrol,
 		"IEC958 In L", "IEC958 In R", /* 9-10 */
 		"Digital Mixer", /* 11 - optional */
 	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items =
-		snd_ctl_get_ioffidx(kcontrol, &uinfo->id) < 2 ? 12 : 11;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	int num_items = snd_ctl_get_ioffidx(kcontrol, &uinfo->id) < 2 ? 12 : 11;
+	return snd_ctl_enum_info(uinfo, 1, num_items, texts);
 }
 
 static int snd_ice1712_pro_route_analog_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
