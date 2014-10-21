From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/43] ALSA: sb16: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:50 +0200
Message-ID: <1413886279-18704-15-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 16DC5266652
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 100FFAD97
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
 sound/isa/sb/sb16_main.c | 10 ++--------
 sound/isa/sb/sb_mixer.c  | 31 ++++++-------------------------
 2 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 0bbcd4714d28..72b10f4f3e70 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -702,17 +702,11 @@ static int snd_sb16_get_dma_mode(struct snd_sb *chip)
 
 static int snd_sb16_dma_control_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {
+	static const char * const texts[3] = {
 		"Auto", "Playback", "Capture"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_sb16_dma_control_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index 1ff78ec9f0ac..e403334a19ad 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -182,17 +182,11 @@ static int snd_sbmixer_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_
 
 static int snd_dt019x_input_sw_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[5] = {
+	static const char * const texts[5] = {
 		"CD", "Mic", "Line", "Synth", "Master"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-	if (uinfo->value.enumerated.item > 4)
-		uinfo->value.enumerated.item = 4;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 5, texts);
 }
 
 static int snd_dt019x_input_sw_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -275,18 +269,11 @@ static int snd_dt019x_input_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl
 static int snd_als4k_mono_capture_route_info(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[3] = {
+	static const char * const texts[3] = {
 		"L chan only", "R chan only", "L ch/2 + R ch/2"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_als4k_mono_capture_route_get(struct snd_kcontrol *kcontrol,
@@ -335,17 +322,11 @@ static int snd_als4k_mono_capture_route_put(struct snd_kcontrol *kcontrol,
 
 static int snd_sb8mixer_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[3] = {
+	static const char * const texts[3] = {
 		"Mic", "CD", "Line"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 
-- 
2.1.2
