From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 8/8] ALSA: hda/realtek - move HP_GPIO_MIC1_LED
	quirk for alc280
Date: Wed,  3 Sep 2014 11:31:11 +0800
Message-ID: <1409715071-12262-9-git-send-email-hui.wang@canonical.com>
References: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EDD62655F9
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:32:05 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id ft15so10008321pdb.20
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:32:04 -0700 (PDT)
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
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b41dd3..1328a04 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4863,20 +4863,12 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x22da, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x22db, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22fb, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x8004, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	/* ALC290 */
 	SND_PCI_QUIRK(0x103c, 0x221b, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x221c, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x221d, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2220, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2221, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2222, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2223, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2224, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2225, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2246, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2247, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
@@ -5124,6 +5116,19 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1d, 0x40700001},
 		{0x1e, 0x411111f0},
 		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED,
+		{0x12, 0x90a60140},
+		{0x13, 0x40000000},
+		{0x14, 0x90170110},
+		{0x15, 0x0421101f},
+		{0x16, 0x411111f0},
+		{0x17, 0x411111f0},
+		{0x18, 0x02811030},
+		{0x19, 0x411111f0},
+		{0x1a, 0x04a1103f},
+		{0x1b, 0x02011020},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP 15 Touchsmart", ALC269_FIXUP_HP_MUTE_LED_MIC1,
 		{0x12, 0x99a30130},
 		{0x14, 0x90170110},
-- 
1.9.1
