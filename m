From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2] ALSA: hda - Fixing speaker noise on the two latest thinkpad models
Date: Tue,  8 Dec 2015 12:27:18 +0800
Message-ID: <1449548838-5002-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have two latest thinkpad laptop models which are all based on the
Intel skylake platforms, and all of them have the codec alc293 on
them. When the machines boot to the desktop, an greeting dialogue
shows up with the notification sound. But on these two models, there
is noise with the notification sound. We have 3 SKUs for each of
the models, all of them have this problem.

So far, this problem is only specific to these two thinkpad models,
we did not find this problem on the old thinkpad models with the
codec alc293 or alc292.

A workaround for this problem is disabling the aamix.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1523517
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ebc5362..49b1d36 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4596,6 +4596,7 @@ enum {
 	ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC275_FIXUP_DELL_XPS,
 	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
+	ALC293_FIXUP_LENOVO_SPK_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5187,6 +5188,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC293_FIXUP_LENOVO_SPK_NOISE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_aamix,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5334,6 +5341,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
@@ -5343,6 +5351,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x5034, "Thinkpad T450", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x503c, "Thinkpad L450", ALC292_FIXUP_TPT440_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x504b, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-- 
1.9.1
