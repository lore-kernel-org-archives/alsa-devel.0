From: Martin Kepplinger <martink@posteo.de>
Subject: [BUG]3.14-rc2 [PATCH] Revert "ALSA: hda/realtek - Avoid invalid COEFs for ALC271X"
Date: Wed, 12 Feb 2014 17:09:23 +0100
Message-ID: <1392221363-5447-1-git-send-email-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, david.henningsson@canonical.com, hui.wang@canonical.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: alsa-devel@alsa-project.org

This reverts commit d3c56568f43807135f2c2a09582a69f809f0d8b7.

The reverted commit breaks audio through headphone line out on
the Acer TravelMate B113 (Type1Sku0) Notebook, my main work
machine. I don't know much about it but this fixes my problem.
Bisected and tested.

Tested-by: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 sound/pci/hda/patch_realtek.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d9693ca..0f5af34 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4434,9 +4434,6 @@ static void alc269_fill_coef(struct hda_codec *codec)
 
 	if (spec->codec_variant != ALC269_TYPE_ALC269VB)
 		return;
-	/* ALC271X doesn't seem to support these COEFs (bko#52181) */
-	if (!strcmp(codec->chip_name, "ALC271X"))
-		return;
 
 	if ((alc_get_coef0(codec) & 0x00ff) < 0x015) {
 		alc_write_coef_idx(codec, 0xf, 0x960b);
-- 
1.7.10.4
