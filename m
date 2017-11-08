From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 1/7] ASoC: msm8916-wcd-analog: mark expected switch
 fall-through
Date: Wed, 8 Nov 2017 14:04:09 -0600
Message-ID: <2ab74b1aac4e26dcc083e09e9e066770a00dd8ca.1510170034.git.garsilva@embeddedor.com>
References: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1510170034.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1397957
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 7ff42ef..5f3c42c 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -621,6 +621,7 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 		case CDC_A_TX_2_EN:
 			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
 					    MICB_1_CTL_CFILT_REF_SEL_MASK, 0);
+			/* fall through */
 		case CDC_A_TX_3_EN:
 			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
 					    CONN_TX2_SERIAL_TX2_MUX,
-- 
2.7.4
