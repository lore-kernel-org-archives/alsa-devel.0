From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/43] ALSA: es18xx: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:48 +0200
Message-ID: <1413886279-18704-13-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D63C126663F
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0F84BAD94
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
 sound/isa/es18xx.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 6faaac60161a..63e7323e218f 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -964,44 +964,28 @@ static int snd_es18xx_capture_close(struct snd_pcm_substream *substream)
 
 static int snd_es18xx_info_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts5Source[5] = {
+	static const char * const texts5Source[5] = {
 		"Mic", "CD", "Line", "Master", "Mix"
 	};
-	static char *texts8Source[8] = {
+	static const char * const texts8Source[8] = {
 		"Mic", "Mic Master", "CD", "AOUT",
 		"Mic1", "Mix", "Line", "Master"
 	};
 	struct snd_es18xx *chip = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
 	switch (chip->version) {
 	case 0x1868:
 	case 0x1878:
-		uinfo->value.enumerated.items = 4;
-		if (uinfo->value.enumerated.item > 3)
-			uinfo->value.enumerated.item = 3;
-		strcpy(uinfo->value.enumerated.name,
-			texts5Source[uinfo->value.enumerated.item]);
-		break;
+		return snd_ctl_enum_info(uinfo, 1, 4, texts5Source);
 	case 0x1887:
 	case 0x1888:
-		uinfo->value.enumerated.items = 5;
-		if (uinfo->value.enumerated.item > 4)
-			uinfo->value.enumerated.item = 4;
-		strcpy(uinfo->value.enumerated.name, texts5Source[uinfo->value.enumerated.item]);
-		break;
+		return snd_ctl_enum_info(uinfo, 1, 5, texts5Source);
 	case 0x1869: /* DS somewhat contradictory for 1869: could be be 5 or 8 */
 	case 0x1879:
-		uinfo->value.enumerated.items = 8;
-		if (uinfo->value.enumerated.item > 7)
-			uinfo->value.enumerated.item = 7;
-		strcpy(uinfo->value.enumerated.name, texts8Source[uinfo->value.enumerated.item]);
-		break;
+		return snd_ctl_enum_info(uinfo, 1, 8, texts8Source);
 	default:
 		return -EINVAL;
 	}
-	return 0;
 }
 
 static int snd_es18xx_get_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-- 
2.1.2
