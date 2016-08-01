From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Can't adjust speaker's volume on a Dell AIO
Date: Mon,  1 Aug 2016 10:20:32 +0800
Message-ID: <1470018032-30084-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have a Dell AIO on which we can't adjust its speaker's volume.
The problem is it is connected to a Audio Output node without Amp-out
capability. To fix it, we change it to be connnected to a node with
Amp-out capability.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ddd29b9..7355054 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4689,6 +4689,22 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 	}
 }
 
+static void alc298_fixup_speaker_volume(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		/* The speaker is routed to the Node 0x06 by a mistake, as a result
+		   we can't adjust the speaker's volume since this node does not has
+		   Amp-out capability. we change the speaker's route to:
+		   Node 0x02 (Audio Output) -> Node 0x0c (Audio Mixer) -> Node 0x17 (
+		   Pin Complex), since Node 0x02 has Amp-out caps, we can adjust
+		   speaker's volume now. */
+
+		hda_nid_t conn1[1] = { 0x0c };
+		snd_hda_override_conn_list(codec, 0x17, 1, conn1);
+	}
+}
+
 /* Hook to update amp GPIO4 for automute */
 static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
 					  struct hda_jack_callback *jack)
@@ -4838,6 +4854,7 @@ enum {
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
+	ALC298_FIXUP_SPK_VOLUME,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5493,6 +5510,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC293_FIXUP_LENOVO_SPK_NOISE,
 	},
+	[ALC298_FIXUP_SPK_VOLUME] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc298_fixup_speaker_volume,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5539,6 +5560,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
1.9.1
