From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Simplify
	alc269_fixup_hp_line1_mic1_led()
Date: Fri, 22 Jun 2018 11:38:02 +0200
Message-ID: <20180622093802.25120-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 09A382673F2
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:38:06 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 71219ACFC
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:38:06 +0000 (UTC)
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

alc269_fixup_hp_line1_mic1_led() can be simplified more with the
existing helper code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d9461eebcfdf..7934c5df4d80 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3973,14 +3973,10 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
+	alc269_fixup_hp_mute_led_micx(codec, fix, action, 0x1a);
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
-		spec->mute_led_polarity = 0;
-		spec->mute_led_nid = 0x1a;
 		spec->cap_mute_led_nid = 0x18;
 		snd_hda_gen_add_micmute_led(codec, alc_cap_micmute_update);
-		spec->gen.vmaster_mute_enum = 1;
-		codec->power_filter = led_power_filter;
 	}
 }
 
-- 
2.17.1
