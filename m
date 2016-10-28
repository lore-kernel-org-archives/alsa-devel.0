From: Stephen Barber <smbarber@chromium.org>
Subject: [PATCH] ASoC: da7219: Connect output enable register to DAIOUT
Date: Thu, 27 Oct 2016 18:02:27 -0700
Message-ID: <1477616547-20714-1-git-send-email-smbarber@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Stephen Barber <smbarber@chromium.org>
List-Id: alsa-devel@alsa-project.org

da7219 output (for headset capture) should be set to high-impedance when
not in use, since it will otherwise interfere with output from other
codecs attached to the same DAI.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
---
 sound/soc/codecs/da7219.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 2610fc5..9960162 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -959,7 +959,8 @@ static const struct snd_soc_dapm_widget da7219_dapm_widgets[] = {
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* DAI */
-	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, DA7219_DAI_TDM_CTRL,
+			     DA7219_DAI_OE_SHIFT, DA7219_NO_INVERT),
 	SND_SOC_DAPM_AIF_IN("DAIIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	/* Output Muxes */
-- 
2.8.0.rc3.226.g39d4020
