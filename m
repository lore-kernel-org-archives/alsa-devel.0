From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/43] ALSA: bebob: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:44 +0200
Message-ID: <1413886279-18704-9-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB1D26663C
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0C327AD35
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

... and reduce the open codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/bebob/bebob_maudio.c | 41 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 34cba8037b36..a422aaa3bb0c 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -352,17 +352,8 @@ static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
 static int special_clk_ctl_info(struct snd_kcontrol *kctl,
 				struct snd_ctl_elem_info *einf)
 {
-	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	einf->count = 1;
-	einf->value.enumerated.items = ARRAY_SIZE(special_clk_labels);
-
-	if (einf->value.enumerated.item >= einf->value.enumerated.items)
-		einf->value.enumerated.item = einf->value.enumerated.items - 1;
-
-	strcpy(einf->value.enumerated.name,
-	       special_clk_labels[einf->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(einf, 1, ARRAY_SIZE(special_clk_labels),
+				 special_clk_labels);
 }
 static int special_clk_ctl_get(struct snd_kcontrol *kctl,
 			       struct snd_ctl_elem_value *uval)
@@ -444,17 +435,9 @@ static const char *const special_dig_in_iface_labels[] = {
 static int special_dig_in_iface_ctl_info(struct snd_kcontrol *kctl,
 					 struct snd_ctl_elem_info *einf)
 {
-	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	einf->count = 1;
-	einf->value.enumerated.items = ARRAY_SIZE(special_dig_in_iface_labels);
-
-	if (einf->value.enumerated.item >= einf->value.enumerated.items)
-		einf->value.enumerated.item = einf->value.enumerated.items - 1;
-
-	strcpy(einf->value.enumerated.name,
-	       special_dig_in_iface_labels[einf->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(einf, 1,
+				 ARRAY_SIZE(special_dig_in_iface_labels),
+				 special_dig_in_iface_labels);
 }
 static int special_dig_in_iface_ctl_get(struct snd_kcontrol *kctl,
 					struct snd_ctl_elem_value *uval)
@@ -545,17 +528,9 @@ static const char *const special_dig_out_iface_labels[] = {
 static int special_dig_out_iface_ctl_info(struct snd_kcontrol *kctl,
 					  struct snd_ctl_elem_info *einf)
 {
-	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	einf->count = 1;
-	einf->value.enumerated.items = ARRAY_SIZE(special_dig_out_iface_labels);
-
-	if (einf->value.enumerated.item >= einf->value.enumerated.items)
-		einf->value.enumerated.item = einf->value.enumerated.items - 1;
-
-	strcpy(einf->value.enumerated.name,
-	       special_dig_out_iface_labels[einf->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(einf, 1,
+				 ARRAY_SIZE(special_dig_out_iface_labels),
+				 special_dig_out_iface_labels);
 }
 static int special_dig_out_iface_ctl_get(struct snd_kcontrol *kctl,
 					 struct snd_ctl_elem_value *uval)
-- 
2.1.2
