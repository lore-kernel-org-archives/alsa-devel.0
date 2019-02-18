From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l36: Make some symbols static" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:22 +0000 (GMT)
Message-ID: <20190218184922.395091128008@debutante.sirena.org.uk>
References: <20190218074653.181365-1-weiyongjun1@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218074653.181365-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: James Schulman <james.schulman@cirrus.com>, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>James Schulman <james.schulman@cirrus.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l36: Make some symbols static

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

>From b2c02c63ac254530cffe3a7dc7d4e433da1b3a67 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 18 Feb 2019 07:46:53 +0000
Subject: [PATCH] ASoC: cs35l36: Make some symbols static

Fixes the following sparse warnings:

sound/soc/codecs/cs35l36.c:135:20: warning:
 symbol 'cs35l36_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:248:6: warning:
 symbol 'cs35l36_readable_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:398:6: warning:
 symbol 'cs35l36_precious_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:410:6: warning:
 symbol 'cs35l36_volatile_reg' was not declared. Should it be static?

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: James Schulman <james.schulman@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l36.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index e374fffb7e17..dc8cf61b9db8 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -131,7 +131,7 @@ static const struct cs35l36_pll_config cs35l36_pll_sysclk[] = {
 	{27000000,	0x3F, 0x0A},
 };
 
-struct reg_default cs35l36_reg[] = {
+static struct reg_default cs35l36_reg[] = {
 	{CS35L36_TESTKEY_CTRL,			0x00000000},
 	{CS35L36_USERKEY_CTL,			0x00000000},
 	{CS35L36_OTP_CTRL1,			0x00002460},
@@ -244,7 +244,7 @@ struct reg_default cs35l36_reg[] = {
 	{CS35L36_PAC_INT7_CTRL,			0x00000001},
 };
 
-bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:
@@ -394,7 +394,7 @@ bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_TESTKEY_CTRL:
@@ -406,7 +406,7 @@ bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:
-- 
2.20.1
