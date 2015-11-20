From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply HP headphone fixups more
	generically
Date: Fri, 20 Nov 2015 17:04:15 +0100
Message-ID: <1448035455-4541-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D4334261A73
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 17:04:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8BCADAAB2
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 16:03:51 +0000 (UTC)
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

It turned out that many HP laptops suffer from the same problem as
fixed in commit [c932b98c1e47: ALSA: hda - Apply pin fixup for HP
ProBook 6550b].  But, it's tiresome to list up all such PCI SSIDs, as
there are really lots of HP machines.

Instead, we do a bit more clever, try to check the supposedly dock and
built-in headphone pins, and apply the fixup when both seem valid.
This rule can be applied generically to all models using the same
quirk, so we'll fix all in a shot.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107491
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 45 +++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 826122d8acee..2c7c5eb8b1e9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3110,6 +3110,29 @@ static void stac92hd71bxx_fixup_hp_hdx(struct hda_codec *codec,
 	spec->gpio_led = 0x08;
 }
 
+static bool is_hp_output(struct hda_codec *codec, hda_nid_t pin)
+{
+	unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, pin);
+
+	/* count line-out, too, as BIOS sets often so */
+	return get_defcfg_connect(pin_cfg) != AC_JACK_PORT_NONE &&
+		(get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
+		 get_defcfg_device(pin_cfg) == AC_JACK_HP_OUT);
+}
+
+static void fixup_hp_headphone(struct hda_codec *codec, hda_nid_t pin)
+{
+	unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, pin);
+
+	/* It was changed in the BIOS to just satisfy MS DTM.
+	 * Lets turn it back into slaved HP
+	 */
+	pin_cfg = (pin_cfg & (~AC_DEFCFG_DEVICE)) |
+		(AC_JACK_HP_OUT << AC_DEFCFG_DEVICE_SHIFT);
+	pin_cfg = (pin_cfg & (~(AC_DEFCFG_DEF_ASSOC | AC_DEFCFG_SEQUENCE))) |
+		0x1f;
+	snd_hda_codec_set_pincfg(codec, pin, pin_cfg);
+}
 
 static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
@@ -3119,22 +3142,12 @@ static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
 	if (action != HDA_FIXUP_ACT_PRE_PROBE)
 		return;
 
-	if (hp_blike_system(codec->core.subsystem_id)) {
-		unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
-		if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
-			get_defcfg_device(pin_cfg) == AC_JACK_SPEAKER  ||
-			get_defcfg_device(pin_cfg) == AC_JACK_HP_OUT) {
-			/* It was changed in the BIOS to just satisfy MS DTM.
-			 * Lets turn it back into slaved HP
-			 */
-			pin_cfg = (pin_cfg & (~AC_DEFCFG_DEVICE))
-					| (AC_JACK_HP_OUT <<
-						AC_DEFCFG_DEVICE_SHIFT);
-			pin_cfg = (pin_cfg & (~(AC_DEFCFG_DEF_ASSOC
-							| AC_DEFCFG_SEQUENCE)))
-								| 0x1f;
-			snd_hda_codec_set_pincfg(codec, 0x0f, pin_cfg);
-		}
+	/* when both output A and F are assigned, these are supposedly
+	 * dock and built-in headphones; fix both pin configs
+	 */
+	if (is_hp_output(codec, 0x0a) && is_hp_output(codec, 0x0f)) {
+		fixup_hp_headphone(codec, 0x0a);
+		fixup_hp_headphone(codec, 0x0f);
 	}
 
 	if (find_mute_led_cfg(codec, 1))
-- 
2.6.3
