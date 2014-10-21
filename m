From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/43] ALSA: ca0106: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:59 +0200
Message-ID: <1413886279-18704-24-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 182DA266655
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3D86AADA3
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

... and reduce the open codes.  Also correct the array size and add
missing const to text arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ca0106/ca0106_mixer.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 27de0de90018..68c0eb0a2807 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -185,17 +185,11 @@ static int snd_ca0106_shared_spdif_put(struct snd_kcontrol *kcontrol,
 static int snd_ca0106_capture_source_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[6] = {
+	static const char * const texts[6] = {
 		"IEC958 out", "i2s mixer out", "IEC958 in", "i2s in", "AC97 in", "SRC out"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 6;
-	if (uinfo->value.enumerated.item > 5)
-                uinfo->value.enumerated.item = 5;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 6, texts);
 }
 
 static int snd_ca0106_capture_source_get(struct snd_kcontrol *kcontrol,
@@ -228,17 +222,11 @@ static int snd_ca0106_capture_source_put(struct snd_kcontrol *kcontrol,
 static int snd_ca0106_i2c_capture_source_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[6] = {
+	static const char * const texts[4] = {
 		"Phone", "Mic", "Line in", "Aux"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-                uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_ca0106_i2c_capture_source_get(struct snd_kcontrol *kcontrol,
@@ -273,29 +261,17 @@ static int snd_ca0106_i2c_capture_source_put(struct snd_kcontrol *kcontrol,
 static int snd_ca0106_capture_line_in_side_out_info(struct snd_kcontrol *kcontrol,
 					       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = { "Side out", "Line in" };
+	static const char * const texts[2] = { "Side out", "Line in" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ca0106_capture_mic_line_in_info(struct snd_kcontrol *kcontrol,
 					       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = { "Line in", "Mic in" };
+	static const char * const texts[2] = { "Line in", "Mic in" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ca0106_capture_mic_line_in_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
