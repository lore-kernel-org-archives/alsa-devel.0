From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: hda/conexant - Use the mic-mute LED
	helper
Date: Thu, 21 Jun 2018 14:24:58 +0200
Message-ID: <20180621122501.22290-3-tiwai@suse.de>
References: <20180621122501.22290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A44F42673F2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 14:25:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 11E26AFE4
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:25:05 +0000 (UTC)
In-Reply-To: <20180621122501.22290-1-tiwai@suse.de>
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

Convert to use the common helper for controlling the mic mute LED for
HP laptops, just as we've done for Realtek codecs.  This will give the
mic mute LED enum as gratis.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e7fcfc3b8885..a9fd0572d526 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -695,16 +695,12 @@ static void cxt_fixup_gpio_mute_hook(void *private_data, int enabled)
 }
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
-static void cxt_fixup_gpio_mic_mute_hook(struct hda_codec *codec,
-					 struct snd_kcontrol *kcontrol,
-					 struct snd_ctl_elem_value *ucontrol)
+static void cxt_gpio_micmute_update(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
-	if (ucontrol)
-		cxt_update_gpio_led(codec, spec->gpio_mic_led_mask,
-				    ucontrol->value.integer.value[0] ||
-				    ucontrol->value.integer.value[1]);
+	cxt_update_gpio_led(codec, spec->gpio_mic_led_mask,
+			    spec->gen.micmute_led.led_value);
 }
 
 
@@ -721,11 +717,11 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = cxt_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = cxt_fixup_gpio_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x01;
 		spec->gpio_mic_led_mask = 0x02;
+		snd_hda_gen_add_micmute_led(codec, cxt_gpio_micmute_update);
 	}
 	snd_hda_add_verbs(codec, gpio_init);
 	if (spec->gpio_led)
-- 
2.17.1
