From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: sdma-pcm: Fix modpost warning" to
	the asoc tree
Date: Thu, 17 May 2018 17:40:55 +0100 (BST)
Message-ID: <20180517164055.4415644007E@finisterre.ee.mobilebroadband>
References: <20180515064335.20565-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61F3A2676B8
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:40:58 +0200 (CEST)
In-Reply-To: <20180515064335.20565-2-peter.ujfalusi@ti.com>
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

   ASoC: omap: sdma-pcm: Fix modpost warning

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

>From 7bf8ad175a1c535e31c9966984a65d12f5ff8629 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 15 May 2018 09:43:34 +0300
Subject: [PATCH] ASoC: omap: sdma-pcm: Fix modpost warning

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
see include/linux/module.h for more information

Add the missing MODULE_LICENSE.

This patch also going to solve:
snd_soc_sdma: Unknown symbol devm_kmalloc (err 0)
snd_soc_sdma: Unknown symbol omap_dma_filter_fn (err 0)
snd_soc_sdma: Unknown symbol snd_dmaengine_pcm_prepare_slave_config (err 0)
snd_soc_sdma: Unknown symbol devm_snd_dmaengine_pcm_register (err 0)

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/sdma-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index f7b2b5b69d27..3e52ccb2ae26 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -66,3 +67,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("sDMA PCM ASoC platform driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
