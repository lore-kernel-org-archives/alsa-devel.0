From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Set TLV_DB_SCALE_MUTE bit for
	cx5051 vmaster
Date: Thu, 14 Aug 2014 11:45:43 +0200
Message-ID: <1408009543-4789-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F6F26537B
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 11:45:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 18B99AAF3
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 09:45:43 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Conexnat HD-audio driver has a workaround for cx5051 (aka CX20561)
chip to add fake mute controls to each amp (commit 3868137e).  This
implies the minimum-as-mute TLV bit in TLV for each corresponding
control.  Meanwhile we build the virtual master from these, but the
TLV bit is missing, even though the slaves have it.

This patch simply adds the missing TLV_DB_SCALE_MUTE bit for vmaster,
as already done in patch_sigmatel.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7627a69ca6d7..6f2fa838b635 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
+#include <sound/tlv.h>
 
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -859,6 +860,11 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
+	if (codec->vendor_id == 0x14f15051) {
+		/* minimum value is actually mute */
+		spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
+	}
+
 	codec->patch_ops = cx_auto_patch_ops;
 
 	/* Some laptops with Conexant chips show stalls in S3 resume,
-- 
2.0.4
