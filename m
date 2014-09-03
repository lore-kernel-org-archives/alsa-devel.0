From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/8] ALSA: hda/realtek - move
	DELL2_MIC_NO_PRESENCE quirk for alc292
Date: Wed,  3 Sep 2014 11:31:04 +0800
Message-ID: <1409715071-12262-2-git-send-email-hui.wang@canonical.com>
References: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 29F3F26558A
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:31:43 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id z10so10185647pdj.3
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:31:42 -0700 (PDT)
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
 sound/pci/hda/patch_realtek.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48d6d10..0586550 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4830,21 +4830,13 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
-	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05be, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c7, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c8, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05c9, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05ca, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05cb, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05da, "Dell Vostro 5460", ALC290_FIXUP_SUBWOOFER),
-	SND_PCI_QUIRK(0x1028, 0x05de, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x05e0, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05e9, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05ea, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05eb, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -4873,9 +4865,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0668, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0669, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0684, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
@@ -5227,6 +5216,30 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1d, 0x40700001},
 		{0x1e, 0x411111f0},
 		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
+		{0x12, 0x90a60140},
+		{0x13, 0x411111f0},
+		{0x14, 0x90170110},
+		{0x15, 0x0221401f},
+		{0x16, 0x01014020},
+		{0x18, 0x411111f0},
+		{0x19, 0x01a19030},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
+		{0x12, 0x90a60140},
+		{0x13, 0x411111f0},
+		{0x14, 0x90170110},
+		{0x15, 0x0221401f},
+		{0x16, 0x01014020},
+		{0x18, 0x02a19031},
+		{0x19, 0x01a1903e},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 		{0x12, 0x90a60140},
 		{0x13, 0x411111f0},
-- 
1.9.1
