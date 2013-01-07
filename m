From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - add mute LED for HP Pavilion 17 (Realtek codec)
Date: Mon,  7 Jan 2013 10:51:29 +0100
Message-ID: <1357552289-3232-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, 1096789@bugs.launchpad.net
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The mute LED is in this case connected to the Mic1 VREF.

The machine also exposes the following string in BIOS:
"HP_Mute_LED_0_A", so if more machines are coming, it probably
makes sense to try to do something more generic, like for the
IDT codec.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1096789
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

I know this is a copy-paste, but I didn't really find a better and more
condensed way to do it. Perhaps if we get a third variation it would make
sense to write a more generic version.

Also, Alsa-info is available at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1096789/+attachment/3476010/+files/alsa-info.txt

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6ee3459..2e6803e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5992,7 +5992,30 @@ static void alc269_fixup_quanta_mute(struct hda_codec *codec,
 	spec->automute_hook = alc269_quanta_automute;
 }
 
-/* update mute-LED according to the speaker mute state via mic2 VREF pin */
+/* update mute-LED according to the speaker mute state via mic VREF pin */
+static void alc269_fixup_mic1_mute_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	unsigned int pinval = AC_PINCTL_IN_EN + (enabled ?
+			      AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80);
+	snd_hda_set_pin_ctl_cache(codec, 0x18, pinval);
+}
+
+static void alc269_fixup_mic1_mute(struct hda_codec *codec,
+				   const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	switch (action) {
+	case ALC_FIXUP_ACT_BUILD:
+		spec->vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
+		snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
+		/* fallthru */
+	case ALC_FIXUP_ACT_INIT:
+		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
+		break;
+	}
+}
+
 static void alc269_fixup_mic2_mute_hook(void *private_data, int enabled)
 {
 	struct hda_codec *codec = private_data;
@@ -6043,6 +6066,7 @@ enum {
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
 	ALC269VB_FIXUP_DMIC,
+	ALC269_FIXUP_MIC1_MUTE_LED,
 	ALC269_FIXUP_MIC2_MUTE_LED,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
@@ -6171,6 +6195,10 @@ static const struct alc_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC269_FIXUP_MIC1_MUTE_LED] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc269_fixup_mic1_mute,
+	},
 	[ALC269_FIXUP_MIC2_MUTE_LED] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc269_fixup_mic2_mute,
@@ -6215,6 +6243,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x1972, "HP Pavilion 17", ALC269_FIXUP_MIC1_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
1.7.9.5
