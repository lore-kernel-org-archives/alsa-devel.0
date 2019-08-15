From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Message-ID: <20190815171426.93A0C2742B9E@ypsilon.sirena.org.uk>
References: <20190815091920.64480-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815091920.64480-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Hulk Robot <hulkci@huawei.com>, info@metux.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, perex@perex.cz, tglx@linutronix.de, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 554b75bde64bcad9662530726d1483f7ef012069 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:19:20 +0800
Subject: [PATCH] ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls

sound/soc/codecs/wm8737.c:112:29: warning:
 high_3d defined but not used [-Wunused-const-variable=]

'high_3d' should be used for 3D High Cut-off.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2a9ae13a2641 ("ASoC: Add initial WM8737 driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190815091920.64480-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8737.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 0c246fb5e5ac..7a3f9fbe8d53 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -167,7 +167,7 @@ SOC_DOUBLE("Polarity Invert Switch", WM8737_ADC_CONTROL, 5, 6, 1, 0),
 SOC_SINGLE("3D Switch", WM8737_3D_ENHANCE, 0, 1, 0),
 SOC_SINGLE("3D Depth", WM8737_3D_ENHANCE, 1, 15, 0),
 SOC_ENUM("3D Low Cut-off", low_3d),
-SOC_ENUM("3D High Cut-off", low_3d),
+SOC_ENUM("3D High Cut-off", high_3d),
 SOC_SINGLE_TLV("3D ADC Volume", WM8737_3D_ENHANCE, 7, 1, 1, adc_tlv),
 
 SOC_SINGLE("Noise Gate Switch", WM8737_NOISE_GATE, 0, 1, 0),
-- 
2.20.1
