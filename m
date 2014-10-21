From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 42/43] ALSA: 6fire: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:11:18 +0200
Message-ID: <1413886279-18704-43-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E3A8266660
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3AAFBAC0F
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
 sound/usb/6fire/control.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
index 184e3987ac24..54656eed6e2e 100644
--- a/sound/usb/6fire/control.c
+++ b/sound/usb/6fire/control.c
@@ -25,8 +25,8 @@
 #include "comm.h"
 #include "chip.h"
 
-static char *opt_coax_texts[2] = { "Optical", "Coax" };
-static char *line_phono_texts[2] = { "Line", "Phono" };
+static const char * const opt_coax_texts[2] = { "Optical", "Coax" };
+static const char * const line_phono_texts[2] = { "Line", "Phono" };
 
 /*
  * data that needs to be sent to device. sets up card internal stuff.
@@ -327,14 +327,7 @@ static int usb6fire_control_input_vol_get(struct snd_kcontrol *kcontrol,
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-			line_phono_texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, line_phono_texts);
 }
 
 static int usb6fire_control_line_phono_put(struct snd_kcontrol *kcontrol,
@@ -361,14 +354,7 @@ static int usb6fire_control_line_phono_get(struct snd_kcontrol *kcontrol,
 static int usb6fire_control_opt_coax_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-			opt_coax_texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, opt_coax_texts);
 }
 
 static int usb6fire_control_opt_coax_put(struct snd_kcontrol *kcontrol,
-- 
2.1.2
