From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: [PATCH v11 07/12] sun4i-codec: Add extra controls to sun4i_codec_quirks, sun7i_codec_quirks.
Date: Fri,  9 Jun 2017 08:22:11 +0200
Message-ID: <20170609062216.26807-8-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Danny Milosavljevic <dannym@scratchpost.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index b1da14d1..d453af65 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1576,6 +1576,8 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.controls = sun4i_codec_extra_controls,
+	.num_controls = ARRAY_SIZE(sun4i_codec_extra_controls),
 };
 
 static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
@@ -1595,6 +1597,8 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.controls = sun7i_codec_extra_controls,
+	.num_controls = ARRAY_SIZE(sun7i_codec_extra_controls),
 };
 
 static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
