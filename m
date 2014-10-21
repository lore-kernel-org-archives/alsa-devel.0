From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/43] ALSA: wss: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:51 +0200
Message-ID: <1413886279-18704-16-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8658266641
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0E2F7AD79
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
 sound/isa/wss/wss_lib.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 360b08b03e1d..347bb1bda110 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1993,25 +1993,20 @@ EXPORT_SYMBOL(snd_wss_timer);
 static int snd_wss_info_mux(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {
+	static const char * const texts[4] = {
 		"Line", "Aux", "Mic", "Mix"
 	};
-	static char *opl3sa_texts[4] = {
+	static const char * const opl3sa_texts[4] = {
 		"Line", "CD", "Mic", "Mix"
 	};
-	static char *gusmax_texts[4] = {
+	static const char * const gusmax_texts[4] = {
 		"Line", "Synth", "Mic", "Mix"
 	};
-	char **ptexts = texts;
+	const char * const *ptexts = texts;
 	struct snd_wss *chip = snd_kcontrol_chip(kcontrol);
 
 	if (snd_BUG_ON(!chip->card))
 		return -EINVAL;
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 2;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-		uinfo->value.enumerated.item = 3;
 	if (!strcmp(chip->card->driver, "GUS MAX"))
 		ptexts = gusmax_texts;
 	switch (chip->hardware) {
@@ -2023,8 +2018,7 @@ static int snd_wss_info_mux(struct snd_kcontrol *kcontrol,
 		ptexts = opl3sa_texts;
 		break;
 	}
-	strcpy(uinfo->value.enumerated.name, ptexts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 2, 4, ptexts);
 }
 
 static int snd_wss_get_mux(struct snd_kcontrol *kcontrol,
-- 
2.1.2
