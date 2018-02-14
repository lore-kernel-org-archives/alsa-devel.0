From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: fix an error code in uniphier_aio_comprdma_new()" to the asoc tree
Date: Wed, 14 Feb 2018 13:29:32 +0000
Message-ID: <E1elx7s-00075e-8E@debutante>
References: <20180214071531.GB26677@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180214071531.GB26677@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Mark Brown <broonie@kernel.org>Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniphier: fix an error code in uniphier_aio_comprdma_new()

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

>From 21957b5bf0ff607e6e0ed55a3a89454e969511ba Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 14 Feb 2018 10:15:31 +0300
Subject: [PATCH] ASoC: uniphier: fix an error code in
 uniphier_aio_comprdma_new()

The dma_mapping_error() returns true or false, but we want to return
-ENOMEM if there was an error.

Fixes: e98131222ff9 ("ASoC: uniphier: add support for UniPhier AIO compress audio")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-compress.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 7f7abe3ae99d..4751c8bdabec 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -54,12 +54,11 @@ static int uniphier_aio_comprdma_new(struct snd_soc_pcm_runtime *rtd)
 		dma_dir = DMA_TO_DEVICE;
 
 	sub->compr_addr = dma_map_single(dev, sub->compr_area, size, dma_dir);
-	ret = dma_mapping_error(dev, sub->compr_addr);
-	if (ret) {
+	if (dma_mapping_error(dev, sub->compr_addr)) {
 		kfree(sub->compr_area);
 		sub->compr_area = NULL;
 
-		return ret;
+		return -ENOMEM;
 	}
 
 	sub->compr_bytes = size;
-- 
2.16.1

