From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/43] ALSA: emu10k1: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:01 +0200
Message-ID: <1413886279-18704-26-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03D80266649
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 55A08ADA7
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
 sound/pci/emu10k1/emumixer.c | 58 ++++++++++----------------------------------
 sound/pci/emu10k1/p16v.c     | 20 +++------------
 2 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index c5ae2a24d8a5..1de33025669a 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -83,7 +83,7 @@ static int snd_emu10k1_spdif_get_mask(struct snd_kcontrol *kcontrol,
  * Items labels in enum mixer controls assigning source data to
  * each destination
  */
-static char *emu1010_src_texts[] = { 
+static const char * const emu1010_src_texts[] = {
 	"Silence",
 	"Dock Mic A",
 	"Dock Mic B",
@@ -141,7 +141,7 @@ static char *emu1010_src_texts[] = {
 
 /* 1616(m) cardbus */
 
-static char *emu1616_src_texts[] = {
+static const char * const emu1616_src_texts[] = {
 	"Silence",
 	"Dock Mic A",
 	"Dock Mic B",
@@ -393,23 +393,11 @@ static int snd_emu1010_input_output_source_info(struct snd_kcontrol *kcontrol,
 						struct snd_ctl_elem_info *uinfo)
 {
 	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
-	char **items;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	if (emu->card_capabilities->emu_model == EMU_MODEL_EMU1616) {
-		uinfo->value.enumerated.items = 49;
-		items = emu1616_src_texts;
-	} else {
-		uinfo->value.enumerated.items = 53;
-		items = emu1010_src_texts;
-	}
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       items[uinfo->value.enumerated.item]);
-	return 0;
+	if (emu->card_capabilities->emu_model == EMU_MODEL_EMU1616)
+		return snd_ctl_enum_info(uinfo, 1, 49, emu1616_src_texts);
+	else
+		return snd_ctl_enum_info(uinfo, 1, 53, emu1010_src_texts);
 }
 
 static int snd_emu1010_output_source_get(struct snd_kcontrol *kcontrol,
@@ -699,19 +687,11 @@ static struct snd_kcontrol_new snd_emu1010_dac_pads[] = {
 static int snd_emu1010_internal_clock_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {
+	static const char * const texts[4] = {
 		"44100", "48000", "SPDIF", "ADAT"
 	};
 		
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
-	
-	
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_emu1010_internal_clock_get(struct snd_kcontrol *kcontrol,
@@ -830,21 +810,15 @@ static int snd_audigy_i2c_capture_source_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
 #if 0
-	static char *texts[4] = {
+	static const char * const texts[4] = {
 		"Unknown1", "Unknown2", "Mic", "Line"
 	};
 #endif
-	static char *texts[2] = {
+	static const char * const texts[2] = {
 		"Mic", "Line"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_audigy_i2c_capture_source_get(struct snd_kcontrol *kcontrol,
@@ -997,15 +971,9 @@ static struct snd_kcontrol_new snd_audigy_i2c_volume_ctls[] = {
 #if 0
 static int snd_audigy_spdif_output_rate_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"44100", "48000", "96000"};
+	static const char * const texts[] = {"44100", "48000", "96000"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_audigy_spdif_output_rate_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index a4fe7f0c9458..7ef3898a7806 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -757,18 +757,12 @@ static int snd_p16v_volume_put(struct snd_kcontrol *kcontrol,
 static int snd_p16v_capture_source_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[8] = {
+	static const char * const texts[8] = {
 		"SPDIF", "I2S", "SRC48", "SRCMulti_SPDIF", "SRCMulti_I2S",
 		"CDIF", "FX", "AC97"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 8;
-	if (uinfo->value.enumerated.item > 7)
-                uinfo->value.enumerated.item = 7;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 8, texts);
 }
 
 static int snd_p16v_capture_source_get(struct snd_kcontrol *kcontrol,
@@ -805,15 +799,9 @@ static int snd_p16v_capture_source_put(struct snd_kcontrol *kcontrol,
 static int snd_p16v_capture_channel_info(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = { "0", "1", "2", "3",  };
+	static const char * const texts[4] = { "0", "1", "2", "3", };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-                uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_p16v_capture_channel_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
