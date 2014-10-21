From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 39/43] ALSA: via82xx: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:15 +0200
Message-ID: <1413886279-18704-40-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E39C26665E
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 16CD1ACE5
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:25 +0000 (UTC)
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
 sound/pci/via82xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index ecedf4dbfa2a..e088467fb736 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1610,16 +1610,10 @@ static int snd_via8233_capture_source_info(struct snd_kcontrol *kcontrol,
 	/* formerly they were "Line" and "Mic", but it looks like that they
 	 * have nothing to do with the actual physical connections...
 	 */
-	static char *texts[2] = {
+	static const char * const texts[2] = {
 		"Input1", "Input2"
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item >= 2)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_via8233_capture_source_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
