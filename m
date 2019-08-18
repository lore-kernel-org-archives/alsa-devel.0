From: jeronimo@borque.com.ar
Subject: [PATCH v2] ALSA: hda - Fixes inverted Conexant GPIO
	mic mute led
Date: Sun, 18 Aug 2019 18:23:02 -0300
Message-ID: <20190818212302.27430-1-jeronimo@borque.com.ar>
References: <s5himqx8tzj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC2FBF800B6
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2019 23:23:27 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id i4so11983975qtj.8
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2019 14:23:27 -0700 (PDT)
In-Reply-To: <s5himqx8tzj.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Jeronimo Borque <jeronimo@borque.com.ar>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Jeronimo Borque <jeronimo@borque.com.ar>

"enabled" parameter historically referred to the device input or
output, not to the led indicator. After the changes added with the led
helper functions the mic mute led logic refers to the led and not to
the mic input which caused led indicator to be negated.
Fixing logic in cxt_update_gpio_led and updated
cxt_fixup_gpio_mute_hook
Also updated debug messages to ease further debugging if necessary.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jeronimo Borque <jeronimo@borque.com.ar>
---
 sound/pci/hda/patch_conexant.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 14298ef45b21..d1c93dfa158b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -611,18 +611,20 @@ static void cxt_fixup_hp_gate_mic_jack(struct hda_codec *codec,
 
 /* update LED status via GPIO */
 static void cxt_update_gpio_led(struct hda_codec *codec, unsigned int mask,
-				bool enabled)
+				bool led_on)
 {
 	struct conexant_spec *spec = codec->spec;
 	unsigned int oldval = spec->gpio_led;
 
 	if (spec->mute_led_polarity)
-		enabled = !enabled;
+		led_on = !led_on;
 
-	if (enabled)
-		spec->gpio_led &= ~mask;
-	else
+	if (led_on)
 		spec->gpio_led |= mask;
+	else
+		spec->gpio_led &= ~mask;
+	codec_dbg(codec, "mask:%d enabled:%d gpio_led:%d\n
+			mask, led_on, spec->gpio_led);
 	if (spec->gpio_led != oldval)
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
 				    spec->gpio_led);
@@ -633,8 +635,8 @@ static void cxt_fixup_gpio_mute_hook(void *private_data, int enabled)
 {
 	struct hda_codec *codec = private_data;
 	struct conexant_spec *spec = codec->spec;
-
-	cxt_update_gpio_led(codec, spec->gpio_mute_led_mask, enabled);
+	/* muted -> LED on */
+	cxt_update_gpio_led(codec, spec->gpio_mute_led_mask, !enabled);
 }
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
@@ -656,7 +658,6 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x03 },
 		{}
 	};
-	codec_info(codec, "action: %d gpio_led: %d\n", action, spec->gpio_led);
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = cxt_fixup_gpio_mute_hook;
-- 
2.21.0
