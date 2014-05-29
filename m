From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - move some alc662 family
	machines to hda_pin_quirk table
Date: Thu, 29 May 2014 15:59:19 +0800
Message-ID: <1401350359-5045-3-git-send-email-hui.wang@canonical.com>
References: <1401350359-5045-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C1FC6260786
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 09:59:36 +0200 (CEST)
Received: by mail-pb0-f53.google.com with SMTP id md12so12592635pbc.40
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 00:59:35 -0700 (PDT)
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
 sound/pci/hda/patch_realtek.c | 72 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d82884b..a00cd69 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5894,12 +5894,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x060a, "Dell XPS 13", ALC668_FIXUP_DELL_XPS13),
-	SND_PCI_QUIRK(0x1028, 0x0623, "Dell", ALC668_FIXUP_AUTO_MUTE),
-	SND_PCI_QUIRK(0x1028, 0x0624, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0625, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0626, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0628, "Dell", ALC668_FIXUP_AUTO_MUTE),
-	SND_PCI_QUIRK(0x1028, 0x064e, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0696, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
@@ -5991,6 +5987,73 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{}
 };
 
+static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
+	{
+		.codec = 0x10ec0668,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x99a30130},
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
+			{0x12, 0x99a30150},
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
+			{0x12, 0x411111f0},
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
+	{}
+};
+
 static void alc662_fill_coef(struct hda_codec *codec)
 {
 	int val, coef;
@@ -6040,6 +6103,7 @@ static int patch_alc662(struct hda_codec *codec)
 
 	snd_hda_pick_fixup(codec, alc662_fixup_models,
 		       alc662_fixup_tbl, alc662_fixups);
+	snd_hda_pick_pin_fixup(codec, alc662_pin_fixup_tbl, alc662_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
-- 
1.8.1.2
