From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: remove set but not used variable
	'dma_buffer'" to the asoc tree
Date: Thu, 15 Nov 2018 19:46:33 +0000 (GMT)
Message-ID: <20181115194633.D3D6A440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 971BA267B0E
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:46:41 +0100 (CET)
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
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: remove set but not used variable 'dma_buffer'

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

>From 424d5b56d020b750803134cc15bbd4d0addaaee7 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Nov 2018 01:56:35 +0000
Subject: [PATCH] ASoC: amd: remove set but not used variable 'dma_buffer'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/amd/raven/acp3x-pcm-dma.c: In function 'acp3x_dma_hw_params':
sound/soc/amd/raven/acp3x-pcm-dma.c:333:25: warning:
 variable 'dma_buffer' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
8de1b5ed0337 ("ASoC: amd: add acp3x system resume pm op")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 2aa34208ae92..022a8912c8a2 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -322,7 +322,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	u64 size;
-	struct snd_dma_buffer *dma_buffer;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct i2s_stream_instance *rtd = runtime->private_data;
@@ -330,7 +329,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 	if (!rtd)
 		return -EINVAL;
 
-	dma_buffer = &substream->dma_buffer;
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
-- 
2.19.1
