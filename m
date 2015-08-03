From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Fix lost pin setting for DMIC1"
	to the asoc tree
Date: Mon, 03 Aug 2015 17:09:07 +0100
Message-ID: <E1ZMIIV-0001yT-5B@finisterre>
References: <1438575459-29702-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9252652FB
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 18:09:17 +0200 (CEST)
In-Reply-To: <1438575459-29702-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Fix lost pin setting for DMIC1

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

>From a094935e4ebdf5c22c45b8aeeb2d88e9e8c53dbf Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 3 Aug 2015 12:17:39 +0800
Subject: [PATCH] ASoC: rt5645: Fix lost pin setting for DMIC1

I2S2_DAC pin can be used for I2S or GPIO. We should set it as GPIO
if we use GPIO5 as DMIC1 data pin.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 ++
 sound/soc/codecs/rt5645.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e9cc3aa..961bd7e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3341,6 +3341,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		break;
 
 	case RT5645_DMIC_DATA_GPIO5:
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_I2S2_DAC_PIN_MASK, RT5645_I2S2_DAC_PIN_GPIO);
 		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
 			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO5);
 		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 0353a6a..278bb9f 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1693,6 +1693,10 @@
 #define RT5645_GP6_PIN_SFT			6
 #define RT5645_GP6_PIN_GPIO6			(0x0 << 6)
 #define RT5645_GP6_PIN_DMIC2_SDA		(0x1 << 6)
+#define RT5645_I2S2_DAC_PIN_MASK		(0x1 << 4)
+#define RT5645_I2S2_DAC_PIN_SFT			4
+#define RT5645_I2S2_DAC_PIN_I2S			(0x0 << 4)
+#define RT5645_I2S2_DAC_PIN_GPIO		(0x1 << 4)
 #define RT5645_GP8_PIN_MASK			(0x1 << 3)
 #define RT5645_GP8_PIN_SFT			3
 #define RT5645_GP8_PIN_GPIO8			(0x0 << 3)
-- 
2.1.4
