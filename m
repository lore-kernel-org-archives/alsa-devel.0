From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - add two new pin tables
Date: Fri,  6 Jun 2014 10:50:24 +0800
Message-ID: <1402023024-15043-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A29E326518B
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 04:52:51 +0200 (CEST)
Received: by mail-pb0-f43.google.com with SMTP id up15so1999186pbc.30
 for <alsa-devel@alsa-project.org>; Thu, 05 Jun 2014 19:52:50 -0700 (PDT)
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

These two new pin tables can fix headset mic problems for several
new Dell machines.

And also delete some machines from old quirk table since the existing
pin talbes already cover them.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 47 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 12fb411..003ba10 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4741,18 +4741,12 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0614, "Dell Inspiron 3135", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0615, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
-	SND_PCI_QUIRK(0x1028, 0x062c, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x064d, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0668, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0669, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0674, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x067e, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x067f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0680, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0684, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
@@ -4977,6 +4971,26 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 #endif
 		.pins = (const struct hda_pintbl[]) {
 			{0x12, 0x90a60160},
+			{0x14, 0x90170120},
+			{0x17, 0x90170140},
+			{0x18, 0x40000000},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x41163b05},
+			{0x1e, 0x411111f0},
+			{0x21, 0x0321102f},
+		},
+		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
+	{
+		.codec = 0x10ec0255,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60160},
 			{0x14, 0x90170130},
 			{0x17, 0x40000000},
 			{0x18, 0x411111f0},
@@ -6014,6 +6028,27 @@ static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
 		.name = "Dell",
 #endif
 		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x99a30140},
+			{0x14, 0x90170110},
+			{0x15, 0x0321101f},
+			{0x16, 0x03011020},
+			{0x18, 0x40000008},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x41000001},
+			{0x1e, 0x411111f0},
+			{0x1f, 0x411111f0},
+		},
+		.value = ALC668_FIXUP_AUTO_MUTE,
+	},
+	{
+		.codec = 0x10ec0668,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
 			{0x12, 0x99a30150},
 			{0x14, 0x90170110},
 			{0x15, 0x0321101f},
-- 
1.8.1.2
