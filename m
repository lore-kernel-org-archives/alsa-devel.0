From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Use the type
	SOC_DAPM_SINGLE_AUTODISABLE to prevent the weird sound in
	runtime of power up" to the asoc tree
Date: Wed, 23 Sep 2015 11:00:53 -0700
Message-ID: <E1ZeoLd-0005SP-DN@finisterre>
References: <1442990130-15801-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A25265DA5
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 23:19:49 +0200 (CEST)
Received: from [70.35.39.2] (helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1ZfDvf-0006bK-TO
 for alsa-devel@alsa-project.org; Thu, 24 Sep 2015 21:19:48 +0000
In-Reply-To: <1442990130-15801-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Use the type SOC_DAPM_SINGLE_AUTODISABLE to prevent the weird sound in runtime of power up

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

>From 21cb13e72b02dbbb5a02477d4dd46bc2bc1cfd08 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 23 Sep 2015 14:35:28 +0800
Subject: [PATCH] ASoC: rt5645: Use the type SOC_DAPM_SINGLE_AUTODISABLE to
 prevent the weird sound in runtime of power up

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dbc1d76..25c34fb 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -732,14 +732,14 @@ static const struct snd_kcontrol_new rt5645_mono_adc_r_mix[] = {
 static const struct snd_kcontrol_new rt5645_dac_l_mix[] = {
 	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_ADCMIX_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 Switch", RT5645_AD_DA_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_DAC1_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5645_dac_r_mix[] = {
 	SOC_DAPM_SINGLE("Stereo ADC Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_ADCMIX_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 Switch", RT5645_AD_DA_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 Switch", RT5645_AD_DA_MIXER,
 			RT5645_M_DAC1_R_SFT, 1, 1),
 };
 
-- 
2.5.0
