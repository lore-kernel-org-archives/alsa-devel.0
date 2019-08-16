From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v3 2/2] ALSA: hda - Define a
	fallback_pin_fixup_tbl for alc269 family
Date: Fri, 16 Aug 2019 14:27:40 +0800
Message-ID: <20190816062740.5059-2-hui.wang@canonical.com>
References: <20190816062740.5059-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03FDBF803F4
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 08:28:05 +0200 (CEST)
In-Reply-To: <20190816062740.5059-1-hui.wang@canonical.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

We have another Dell laptop which needs the DELL4_MIC_NO_PRESENCE,
and this laptop has different pincfg definitions from existing
ones in the pintbl, rather adding a new entry, let us define
a tbl in the fallback_pin_fixup_tbl and this tbl will match
all dell machines with alc289 codec and the pins of 0x19 and 0x1b
are undef by default.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2fa03fb6bd9e..e62672877597 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7648,10 +7648,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x12, 0xb7a60130},
-		{0x14, 0x90170110},
-		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
 		ALC290_STANDARD_PINS,
 		{0x15, 0x04211040},
@@ -7761,6 +7757,19 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	{}
 };
 
+/* This is the fallback pin_fixup_tbl for alc269 family, to make the tbl match
+ * more machines, don't need to match all valid pins, just need to match
+ * all the pins defined in the tbl. Just because of this reason, it is possible
+ * that a single machine matches multiple tbls, so there is one limitation:
+ *   at most one tbl is allowed to define for the same vendor and same codec
+ */
+static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
+	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
+	{}
+};
+
 static void alc269_fill_coef(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -7951,6 +7960,7 @@ static int patch_alc269(struct hda_codec *codec)
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
 	snd_hda_pick_pin_fixup(codec, alc269_pin_fixup_tbl, alc269_fixups, true);
+	snd_hda_pick_pin_fixup(codec, alc269_fallback_pin_fixup_tbl, alc269_fixups, false);
 	snd_hda_pick_fixup(codec, NULL,	alc269_fixup_vendor_tbl,
 			   alc269_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
-- 
2.17.1
