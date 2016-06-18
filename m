From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: cs53l30: Set idle_bias_off true
Date: Fri, 17 Jun 2016 18:31:57 -0700
Message-ID: <1466213517-18523-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver is using the set_bias_level to control the power on and
off so it should get SND_SOC_BIAS_OFF in order to proceed normal
powering sequences. This patch enables the idle_bias_off option so
the DAPM core will set the bias level to SND_SOC_BIAS_OFF instead
of stopping at SND_SOC_BIAS_STANDBY.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index a5976f3..b0a64a1 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -879,6 +879,7 @@ static int cs53l30_codec_probe(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver cs53l30_driver = {
 	.probe = cs53l30_codec_probe,
 	.set_bias_level = cs53l30_set_bias_level,
+	.idle_bias_off = true,
 
 	.dapm_widgets = cs53l30_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(cs53l30_dapm_widgets),
-- 
2.1.4
