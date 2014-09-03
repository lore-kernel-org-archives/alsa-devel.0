From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 5/8] ALSA: hda/realtek - move HP_MUTE_LED_MIC1
	quirk for alc282
Date: Wed,  3 Sep 2014 11:31:08 +0800
Message-ID: <1409715071-12262-6-git-send-email-hui.wang@canonical.com>
References: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 316342655DC
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:31:56 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id r10so9967687pdi.22
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:31:55 -0700 (PDT)
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
 sound/pci/hda/patch_realtek.c | 79 ++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b1eca70..22ca89b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4845,19 +4845,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
 	/* ALC282 */
-	SND_PCI_QUIRK(0x103c, 0x21f8, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x220d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x220e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x220f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2211, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2212, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2213, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2214, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2234, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2235, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
@@ -4873,30 +4863,16 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x224b, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x224c, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x224d, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2266, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2267, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2268, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2269, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x226c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x226d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x226f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x227a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x227b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22a0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22c0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22c1, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22c2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22cd, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22ce, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22d0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22da, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22db, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
@@ -5181,6 +5157,61 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1d, 0x40f41905},
 		{0x1e, 0x411111f0},
 		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x17, 0x40020008},
+		{0x18, 0x411111f0},
+		{0x19, 0x03a11020},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40e00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x03211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x03a11030},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40e00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x03a11030},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40f00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x04a11020},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40f00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x0421101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x03a11030},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40f00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0283, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
-- 
1.9.1
