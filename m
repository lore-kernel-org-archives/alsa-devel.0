From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Provide missing pin configs for
	VAIO with ALC260
Date: Fri, 22 Nov 2013 08:10:40 +0100
Message-ID: <1385104240-8443-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9255C261680
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 08:10:41 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 12B1FA7B64
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 08:10:40 +0100 (CET)
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

Some models (or maybe depending on BIOS version) of Sony VAIO with
ALC260 give no proper pin configurations as default, resulting in the
non-working speaker, etc.  Just provide the whole pin configurations
via a fixup.

Reported-by: Matthew Markus <mmarkus@hearit.co>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb653dd0f813..6d8d9b3520d0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1512,6 +1512,7 @@ enum {
 	ALC260_FIXUP_KN1,
 	ALC260_FIXUP_FSC_S7020,
 	ALC260_FIXUP_FSC_S7020_JWSE,
+	ALC260_FIXUP_VAIO_PINS,
 };
 
 static void alc260_gpio1_automute(struct hda_codec *codec)
@@ -1652,6 +1653,24 @@ static const struct hda_fixup alc260_fixups[] = {
 		.chained = true,
 		.chain_id = ALC260_FIXUP_FSC_S7020,
 	},
+	[ALC260_FIXUP_VAIO_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* Pin configs are missing completely on some VAIOs */
+			{ 0x0f, 0x01211020 },
+			{ 0x10, 0x0001003f },
+			{ 0x11, 0x411111f0 },
+			{ 0x12, 0x01a15930 },
+			{ 0x13, 0x411111f0 },
+			{ 0x14, 0x411111f0 },
+			{ 0x15, 0x411111f0 },
+			{ 0x16, 0x411111f0 },
+			{ 0x17, 0x411111f0 },
+			{ 0x18, 0x411111f0 },
+			{ 0x19, 0x411111f0 },
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
@@ -1660,6 +1679,7 @@ static const struct snd_pci_quirk alc260_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
 	SND_PCI_QUIRK(0x103c, 0x30ba, "HP Presario B1900", ALC260_FIXUP_HP_B1900),
+	SND_PCI_QUIRK(0x104d, 0x81bb, "Sony VAIO", ALC260_FIXUP_VAIO_PINS),
 	SND_PCI_QUIRK(0x104d, 0x81e2, "Sony VAIO TX", ALC260_FIXUP_HP_PIN_0F),
 	SND_PCI_QUIRK(0x10cf, 0x1326, "FSC LifeBook S7020", ALC260_FIXUP_FSC_S7020),
 	SND_PCI_QUIRK(0x1509, 0x4540, "Favorit 100XS", ALC260_FIXUP_GPIO1),
-- 
1.8.4.3
