From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 33/43] ALSA: rme32: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:09 +0200
Message-ID: <1413886279-18704-34-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F75426665B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9DB3ADAF
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
 sound/pci/rme32.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 4afd3cab775b..6c60dcd2e5a1 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1608,30 +1608,24 @@ snd_rme32_info_inputtype_control(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
 	struct rme32 *rme32 = snd_kcontrol_chip(kcontrol);
-	static char *texts[4] = { "Optical", "Coaxial", "Internal", "XLR" };
+	static const char * const texts[4] = {
+		"Optical", "Coaxial", "Internal", "XLR"
+	};
+	int num_items;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
 	switch (rme32->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI32:
 	case PCI_DEVICE_ID_RME_DIGI32_8:
-		uinfo->value.enumerated.items = 3;
+		num_items = 3;
 		break;
 	case PCI_DEVICE_ID_RME_DIGI32_PRO:
-		uinfo->value.enumerated.items = 4;
+		num_items = 4;
 		break;
 	default:
 		snd_BUG();
-		break;
-	}
-	if (uinfo->value.enumerated.item >
-	    uinfo->value.enumerated.items - 1) {
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
+		return -EINVAL;
 	}
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_items, texts);
 }
 static int
 snd_rme32_get_inputtype_control(struct snd_kcontrol *kcontrol,
@@ -1695,20 +1689,12 @@ static int
 snd_rme32_info_clockmode_control(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = { "AutoSync", 
+	static const char * const texts[4] = { "AutoSync",
 				  "Internal 32.0kHz", 
 				  "Internal 44.1kHz", 
 				  "Internal 48.0kHz" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3) {
-		uinfo->value.enumerated.item = 3;
-	}
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 static int
 snd_rme32_get_clockmode_control(struct snd_kcontrol *kcontrol,
-- 
2.1.2
