From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: hda/realtek - Fix the regression by
	widget power-saving
Date: Thu,  9 Apr 2015 10:40:38 +0200
Message-ID: <1428568838-21550-6-git-send-email-tiwai@suse.de>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1560E26588E
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:40 +0200 (CEST)
In-Reply-To: <1428568838-21550-1-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

While enabling the widget power-saving for ALC269 & co, the important
setup was forgotten -- stream_pm ops.  Without this setup, the paths
for PCM won't be powered up at all.

Also, the power_filter callbacks used in ALC269 & co need to chain to
the default snd_hda_gen_path_power_filter().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b5c93e0e78c..acccedf8a4be 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3223,7 +3223,7 @@ static unsigned int led_power_filter(struct hda_codec *codec,
 	snd_hda_set_pin_ctl(codec, nid,
 			    snd_hda_codec_get_pin_target(codec, nid));
 
-	return AC_PWRST_D0;
+	return snd_hda_gen_path_power_filter(codec, nid, power_state);
 }
 
 static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
@@ -4186,7 +4186,7 @@ static unsigned int alc_power_filter_xps13(struct hda_codec *codec,
 	if (spec->gen.hp_jack_present)
 		if (nid == codec->core.afg || nid == 0x02 || nid == 0x15)
 			return AC_PWRST_D0;
-	return power_state;
+	return snd_hda_gen_path_power_filter(codec, nid, power_state);
 }
 
 static void alc_fixup_dell_xps13(struct hda_codec *codec,
@@ -5673,6 +5673,7 @@ static int patch_alc269(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x04, HDA_INPUT);
 
 	codec->patch_ops = alc_patch_ops;
+	codec->patch_ops.stream_pm = snd_hda_gen_stream_pm,
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;
 	codec->patch_ops.resume = alc269_resume;
-- 
2.3.5
