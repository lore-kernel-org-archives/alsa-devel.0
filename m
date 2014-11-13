From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add mute LED control for Lenovo
	Ideapad Z560
Date: Thu, 13 Nov 2014 09:07:23 +0100
Message-ID: <1415866043-11002-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38A83265CC8
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 09:07:32 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D7C7DAAF1
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 08:07:31 +0000 (UTC)
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

Lenovo Ideapad Z560 has a mute LED that is controlled via EAPD pin
0x1b on CX20585 codec.  (EAPD bit on corresponds to mute LED on.)
The machine doesn't need other EAPD, so the fixup concentrates on
controlling EAPD 0x1b following the vmaster state (but inversely).

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=665315
Reported-by: Szymon Kowalczyk <fazerxlo@o2.pl>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 71e4bad06345..e9ebc7bd752c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -43,6 +43,7 @@ struct conexant_spec {
 	unsigned int num_eapds;
 	hda_nid_t eapds[4];
 	bool dynamic_eapd;
+	hda_nid_t mute_led_eapd;
 
 	unsigned int parse_flags; /* flag for snd_hda_parse_pin_defcfg() */
 
@@ -163,6 +164,17 @@ static void cx_auto_vmaster_hook(void *private_data, int enabled)
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, enabled);
 }
 
+/* turn on/off EAPD according to Master switch (inversely!) for mute LED */
+static void cx_auto_vmaster_hook_mute_led(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct conexant_spec *spec = codec->spec;
+
+	snd_hda_codec_write(codec, spec->mute_led_eapd, 0,
+			    AC_VERB_SET_EAPD_BTLENABLE,
+			    enabled ? 0x00 : 0x02);
+}
+
 static int cx_auto_build_controls(struct hda_codec *codec)
 {
 	int err;
@@ -223,6 +235,7 @@ enum {
 	CXT_FIXUP_TOSHIBA_P105,
 	CXT_FIXUP_HP_530,
 	CXT_FIXUP_CAP_MIX_AMP_5047,
+	CXT_FIXUP_MUTE_LED_EAPD,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -557,6 +570,18 @@ static void cxt_fixup_olpc_xo(struct hda_codec *codec,
 	}
 }
 
+static void cxt_fixup_mute_led_eapd(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_eapd = 0x1b;
+		spec->dynamic_eapd = 1;
+		spec->gen.vmaster_mute.hook = cx_auto_vmaster_hook_mute_led;
+	}
+}
+
 /*
  * Fix max input level on mixer widget to 0dB
  * (originally it has 0x2b steps with 0dB offset 0x14)
@@ -705,6 +730,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_cap_mix_amp_5047,
 	},
+	[CXT_FIXUP_MUTE_LED_EAPD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_mute_led_eapd,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -762,6 +791,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
+	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
@@ -780,6 +810,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LEMOTE_A1004, .name = "lemote-a1004" },
 	{ .id = CXT_PINCFG_LEMOTE_A1205, .name = "lemote-a1205" },
 	{ .id = CXT_FIXUP_OLPC_XO, .name = "olpc-xo" },
+	{ .id = CXT_FIXUP_MUTE_LED_EAPD, .name = "mute-led-eapd" },
 	{}
 };
 
-- 
2.1.3
