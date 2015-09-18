From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH RFC 6/7] ASoC: tlv320aic26: Add support for DSP_B data format
Date: Fri, 18 Sep 2015 16:11:15 -0400
Message-ID: <1442607076-26681-7-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Gluszek <greg.gluszek@criticallink.com>, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index c3b0a698ea66..5c5641cd28de 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -211,6 +211,7 @@ static int aic26_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:     aic26->datfm = AIC26_DATFM_I2S; break;
 	case SND_SOC_DAIFMT_DSP_A:   aic26->datfm = AIC26_DATFM_DSP; break;
+	case SND_SOC_DAIFMT_DSP_B:   aic26->datfm = AIC26_DATFM_DSP; break;
 	case SND_SOC_DAIFMT_RIGHT_J: aic26->datfm = AIC26_DATFM_RIGHTJ; break;
 	case SND_SOC_DAIFMT_LEFT_J:  aic26->datfm = AIC26_DATFM_LEFTJ; break;
 	default:
-- 
1.9.1
