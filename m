From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/43] ALSA: echoaudio: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:00 +0200
Message-ID: <1413886279-18704-25-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18DE9266656
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 49349ADA4
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
 sound/pci/echoaudio/echoaudio.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 631aaa4046ad..d82321ff549b 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1416,21 +1416,14 @@ static struct snd_kcontrol_new snd_echo_vmixer = {
 static int snd_echo_digital_mode_info(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_info *uinfo)
 {
-	static char *names[4] = {
+	static const char * const names[4] = {
 		"S/PDIF Coaxial", "S/PDIF Optical", "ADAT Optical",
 		"S/PDIF Cdrom"
 	};
 	struct echoaudio *chip;
 
 	chip = snd_kcontrol_chip(kcontrol);
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->value.enumerated.items = chip->num_digital_modes;
-	uinfo->count = 1;
-	if (uinfo->value.enumerated.item >= chip->num_digital_modes)
-		uinfo->value.enumerated.item = chip->num_digital_modes - 1;
-	strcpy(uinfo->value.enumerated.name, names[
-			chip->digital_mode_list[uinfo->value.enumerated.item]]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, chip->num_digital_modes, names);
 }
 
 static int snd_echo_digital_mode_get(struct snd_kcontrol *kcontrol,
@@ -1509,16 +1502,9 @@ static struct snd_kcontrol_new snd_echo_digital_mode_switch = {
 static int snd_echo_spdif_mode_info(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_info *uinfo)
 {
-	static char *names[2] = {"Consumer", "Professional"};
+	static const char * const names[2] = {"Consumer", "Professional"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->value.enumerated.items = 2;
-	uinfo->count = 1;
-	if (uinfo->value.enumerated.item)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-	       names[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, names);
 }
 
 static int snd_echo_spdif_mode_get(struct snd_kcontrol *kcontrol,
@@ -1566,21 +1552,14 @@ static struct snd_kcontrol_new snd_echo_spdif_mode_switch = {
 static int snd_echo_clock_source_info(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_info *uinfo)
 {
-	static char *names[8] = {
+	static const char * const names[8] = {
 		"Internal", "Word", "Super", "S/PDIF", "ADAT", "ESync",
 		"ESync96", "MTC"
 	};
 	struct echoaudio *chip;
 
 	chip = snd_kcontrol_chip(kcontrol);
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->value.enumerated.items = chip->num_clock_sources;
-	uinfo->count = 1;
-	if (uinfo->value.enumerated.item >= chip->num_clock_sources)
-		uinfo->value.enumerated.item = chip->num_clock_sources - 1;
-	strcpy(uinfo->value.enumerated.name, names[
-			chip->clock_source_list[uinfo->value.enumerated.item]]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, chip->num_clock_sources, names);
 }
 
 static int snd_echo_clock_source_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
