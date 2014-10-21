From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/43] ALSA: vx: Use snd_ctl_elem_info()
Date: Tue, 21 Oct 2014 12:10:42 +0200
Message-ID: <1413886279-18704-7-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CEFFD26663A
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0C16BACFC
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
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
 sound/drivers/vx/vx_mixer.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/sound/drivers/vx/vx_mixer.c b/sound/drivers/vx/vx_mixer.c
index 3b6823fc0606..be9477e30739 100644
--- a/sound/drivers/vx/vx_mixer.c
+++ b/sound/drivers/vx/vx_mixer.c
@@ -471,30 +471,18 @@ static struct snd_kcontrol_new vx_control_output_level = {
  */
 static int vx_audio_src_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts_mic[3] = {
+	static const char * const texts_mic[3] = {
 		"Digital", "Line", "Mic"
 	};
-	static char *texts_vx2[2] = {
+	static const char * const texts_vx2[2] = {
 		"Digital", "Analog"
 	};
 	struct vx_core *chip = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	if (chip->type >= VX_TYPE_VXPOCKET) {
-		uinfo->value.enumerated.items = 3;
-		if (uinfo->value.enumerated.item > 2)
-			uinfo->value.enumerated.item = 2;
-		strcpy(uinfo->value.enumerated.name,
-		       texts_mic[uinfo->value.enumerated.item]);
-	} else {
-		uinfo->value.enumerated.items = 2;
-		if (uinfo->value.enumerated.item > 1)
-			uinfo->value.enumerated.item = 1;
-		strcpy(uinfo->value.enumerated.name,
-		       texts_vx2[uinfo->value.enumerated.item]);
-	}
-	return 0;
+	if (chip->type >= VX_TYPE_VXPOCKET)
+		return snd_ctl_enum_info(uinfo, 1, 3, texts_mic);
+	else
+		return snd_ctl_enum_info(uinfo, 1, 2, texts_vx2);
 }
 
 static int vx_audio_src_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -539,18 +527,11 @@ static struct snd_kcontrol_new vx_control_audio_src = {
  */
 static int vx_clock_mode_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {
+	static const char * const texts[3] = {
 		"Auto", "Internal", "External"
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
 
 static int vx_clock_mode_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-- 
2.1.2
