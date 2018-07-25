From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: make sst_dma functions
	static" to the asoc tree
Date: Wed, 25 Jul 2018 17:40:21 +0100 (BST)
Message-ID: <20180725164022.00F191123B08@debutante.sirena.org.uk>
References: <20180724211248.29427-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F14026779B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:40:22 +0200 (CEST)
In-Reply-To: <20180724211248.29427-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: make sst_dma functions static

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

>From ef3cb7423358ff0cadacb76f26e3e1f4da8be4ce Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 24 Jul 2018 16:12:46 -0500
Subject: [PATCH] ASoC: Intel: common: make sst_dma functions static

sst_dma_new and sst_dma_free are not used in any other file and don't
have a prototype. Move to static functions and remove
EXPORT_SYMBOL_GPL statement.

Reported by sparse warnings.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-firmware.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 657afc02f1c4..11041aedea31 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -270,7 +270,7 @@ void sst_dsp_dma_put_channel(struct sst_dsp *dsp)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_dma_put_channel);
 
-int sst_dma_new(struct sst_dsp *sst)
+static int sst_dma_new(struct sst_dsp *sst)
 {
 	struct sst_pdata *sst_pdata = sst->pdata;
 	struct sst_dma *dma;
@@ -320,9 +320,8 @@ int sst_dma_new(struct sst_dsp *sst)
 	devm_kfree(sst->dev, dma);
 	return ret;
 }
-EXPORT_SYMBOL(sst_dma_new);
 
-void sst_dma_free(struct sst_dma *dma)
+static void sst_dma_free(struct sst_dma *dma)
 {
 
 	if (dma == NULL)
@@ -335,7 +334,6 @@ void sst_dma_free(struct sst_dma *dma)
 		dw_remove(dma->chip);
 
 }
-EXPORT_SYMBOL(sst_dma_free);
 
 /* create new generic firmware object */
 struct sst_fw *sst_fw_new(struct sst_dsp *dsp, 
-- 
2.18.0
