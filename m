From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7218: Set DAI output pin high impedance when not in
 use
Date: Fri, 16 Dec 2016 11:05:02 +0000
Message-ID: <20161216110502.849053FA9F@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For TDM mode, the I2S data out line can be shared between mutliple
codecs. In this scenario, only the active codec should be using
the line, and all others should be high impedance. However,
currently in the driver this configuration isn't set when capture
is inactive, and the line remains driven.

This patch updates the AIF_OUT widget to set the DAI output pin of
the device as high impedance when not in use.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7218.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index c69e976..d256ebf 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1634,7 +1634,8 @@ static int da7218_hp_pga_event(struct snd_soc_dapm_widget *w,
 			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* DAI */
-	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, DA7218_DAI_TDM_CTRL,
+			     DA7218_DAI_OE_SHIFT, DA7218_NO_INVERT),
 	SND_SOC_DAPM_AIF_IN("DAIIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	/* Output Mixers */
-- 
1.9.3
