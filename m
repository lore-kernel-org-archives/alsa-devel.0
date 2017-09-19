From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: remove duplicate initializations of dma_ch and v" to the asoc tree
Date: Tue, 19 Sep 2017 14:47:06 +0100
Message-ID: <E1duIri-0008Nz-2p@debutante>
References: <20170918092603.27613-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918092603.27613-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: remove duplicate initializations of dma_ch and v

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

>From 20cf7e3ce3083593e163849ae6ba95525f2366ca Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 18 Sep 2017 10:26:03 +0100
Subject: [PATCH] ASoC: qcom: remove duplicate initializations of dma_ch and v

dma_ch is being initialized to zero and then immediately afterwards
being updated again, so the first initialization is redundant and
can be remove.

Likewise, the pointer v is being initialized twice, so remove the second
duplicate initialization.

Cleans up two clang build warnings:
warning: Value stored to 'dma_ch' is never read
warning: Value stored to 'v' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index e1945e1772cd..caf71aab8196 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -74,7 +74,6 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	data->i2s_port = cpu_dai->driver->id;
 	runtime->private_data = data;
 
-	dma_ch = 0;
 	if (v->alloc_dma_channel)
 		dma_ch = v->alloc_dma_channel(drvdata, dir);
 	else
@@ -122,7 +121,6 @@ static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
 	struct lpass_pcm_data *data;
 
 	data = runtime->private_data;
-	v = drvdata->variant;
 	drvdata->substream[data->dma_ch] = NULL;
 	if (v->free_dma_channel)
 		v->free_dma_channel(drvdata, data->dma_ch);
-- 
2.14.1
