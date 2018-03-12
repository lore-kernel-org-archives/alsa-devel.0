From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: fix wrong control register for
	ADC2 power" to the asoc tree
Date: Mon, 12 Mar 2018 16:28:51 +0000 (GMT)
Message-ID: <20180312162851.65EF6440079@finisterre.ee.mobilebroadband>
References: <1520855409-28862-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E70CE267381
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:28:55 +0100 (CET)
In-Reply-To: <1520855409-28862-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: fix wrong control register for ADC2 power

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

>From 3795e0c7d5c8b81d4ae32129b860aaa169945ce3 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 12 Mar 2018 19:50:08 +0800
Subject: [PATCH] ASoC: rt5659: fix wrong control register for ADC2 power

The control register for ADC L2 and R2 is RT5659_PWR_DIG_1
not RT5659_PWR_DIG_2.

Signed-off-by: Zhong An <zhongan@pinecone.net>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 07e7757417bc..ebadc3da0aaf 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2500,9 +2500,9 @@ static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
 		RT5659_PWR_ADC_L1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC1 R Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_R1_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC2 L Power", RT5659_PWR_DIG_2,
+	SND_SOC_DAPM_SUPPLY("ADC2 L Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_L2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC2 R Power", RT5659_PWR_DIG_2,
+	SND_SOC_DAPM_SUPPLY("ADC2 R Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_R2_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC1 clock", SND_SOC_NOPM, 0, 0, set_adc_clk,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-- 
2.16.2
