From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: use dw_dmac autoconfiguration"
	to the asoc tree
Date: Wed, 07 Oct 2015 11:38:35 +0100
Message-ID: <E1Zjm7H-0004Ge-DF@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E8882661EE
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:39:03 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: use dw_dmac autoconfiguration

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

>From b5e5a4549c8b88a880fa3866fa3803ea9396ba03 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 5 Oct 2015 14:53:50 +0300
Subject: [PATCH] ASoC: Intel: use dw_dmac autoconfiguration

Instead of hardconding a platform data for dw_dmac let's use it's own
autoconfiguration feature. Thus, remove hardcoded values.

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-firmware.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index ebcca6d..1636a1e 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -26,7 +26,6 @@
 #include <linux/acpi.h>
 
 /* supported DMA engine drivers */
-#include <linux/platform_data/dma-dw.h>
 #include <linux/dma/dw.h>
 
 #include <asm/page.h>
@@ -169,12 +168,6 @@ err:
 	return ret;
 }
 
-static struct dw_dma_platform_data dw_pdata = {
-	.is_private = 1,
-	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
-	.chan_priority = CHAN_PRIORITY_ASCENDING,
-};
-
 static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 	int irq)
 {
@@ -195,7 +188,8 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 		return ERR_PTR(err);
 
 	chip->dev = dev;
-	err = dw_dma_probe(chip, &dw_pdata);
+
+	err = dw_dma_probe(chip, NULL);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.5.0
