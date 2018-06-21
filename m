From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda/sigmatel - Use common helper for
	mic mute LED
Date: Thu, 21 Jun 2018 14:25:00 +0200
Message-ID: <20180621122501.22290-5-tiwai@suse.de>
References: <20180621122501.22290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D94EE2676D9
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 14:25:06 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2A394AFEC
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

To simplify the code and to get the mic-mute LED behavior control, use
the new helper function for controlling the mic mute LED instead of
open-codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 63d15b545b33..046705b4691a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -332,33 +332,15 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
 }
 
 /* hook for controlling mic-mute LED GPIO */
-static void stac_capture_led_hook(struct hda_codec *codec,
-				  struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
+static void stac_capture_led_update(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	unsigned int mask;
-	bool cur_mute, prev_mute;
 
-	if (!kcontrol || !ucontrol)
-		return;
-
-	mask = 1U << snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-	prev_mute = !spec->mic_enabled;
-	if (ucontrol->value.integer.value[0] ||
-	    ucontrol->value.integer.value[1])
-		spec->mic_enabled |= mask;
+	if (spec->gen.micmute_led.led_value)
+		spec->gpio_data |= spec->mic_mute_led_gpio;
 	else
-		spec->mic_enabled &= ~mask;
-	cur_mute = !spec->mic_enabled;
-	if (cur_mute != prev_mute) {
-		if (cur_mute)
-			spec->gpio_data |= spec->mic_mute_led_gpio;
-		else
-			spec->gpio_data &= ~spec->mic_mute_led_gpio;
-		stac_gpio_set(codec, spec->gpio_mask,
-			      spec->gpio_dir, spec->gpio_data);
-	}
+		spec->gpio_data &= ~spec->mic_mute_led_gpio;
+	stac_gpio_set(codec, spec->gpio_mask, spec->gpio_dir, spec->gpio_data);
 }
 
 static int stac_vrefout_set(struct hda_codec *codec,
@@ -4656,8 +4638,7 @@ static void stac_setup_gpio(struct hda_codec *codec)
 		spec->gpio_dir |= spec->mic_mute_led_gpio;
 		spec->mic_enabled = 0;
 		spec->gpio_data |= spec->mic_mute_led_gpio;
-
-		spec->gen.cap_sync_hook = stac_capture_led_hook;
+		snd_hda_gen_add_micmute_led(codec, stac_capture_led_update);
 	}
 }
 
-- 
2.17.1
