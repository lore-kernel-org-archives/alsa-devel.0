From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic support for Asus
	X101CH
Date: Mon, 15 Apr 2013 12:50:02 +0200
Message-ID: <1366023002-5100-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 35BE026512F
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 12:50:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: kailang@realtek.com, David Henningsson <david.henningsson@canonical.com>, 1169138@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

With this patch, a TRRS headset mic cannot be successfully detected
on the Asus X101CH, and we can also distinguish between headphone
and headset automatically.

Buglink: https://bugs.launchpad.net/bugs/1169138
Co-authored-by: Kailang <kailang@realtek.com>
Tested-by: Luis Henriques <luis.henriques@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Now that we have better headset mic support infrastructure, I remembered I forgot
to upstream this patch. It was originally provided by Realtek (therefore, I cannot
answer for the msleeps and exactly why this is needed). I just rewrote it for the
current kernel version.

 sound/pci/hda/patch_realtek.c |   56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6cf27f5..1b7aed5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2680,6 +2680,34 @@ static void alc269_fixup_quanta_mute(struct hda_codec *codec,
 	spec->gen.automute_hook = alc269_quanta_automute;
 }
 
+static void alc269_x101_hp_automute_hook(struct hda_codec *codec,
+					 struct hda_jack_tbl *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	int vref;
+	msleep(200);
+	snd_hda_gen_hp_automute(codec, jack);
+
+	vref = spec->gen.hp_jack_present ? PIN_VREF80 : 0;
+	msleep(100);
+	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    vref);
+	msleep(500);
+	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    vref);
+}
+
+static void alc269_fixup_x101_headset_mic(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		spec->gen.hp_automute_hook = alc269_x101_hp_automute_hook;
+	}
+}
+
+
 /* update mute-LED according to the speaker mute state via mic VREF pin */
 static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 {
@@ -2837,6 +2865,9 @@ enum {
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
+	ALC269_FIXUP_ASUS_X101_FUNC,
+	ALC269_FIXUP_ASUS_X101_VERB,
+	ALC269_FIXUP_ASUS_X101,
 	ALC271_FIXUP_AMIC_MIC2,
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
 	ALC269_FIXUP_ACER_AC700,
@@ -2996,6 +3027,30 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC269_FIXUP_ASUS_X101_FUNC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_x101_headset_mic,
+	},
+	[ALC269_FIXUP_ASUS_X101_VERB] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x08},
+			{0x20, AC_VERB_SET_PROC_COEF,  0x0310},
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_ASUS_X101_FUNC
+	},
+	[ALC269_FIXUP_ASUS_X101] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x04a1182c }, /* Headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_ASUS_X101_VERB
+	},
 	[ALC271_FIXUP_AMIC_MIC2] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -3044,6 +3099,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
-- 
1.7.9.5
