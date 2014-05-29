From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - move some alc269 family
	machines to hda_pin_quirk table
Date: Thu, 29 May 2014 15:59:18 +0800
Message-ID: <1401350359-5045-2-git-send-email-hui.wang@canonical.com>
References: <1401350359-5045-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 580A92607C8
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 09:59:33 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id ma3so12692080pbc.9
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 00:59:32 -0700 (PDT)
In-Reply-To: <1401350359-5045-1-git-send-email-hui.wang@canonical.com>
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

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 196 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 171 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 08bb069..d82884b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4739,31 +4739,16 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0606, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0608, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0609, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x060f, "Dell", ALC269_FIXUP_DELL3_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0610, "Dell", ALC269_FIXUP_DELL3_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0613, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0614, "Dell Inspiron 3135", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0615, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
-	SND_PCI_QUIRK(0x1028, 0x061f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0629, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x062c, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS_HSJACK),
-	SND_PCI_QUIRK(0x1028, 0x063e, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0640, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064d, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0651, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0652, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0653, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0657, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0658, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x065c, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x065f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0662, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0667, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0668, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0669, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0674, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -4947,25 +4932,24 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 
 static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	{
-		.codec = 0x10ec0293,
+		.codec = 0x10ec0255,
 		.subvendor = 0x1028,
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 		.name = "Dell",
 #endif
 		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x40000000},
-			{0x13, 0x90a60140},
+			{0x12, 0x90a60140},
 			{0x14, 0x90170110},
-			{0x15, 0x0221401f},
-			{0x16, 0x21014020},
+			{0x17, 0x40000000},
 			{0x18, 0x411111f0},
-			{0x19, 0x21a19030},
+			{0x19, 0x411111f0},
 			{0x1a, 0x411111f0},
 			{0x1b, 0x411111f0},
 			{0x1d, 0x40700001},
 			{0x1e, 0x411111f0},
+			{0x21, 0x02211020},
 		},
-		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
 	{
 		.codec = 0x10ec0255,
@@ -4974,8 +4958,8 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		.name = "Dell",
 #endif
 		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60140},
-			{0x14, 0x90170110},
+			{0x12, 0x90a60160},
+			{0x14, 0x90170120},
 			{0x17, 0x40000000},
 			{0x18, 0x411111f0},
 			{0x19, 0x411111f0},
@@ -4983,10 +4967,172 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 			{0x1b, 0x411111f0},
 			{0x1d, 0x40700001},
 			{0x1e, 0x411111f0},
-			{0x21, 0x02211020},
+			{0x21, 0x02211030},
 		},
 		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
+	{
+		.codec = 0x10ec0255,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60160},
+			{0x14, 0x90170130},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211040},
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
+			{0x14, 0x90170140},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211050},
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
+			{0x12, 0x90a60170},
+			{0x14, 0x90170120},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211030},
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
+			{0x12, 0x90a60170},
+			{0x14, 0x90170130},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211040},
+		},
+		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
+	{
+		.codec = 0x10ec0283,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60130},
+			{0x14, 0x90170110},
+			{0x17, 0x40020008},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40e00001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x0321101f},
+		},
+		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
+	{
+		.codec = 0x10ec0283,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60160},
+			{0x14, 0x90170120},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211030},
+		},
+		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
+	{
+		.codec = 0x10ec0292,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60140},
+			{0x13, 0x411111f0},
+			{0x14, 0x90170110},
+			{0x15, 0x0221401f},
+			{0x16, 0x411111f0},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+		},
+		.value = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
+	},
+	{
+		.codec = 0x10ec0293,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x40000000},
+			{0x13, 0x90a60140},
+			{0x14, 0x90170110},
+			{0x15, 0x0221401f},
+			{0x16, 0x21014020},
+			{0x18, 0x411111f0},
+			{0x19, 0x21a19030},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+		},
+		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
 	{}
 };
 
-- 
1.8.1.2
