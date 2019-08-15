From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda - change the pintbl to undef
	tbl for Dell with alc289
Date: Thu, 15 Aug 2019 18:14:15 +0800
Message-ID: <20190815101415.4169-2-hui.wang@canonical.com>
References: <20190815101415.4169-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08895F8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 12:14:36 +0200 (CEST)
In-Reply-To: <20190815101415.4169-1-hui.wang@canonical.com>
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
ones in the pintbl, rather adding a new entry, let us change
the exiting tbl to undef tbl. It will cover all Dell laptops
with alc289 codec and the pins of 0x19 and 0x1b are undef by default.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1439c9a635a..1c76514e32b7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7366,6 +7366,10 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{0x12, 0x90a60130}, \
 	{0x21, 0x03211020}
 
+/* For the tbls which only contain undefined configurations like 0x40000000,
+ * we call them undef tbls, there is a limitation to define the undef tbl:
+ *  - we could define at most 1 undef tbl for the same vendor and same codec
+ */
 static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0221, 0x103c, "HP Workstation", ALC221_FIXUP_HP_HEADSET_MIC,
 		{0x14, 0x01014020},
@@ -7648,9 +7652,8 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x12, 0xb7a60130},
-		{0x14, 0x90170110},
-		{0x21, 0x04211020}),
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
 		ALC290_STANDARD_PINS,
 		{0x15, 0x04211040},
-- 
2.17.1
