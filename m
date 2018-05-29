From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda/realtek - Refactor
	alc269_fixup_hp_mute_led_mic*()
Date: Tue, 29 May 2018 11:49:40 +0200
Message-ID: <20180529094940.2710-2-tiwai@suse.de>
References: <20180529094940.2710-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 125D9267688
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 11:49:43 +0200 (CEST)
In-Reply-To: <20180529094940.2710-1-tiwai@suse.de>
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
Cc: Tom Briden <tom@decompile.me.uk>
List-Id: alsa-devel@alsa-project.org

Just a code refactoring to use the common helper for the all three
functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6369964c117a..4a9ea34b11b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3653,43 +3653,37 @@ static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
 	}
 }
 
-static void alc269_fixup_hp_mute_led_mic1(struct hda_codec *codec,
-				const struct hda_fixup *fix, int action)
+static void alc269_fixup_hp_mute_led_micx(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action, hda_nid_t pin)
 {
 	struct alc_spec *spec = codec->spec;
+
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mute_led_polarity = 0;
-		spec->mute_led_nid = 0x18;
+		spec->mute_led_nid = pin;
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 		codec->power_filter = led_power_filter;
 	}
 }
 
+static void alc269_fixup_hp_mute_led_mic1(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	alc269_fixup_hp_mute_led_micx(codec, fix, action, 0x18);
+}
+
 static void alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->mute_led_polarity = 0;
-		spec->mute_led_nid = 0x19;
-		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
-		spec->gen.vmaster_mute_enum = 1;
-		codec->power_filter = led_power_filter;
-	}
+	alc269_fixup_hp_mute_led_micx(codec, fix, action, 0x19);
 }
 
 static void alc269_fixup_hp_mute_led_mic3(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->mute_led_polarity = 0;
-		spec->mute_led_nid = 0x1b;
-		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
-		spec->gen.vmaster_mute_enum = 1;
-		codec->power_filter = led_power_filter;
-	}
+	alc269_fixup_hp_mute_led_micx(codec, fix, action, 0x1b);
 }
 
 /* update LED status via GPIO */
-- 
2.17.0
