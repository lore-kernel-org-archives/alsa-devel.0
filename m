From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld()'" to the asoc tree
Date: Mon, 08 Jan 2018 16:23:27 +0000
Message-ID: <E1eYaCt-0002Gy-6e@debutante>
References: <20180106201824.6081-1-christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180106201824.6081-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld()'

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

>From eaadb1caa966a91128297b754e90b7c92b350a00 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 6 Jan 2018 21:18:24 +0100
Subject: [PATCH] ASoC: Intel: sst: Fix the return value of
 'sst_send_byte_stream_mrfld()'

In some error handling paths, an error code is assiegned to 'ret'.
However, the function always return 0.

Fix it and return the error code if such an error paths is taken.

Fixes: 3d9ff34622ba ("ASoC: Intel: sst: add stream operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 65e257b17a7e..20f5066fefb9 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -220,7 +220,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.15.1

