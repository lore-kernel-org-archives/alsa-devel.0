From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Revert "samsung: Remove unneeded
	initialization of chan_name"" to the asoc tree
Date: Tue, 24 Jan 2017 18:39:18 +0000
Message-ID: <E1cW5zy-0006ZG-Py@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAD6B266CC1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:39:25 +0100 (CET)
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
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Revert "samsung: Remove unneeded initialization of chan_name"

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

>From b8ab0ccc0b6e517ff595f1b06fb9f578c8b4001f Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 17 Jan 2017 14:16:42 +0100
Subject: [PATCH] ASoC: Revert "samsung: Remove unneeded initialization of
 chan_name"

This reverts commit cdaf9af1eaeb539e32bfd6da6310b41ad6c3ba23
which breaks I2S support on the non-DT Samsung SoC platforms,
since the default "tx", "rx" DMA channel names for playback
and capture streams or custom channel names in struct
snd_dmaengine_pcm_config are supported in the ASoC dmaengine
module only for devicetree booting case.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/dmaengine.c   | 8 ++++++--
 sound/soc/samsung/i2s.c         | 3 +++
 sound/soc/samsung/s3c2412-i2s.c | 2 ++
 sound/soc/samsung/s3c24xx-i2s.c | 2 ++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index cda656e4afc6..9104c98deeb7 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -37,8 +37,12 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 	pcm_conf->prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 	pcm_conf->compat_filter_fn = filter;
 
-	pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
-	pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
+	if (dev->of_node) {
+		pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
+		pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
+	} else {
+		flags |= SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME;
+	}
 
 	return devm_snd_dmaengine_pcm_register(dev, pcm_conf, flags);
 }
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e00974bc5616..85324e61cbd5 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1305,6 +1305,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	}
 	pri_dai->dma_playback.addr = regs_base + I2STXD;
 	pri_dai->dma_capture.addr = regs_base + I2SRXD;
+	pri_dai->dma_playback.chan_name = "tx";
+	pri_dai->dma_capture.chan_name = "rx";
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
@@ -1329,6 +1331,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->lock = &pri_dai->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
+		sec_dai->dma_playback.chan_name = "tx-sec";
 
 		if (!np) {
 			sec_dai->dma_playback.filter_data = i2s_pdata->dma_play_sec;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 6d0b8897fa6c..0a4718207e6e 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -35,10 +35,12 @@
 #include <linux/platform_data/asoc-s3c.h>
 
 static struct snd_dmaengine_dai_dma_data s3c2412_i2s_pcm_stereo_out = {
+	.chan_name	= "tx",
 	.addr_width	= 4,
 };
 
 static struct snd_dmaengine_dai_dma_data s3c2412_i2s_pcm_stereo_in = {
+	.chan_name	= "rx",
 	.addr_width	= 4,
 };
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 07f5091b33e8..91e6871e5413 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -31,10 +31,12 @@
 #include "s3c24xx-i2s.h"
 
 static struct snd_dmaengine_dai_dma_data s3c24xx_i2s_pcm_stereo_out = {
+	.chan_name	= "tx",
 	.addr_width	= 2,
 };
 
 static struct snd_dmaengine_dai_dma_data s3c24xx_i2s_pcm_stereo_in = {
+	.chan_name	= "rx",
 	.addr_width	= 2,
 };
 
-- 
2.11.0
