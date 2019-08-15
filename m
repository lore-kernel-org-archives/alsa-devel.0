From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - change the pintbl to undef tbl for Dell with alc289
Date: Thu, 15 Aug 2019 16:30:01 +0800
Message-ID: <20190815083001.3793-2-hui.wang@canonical.com>
References: <20190815083001.3793-1-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190815083001.3793-1-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We have another Dell laptop which needs the DELL4_MIC_NO_PRESENCE,
and this laptop has different pincfg definitions from existing
ones in the pintbl, rather adding a new entry, let us change
the exiting tbl to undef tbl. It will cover all Dell laptops
with alc289 codec and the pins of 0x19 and 0x1b are undef by default.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1439c9a635a..50b977ea16c2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7648,9 +7648,8 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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
