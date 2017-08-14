From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx_aud96p22: make array aud96p22_dt_ids static" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:50 +0100
Message-ID: <E1dhITy-0005aq-ID@finisterre>
References: <20170626090014.8977-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170626090014.8977-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx_aud96p22: make array aud96p22_dt_ids static

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

>From def4b1243e56774fdc47de9292111a344f14e88c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 13 Aug 2017 16:28:08 +0100
Subject: [PATCH] ASoC: zx_aud96p22: make array aud96p22_dt_ids static

The array aud96p22_dt_ids is local to the source and does not need to be
in global scope, so make it static.

Cleans up sparse warning:
symbol 'aud96p22_dt_ids' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/zx_aud96p22.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 032fb7cf6cbd..bc23ce1a30a1 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -382,7 +382,7 @@ static int aud96p22_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-const struct of_device_id aud96p22_dt_ids[] = {
+static const struct of_device_id aud96p22_dt_ids[] = {
 	{ .compatible = "zte,zx-aud96p22", },
 	{ }
 };
-- 
2.13.2
