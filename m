From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/43] ALSA: asihpi: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:56 +0200
Message-ID: <1413886279-18704-21-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EABFC266645
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 11A14AD9F
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

... and reduce the open codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/asihpi.c | 46 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 5017176bfaa1..ac66b3228a34 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1625,18 +1625,7 @@ static const char * const asihpi_aesebu_format_names[] = {
 static int snd_asihpi_aesebu_format_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-		asihpi_aesebu_format_names[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, asihpi_aesebu_format_names);
 }
 
 static int snd_asihpi_aesebu_format_get(struct snd_kcontrol *kcontrol,
@@ -1863,22 +1852,7 @@ static int snd_asihpi_tuner_band_info(struct snd_kcontrol *kcontrol,
 	if (num_bands < 0)
 		return num_bands;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = num_bands;
-
-	if (num_bands > 0) {
-		if (uinfo->value.enumerated.item >=
-					uinfo->value.enumerated.items)
-			uinfo->value.enumerated.item =
-				uinfo->value.enumerated.items - 1;
-
-		strcpy(uinfo->value.enumerated.name,
-			asihpi_tuner_band_names[
-				tuner_bands[uinfo->value.enumerated.item]]);
-
-	}
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_bands, asihpi_tuner_band_names);
 }
 
 static int snd_asihpi_tuner_band_get(struct snd_kcontrol *kcontrol,
@@ -2253,7 +2227,7 @@ static int snd_asihpi_cmode_info(struct snd_kcontrol *kcontrol,
 	u32 h_control = kcontrol->private_value;
 	u16 mode;
 	int i;
-	u16 mode_map[6];
+	const char *mapped_names[6];
 	int valid_modes = 0;
 
 	/* HPI channel mode values can be from 1 to 6
@@ -2262,24 +2236,14 @@ static int snd_asihpi_cmode_info(struct snd_kcontrol *kcontrol,
 	for (i = 0; i < HPI_CHANNEL_MODE_LAST; i++)
 		if (!hpi_channel_mode_query_mode(
 			h_control, i, &mode)) {
-			mode_map[valid_modes] = mode;
+			mapped_names[valid_modes] = mode_names[mode];
 			valid_modes++;
 			}
 
 	if (!valid_modes)
 		return -EINVAL;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = valid_modes;
-
-	if (uinfo->value.enumerated.item >= valid_modes)
-		uinfo->value.enumerated.item = valid_modes - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-	       mode_names[mode_map[uinfo->value.enumerated.item]]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, valid_modes, mapped_names);
 }
 
 static int snd_asihpi_cmode_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
