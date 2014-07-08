From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - fix a typo by changing
	mute_led_nid to cap_mute_led_nid
Date: Tue,  8 Jul 2014 17:56:14 +0800
Message-ID: <1404813375-7602-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 16138260824
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 11:56:42 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id lj1so7013570pab.22
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 02:56:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, kailang@realtek.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

BugLink: https://bugs.launchpad.net/bugs/1329580
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 327413e..73b1759 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3529,7 +3529,7 @@ static void alc269_fixup_hp_cap_mic_mute_hook(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 	unsigned int pinval, enable, disable;
 
-	pinval = snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);
+	pinval = snd_hda_codec_get_pin_target(codec, spec->cap_mute_led_nid);
 	pinval &= ~AC_PINCTL_VREFEN;
 	enable  = pinval | AC_PINCTL_VREF_80;
 	disable = pinval | AC_PINCTL_VREF_HIZ;
-- 
1.8.1.2
