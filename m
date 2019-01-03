From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Fix recording no sound issue"
	to the asoc tree
Date: Thu,  3 Jan 2019 16:29:25 +0000 (GMT)
Message-ID: <20190103162925.A213A440080@finisterre.ee.mobilebroadband>
References: <1546420736-32405-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9B5267BC7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 17:29:31 +0100 (CET)
In-Reply-To: <1546420736-32405-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Fix recording no sound issue

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

>From a992571e46d592c7f447660ca4dc3d24ce773445 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Wed, 2 Jan 2019 17:18:56 +0800
Subject: [PATCH] ASoC: rt5682: Fix recording no sound issue

The ADC mixer setting needs to restore to default value
after calibration.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 34cfaf8f6f34..89c43b26c379 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2512,6 +2512,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
 	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.20.1
