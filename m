From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: fix spelling mistake: "allocationf" -> "allocation"" to the asoc tree
Date: Mon, 15 May 2017 17:02:14 +0900
Message-ID: <E1dAAxK-0002Mt-5m@finisterre>
References: <20170510102940.18786-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170510102940.18786-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: fix spelling mistake: "allocationf" -> "allocation"

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

>From 3c0a98c595d87b9c961bafa755c2c0f3c031249c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 10 May 2017 11:29:40 +0100
Subject: [PATCH] ASoC: Intel: sst: fix spelling mistake: "allocationf" ->
 "allocation"

Trivial fix to spelling mistake in dev_err message. Also replace "fail"
with "failure".

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 21cac1c8dd4c..b082b31023d5 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -690,7 +690,7 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			snd_dma_continuous_data(GFP_DMA),
 			SST_MIN_BUFFER, SST_MAX_BUFFER);
 		if (retval) {
-			dev_err(rtd->dev, "dma buffer allocationf fail\n");
+			dev_err(rtd->dev, "dma buffer allocation failure\n");
 			return retval;
 		}
 	}
-- 
2.11.0
