From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 1/2] ALSA: hda - Turn CX8200 into D3 as well upon reboot
Date: Sat, 28 Jul 2018 03:16:21 +0900
Message-ID: <20180727181621.7188-1-qkrwngud825@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.com, alsa-devel@alsa-project.org
Cc: Park Ju Hyung <qkrwngud825@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

As an equivalent codec with CX20724,
CX8200 is also subject to the reboot bug.

Late 2017 and 2018 LG Gram and some HP Spectre laptops are known victims
to this issue, causing extremely loud noises upon reboot.

Now that we know that this bug is subject to multiple codecs,
fix the comment as well.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_conexant.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f641c20095f7..909a880f5e01 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -211,6 +211,7 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 	struct conexant_spec *spec = codec->spec;
 
 	switch (codec->core.vendor_id) {
+	case 0x14f12008: /* CX8200 */
 	case 0x14f150f2: /* CX20722 */
 	case 0x14f150f4: /* CX20724 */
 		break;
@@ -218,7 +219,7 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 		return;
 	}
 
-	/* Turn the CX20722 codec into D3 to avoid spurious noises
+	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
 
-- 
2.18.0
