From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Set DAI output pin high impedance when not in use" to the asoc tree
Date: Fri, 16 Dec 2016 12:31:40 +0000
Message-ID: <E1cHrfo-0006Fo-Rm@debutante>
References: <20161216110502.849053FA9F@swsrvapps-01.diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161216110502.849053FA9F@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Set DAI output pin high impedance when not in use

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

>From ac29a8f41740186aee601de99c729530e37ca77c Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 16 Dec 2016 11:05:02 +0000
Subject: [PATCH] ASoC: da7218: Set DAI output pin high impedance when not in
 use

For TDM mode, the I2S data out line can be shared between mutliple
codecs. In this scenario, only the active codec should be using
the line, and all others should be high impedance. However,
currently in the driver this configuration isn't set when capture
is inactive, and the line remains driven.

This patch updates the AIF_OUT widget to set the DAI output pin of
the device as high impedance when not in use.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index c69e97654fc6..d256ebf9e309 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1634,7 +1634,8 @@ static const struct snd_soc_dapm_widget da7218_dapm_widgets[] = {
 			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* DAI */
-	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, DA7218_DAI_TDM_CTRL,
+			     DA7218_DAI_OE_SHIFT, DA7218_NO_INVERT),
 	SND_SOC_DAPM_AIF_IN("DAIIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	/* Output Mixers */
-- 
2.11.0
