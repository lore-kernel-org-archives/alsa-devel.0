From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 35/43] ALSA: hdsp: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:11 +0200
Message-ID: <1413886279-18704-36-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D6826664E
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BF8E6ABE6
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
 sound/pci/rme9652/hdsp.c | 175 +++++++++++++++--------------------------------
 1 file changed, 57 insertions(+), 118 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 7646ba1664eb..2eb8baf7b828 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1680,16 +1680,13 @@ static int hdsp_set_spdif_input(struct hdsp *hdsp, int in)
 
 static int snd_hdsp_info_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {"Optical", "Coaxial", "Internal", "AES"};
+	static const char * const texts[4] = {
+		"Optical", "Coaxial", "Internal", "AES"
+	};
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ((hdsp->io_type == H9632) ? 4 : 3);
-	if (uinfo->value.enumerated.item > ((hdsp->io_type == H9632) ? 3 : 2))
-		uinfo->value.enumerated.item = ((hdsp->io_type == H9632) ? 3 : 2);
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, (hdsp->io_type == H9632) ? 4 : 3,
+				 texts);
 }
 
 static int snd_hdsp_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1786,16 +1783,14 @@ static int snd_hdsp_put_toggle_setting(struct snd_kcontrol *kcontrol,
 
 static int snd_hdsp_info_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
+	static const char * const texts[] = {
+		"32000", "44100", "48000", "64000", "88200", "96000",
+		"None", "128000", "176400", "192000"
+	};
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, (hdsp->io_type == H9632) ? 10 : 7,
+				 texts);
 }
 
 static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1872,14 +1867,13 @@ static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7 ;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	static const char * const texts[] = {
+		"32000", "44100", "48000", "64000", "88200", "96000",
+		"None", "128000", "176400", "192000"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, (hdsp->io_type == H9632) ? 10 : 7,
+				 texts);
 }
 
 static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1940,15 +1934,9 @@ static int hdsp_system_clock_mode(struct hdsp *hdsp)
 
 static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"Master", "Slave" };
+	static const char * const texts[] = {"Master", "Slave" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_hdsp_get_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2049,19 +2037,16 @@ static int hdsp_set_clock_source(struct hdsp *hdsp, int mode)
 
 static int snd_hdsp_info_clock_source(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"AutoSync", "Internal 32.0 kHz", "Internal 44.1 kHz", "Internal 48.0 kHz", "Internal 64.0 kHz", "Internal 88.2 kHz", "Internal 96.0 kHz", "Internal 128 kHz", "Internal 176.4 kHz", "Internal 192.0 KHz" };
+	static const char * const texts[] = {
+		"AutoSync", "Internal 32.0 kHz", "Internal 44.1 kHz",
+		"Internal 48.0 kHz", "Internal 64.0 kHz", "Internal 88.2 kHz",
+		"Internal 96.0 kHz", "Internal 128 kHz", "Internal 176.4 kHz",
+		"Internal 192.0 KHz"
+	};
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	if (hdsp->io_type == H9632)
-	    uinfo->value.enumerated.items = 10;
-	else
-	    uinfo->value.enumerated.items = 7;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, (hdsp->io_type == H9632) ? 10 : 7,
+				 texts);
 }
 
 static int snd_hdsp_get_clock_source(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2165,15 +2150,9 @@ static int hdsp_set_da_gain(struct hdsp *hdsp, int mode)
 
 static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"Hi Gain", "+4 dBu", "-10 dbV"};
+	static const char * const texts[] = {"Hi Gain", "+4 dBu", "-10 dbV"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_hdsp_get_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2250,15 +2229,9 @@ static int hdsp_set_ad_gain(struct hdsp *hdsp, int mode)
 
 static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"-10 dBV", "+4 dBu", "Lo Gain"};
+	static const char * const texts[] = {"-10 dBV", "+4 dBu", "Lo Gain"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_hdsp_get_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2335,15 +2308,9 @@ static int hdsp_set_phone_gain(struct hdsp *hdsp, int mode)
 
 static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"0 dB", "-6 dB", "-12 dB"};
+	static const char * const texts[] = {"0 dB", "-6 dB", "-12 dB"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_hdsp_get_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2439,31 +2406,28 @@ static int hdsp_set_pref_sync_ref(struct hdsp *hdsp, int pref)
 
 static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"Word", "IEC958", "ADAT1", "ADAT Sync", "ADAT2", "ADAT3" };
+	static const char * const texts[] = {
+		"Word", "IEC958", "ADAT1", "ADAT Sync", "ADAT2", "ADAT3"
+	};
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
+	int num_items;
 
 	switch (hdsp->io_type) {
 	case Digiface:
 	case H9652:
-		uinfo->value.enumerated.items = 6;
+		num_items = 6;
 		break;
 	case Multiface:
-		uinfo->value.enumerated.items = 4;
+		num_items = 4;
 		break;
 	case H9632:
-		uinfo->value.enumerated.items = 3;
+		num_items = 3;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_items, texts);
 }
 
 static int snd_hdsp_get_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2543,15 +2507,11 @@ static int hdsp_autosync_ref(struct hdsp *hdsp)
 
 static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"Word", "ADAT Sync", "IEC958", "None", "ADAT1", "ADAT2", "ADAT3" };
+	static const char * const texts[] = {
+		"Word", "ADAT Sync", "IEC958", "None", "ADAT1", "ADAT2", "ADAT3"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 7;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 7, texts);
 }
 
 static int snd_hdsp_get_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2738,14 +2698,9 @@ static int snd_hdsp_put_mixer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
 static int snd_hdsp_info_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No Lock", "Lock", "Sync" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	static const char * const texts[] = {"No Lock", "Lock", "Sync" };
+
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int hdsp_wc_sync_check(struct hdsp *hdsp)
@@ -3101,15 +3056,11 @@ static int snd_hdsp_put_rpm_input12(struct snd_kcontrol *kcontrol, struct snd_ct
 
 static int snd_hdsp_info_rpm_input(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"Phono +6dB", "Phono 0dB", "Phono -6dB", "Line 0dB", "Line -6dB"};
+	static const char * const texts[] = {
+		"Phono +6dB", "Phono 0dB", "Phono -6dB", "Line 0dB", "Line -6dB"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 5, texts);
 }
 
 
@@ -3234,15 +3185,9 @@ static int snd_hdsp_put_rpm_bypass(struct snd_kcontrol *kcontrol, struct snd_ctl
 
 static int snd_hdsp_info_rpm_bypass(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"On", "Off"};
+	static const char * const texts[] = {"On", "Off"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 
@@ -3291,15 +3236,9 @@ static int snd_hdsp_put_rpm_disconnect(struct snd_kcontrol *kcontrol, struct snd
 
 static int snd_hdsp_info_rpm_disconnect(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"On", "Off"};
+	static const char * const texts[] = {"On", "Off"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static struct snd_kcontrol_new snd_hdsp_rpm_controls[] = {
-- 
2.1.2
