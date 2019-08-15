From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt2701: remove unused variables" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Message-ID: <20190815171426.173082742BC7@ypsilon.sirena.org.uk>
References: <20190813143811.31456-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813143811.31456-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.orgMark Brown <broonie@kernel.org>, matthias.bgg@gmail.com, perex@perex.c, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt2701: remove unused variables

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

>From a9e792d006edbd33724f2eb858887d3b591d82c5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 13 Aug 2019 22:38:11 +0800
Subject: [PATCH] ASoC: mt2701: remove unused variables

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:799:38: warning:
 mt2701_afe_o23_mix defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:803:38: warning:
 mt2701_afe_o24_mix defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:835:38: warning:
 mt2701_afe_multi_ch_out_i2s4 defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190813143811.31456-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 9af76ae315a5..d7f5defa50c2 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -796,14 +796,6 @@ static const struct snd_kcontrol_new mt2701_afe_o22_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I19 Switch", AFE_CONN22, 19, 1, 0),
 };
 
-static const struct snd_kcontrol_new mt2701_afe_o23_mix[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("I20 Switch", AFE_CONN23, 20, 1, 0),
-};
-
-static const struct snd_kcontrol_new mt2701_afe_o24_mix[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("I21 Switch", AFE_CONN24, 21, 1, 0),
-};
-
 static const struct snd_kcontrol_new mt2701_afe_o31_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I35 Switch", AFE_CONN41, 9, 1, 0),
 };
@@ -832,11 +824,6 @@ static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_i2s3[] = {
 				    PWR2_TOP_CON, 18, 1, 0),
 };
 
-static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_i2s4[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("Multich I2S4 Out Switch",
-				    PWR2_TOP_CON, 19, 1, 0),
-};
-
 static const struct snd_soc_dapm_widget mt2701_afe_pcm_widgets[] = {
 	/* inter-connections */
 	SND_SOC_DAPM_MIXER("I00", SND_SOC_NOPM, 0, 0, NULL, 0),
-- 
2.20.1
