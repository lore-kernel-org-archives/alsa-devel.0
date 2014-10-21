From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/43] ALSA: ice1724: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:06 +0200
Message-ID: <1413886279-18704-31-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0581826664D
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8BE31ADAC
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

... and reduce the open codes.  Also add missing const to text arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/aureon.c       | 46 +++++++---------------------------------
 sound/pci/ice1712/ice1724.c      |  8 +------
 sound/pci/ice1712/maya44.c       | 20 ++---------------
 sound/pci/ice1712/phase.c        | 12 +----------
 sound/pci/ice1712/pontis.c       |  8 +------
 sound/pci/ice1712/prodigy192.c   | 18 ++--------------
 sound/pci/ice1712/prodigy_hifi.c | 11 ++--------
 sound/pci/ice1712/quartet.c      | 27 ++++-------------------
 sound/pci/ice1712/se.c           |  9 +-------
 9 files changed, 22 insertions(+), 137 deletions(-)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 3b3cf4ac9060..c9411dfff5a4 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -205,13 +205,7 @@ static int aureon_universe_inmux_info(struct snd_kcontrol *kcontrol,
 	static const char * const texts[3] =
 		{"Internal Aux", "Wavetable", "Rear Line-In"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int aureon_universe_inmux_get(struct snd_kcontrol *kcontrol,
@@ -1106,20 +1100,10 @@ static int wm_adc_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_in
 	};
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 2;
-	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AUREON71_UNIVERSE) {
-		uinfo->value.enumerated.items = 8;
-		if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-			uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-		strcpy(uinfo->value.enumerated.name, universe_texts[uinfo->value.enumerated.item]);
-	} else {
-		uinfo->value.enumerated.items = 5;
-		if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-			uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-		strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	}
-	return 0;
+	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_AUREON71_UNIVERSE)
+		return snd_ctl_enum_info(uinfo, 2, 8, universe_texts);
+	else
+		return snd_ctl_enum_info(uinfo, 2, 5, texts);
 }
 
 static int wm_adc_mux_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1167,16 +1151,10 @@ static int aureon_cs8415_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_
 		"CD",
 		"Coax"
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	if (ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71)
-		strcpy(uinfo->value.enumerated.name, prodigy_texts[uinfo->value.enumerated.item]);
+		return snd_ctl_enum_info(uinfo, 1, 2, prodigy_texts);
 	else
