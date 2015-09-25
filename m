From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH  V1 6/6] ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa documentation.
Date: Fri, 25 Sep 2015 14:30:09 -0400
Message-ID: <1443205809-27549-7-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 7d2fbca068d0..f7629b17ee5b 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -269,7 +269,7 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
 	SOC_DOUBLE("PCM Playback Volume", AIC26_REG_DAC_GAIN, 8, 0, 0x7f, 1),
 	SOC_DOUBLE("PCM Playback Switch", AIC26_REG_DAC_GAIN, 15, 7, 1, 1),
 	SOC_SINGLE("PCM Capture Volume", AIC26_REG_ADC_GAIN, 8, 0x7f, 0),
-	SOC_SINGLE("PCM Capture Mute", AIC26_REG_ADC_GAIN, 15, 1, 1),
+	SOC_SINGLE("PCM Capture Switch", AIC26_REG_ADC_GAIN, 15, 1, 1),
 	SOC_SINGLE("Keyclick activate", AIC26_REG_AUDIO_CTRL2, 15, 0x1, 0),
 	SOC_SINGLE("Keyclick amplitude", AIC26_REG_AUDIO_CTRL2, 12, 0x7, 0),
 	SOC_SINGLE("Keyclick frequency", AIC26_REG_AUDIO_CTRL2, 8, 0x7, 0),
-- 
1.9.1
