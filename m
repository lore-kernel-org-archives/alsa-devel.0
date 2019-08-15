From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98371: remove unused variable 'max98371_noload_gain_tlv'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:24 +0100 (BST)
Message-ID: <20190815171424.409CF2742B9E@ypsilon.sirena.org.uk>
References: <20190815090404.72752-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815090404.72752-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, info@metux.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98371: remove unused variable 'max98371_noload_gain_tlv'

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

>From 9d22142c9b1ec8612b880121dd0bc27311cbb2b5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:04:04 +0800
Subject: [PATCH] ASoC: max98371: remove unused variable
 'max98371_noload_gain_tlv'

sound/soc/codecs/max98371.c:157:35: warning:
 max98371_noload_gain_tlv defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090404.72752-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98371.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index ce801489a86d..dfee05f985bd 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -154,10 +154,6 @@ static const DECLARE_TLV_DB_RANGE(max98371_gain_tlv,
 	8, 10, TLV_DB_SCALE_ITEM(400, 100, 0)
 );
 
-static const DECLARE_TLV_DB_RANGE(max98371_noload_gain_tlv,
-	0, 11, TLV_DB_SCALE_ITEM(950, 100, 0),
-);
-
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -6300, 50, 1);
 
 static const struct snd_kcontrol_new max98371_snd_controls[] = {
-- 
2.20.1
