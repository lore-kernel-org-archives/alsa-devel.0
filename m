From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 5/5] ALSA: hda - add an instance to use
	snd_hda_pick_pin_fixup
Date: Mon, 26 May 2014 16:22:44 +0800
Message-ID: <1401092564-14293-5-git-send-email-hui.wang@canonical.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1065E264FDF
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 10:23:26 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id ey11so7273251pad.4
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 01:23:26 -0700 (PDT)
In-Reply-To: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
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

Just two members in the alc269_pin_fixup_tbl[] can cover more than
10 Dell laptop models.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 47 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c0b16de..992949c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4725,8 +4725,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x061f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0629, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x062c, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x062e, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0632, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x063e, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -4924,6 +4922,50 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{}
 };
 
+static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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
+	{
+		.codec = 0x10ec0255,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60140},
+			{0x14, 0x90170110},
+			{0x17, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40700001},
+			{0x1e, 0x411111f0},
+			{0x21, 0x02211020},
+		},
+		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	},
+	{}
+};
 
 static void alc269_fill_coef(struct hda_codec *codec)
 {
@@ -4985,6 +5027,7 @@ static int patch_alc269(struct hda_codec *codec)
 
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
+	snd_hda_pick_pin_fixup(codec, alc269_pin_fixup_tbl, alc269_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
-- 
1.8.1.2
