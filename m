From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 1/2] ALSA: hda - Apply ALC269_FIXUP_NO_SHUTUP on HDA_FIXUP_ACT_PROBE
Date: Sat, 24 Dec 2016 19:50:00 +0100
Message-ID: <20161224185001.26824-1-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: alsa-devel@alsa-project.org

Setting shutup when the action is HDA_FIXUP_ACT_PRE_PROBE might
not have the desired effect since it could be overridden by
another more generic shutup function. Prevent this by setting
the more specific shutup function on HDA_FIXUP_ACT_PROBE.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ea81c08ddc7a..d30cc49512e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4400,7 +4400,7 @@ static void alc_no_shutup(struct hda_codec *codec)
 static void alc_fixup_no_shutup(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+	if (action == HDA_FIXUP_ACT_PROBE) {
 		struct alc_spec *spec = codec->spec;
 		spec->shutup = alc_no_shutup;
 	}
-- 
2.11.0
