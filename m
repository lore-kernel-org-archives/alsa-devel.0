From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Add a de-pop quirk for some HP machines
Date: Fri, 29 Aug 2014 15:47:05 +0800
Message-ID: <1409298425-9697-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On some HP machines, there will be pop noise when the machine is
shutting down, rebooting or booting up from poweroff state.

Set EAPD enable only when stream starts can help to fix this
problem.

[The patch was originally written by Kailang, we tested it and
rebased it on latest kernel.]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 55 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48d6d10..51811a6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4282,6 +4282,47 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 	}
 }
 
+/*
+ * ALC290 PCM hooks
+ */
+static void alc290_playback_pcm_hook(struct hda_pcm_stream *hinfo,
+				     struct hda_codec *codec,
+				     struct snd_pcm_substream *substream,
+				     int action)
+{
+	int val;
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		val = alc_read_coef_idx(codec, 0x4); /* EAPD manual high */
+		if ((val & 0xc000) != 0xc000)
+			alc_write_coef_idx(codec, 0x4, val | (1<<14));
+		break;
+	}
+}
+
+static void alc290_fixup_pop_noise(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	int val;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_codec_write(codec, 0x17, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		val = alc_read_coef_idx(codec, 0x4);
+		if ((val & 0xc000) != 0xc000)
+			alc_write_coef_idx(codec, 0x4, val | (3<<14)); /* EAPD low */
+		spec->gen.pcm_playback_hook = alc290_playback_pcm_hook;
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		snd_hda_codec_write(codec, 0x17, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -4354,6 +4395,7 @@ enum {
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
+	ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -4817,7 +4859,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ },
 		},
 	},
-
+	[ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc290_fixup_pop_noise,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HP_MUTE_LED_MIC1,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -4975,12 +5022,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2280, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2281, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x228d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x228f, "HP", ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x22a8, "HP", ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-- 
1.9.1
