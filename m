From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:23 +0100 (BST)
Message-ID: <20190815171424.034DC2742BD6@ypsilon.sirena.org.uk>
References: <20190815090602.9000-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815090602.9000-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'

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

>From 5b366753c1c12feead0ae53b45482f569ed5399c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:06:02 +0800
Subject: [PATCH] ASoC: rt1011: remove unused variable 'dac_vol_tlv' and
 'adc_vol_tlv'

sound/soc/codecs/rt1011.c:981:35: warning:
 dac_vol_tlv defined but not used [-Wunused-const-variable=]
sound/soc/codecs/rt1011.c:982:35: warning:
 adc_vol_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090602.9000-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 638abcaf52b3..fa34565a3938 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -978,9 +978,6 @@ static bool rt1011_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9435, 37, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1739, 37, 0);
-
 static const char * const rt1011_din_source_select[] = {
 	"Left",
 	"Right",
-- 
2.20.1
