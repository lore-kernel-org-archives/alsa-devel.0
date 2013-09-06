From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add dock speaker support for ASUS
	TX300
Date: Fri,  6 Sep 2013 15:56:14 +0200
Message-ID: <1378475774-993-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA8C26086E
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 15:54:02 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1D165A4EB7
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 15:54:02 +0200 (CEST)
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

ASUS TX300 has a built-in speaker in the tablet part and in the dock
part, and the tablet speaker is supposed to be unused while the
machine is docked.  The current HD-audio driver, however, doesn't
support the dock speaker, partly because BIOS doesn't set up the pin
for the corresponding output.

But, not only the missing pin config, also the missing unsol event
handling is another issue.  Otherwise the automatic switching via
dock/undock won't work.

Through debugging sessions, we found out that the dock speaker pin is
NID 0x1b, and it generates an unsol event at docking/undocking, the
docking state can be inquired via the normal pin detection verb.
Also, it's turned out that GPIO 2 is needed as an amp.  So, all
materials are ready to cook.

This patch provides the basic dock speaker support with TX300:
- The dock speaker is turned on/off via "Dock Speaker" mixer mute.
- The dock speaker is automatically muted when docked.  This is
  independently from the mixer mute switch, just like the headphone
  auto-mute function.

The implementation is a bit tricky.  Since we want to handle it as a
secondary speaker, we set it up a pin as a speaker with a jack
detection.  Then, the fixup function registers the own unsol callback
for this pin because the standard automute can't handle the thing like
a "speaker jack".  In the own automute hook, we apply the mute of the
tablet speaker in addition by checking the dock state.

Also, the speaker control names are slightly shuffled because the
generic parser doesn't give good names but blindly assumes a bass
speaker as a secondary speaker.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=59791
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4a90917..d38d6a0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3443,6 +3443,56 @@ static void alc283_fixup_chromebook(struct hda_codec *codec,
 	}
 }
 
+/* mute tablet speaker pin (0x14) via dock plugging in addition */
+static void asus_tx300_automute(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	snd_hda_gen_update_outputs(codec);
+	if (snd_hda_jack_detect(codec, 0x1b))
+		spec->gen.mute_bits |= (1ULL << 0x14);
+}
+
+static void alc282_fixup_asus_tx300(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	/* TX300 needs to set up GPIO2 for the speaker amp */
+	static const struct hda_verb gpio2_verbs[] = {
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x04 },
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04 },
+		{ 0x01, AC_VERB_SET_GPIO_DATA, 0x04 },
+		{}
+	};
+	static const struct hda_pintbl dock_pins[] = {
+		{ 0x1b, 0x21114000 }, /* dock speaker pin */
+		{}
+	};
+	struct snd_kcontrol *kctl;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_add_verbs(codec, gpio2_verbs);
+		snd_hda_apply_pincfgs(codec, dock_pins);
+		spec->gen.auto_mute_via_amp = 1;
+		spec->gen.automute_hook = asus_tx300_automute;
+		snd_hda_jack_detect_enable_callback(codec, 0x1b,
+						    HDA_GEN_HP_EVENT,
+						    snd_hda_gen_hp_automute);
+		break;
+	case HDA_FIXUP_ACT_BUILD:
+		/* this is a bit tricky; give more sane names for the main
+		 * (tablet) speaker and the dock speaker, respectively
+		 */
+		kctl = snd_hda_find_mixer_ctl(codec, "Speaker Playback Switch");
+		if (kctl)
+			strcpy(kctl->id.name, "Dock Speaker Playback Switch");
+		kctl = snd_hda_find_mixer_ctl(codec, "Bass Speaker Playback Switch");
+		if (kctl)
+			strcpy(kctl->id.name, "Speaker Playback Switch");
+		break;
+	}
+}
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -3480,6 +3530,7 @@ enum {
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
 	ALC269VB_FIXUP_ORDISSIMO_EVE2,
 	ALC283_FIXUP_CHROME_BOOK,
+	ALC282_FIXUP_ASUS_TX300,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3735,6 +3786,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc283_fixup_chromebook,
 	},
+	[ALC282_FIXUP_ASUS_TX300] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc282_fixup_asus_tx300,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -3784,6 +3839,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x21ed, "HP Falco Chromebook", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
-- 
1.8.4
