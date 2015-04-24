From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/21] ALSA: hda - Reenable tracepoints for
	controller
Date: Fri, 24 Apr 2015 14:38:46 +0200
Message-ID: <1429879133-32293-15-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 819F52605EE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C3A5DAD85
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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

After correcting the fields to point the right members, tracepoints
can be reenabled again for the legacy controller code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c  | 6 ++++++
 sound/pci/hda/hda_intel_trace.h | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 8f12ad9a4df5..0e43f79e1d9b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -31,6 +31,9 @@
 #include <sound/initval.h>
 #include "hda_controller.h"
 
+#define CREATE_TRACE_POINTS
+#include "hda_intel_trace.h"
+
 /* DSP lock helpers */
 #define dsp_lock(dev)		snd_hdac_dsp_lock(azx_stream(dev))
 #define dsp_unlock(dev)		snd_hdac_dsp_unlock(azx_stream(dev))
@@ -229,6 +232,8 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	int sync_reg;
 
 	azx_dev = get_azx_dev(substream);
+	trace_azx_pcm_trigger(chip, azx_dev, cmd);
+
 	hstr = azx_stream(azx_dev);
 	if (chip->driver_caps & AZX_DCAPS_OLD_SSYNC)
 		sync_reg = AZX_REG_OLD_SSYNC;
@@ -330,6 +335,7 @@ unsigned int azx_get_position(struct azx *chip,
 		substream->runtime->delay = delay;
 	}
 
+	trace_azx_get_position(chip, azx_dev, pos, delay);
 	return pos;
 }
 EXPORT_SYMBOL_GPL(azx_get_position);
diff --git a/sound/pci/hda/hda_intel_trace.h b/sound/pci/hda/hda_intel_trace.h
index 7b5e4c2cf9d5..ae004737d0fd 100644
--- a/sound/pci/hda/hda_intel_trace.h
+++ b/sound/pci/hda/hda_intel_trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(azx_pcm_trigger,
 
 	TP_fast_assign(
 		__entry->card = (chip)->card->number;
-		__entry->idx = (dev)->index;
+		__entry->idx = (dev)->core.index;
 		__entry->cmd = cmd;
 	),
 
@@ -46,7 +46,7 @@ TRACE_EVENT(azx_get_position,
 
 	TP_fast_assign(
 		__entry->card = (chip)->card->number;
-		__entry->idx = (dev)->index;
+		__entry->idx = (dev)->core.index;
 		__entry->pos = pos;
 		__entry->delay = delay;
 	),
-- 
2.3.5
