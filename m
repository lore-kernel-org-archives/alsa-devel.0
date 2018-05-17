From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: sdma-pcm: Correction for the
	include files" to the asoc tree
Date: Thu, 17 May 2018 17:40:40 +0100 (BST)
Message-ID: <20180517164040.E644D44007E@finisterre.ee.mobilebroadband>
References: <20180511122055.14206-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F4282676AB
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:40:44 +0200 (CEST)
In-Reply-To: <20180511122055.14206-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap: sdma-pcm: Correction for the include files

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1cc0fe247958e5ae359e42e4d3cae1cf4f3c8136 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 15 May 2018 09:43:35 +0300
Subject: [PATCH] ASoC: omap: sdma-pcm: Correction for the include files

The sdma-pcm does not need any information from omap-dma.h, it only needs
to include the omap-dmaengine.h - for the omap_dma_filter_fn, but that
might not be needed at all as OMAP1 was converted to dma_slave_map, but
I can not test OMAP1.

Add the linux/device.h include as well for devm_kzalloc()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/sdma-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index 3e52ccb2ae26..21a9c2499d48 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,13 +4,14 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/omap-dma.h>
+#include <linux/omap-dmaengine.h>
 
 #include "sdma-pcm.h"
 
-- 
2.17.0
