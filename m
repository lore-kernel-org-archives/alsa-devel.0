From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: remove unused variable 'adc_swap_enum'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:22 +0100 (BST)
Message-ID: <20190815171422.AB4402742B9E@ypsilon.sirena.org.uk>
References: <20190815092436.34632-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815092436.34632-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, brian.austin@cirrus.com, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: remove unused variable 'adc_swap_enum'

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

>From e33d565795930d0341bb946aec457a814ccd53e6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:24:36 +0800
Subject: [PATCH] ASoC: cs42l56: remove unused variable 'adc_swap_enum'

sound/soc/codecs/cs42l56.c:206:30: warning:
 adc_swap_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092436.34632-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index b4d7627525f9..ac569ab3d30f 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -199,14 +199,6 @@ static const struct soc_enum beep_bass_enum =
 	SOC_ENUM_SINGLE(CS42L56_BEEP_TONE_CFG, 1,
 			ARRAY_SIZE(beep_bass_text), beep_bass_text);
 
-static const char * const adc_swap_text[] = {
-	"None", "A+B/2", "A-B/2", "Swap"
-};
-
-static const struct soc_enum adc_swap_enum =
-	SOC_ENUM_SINGLE(CS42L56_MISC_ADC_CTL, 3,
-			ARRAY_SIZE(adc_swap_text), adc_swap_text);
-
 static const char * const pgaa_mux_text[] = {
 	"AIN1A", "AIN2A", "AIN3A"};
 
-- 
2.20.1
