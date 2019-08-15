From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: remove unused variable 'pga_tlv'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Message-ID: <20190815171423.318EC2742BD6@ypsilon.sirena.org.uk>
References: <20190815092056.28724-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815092056.28724-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, gustavo@embeddedor.com, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: remove unused variable 'pga_tlv'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 97d39be9ce5befc2e36f15d0df33832e0f633565 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:20:56 +0800
Subject: [PATCH] ASoC: es8328: remove unused variable 'pga_tlv'

sound/soc/codecs/es8328.c:102:35: warning:
 pga_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092056.28724-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 822a25a8f53c..4a3d303fedfb 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -99,7 +99,6 @@ static SOC_ENUM_SINGLE_DECL(adcpol,
 
 static const DECLARE_TLV_DB_SCALE(play_tlv, -3000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(dac_adc_tlv, -9600, 50, 0);
-static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 300, 0);
 
-- 
2.20.1
