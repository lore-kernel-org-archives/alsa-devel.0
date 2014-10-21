From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 31/43] ALSA: korg1212: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:07 +0200
Message-ID: <1413886279-18704-32-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB3F266658
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 962D5ADAD
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
 sound/pci/korg1212/korg1212.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 9fe549b2efdf..59d21c9401d2 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -444,9 +444,9 @@ static char *stateName[] = {
 	"Invalid"
 };
 
-static char *clockSourceTypeName[] = { "ADAT", "S/PDIF", "local" };
+static const char * const clockSourceTypeName[] = { "ADAT", "S/PDIF", "local" };
 
-static char *clockSourceName[] = {
+static const char * const clockSourceName[] = {
 	"ADAT at 44.1 kHz",
 	"ADAT at 48 kHz",
 	"S/PDIF at 44.1 kHz",
@@ -455,7 +455,7 @@ static char *clockSourceName[] = {
 	"local clock at 48 kHz"
 };
 
-static char *channelName[] = {
+static const char * const channelName[] = {
 	"ADAT-1",
 	"ADAT-2",
 	"ADAT-3",
@@ -1844,14 +1844,9 @@ static int snd_korg1212_control_volume_put(struct snd_kcontrol *kcontrol,
 static int snd_korg1212_control_route_info(struct snd_kcontrol *kcontrol,
 					   struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = (kcontrol->private_value >= 8) ? 2 : 1;
-	uinfo->value.enumerated.items = kAudioChannels;
-	if (uinfo->value.enumerated.item > kAudioChannels-1) {
-		uinfo->value.enumerated.item = kAudioChannels-1;
-	}
-	strcpy(uinfo->value.enumerated.name, channelName[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo,
+				 (kcontrol->private_value >= 8) ? 2 : 1,
+				 kAudioChannels, channelName);
 }
 
 static int snd_korg1212_control_route_get(struct snd_kcontrol *kcontrol,
@@ -1961,14 +1956,7 @@ static int snd_korg1212_control_put(struct snd_kcontrol *kcontrol,
 static int snd_korg1212_control_sync_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2) {
-		uinfo->value.enumerated.item = 2;
-	}
-	strcpy(uinfo->value.enumerated.name, clockSourceTypeName[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, clockSourceTypeName);
 }
 
 static int snd_korg1212_control_sync_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
