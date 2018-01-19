From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Reduce the suspend time
	consumption for ALC256
Date: Fri, 19 Jan 2018 14:26:27 +0100
Message-ID: <20180119132627.27573-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B49267198
 for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2018 14:26:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9897AAB49
 for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2018 13:26:31 +0000 (UTC)
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

ALC256 has its own quirk to override the shutup call, and it contains
the COEF update for pulling down the headset jack control.  Currently,
the COEF update is called after clearing the headphone pin, and this
seems triggering a stall of the codec communication, and results in a
long delay over a second at suspend.

A quick resolution is to swap the calls: at first with the COEF
update, then clear the headphone pin.

Fixes: 4a219ef8f370 ("ALSA: hda/realtek - Add ALC256 HP depop function")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198503
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0004e282a837..23475888192b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3154,11 +3154,13 @@ static void alc256_shutup(struct hda_codec *codec)
 	if (hp_pin_sense)
 		msleep(85);
 
+	/* 3k pull low control for Headset jack. */
+	/* NOTE: call this before clearing the pin, otherwise codec stalls */
+	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
+
 	snd_hda_codec_write(codec, hp_pin, 0,
 			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
-	alc_update_coef_idx(codec, 0x46, 0, 3 << 12); /* 3k pull low control for Headset jack. */
-
 	if (hp_pin_sense)
 		msleep(100);
 
-- 
2.15.1
