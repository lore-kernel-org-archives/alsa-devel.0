From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxt: Move codec sysclk config to codec_init function" to the asoc tree
Date: Mon, 19 Jun 2017 17:23:49 +0100
Message-ID: <E1dMzSv-0002Mi-8f@debutante>
References: <aa8a70dcef146c6863b78e202e2adad652a99d45.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa8a70dcef146c6863b78e202e2adad652a99d45.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxt: Move codec sysclk config to codec_init function

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

>From fd0f237572ada2b18fe1e8684ae9fa131b577a17 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 19 Jun 2017 10:56:34 +0100
Subject: [PATCH] ASoC: Intel: bxt: Move codec sysclk config to codec_init
 function

The MCLK for DA7219 does not change in this platform, but is
currently being configured everytime as part of the platform_clock
event handler for DAPM. The upshot of this is that we have
unnecessary calls to this function, and it also means that if
a stream hasn't yet been started, DA7219 driver does not have the
correct MCLK rates programmed and so the HP detection feature does
not operate as expected.

This patch rectifies this issue by moving the sysclk call to
codec_init function so it's only called once at initialisation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3a8c4d954a91..1866e31b6c29 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -89,11 +89,6 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		if (ret)
 			dev_err(card->dev, "failed to stop PLL: %d\n", ret);
 	} else if(SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai,
-                        DA7219_CLKSRC_MCLK, 19200000, SND_SOC_CLOCK_IN);
-		if (ret)
-			dev_err(card->dev, "can't set codec sysclk configuration\n");
-
 		ret = snd_soc_dai_set_pll(codec_dai, 0,
 			DA7219_SYSCLK_PLL_SRM, 0, DA7219_PLL_FREQ_OUT_98304);
 		if (ret)
@@ -187,8 +182,17 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	/* Configure sysclk for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 19200000,
+				     SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
 	/*
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
-- 
2.11.0
