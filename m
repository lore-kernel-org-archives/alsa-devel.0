From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 28/31] ALSA: hdspm - Use snd_ctl_enum_info
	for most text arrays
Date: Fri,  5 Jul 2013 11:28:20 +0200
Message-ID: <1373016503-9474-29-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-19-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-20-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-21-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-22-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-23-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-24-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-25-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-26-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-27-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-28-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-28-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use snd_ctl_enum_info() to fill most of the enumerated controls. More
non-trivial occurrences will follow in separate commits.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 630316c..5a2eb64 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -590,7 +590,7 @@ static char *texts_autosync_aio_tco[] = {
 static char *texts_autosync_aio[] = { "Word Clock",
 				      "ADAT", "AES", "SPDIF", "Sync In" };
 
-static char *texts_freq[] = {
+static const char *const texts_freq[] = {
 	"No Lock",
 	"32 kHz",
 	"44.1 kHz",
@@ -2286,21 +2286,8 @@ static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 	return (status >> (idx*4)) & 0xF;
 }
 
-static void snd_hdspm_set_infotext(struct snd_ctl_elem_info *uinfo,
-		char **texts, const int count)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = count;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-}
-
 #define ENUMERATED_CTL_INFO(info, texts) \
-	snd_hdspm_set_infotext(info, texts, ARRAY_SIZE(texts))
+	snd_ctl_enum_info(info, 1, ARRAY_SIZE(texts), texts)
 
 
 /* Helper function to query the external sample rate and return the
@@ -2477,7 +2464,7 @@ static void hdspm_set_system_clock_mode(struct hdspm *hdspm, int mode)
 static int snd_hdspm_info_system_clock_mode(struct snd_kcontrol *kcontrol,
 					    struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Master", "AutoSync" };
+	static const char *const texts[] = { "Master", "AutoSync" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3057,7 +3044,7 @@ static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_video_input_format(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No video", "NTSC", "PAL"};
+	static const char *const texts[] = {"No video", "NTSC", "PAL"};
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3103,7 +3090,7 @@ static int snd_hdspm_get_tco_video_input_format(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_ltc_frames(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No lock", "24 fps", "25 fps", "29.97 fps",
+	static const char *const texts[] = {"No lock", "24 fps", "25 fps", "29.97 fps",
 				"30 fps"};
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
@@ -3253,7 +3240,7 @@ static int hdspm_set_input_select(struct hdspm * hdspm, int out)
 static int snd_hdspm_info_input_select(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "optical", "coaxial" };
+	static const char *const texts[] = { "optical", "coaxial" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3315,7 +3302,7 @@ static int hdspm_set_ds_wire(struct hdspm * hdspm, int ds)
 static int snd_hdspm_info_ds_wire(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Single", "Double" };
+	static const char *const texts[] = { "Single", "Double" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3388,7 +3375,7 @@ static int hdspm_set_qs_wire(struct hdspm * hdspm, int mode)
 static int snd_hdspm_info_qs_wire(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Single", "Double", "Quad" };
+	static const char *const texts[] = { "Single", "Double", "Quad" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3454,8 +3441,8 @@ static int snd_hdspm_info_tristate(struct snd_kcontrol *kcontrol,
 {
 	u32 regmask = kcontrol->private_value;
 
-	static char *texts_spdif[] = { "Optical", "Coaxial", "Internal" };
-	static char *texts_levels[] = { "Hi Gain", "+4 dBu", "-10 dBV" };
+	static const char *const texts_spdif[] = { "Optical", "Coaxial", "Internal" };
+	static const char *const texts_levels[] = { "Hi Gain", "+4 dBu", "-10 dBV" };
 
 	switch (regmask) {
 	case HDSPM_c0_Input0:
@@ -3542,7 +3529,7 @@ static int hdspm_set_madi_speedmode(struct hdspm *hdspm, int mode)
 static int snd_hdspm_info_madi_speedmode(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Single", "Double", "Quad" };
+	static const char *const texts[] = { "Single", "Double", "Quad" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3777,7 +3764,7 @@ static int snd_hdspm_put_playback_mixer(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_sync_check(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "No Lock", "Lock", "Sync", "N/A" };
+	static const char *const texts[] = { "No Lock", "Lock", "Sync", "N/A" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -3785,7 +3772,7 @@ static int snd_hdspm_info_sync_check(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_tco_info_lock_check(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "No Lock", "Lock" };
+	static const char *const texts[] = { "No Lock", "Lock" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -4175,7 +4162,7 @@ static void hdspm_tco_write(struct hdspm *hdspm)
 static int snd_hdspm_info_tco_sample_rate(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "44.1 kHz", "48 kHz" };
+	static const char *const texts[] = { "44.1 kHz", "48 kHz" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -4221,7 +4208,8 @@ static int snd_hdspm_put_tco_sample_rate(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_pull(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "0", "+ 0.1 %", "- 0.1 %", "+ 4 %", "- 4 %" };
+	static const char *const texts[] = { "0", "+ 0.1 %", "- 0.1 %",
+		"+ 4 %", "- 4 %" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -4266,7 +4254,7 @@ static int snd_hdspm_put_tco_pull(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_wck_conversion(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "1:1", "44.1 -> 48", "48 -> 44.1" };
+	static const char *const texts[] = { "1:1", "44.1 -> 48", "48 -> 44.1" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
@@ -4312,7 +4300,7 @@ static int snd_hdspm_put_tco_wck_conversion(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_frame_rate(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "24 fps", "25 fps", "29.97fps",
+	static const char *const texts[] = { "24 fps", "25 fps", "29.97fps",
 		"29.97 dfps", "30 fps", "30 dfps" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
@@ -4359,7 +4347,7 @@ static int snd_hdspm_put_tco_frame_rate(struct snd_kcontrol *kcontrol,
 static int snd_hdspm_info_tco_sync_source(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "LTC", "Video", "WCK" };
+	static const char *const texts[] = { "LTC", "Video", "WCK" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
-- 
1.8.3.1
