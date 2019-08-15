From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: 88pm860x: remove unused variables 'pcm_switch_controls' and 'aif1_mux'" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:22 +0100 (BST)
Message-ID: <20190815171422.69F812742BD6@ypsilon.sirena.org.uk>
References: <20190815092547.29564-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815092547.29564-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, kstewart@linuxfoundation.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tglx@linutronix.de, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: 88pm860x: remove unused variables 'pcm_switch_controls' and 'aif1_mux'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 12f0bfadf69bb154052722e7e4e5cd1639044c76 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:25:47 +0800
Subject: [PATCH] ASoC: 88pm860x: remove unused variables 'pcm_switch_controls'
 and 'aif1_mux'

sound/soc/codecs/88pm860x-codec.c:533:38: warning:
 pcm_switch_controls defined but not used [-Wunused-const-variable=]
sound/soc/codecs/88pm860x-codec.c:560:38: warning:
 aif1_mux defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092547.29564-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index e982722b448e..00b2c43d28a1 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -529,10 +529,6 @@ static const struct snd_kcontrol_new pm860x_snd_controls[] = {
  * DAPM Controls
  */
 
-/* PCM Switch / PCM Interface */
-static const struct snd_kcontrol_new pcm_switch_controls =
-	SOC_DAPM_SINGLE("Switch", PM860X_ADC_EN_2, 0, 1, 0);
-
 /* AUX1 Switch */
 static const struct snd_kcontrol_new aux1_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_ANA_TO_ANA, 4, 1, 0);
@@ -549,17 +545,6 @@ static const struct snd_kcontrol_new lepa_switch_controls =
 static const struct snd_kcontrol_new repa_switch_controls =
 	SOC_DAPM_SINGLE("Switch", PM860X_DAC_EN_2, 1, 1, 0);
 
-/* PCM Mux / Mux7 */
-static const char *aif1_text[] = {
-	"PCM L", "PCM R",
-};
-
-static SOC_ENUM_SINGLE_DECL(aif1_enum,
-			    PM860X_PCM_IFACE_3, 6, aif1_text);
-
-static const struct snd_kcontrol_new aif1_mux =
-	SOC_DAPM_ENUM("PCM Mux", aif1_enum);
-
 /* I2S Mux / Mux9 */
 static const char *i2s_din_text[] = {
 	"DIN", "DIN1",
-- 
2.20.1
