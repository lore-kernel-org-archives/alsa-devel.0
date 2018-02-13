From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3] ASoC: tlv320aic31xx: Fix master mode clock
	I2S bus clocks
Date: Tue, 13 Feb 2018 13:28:01 +0200
Message-ID: <20180213112801.32698-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id B1A97266C0E
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 12:27:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, afd@ti.com
List-Id: alsa-devel@alsa-project.org

In the reset state of the codec we do not have complete playback or capture
routes.

The audio playback/capture will not work due to missing clock signals on
the I2S bus if PLL, MDAC/NDAC/DAC MADC/NADC/ADC is powered down.

To make sure that even if all output/input is disconnected the codec is
generating clocks, we need to have valid DAPM route in every case to power
up the must needed parts of the codec.

I have verified that switching DAC (during playback) or ADC (during
capture) will stop the I2S clocks, so the only solution is to connect the
'Off' routes as well to output/input.

The routes only going to be added if the codec is configured as clock
master.

Tested on am43x-epos-evm with aic3111 codec in master mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v2:
- Leftover debug prints removed.

Changes since v1:
- Only apply the master mode DAPM routes when the codec is clock master
- comments added to explain the need.

Regards,
Peter

 sound/soc/codecs/tlv320aic31xx.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 858cb8be445f..088648791111 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -166,6 +166,7 @@ struct aic31xx_priv {
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
+	bool master_dapm_route_applied;
 };
 
 struct aic31xx_rate_divs {
@@ -670,6 +671,29 @@ aic310x_audio_map[] = {
 	{"SPK", NULL, "SPK ClassD"},
 };
 
+/*
+ * Always connected DAPM routes for codec clock master modes.
+ * If the codec is the master on the I2S bus, we need to power on components
+ * to have valid DAC_CLK and also the DACs and ADC for playback/capture.
+ * Otherwise the codec will not generate clocks on the bus.
+ */
+static const struct snd_soc_dapm_route
+common31xx_cm_audio_map[] = {
+	{"DAC Left Input", "Off", "DAC IN"},
+	{"DAC Right Input", "Off", "DAC IN"},
+
+	{"HPL", NULL, "DAC Left"},
+	{"HPR", NULL, "DAC Right"},
+};
+
+static const struct snd_soc_dapm_route
+aic31xx_cm_audio_map[] = {
+	{"MIC1LP P-Terminal", "Off", "MIC1LP"},
+	{"MIC1RP P-Terminal", "Off", "MIC1RP"},
+	{"MIC1LM P-Terminal", "Off", "MIC1LM"},
+	{"MIC1LM M-Terminal", "Off", "MIC1LM"},
+};
+
 static int aic31xx_add_controls(struct snd_soc_codec *codec)
 {
 	int ret = 0;
@@ -916,6 +940,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			       unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	u8 iface_reg1 = 0;
 	u8 iface_reg2 = 0;
 	u8 dsp_a_val = 0;
@@ -992,6 +1017,25 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			    AIC31XX_BCLKINV_MASK,
 			    iface_reg2);
 
+	/* Add the needed DAPM route(s) for codec clock master modes, once */
+	if (iface_reg1 & (AIC31XX_BCLK_MASTER | AIC31XX_WCLK_MASTER) &&
+	    !aic31xx->master_dapm_route_applied) {
+		struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+		int ret;
+
+		ret = snd_soc_dapm_add_routes(dapm, common31xx_cm_audio_map,
+					ARRAY_SIZE(common31xx_cm_audio_map));
+		if (!ret && !(aic31xx->codec_type & DAC31XX_BIT))
+			ret = snd_soc_dapm_add_routes(dapm,
+					aic31xx_cm_audio_map,
+					ARRAY_SIZE(aic31xx_cm_audio_map));
+
+		if (ret)
+			return ret;
+
+		aic31xx->master_dapm_route_applied = true;
+	}
+
 	return 0;
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
