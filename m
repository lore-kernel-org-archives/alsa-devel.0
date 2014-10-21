From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 37/43] ALSA: rme9652: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:13 +0200
Message-ID: <1413886279-18704-38-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D6DA26665A
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D6861ACA1
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
 sound/pci/rme9652/rme9652.c | 58 ++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index fa9a2a8dce5a..6521521853b8 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -920,15 +920,9 @@ static int rme9652_set_adat1_input(struct snd_rme9652 *rme9652, int internal)
 
 static int snd_rme9652_info_adat1_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = {"ADAT1", "Internal"};
+	static const char * const texts[2] = {"ADAT1", "Internal"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_rme9652_get_adat1_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -991,15 +985,9 @@ static int rme9652_set_spdif_input(struct snd_rme9652 *rme9652, int in)
 
 static int snd_rme9652_info_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {"ADAT1", "Coaxial", "Internal"};
+	static const char * const texts[3] = {"ADAT1", "Coaxial", "Internal"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_rme9652_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1140,15 +1128,11 @@ static int rme9652_set_sync_mode(struct snd_rme9652 *rme9652, int mode)
 
 static int snd_rme9652_info_sync_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {"AutoSync", "Master", "Word Clock"};
+	static const char * const texts[3] = {
+		"AutoSync", "Master", "Word Clock"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_rme9652_get_sync_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1231,16 +1215,14 @@ static int rme9652_set_sync_pref(struct snd_rme9652 *rme9652, int pref)
 
 static int snd_rme9652_info_sync_pref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {"IEC958 In", "ADAT1 In", "ADAT2 In", "ADAT3 In"};
+	static const char * const texts[4] = {
+		"IEC958 In", "ADAT1 In", "ADAT2 In", "ADAT3 In"
+	};
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = rme9652->ss_channels == RME9652_NCHANNELS ? 4 : 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1,
+				 rme9652->ss_channels == RME9652_NCHANNELS ? 4 : 3,
+				 texts);
 }
 
 static int snd_rme9652_get_sync_pref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1392,15 +1374,11 @@ static int snd_rme9652_get_spdif_rate(struct snd_kcontrol *kcontrol, struct snd_
 
 static int snd_rme9652_info_adat_sync(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {"No Lock", "Lock", "No Lock Sync", "Lock Sync"};
+	static const char * const texts[4] = {
+		"No Lock", "Lock", "No Lock Sync", "Lock Sync"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_rme9652_get_adat_sync(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-- 
2.1.2
