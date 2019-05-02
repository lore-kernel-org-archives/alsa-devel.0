From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_micfil: Remove set but not used variable 'osr'" to the asoc tree
Date: Thu,  2 May 2019 03:18:42 +0100 (BST)
Message-ID: <20190502021843.03B03441D3B@finisterre.ee.mobilebroadband>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417150915.37968-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, festevam@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.orgMark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com, perex@perex.cz, timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_micfil: Remove set but not used variable 'osr'

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

>From a0c34c7629bee46ffd8121987d27df25a6433cc7 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:09:15 +0800
Subject: [PATCH] ASoC: fsl_micfil: Remove set but not used variable 'osr'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/fsl/fsl_micfil.c: In function 'get_clk_div':
sound/soc/fsl/fsl_micfil.c:154:6: warning: variable 'osr' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 40c07e756481..f7f2d29f1bfe 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
 {
 	u32 ctrl2_reg;
 	long mclk_rate;
-	int osr;
 	int clk_div;
 
 	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
-	osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
-		    >> MICFIL_CTRL2_CICOSR_SHIFT);
 
 	mclk_rate = clk_get_rate(micfil->mclk);
 
-- 
2.20.1
