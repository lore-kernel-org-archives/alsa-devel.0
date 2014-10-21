From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/43] ALSA: aoa: Use snd_ctl_elem_info()
Date: Tue, 21 Oct 2014 12:10:40 +0200
Message-ID: <1413886279-18704-5-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DE44266636
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0A9E6ACA7
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

... and reduce the open codes.  Also add missing const to text arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/codecs/onyx.c |  8 +-------
 sound/aoa/codecs/tas.c  | 10 ++--------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 401107b85d30..23c371ecfb6b 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -243,13 +243,7 @@ static int onyx_snd_capture_source_info(struct snd_kcontrol *kcontrol,
 {
 	static const char * const texts[] = { "Line-In", "Microphone" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int onyx_snd_capture_source_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index cf3c6303b7e3..364c7c4416e8 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -478,15 +478,9 @@ static struct snd_kcontrol_new drc_switch_control = {
 static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Line-In", "Microphone" };
+	static const char * const texts[] = { "Line-In", "Microphone" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int tas_snd_capture_source_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
