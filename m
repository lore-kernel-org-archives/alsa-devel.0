From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - add quirks for mute LED on two HP
	machines
Date: Mon, 18 Feb 2013 11:41:55 +0100
Message-ID: <1361184115-6388-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EFE7E264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 11:41:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, 1128934@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

These two machines have no mute LED string in BIOS.

BugLink: https://bugs.launchpad.net/bugs/1128934
Tested-by: Tammy Yang <tammy.yang@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Should be sent to stable too, but I guess the patch have to be
rewritten to fit.

 sound/pci/hda/patch_realtek.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48c9d10..e575685 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2726,6 +2726,18 @@ static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void alc269_fixup_hp_mute_led_mic1(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_nid = 0x18;
+		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
+		spec->gen.vmaster_mute_enum = 1;
+	}
+}
+
 static void alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -2771,6 +2783,7 @@ enum {
 	ALC269VB_FIXUP_AMIC,
 	ALC269VB_FIXUP_DMIC,
 	ALC269_FIXUP_HP_MUTE_LED,
+	ALC269_FIXUP_HP_MUTE_LED_MIC1,
 	ALC269_FIXUP_HP_MUTE_LED_MIC2,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
@@ -2903,6 +2916,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led,
 	},
+	[ALC269_FIXUP_HP_MUTE_LED_MIC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_hp_mute_led_mic1,
+	},
 	[ALC269_FIXUP_HP_MUTE_LED_MIC2] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led_mic2,
@@ -2947,6 +2964,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_DMIC),
-- 
1.7.9.5
