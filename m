From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Fix master mode clock
	I2S bus clocks" to the asoc tree
Date: Wed, 14 Feb 2018 13:28:52 +0000
Message-ID: <E1elx7E-0006jR-RR@debutante>
References: <20180214122056.5809-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FAC42677DA
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:28:56 +0100 (CET)
In-Reply-To: <20180214122056.5809-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, afd@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Fix master mode clock I2S bus clocks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d460b3f861e18b9c826abe178b2db57c6dc6b3e4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 14 Feb 2018 14:20:56 +0200
Subject: [PATCH] ASoC: tlv320aic31xx: Fix master mode clock I2S bus clocks

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

The routes will be only added if the codec is clock master. In case the
role changes runtime, the applied routes are removed.

Tested on am43x-epos-evm with aic3111 codec in master mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 73 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d3cd924dc300..7090342e8285 100644
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
 static int aic31xx_add_controls(struct snd_soc_component *component)
 {
 	int ret = 0;
@@ -912,6 +936,53 @@ static int aic31xx_dac_mute(struct snd_soc_dai *codec_dai, int mute)
 	return 0;
 }
 
+static int aic31xx_clock_master_routes(struct snd_soc_component *component,
+				       unsigned int fmt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	fmt &= SND_SOC_DAIFMT_MASTER_MASK;
+	if (fmt == SND_SOC_DAIFMT_CBS_CFS &&
+	    aic31xx->master_dapm_route_applied) {
+		/*
+		 * Remove the DAPM route(s) for codec clock master modes,
+		 * if applied
+		 */
+		ret = snd_soc_dapm_del_routes(dapm, common31xx_cm_audio_map,
+					ARRAY_SIZE(common31xx_cm_audio_map));
+		if (!ret && !(aic31xx->codec_type & DAC31XX_BIT))
+			ret = snd_soc_dapm_del_routes(dapm,
+					aic31xx_cm_audio_map,
+					ARRAY_SIZE(aic31xx_cm_audio_map));
+
+		if (ret)
+			return ret;
+
+		aic31xx->master_dapm_route_applied = false;
+	} else if (fmt != SND_SOC_DAIFMT_CBS_CFS &&
+		   !aic31xx->master_dapm_route_applied) {
+		/*
+		 * Add the needed DAPM route(s) for codec clock master modes,
+		 * if it is not done already
+		 */
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
+	return 0;
+}
+
 static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			       unsigned int fmt)
 {
@@ -992,7 +1063,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			    AIC31XX_BCLKINV_MASK,
 			    iface_reg2);
 
-	return 0;
+	return aic31xx_clock_master_routes(component, fmt);
 }
 
 static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-- 
2.16.1
