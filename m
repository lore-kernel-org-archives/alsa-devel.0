From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: make tm2_dapm_widgets and tm2_pm_ops static" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:46 +0100
Message-ID: <E1dhITu-0005Zv-MJ@finisterre>
References: <20170813153715.18058-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170813153715.18058-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: make tm2_dapm_widgets and tm2_pm_ops static

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

>From fa99125e2acca4e85de57cff55aea9fc7cb2930a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 13 Aug 2017 16:37:15 +0100
Subject: [PATCH] ASoC: samsung: make tm2_dapm_widgets and tm2_pm_ops static

tm2_dapm_widgets and tm2_pm_ops are local to the source and do not need
to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'tm2_dapm_widgets' was not declared. Should it be static?
symbol 'tm2_pm_ops' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/tm2_wm5110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 24cc9d63ce87..68698f3d72f9 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -318,7 +318,7 @@ static const struct snd_kcontrol_new tm2_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
-const struct snd_soc_dapm_widget tm2_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget tm2_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("HP", NULL),
 	SND_SOC_DAPM_SPK("SPK", NULL),
 	SND_SOC_DAPM_SPK("RCV", NULL),
@@ -521,7 +521,7 @@ static void tm2_pm_complete(struct device *dev)
 	tm2_start_sysclk(card);
 }
 
-const struct dev_pm_ops tm2_pm_ops = {
+static const struct dev_pm_ops tm2_pm_ops = {
 	.prepare	= tm2_pm_prepare,
 	.suspend	= snd_soc_suspend,
 	.resume		= snd_soc_resume,
-- 
2.13.2
