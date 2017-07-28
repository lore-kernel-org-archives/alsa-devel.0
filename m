From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Fix possible double iounmap on s3c24xx driver probe failure" to the asoc tree
Date: Fri, 28 Jul 2017 11:18:29 +0100
Message-ID: <E1db2Ll-0003pn-Ch@debutante>
References: <20170726185729.28897-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726185729.28897-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgArvind Yadav <arvind.yadav.cs@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Fix possible double iounmap on s3c24xx driver probe failure

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

>From 776bac64bf13e20c27f7ad168811abdf3b72f14d Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 27 Jul 2017 19:13:36 +0200
Subject: [PATCH] ASoC: samsung: Fix possible double iounmap on s3c24xx driver
 probe failure

Commit 87b132bc0315 ("ASoC: samsung: s3c24{xx,12}-i2s: port to use
generic dmaengine API") moved ioremap() call from
s3c-i2s-v2.c:s3c_i2sv2_probe() to s3c2412-i2s.c:s3c2412_iis_dev_probe()
and converted it to devm- resource managed interface.

However the error path in first of them - s3c_i2sv2_probe() - was not
updated.  If getting a iis clock in s3c_i2sv2_probe() failed, the
address space would be unmapped there.  This could lead to:
1. double iounmap() later from devm-interface of s3c2412_iis_dev_probe()),
2. accessing the memory by other functions in s3c2412-i2s.c unit.

Anyway, the owner of this mapped region should be s3c2412-i2s.c because
it starts the mapping.

Affected are drivers for S3C24xx family although issue was not reproduced.

Fixes: 87b132bc0315 ("ASoC: samsung: s3c24{xx,12}-i2s: port to use generic dmaengine API")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Arvind Yadav<arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index ca522a95160b..9b28046eea8e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -634,7 +634,6 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 	i2s->iis_pclk = clk_get(dev, "iis");
 	if (IS_ERR(i2s->iis_pclk)) {
 		dev_err(dev, "failed to get iis_clock\n");
-		iounmap(i2s->regs);
 		return -ENOENT;
 	}
 
-- 
2.13.2
