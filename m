From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 26/43] ALSA: es1938: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:02 +0200
Message-ID: <1413886279-18704-27-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 035F8266648
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5E1FAADA8
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

... and reduce the open codes.  Also add missing const to the text array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1938.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 639962443ccc..0fc46eb4e251 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1045,18 +1045,12 @@ static int snd_es1938_new_pcm(struct es1938 *chip, int device)
 static int snd_es1938_info_mux(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[8] = {
+	static const char * const texts[8] = {
 		"Mic", "Mic Master", "CD", "AOUT",
 		"Mic1", "Mix", "Line", "Master"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 8;
-	if (uinfo->value.enumerated.item > 7)
-		uinfo->value.enumerated.item = 7;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 8, texts);
 }
 
 static int snd_es1938_get_mux(struct snd_kcontrol *kcontrol,
-- 
2.1.2
