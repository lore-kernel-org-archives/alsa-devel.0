From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Enable docking station for an HP
	machine
Date: Tue, 20 Jan 2015 15:06:21 +0100
Message-ID: <1421762781-25400-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A03942604D0
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 15:06:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tienfu.chen@canonical.com, tiwai@suse.de, alsa-devel@alsa-project.org, 1412800@bugs.launchpad.net
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: TienFu Chen <tienfu.chen@canonical.com>

On this machine we need to inform the driver where the docking
station pins are, because it has not been set up by BIOS.

Tested-by: TienFu Chen <tienfu.chen@canonical.com>
BugLink: https://bugs.launchpad.net/bugs/1412800
Signed-off-by: TienFu Chen <tienfu.chen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1720f8a..0403061 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4417,6 +4417,7 @@ enum {
 	ALC280_FIXUP_HP_GPIO4,
 	ALC286_FIXUP_HP_GPIO_LED,
 	ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY,
+	ALC280_FIXUP_HP_DOCK_PINS,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -4894,6 +4895,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc280_fixup_hp_gpio2_mic_hotkey,
 	},
+	[ALC280_FIXUP_HP_DOCK_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x21011020 }, /* line-out */
+			{ 0x1a, 0x01a1903c }, /* headset mic */
+			{ 0x18, 0x2181103f }, /* line-in */
+			{ },
+		},
+		.chained = true,
+		.chain_id = ALC280_FIXUP_HP_GPIO4
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -4937,6 +4949,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2271, "HP", ALC286_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x2272, "HP", ALC280_FIXUP_HP_DOCK_PINS),
 	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-- 
1.9.1
