From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/7] ALSA: hdspm - Remove duplicate code from
	ALSA controls
Date: Sun, 10 Mar 2013 00:37:24 +0100
Message-ID: <1362872247-29029-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
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

Considerably shorten the code by using a macro. Though this won't lower
the binary size, it makes the source more readable.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 60e992d..9c79803e 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2172,6 +2172,16 @@ static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 	return (status >> (idx*4)) & 0xF;
 }
 
+#define ENUMERATED_CTL_INFO(info, texts) \
+{ \
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED; \
+	uinfo->count = 1; \
+	uinfo->value.enumerated.items = ARRAY_SIZE(texts); \
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items) \
+		uinfo->value.enumerated.item =	uinfo->value.enumerated.items - 1; \
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]); \
+}
+
 
 
 #define HDSPM_AUTOSYNC_SAMPLE_RATE(xname, xindex) \
@@ -2187,14 +2197,7 @@ static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 static int snd_hdspm_info_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 					       struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 10;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-			texts_freq[uinfo->value.enumerated.item]);
+	ENUMERATED_CTL_INFO(uinfo, texts_freq);
 	return 0;
 }
 
@@ -2360,15 +2363,7 @@ static int snd_hdspm_info_system_clock_mode(struct snd_kcontrol *kcontrol,
 					    struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "Master", "AutoSync" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3018,17 +3013,7 @@ static int snd_hdspm_info_input_select(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "optical", "coaxial" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3090,17 +3075,7 @@ static int snd_hdspm_info_ds_wire(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "Single", "Double" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3173,17 +3148,7 @@ static int snd_hdspm_info_qs_wire(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "Single", "Double", "Quad" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3259,17 +3224,7 @@ static int snd_hdspm_info_madi_speedmode(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "Single", "Double", "Quad" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3494,14 +3449,7 @@ static int snd_hdspm_info_sync_check(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "No Lock", "Lock", "Sync", "N/A" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3857,17 +3805,7 @@ static int snd_hdspm_info_tco_sample_rate(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "44.1 kHz", "48 kHz" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3913,17 +3851,7 @@ static int snd_hdspm_info_tco_pull(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "0", "+ 0.1 %", "- 0.1 %", "+ 4 %", "- 4 %" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -3968,17 +3896,7 @@ static int snd_hdspm_info_tco_wck_conversion(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "1:1", "44.1 -> 48", "48 -> 44.1" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -4025,17 +3943,7 @@ static int snd_hdspm_info_tco_frame_rate(struct snd_kcontrol *kcontrol,
 {
 	static char *texts[] = { "24 fps", "25 fps", "29.97fps",
 		"29.97 dfps", "30 fps", "30 dfps" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 6;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
@@ -4081,17 +3989,7 @@ static int snd_hdspm_info_tco_sync_source(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = { "LTC", "Video", "WCK" };
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			texts[uinfo->value.enumerated.item]);
-
+	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
 }
 
-- 
1.7.10.4
