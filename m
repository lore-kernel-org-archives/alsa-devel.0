From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4265: CS4265_INT_STATUS is readable
	register" to the asoc tree
Date: Fri, 24 Jul 2015 18:31:58 +0100
Message-ID: <E1ZIgpC-0001lp-Bx@debutante>
References: <1437280372.23834.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB912605D9
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 19:32:04 +0200 (CEST)
In-Reply-To: <1437280372.23834.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4265: CS4265_INT_STATUS is readable register

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

>From 80deaf09cb3fb3939c1d2b84610ae411cd7c6001 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 19 Jul 2015 12:32:52 +0800
Subject: [PATCH] ASoC: cs4265: CS4265_INT_STATUS is readable register

CS4265_INT_STATUS was missed in cs4265_readable_register, fix it.
The register 0x01 ~ 0x12 are readable, use
CS4265_CHIP_ID ... CS4265_SPDIF_CTL2 syntax for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4265.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index d7ec4756e45b..688c5007d157 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -60,23 +60,7 @@ static const struct reg_default cs4265_reg_defaults[] = {
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4265_PWRCTL:
-	case CS4265_DAC_CTL:
-	case CS4265_ADC_CTL:
-	case CS4265_MCLK_FREQ:
-	case CS4265_SIG_SEL:
-	case CS4265_CHB_PGA_CTL:
-	case CS4265_CHA_PGA_CTL:
-	case CS4265_ADC_CTL2:
-	case CS4265_DAC_CHA_VOL:
-	case CS4265_DAC_CHB_VOL:
-	case CS4265_DAC_CTL2:
-	case CS4265_SPDIF_CTL1:
-	case CS4265_SPDIF_CTL2:
-	case CS4265_INT_MASK:
-	case CS4265_STATUS_MODE_MSB:
-	case CS4265_STATUS_MODE_LSB:
-	case CS4265_CHIP_ID:
+	case CS4265_CHIP_ID ... CS4265_SPDIF_CTL2:
 		return true;
 	default:
 		return false;
-- 
2.1.4
