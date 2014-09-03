From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 7/8] ALSA: hda/realtek - move HP_LINE1_MIC1_LED
	quirk for alc282
Date: Wed,  3 Sep 2014 11:31:10 +0800
Message-ID: <1409715071-12262-8-git-send-email-hui.wang@canonical.com>
References: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B67F02655AB
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:32:02 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id bj1so16223969pad.32
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:32:01 -0700 (PDT)
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
 sound/pci/hda/patch_realtek.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 06d6f0d..7b41dd3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4849,20 +4849,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	/* ALC282 */
 	SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2214, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-	SND_PCI_QUIRK(0x103c, 0x2234, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2235, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2236, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2237, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2238, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2239, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2246, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2247, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2248, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2249, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x224a, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x224b, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x224c, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x224d, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2268, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -5199,6 +5190,17 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1d, 0x40f00001},
 		{0x1e, 0x411111f0},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0282, 0x103c, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED,
+		{0x12, 0x90a60140},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x04a11030},
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
