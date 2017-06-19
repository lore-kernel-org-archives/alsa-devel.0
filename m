From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: Intel: bxt: Move codec sysclk config to codec_init
 function
Date: Mon, 19 Jun 2017 10:56:34 +0100
Message-ID: <aa8a70dcef146c6863b78e202e2adad652a99d45.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3a8c4d9..1866e31 100644
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
1.9.1
