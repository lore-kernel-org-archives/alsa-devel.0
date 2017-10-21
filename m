From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: remove redundant variable dma_dev_name" to the asoc tree
Date: Sat, 21 Oct 2017 11:13:43 +0100 (BST)
Message-ID: <20171021101343.69C41440057@finisterre.ee.mobilebroadband>
References: <20171019123352.30294-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019123352.30294-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: remove redundant variable dma_dev_name

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

>From 271ef65b5882425d500e969e875c98e47a6b0c86 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 19 Oct 2017 14:33:52 +0200
Subject: [PATCH] ASoC: Intel: sst: remove redundant variable dma_dev_name

The pointer dma_dev_name is assigned but never read, it is redundant
and can therefore be removed.

Cleans up clang warning:
sound/soc/intel/common/sst-firmware.c:288:3: warning: Value stored to
'dma_dev_name' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-firmware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index a086c35f91bb..79a9fdf94d38 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -274,7 +274,6 @@ int sst_dma_new(struct sst_dsp *sst)
 	struct sst_pdata *sst_pdata = sst->pdata;
 	struct sst_dma *dma;
 	struct resource mem;
-	const char *dma_dev_name;
 	int ret = 0;
 
 	if (sst->pdata->resindex_dma_base == -1)
@@ -285,7 +284,6 @@ int sst_dma_new(struct sst_dsp *sst)
 	* is attached to the ADSP IP. */
 	switch (sst->pdata->dma_engine) {
 	case SST_DMA_TYPE_DW:
-		dma_dev_name = "dw_dmac";
 		break;
 	default:
 		dev_err(sst->dev, "error: invalid DMA engine %d\n",
-- 
2.14.1
