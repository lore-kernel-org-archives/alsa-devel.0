From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 43/43] ALSA: usb-audio: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:19 +0200
Message-ID: <1413886279-18704-44-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7D1266661
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 458FAACA7
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

... and reduce the open codes.  Also add missing const to text arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f119a41ed9a9..3980bf554c83 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -437,19 +437,9 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 static int snd_emu0204_ch_switch_info(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[2] = {"1/2",
-				       "3/4"
-	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
+	static const char * const texts[2] = {"1/2", "3/4"};
 
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
 static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
@@ -735,25 +725,12 @@ struct snd_ftu_eff_switch_priv_val {
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[8] = {"Room 1",
-				       "Room 2",
-				       "Room 3",
-				       "Hall 1",
-				       "Hall 2",
-				       "Plate",
-				       "Delay",
-				       "Echo"
+	static const char *const texts[8] = {
+		"Room 1", "Room 2", "Room 3", "Hall 1",
+		"Hall 2", "Plate", "Delay", "Echo"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 8;
-	if (uinfo->value.enumerated.item > 7)
-		uinfo->value.enumerated.item = 7;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
 static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
-- 
2.1.2
