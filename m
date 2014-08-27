From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Set up initial pins for Acer
	Aspire V5
Date: Wed, 27 Aug 2014 08:23:38 +0200
Message-ID: <1409120618-28485-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5749D2652E8
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 08:23:43 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3E742AD07
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 06:23:43 +0000 (UTC)
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

Acer Aspire V5 doesn't set up the pins correctly at the cold boot
while the pins are corrected after the warm reboot.  This patch gives
the proper pin configs statically in the driver as a workaround.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=81561
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d71270a3f73f..d446ac3137b3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4408,6 +4408,7 @@ enum {
 	ALC292_FIXUP_TPT440_DOCK,
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
+	ALC282_FIXUP_ASPIRE_V5_PINS,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -4855,6 +4856,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained_before = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC282_FIXUP_ASPIRE_V5_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x12, 0x90a60130 },
+			{ 0x14, 0x90170110 },
+			{ 0x17, 0x40000008 },
+			{ 0x18, 0x411111f0 },
+			{ 0x19, 0x411111f0 },
+			{ 0x1a, 0x411111f0 },
+			{ 0x1b, 0x411111f0 },
+			{ 0x1d, 0x40f89b2d },
+			{ 0x1e, 0x411111f0 },
+			{ 0x21, 0x0321101f },
+			{ },
+		},
+	},
 
 };
 
@@ -4866,6 +4883,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0740, "Acer AO725", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK(0x1025, 0x0742, "Acer AO756", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
+	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05be, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-- 
2.1.0
