From: jeeja.kp@intel.com
Subject: [PATCH v2 09/11] ASoC: Intel: Skylake: Fix DMA
	position reporting for capture stream
Date: Fri, 24 Mar 2017 23:10:32 +0530
Message-ID: <1490377234-30257-10-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F842674C5
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:51 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Hardik T Shah <hardik.t.shah@intel.com>

As per hardware recommendation, for every capture stream completion
following operations need to be done in order to reflect the actual
data that is received in position buffer.

1. Wait for 20us before reading the DMA position in buffer once the
interrupt is generated for stream completion.
2. Read any of the register to flush the DMA position value. This is
dummy read operation.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ef440d8..1823197 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -21,6 +21,7 @@
 
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <linux/delay.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "skl.h"
@@ -1063,13 +1064,31 @@ static snd_pcm_uframes_t skl_platform_pcm_pointer
 	 * HAD space reflects the actual data that is transferred.
 	 * Use the position buffer for capture, as DPIB write gets
 	 * completed earlier than the actual data written to the DDR.
+	 *
+	 * For capture stream following workaround is required to fix the
+	 * incorrect position reporting.
+	 *
+	 * 1. Wait for 20us before reading the DMA position in buffer once
+	 * the interrupt is generated for stream completion as update happens
+	 * on the HDA frame boundary i.e. 20.833uSec.
+	 * 2. Read DPIB register to flush the DMA position value. This dummy
+	 * read is required to flush DMA position value.
+	 * 3. Read the DMA Position-in-Buffer. This value now will be equal to
+	 * or greater than period boundary.
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		pos = readl(ebus->bus.remap_addr + AZX_REG_VS_SDXDPIB_XBASE +
 				(AZX_REG_VS_SDXDPIB_XINTERVAL *
 				hdac_stream(hstream)->index));
-	else
+	} else {
+		udelay(20);
+		readl(ebus->bus.remap_addr +
+				AZX_REG_VS_SDXDPIB_XBASE +
+				(AZX_REG_VS_SDXDPIB_XINTERVAL *
+				 hdac_stream(hstream)->index));
 		pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
+	}
 
 	if (pos >= hdac_stream(hstream)->bufsize)
 		pos = 0;
-- 
2.5.0
