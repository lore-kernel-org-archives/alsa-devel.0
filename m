From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: rt5645: remove unused variable
Date: Fri, 17 Jul 2015 12:53:38 +0530
Message-ID: <1437117818-25972-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We were getting a build warning about unused variable. This variable was
a leftover from:
a4e3c5fa955c ("ASoC: rt5645: Simplify rt5645_enable_push_button_irq")

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/rt5645.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d24c979..ff091d6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2763,7 +2763,6 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
 		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
-- 
1.8.1.2
