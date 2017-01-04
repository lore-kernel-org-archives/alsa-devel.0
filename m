From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: move DAC2 Power to
	rt5640_dapm_widgets" to the asoc tree
Date: Wed, 04 Jan 2017 18:37:05 +0000
Message-ID: <E1cOqQr-0001vr-11@debutante>
References: <1483506852-599-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3841526753A
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 19:37:15 +0100 (CET)
In-Reply-To: <1483506852-599-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: move DAC2 Power to rt5640_dapm_widgets

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

>From 80317c2cb40085a3dcf80015bc39fbac40e2092a Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 4 Jan 2017 13:14:12 +0800
Subject: [PATCH] ASoC: rt5640: move DAC2 Power to rt5640_dapm_widgets

"DAC L2 Power" and "DAC R2 Power" are used by both rt5639 and rt5640.
But it was defined in rt5640_specific_dapm_widgets[]. Move them to
rt5640_dapm_widgets will let both rt5639 and rt5640 can use it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e29a6defefa0..0f1b2165e01c 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1227,6 +1227,10 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		RT5640_PWR_DAC_L1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DAC R1 Power", RT5640_PWR_DIG1,
 		RT5640_PWR_DAC_R1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC L2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
 	/* SPK/OUT Mixer */
 	SND_SOC_DAPM_MIXER("SPK MIXL", RT5640_PWR_MIXER, RT5640_PWR_SM_L_BIT,
 		0, rt5640_spk_l_mix, ARRAY_SIZE(rt5640_spk_l_mix)),
@@ -1322,10 +1326,6 @@ static const struct snd_soc_dapm_widget rt5640_specific_dapm_widgets[] = {
 		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
 	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
 		RT5640_PWR_MA_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC L2 Power", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC R2 Power", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("MONOP"),
 	SND_SOC_DAPM_OUTPUT("MONON"),
-- 
2.11.0