-		strcpy(uinfo->value.enumerated.name, aureon_texts[uinfo->value.enumerated.item]);
-	return 0;
+		return snd_ctl_enum_info(uinfo, 1, 2, aureon_texts);
 }
 
 static int aureon_cs8415_mux_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1392,15 +1370,7 @@ static int aureon_oversampling_info(struct snd_kcontrol *k, struct snd_ctl_elem_
 {
 	static const char * const texts[2] = { "128x", "64x"	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int aureon_oversampling_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 08cb08ac85e6..f633e3bb4c43 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2049,13 +2049,7 @@ static int snd_vt1724_pro_route_info(struct snd_kcontrol *kcontrol,
 		"IEC958 In L", "IEC958 In R", /* 3-4 */
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 5, texts);
 }
 
 static inline int analog_route_shift(int idx)
diff --git a/sound/pci/ice1712/maya44.c b/sound/pci/ice1712/maya44.c
index 63aa39f06f02..7de25c4807fd 100644
--- a/sound/pci/ice1712/maya44.c
+++ b/sound/pci/ice1712/maya44.c
@@ -359,15 +359,7 @@ static int maya_rec_src_info(struct snd_kcontrol *kcontrol,
 {
 	static const char * const texts[] = { "Line", "Mic" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ARRAY_SIZE(texts);
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
 static int maya_rec_src_get(struct snd_kcontrol *kcontrol,
@@ -411,15 +403,7 @@ static int maya_pb_route_info(struct snd_kcontrol *kcontrol,
 		"Input 1", "Input 2", "Input 3", "Input 4"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ARRAY_SIZE(texts);
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
 static int maya_pb_route_shift(int idx)
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index 0011e04f36a2..e9ca89c9174b 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -723,17 +723,7 @@ static int phase28_oversampling_info(struct snd_kcontrol *k,
 {
 	static const char * const texts[2] = { "128x", "64x"	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items -
-						1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int phase28_oversampling_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 5555eb4b2400..5101f40f6fbd 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -417,13 +417,7 @@ static int cs_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_inf
 		"Optical",	/* RXP1 */
 		"CD",		/* RXP2 */
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int cs_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index f3b491aa3e22..1eb151aaa965 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -284,15 +284,7 @@ static int stac9460_mic_sw_info(struct snd_kcontrol *kcontrol,
 {
 	static const char * const texts[2] = { "Line In", "Mic" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-
-        return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 
@@ -563,13 +555,7 @@ static int ak4114_input_sw_info(struct snd_kcontrol *kcontrol,
 {
 	static const char * const texts[2] = { "Toslink", "Coax" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-        return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 2261d1e49150..2697402b5195 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -537,7 +537,7 @@ static int wm_master_vol_put(struct snd_kcontrol *kcontrol,
 static int wm_adc_mux_enum_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	static char* texts[32] = {
+	static const char * const texts[32] = {
 		"NULL", WM_AIN1, WM_AIN2, WM_AIN1 "+" WM_AIN2,
 		WM_AIN3, WM_AIN1 "+" WM_AIN3, WM_AIN2 "+" WM_AIN3,
 		WM_AIN1 "+" WM_AIN2 "+" WM_AIN3,
@@ -560,14 +560,7 @@ static int wm_adc_mux_enum_info(struct snd_kcontrol *kcontrol,
 		WM_AIN1 "+" WM_AIN2 "+" WM_AIN3 "+" WM_AIN4 "+" WM_AIN5
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 32;
-	if (uinfo->value.enumerated.item > 31)
-		uinfo->value.enumerated.item = 31;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 32, texts);
 }
 
 static int wm_adc_mux_enum_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 2c2df4b74e01..d4caf9d05922 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -46,7 +46,7 @@ struct qtet_kcontrol_private {
 	unsigned int bit;
 	void (*set_register)(struct snd_ice1712 *ice, unsigned int val);
 	unsigned int (*get_register)(struct snd_ice1712 *ice);
-	unsigned char * const texts[2];
+	const char * const texts[2];
 };
 
 enum {
@@ -554,17 +554,7 @@ static int qtet_ain12_enum_info(struct snd_kcontrol *kcontrol,
 {
 	static const char * const texts[3] =
 		{"Line In 1/2", "Mic", "Mic + Low-cut"};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ARRAY_SIZE(texts);
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
 static int qtet_ain12_sw_get(struct snd_kcontrol *kcontrol,
@@ -706,17 +696,8 @@ static int qtet_enum_info(struct snd_kcontrol *kcontrol,
 {
 	struct qtet_kcontrol_private private =
 		qtet_privates[kcontrol->private_value];
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ARRAY_SIZE(private.texts);
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-			private.texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(private.texts),
+				 private.texts);
 }
 
 static int qtet_sw_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/ice1712/se.c b/sound/pci/ice1712/se.c
index ffd894bb4507..1c5d5b22c7a0 100644
--- a/sound/pci/ice1712/se.c
+++ b/sound/pci/ice1712/se.c
@@ -452,14 +452,7 @@ static int se200pci_cont_enum_info(struct snd_kcontrol *kc,
 	c = se200pci_get_enum_count(n);
 	if (!c)
 		return -EINVAL;
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = c;
-	if (uinfo->value.enumerated.item >= c)
-		uinfo->value.enumerated.item = c - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       se200pci_cont[n].member[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, c, se200pci_cont[n].member);
 }
 
 static int se200pci_cont_volume_get(struct snd_kcontrol *kc,
-- 
2.1.2
