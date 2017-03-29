From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix DMA position
	reporting for capture stream" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:09 +0100
Message-ID: <E1ctCAz-0001UJ-GF@debutante>
References: <1490377234-30257-10-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C6C266F51
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:18 +0200 (CEST)
In-Reply-To: <1490377234-30257-10-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hardik T Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix DMA position reporting for capture stream

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fdd85a054b850db43c6abe39c1da28b581be5e93 Mon Sep 17 00:00:00 2001
From: Hardik T Shah <hardik.t.shah@intel.com>
Date: Fri, 24 Mar 2017 23:10:32 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix DMA position reporting for capture
 stream

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
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ef440d8629e8..1823197c15c8 100644
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
2.11.0
