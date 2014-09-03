From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 6/8] ALSA: hda/realtek - move HP_MUTE_LED_MIC1
	quirk for alc290
Date: Wed,  3 Sep 2014 11:31:09 +0800
Message-ID: <1409715071-12262-7-git-send-email-hui.wang@canonical.com>
References: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AAED2655A5
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:31:59 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id r10so9967761pdi.22
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:31:58 -0700 (PDT)
In-Reply-To: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
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
Cc: hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Cc: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 104 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 22ca89b..06d6f0d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4868,7 +4868,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22a0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -4901,8 +4900,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2259, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x225a, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2260, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2261, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2262, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2263, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2264, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2265, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -4910,23 +4907,13 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2273, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2277, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2278, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x227d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x227e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x227f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2280, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2281, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x228d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c8, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22c3, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22c4, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2334, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2335, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -5245,6 +5232,97 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1d, 0x40e00001},
 		{0x1e, 0x411111f0},
 		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x15, 0x04211040},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x90170112},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11020},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4075812d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x15, 0x04211040},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x90170110},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11020},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4075812d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x15, 0x0421101f},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11020},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4075812d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x411111f0},
+		{0x15, 0x04211020},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11040},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4076a12d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x90170110},
+		{0x15, 0x04211020},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11040},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4076a12d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x90170110},
+		{0x15, 0x04211020},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11020},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4076a12d},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x13, 0x40000000},
+		{0x14, 0x90170110},
+		{0x15, 0x0421101f},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a11020},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x4075812d},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x12, 0x90a60140},
 		{0x13, 0x411111f0},
-- 
1.9.1
