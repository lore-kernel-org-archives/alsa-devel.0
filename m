From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define" to the asoc tree
Date: Thu, 27 Jul 2017 20:02:26 +0100
Message-ID: <E1dao3G-0006TP-7U@debutante>
References: <20170725175126.26578-2-damien.riegel@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725175126.26578-2-damien.riegel@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define

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

>From deab4563ad6a7f4668024455fa61b87f1d25ff73 Mon Sep 17 00:00:00 2001
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Date: Tue, 25 Jul 2017 13:51:24 -0400
Subject: [PATCH] ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN
 define

The wrong bit is assigned to DIG_CLK_CTL_RXD3_CLK_EN, change it for the
correct one.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a78802920c3c..5710fd440bcd 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -36,7 +36,7 @@
 #define CDC_D_CDC_DIG_CLK_CTL		(0xf04A)
 #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
 #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
-#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(3)
+#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
 #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
 #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
 #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
-- 
2.13.2
