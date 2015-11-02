From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix lost 4k BDL boundary workaround
Date: Mon,  2 Nov 2015 17:41:15 +0100
Message-ID: <1446482475-22821-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B21B6261703
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 17:41:16 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8D55CAAD0
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 16:41:06 +0000 (UTC)
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

During the migration to HDA core code, we lost the workaround for 4k
BDL boundary.  The flag exists in the new hdac_bus, but it's never
set.  This resulted in the sudden sound stall on some controllers that
require this workaround like Creative Recon3D.

This patch fixes the issue by setting the flag for such controllers
properly.

Fixes: ccc98865aa44 ('ALSA: hda - Migrate more hdac_stream codes')
Cc: <stable@vger.kernel.org> # v4.2+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index d6b93a20361b..22dbfa563919 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1060,6 +1060,9 @@ int azx_bus_init(struct azx *chip, const char *model,
 		bus->needs_damn_long_delay = 1;
 	}
 
+	if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY)
+		bus->core.align_bdle_4k = true;
+
 	/* AMD chipsets often cause the communication stalls upon certain
 	 * sequence like the pin-detection.  It seems that forcing the synced
 	 * access works around the stall.  Grrr...
-- 
2.6.2
