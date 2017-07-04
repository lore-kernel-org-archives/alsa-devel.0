From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix unbalance of i915 module
	refcount
Date: Tue,  4 Jul 2017 16:08:12 +0200
Message-ID: <20170704140812.31096-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B66DD266884
 for <alsa-devel@alsa-project.org>; Tue,  4 Jul 2017 16:08:18 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C07A1AAF2
 for <alsa-devel@alsa-project.org>; Tue,  4 Jul 2017 14:08:17 +0000 (UTC)
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

The commit dba9b7b6ca1a ("ALSA: hda - Fix doubly initialization of
i915 component") contained a typo that leads to the unbalance of i915
module reference.  The value to be checked is not chip->driver_type
but chip->driver_caps.

Fixes: dba9b7b6ca1a ("ALSA: hda - Fix doubly initialization of i915 component")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196219
Reported-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 03e34edc8f24..5ae8ddab6412 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1385,7 +1385,7 @@ static int azx_free(struct azx *chip)
 		if (hda->need_i915_power)
 			snd_hdac_display_power(bus, false);
 	}
-	if (chip->driver_type & AZX_DCAPS_I915_COMPONENT)
+	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT)
 		snd_hdac_i915_exit(bus);
 	kfree(hda);
 
-- 
2.13.2
