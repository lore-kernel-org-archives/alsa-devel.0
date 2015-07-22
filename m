From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm4567: Keep TDM_BCLKS in ssm4567_set_dai_fmt" to the asoc tree
Date: Wed, 22 Jul 2015 10:57:30 +0100
Message-ID: <E1ZHqmI-00078S-Lm@debutante>
References: <1437515186-1961-1-git-send-email-benzh@chromium.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437515186-1961-1-git-send-email-benzh@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm4567: Keep TDM_BCLKS in ssm4567_set_dai_fmt

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

>From a6c2a32ac83567f15e9af3dcbc73148ce68b2ced Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Tue, 21 Jul 2015 14:46:26 -0700
Subject: [PATCH] ASoC: ssm4567: Keep TDM_BCLKS in ssm4567_set_dai_fmt

The regmap_write in ssm4567_set_dai_fmt accidentally clears the
TDM_BCLKS field which was set earlier by ssm4567_set_tdm_slot.

This patch fixes it by using regmap_update_bits with proper mask.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/ssm4567.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 938d2cb6d78b..84a4f5ad8064 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -315,7 +315,13 @@ static int ssm4567_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (invert_fclk)
 		ctrl1 |= SSM4567_SAI_CTRL_1_FSYNC;
 
-	return regmap_write(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1, ctrl1);
+	return regmap_update_bits(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1,
+			SSM4567_SAI_CTRL_1_BCLK |
+			SSM4567_SAI_CTRL_1_FSYNC |
+			SSM4567_SAI_CTRL_1_LJ |
+			SSM4567_SAI_CTRL_1_TDM |
+			SSM4567_SAI_CTRL_1_PDM,
+			ctrl1);
 }
 
 static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
-- 
2.1.4
