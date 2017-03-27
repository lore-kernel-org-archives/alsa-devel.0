From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: remove unused variable data and associated code" to the asoc tree
Date: Mon, 27 Mar 2017 12:32:08 +0100
Message-ID: <E1csSsa-0000m3-Dz@debutante>
References: <20170322143644.29051-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170322143644.29051-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: remove unused variable data and associated code

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

>From 74a4ce4c8e13820799911c746b917efd7cc25f55 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 22 Mar 2017 14:36:44 +0000
Subject: [PATCH] ASoC: intel: remove unused variable data and associated code

The variable 'data' is assigned null and never re-assigned. There
is also a redundant check for data being non-null which is always
false, so remove this and the variable data and dma_addr as they
are not used once the dead code has been removed.

Detected with CoverityScan, CID#1324015 ("'Constant' variable gaurds
dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index a3459d1682a6..d33bdaf92c57 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2000,10 +2000,8 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 	u32 param_size, char *param)
 {
 	int ret;
-	unsigned char *data = NULL;
 	u32 header = 0;
 	u32 payload_size = 0, transfer_parameter_size = 0;
-	dma_addr_t dma_addr = 0;
 	struct sst_hsw_transfer_parameter *parameter;
 	struct device *dev = hsw->dev;
 
@@ -2047,10 +2045,6 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 
 	kfree(parameter);
 
-	if (data)
-		dma_free_coherent(hsw->dsp->dma_dev,
-			param_size, (void *)data, dma_addr);
-
 	return ret;
 }
 
-- 
2.11.0

