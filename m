From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static" to the asoc tree
Date: Tue, 16 Apr 2019 17:32:56 +0100 (BST)
Message-ID: <20190416163256.39C7A1127D45@debutante.sirena.org.uk>
References: <20190416145251.16800-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416145251.16800-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, colin.king@canonical.com, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, maruthi.bayyavarapu@amd.com, perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From dc11607e151bd85b17c8e03d1bf823febd5e3c40 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 16 Apr 2019 22:52:51 +0800
Subject: [PATCH] ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static

Fix sparse warning:

sound/soc/amd/raven/acp3x-pcm-dma.c:561:24: warning:
 symbol 'acp3x_dai_i2s_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1a2e15ff1456..9775bda2a4ca 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -558,7 +558,7 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
+static struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
 	.set_fmt = acp3x_dai_i2s_set_fmt,
-- 
2.20.1
