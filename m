From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Use usleep_range() instead of
	msleep()" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:53 +0000
Message-ID: <E1aMgQ9-0004CT-5O@debutante>
References: <1452857725-32414-2-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 349C9261583
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:58 +0100 (CET)
In-Reply-To: <1452857725-32414-2-git-send-email-lixiubo@cmss.chinamobile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Use usleep_range() instead of msleep()

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

>From 512feb4e19a262ea0dfd7209506a998897feaadc Mon Sep 17 00:00:00 2001
From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Date: Fri, 15 Jan 2016 19:35:24 +0800
Subject: [PATCH] ASoC: fsl_sai: Use usleep_range() instead of msleep()

Since msleep() will sleep longer than intended time for values less
than 20ms, this patch allows the use of usleep_range for just 1ms.
usleep_range is a finer precision implementation of msleep and is
designed to be a drop-in replacement for udelay where a precise
sleep/busy-wait is unnecessary.

More details see Documentation/timers/timers-howto.txt.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 43ba5dc26775..4919de9684eb 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/time.h>
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -884,7 +885,7 @@ static int fsl_sai_resume(struct device *dev)
 	regcache_cache_only(sai->regmap, false);
 	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
 	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
-	msleep(1);
+	usleep_range(1000, 2000);
 	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
 	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
 	return regcache_sync(sai->regmap);
-- 
2.7.0.rc3
