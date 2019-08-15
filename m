From: jeronimo@borque.com.ar
Subject: [PATCH] ALSA: hda - Fixes inverted Conexant GPIO mic
	mute led
Date: Wed, 14 Aug 2019 22:38:24 -0300
Message-ID: <20190815013824.13373-1-jeronimo@borque.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34755F801DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 03:39:23 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id q4so881231qtp.1
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 18:39:23 -0700 (PDT)
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
Cc: Jeronimo Borque <jeronimo@borque.com.ar>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Jeronimo Borque <jeronimo@borque.com.ar>

"enabled" parameter historically referred to the device input or
output, not to the led indicator. After the changes added with the
led helper functions the mic mute led logic refers to the led and not
to the mic input which caused led indicator to be negated (Mic mute
led was on when the input enabled) Fixing it in the call to
cxt_update_gpio_led at the cxt_gpio_micmute_update hook.
Maybe more changes are required to be consistent everywhere.

Signed-off-by: Jeronimo Borque <jeronimo@borque.com.ar>
---
 sound/pci/hda/patch_conexant.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f299f137eaea..8edf0d1290b5 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -636,6 +636,10 @@ static void cxt_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 		spec->gpio_led &= ~mask;
 	else
 		spec->gpio_led |= mask;
+
+	codec_dbg(codec, "mask:%d enabled:%d gpio_led:%d\n",
+			    mask, enabled, spec->gpio_led);
+
 	if (spec->gpio_led != oldval)
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
 				    spec->gpio_led);
@@ -656,7 +660,7 @@ static void cxt_gpio_micmute_update(struct hda_codec *codec)
 	struct conexant_spec *spec = codec->spec;
 
 	cxt_update_gpio_led(codec, spec->gpio_mic_led_mask,
-			    spec->gen.micmute_led.led_value);
+			    !spec->gen.micmute_led.led_value);
 }
 
 
@@ -669,7 +673,6 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x03 },
 		{}
 	};
-	codec_info(codec, "action: %d gpio_led: %d\n", action, spec->gpio_led);
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = cxt_fixup_gpio_mute_hook;
-- 
2.21.0
