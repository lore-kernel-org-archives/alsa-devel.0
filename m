From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: [PATCH v11 11/12] sun4i-codec: Add MIC2 Pre-Amplifier.
Date: Fri,  9 Jun 2017 08:22:15 +0200
Message-ID: <20170609062216.26807-12-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Danny Milosavljevic <dannym@scratchpost.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 730f6151..a9e10dce 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -860,6 +860,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	/* Mic Pre-Amplifiers */
 	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
 
 	/* Power Amplifier */
 	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
