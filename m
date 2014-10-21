From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 34/43] ALSA: rme96: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:10 +0200
Message-ID: <1413886279-18704-35-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C9F26665C
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B3BA9AAF3
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
 sound/pci/rme96.c | 62 +++++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 5a395c87c6fc..2f1a85185a16 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1884,39 +1884,38 @@ snd_rme96_put_loopback_control(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 static int
 snd_rme96_info_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *_texts[5] = { "Optical", "Coaxial", "Internal", "XLR", "Analog" };
+	static const char * const _texts[5] = {
+		"Optical", "Coaxial", "Internal", "XLR", "Analog"
+	};
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	char *texts[5] = { _texts[0], _texts[1], _texts[2], _texts[3], _texts[4] };
+	const char *texts[5] = {
+		_texts[0], _texts[1], _texts[2], _texts[3], _texts[4]
+	};
+	int num_items;
 	
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
 	case PCI_DEVICE_ID_RME_DIGI96_8:
-		uinfo->value.enumerated.items = 3;
+		num_items = 3;
 		break;
 	case PCI_DEVICE_ID_RME_DIGI96_8_PRO:
-		uinfo->value.enumerated.items = 4;
+		num_items = 4;
 		break;
 	case PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST:
 		if (rme96->rev > 4) {
 			/* PST */
-			uinfo->value.enumerated.items = 4;
+			num_items = 4;
 			texts[3] = _texts[4]; /* Analog instead of XLR */
 		} else {
 			/* PAD */
-			uinfo->value.enumerated.items = 5;
+			num_items = 5;
 		}
 		break;
 	default:
 		snd_BUG();
-		break;
-	}
-	if (uinfo->value.enumerated.item > uinfo->value.enumerated.items - 1) {
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+		return -EINVAL;
 	}
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_items, texts);
 }
 static int
 snd_rme96_get_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2002,16 +2001,9 @@ snd_rme96_put_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 static int
 snd_rme96_info_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = { "AutoSync", "Internal", "Word" };
+	static const char * const texts[3] = { "AutoSync", "Internal", "Word" };
 	
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2) {
-		uinfo->value.enumerated.item = 2;
-	}
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 static int
 snd_rme96_get_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2041,16 +2033,11 @@ snd_rme96_put_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 static int
 snd_rme96_info_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = { "0 dB", "-6 dB", "-12 dB", "-18 dB" };
+	static const char * const texts[4] = {
+		"0 dB", "-6 dB", "-12 dB", "-18 dB"
+	};
 	
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3) {
-		uinfo->value.enumerated.item = 3;
-	}
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 static int
 snd_rme96_get_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2081,16 +2068,9 @@ snd_rme96_put_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_
 static int
 snd_rme96_info_montracks_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = { "1+2", "3+4", "5+6", "7+8" };
+	static const char * const texts[4] = { "1+2", "3+4", "5+6", "7+8" };
 	
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3) {
-		uinfo->value.enumerated.item = 3;
-	}
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 static int
 snd_rme96_get_montracks_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-- 
2.1.2
