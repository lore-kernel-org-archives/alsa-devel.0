From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Do not force power on
	the DAC/ADC in clock master mode" to the asoc tree
Date: Mon, 19 Feb 2018 12:18:26 +0000
Message-ID: <E1enkOo-0002ko-4K@debutante>
References: <20180219094508.26662-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0229433784841117872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EF453266EBE
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:18:28 +0100 (CET)
In-Reply-To: <20180219094508.26662-3-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, s.mueller-klieser@phytec.de, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, afd@ti.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============0229433784841117872==
Content-Type: text/plain

The patch

   ASoC: tlv320aic31xx: Do not force power on the DAC/ADC in clock master mode

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

>From a16be2a6e2ffa8ad5e24e96289f317e1b5b8c17a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 19 Feb 2018 11:45:08 +0200
Subject: [PATCH] ASoC: tlv320aic31xx: Do not force power on the DAC/ADC in
 clock master mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With P0 R29, Bit2 set the I2S clocks will be running when the DAC/ADC is
powered down, but still the codec need to be powered up by needing at least
one complete DAPM path for the stream.

If the AIF is not needed (analog loopback for example) the I2S clocks will
not run as they are not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Suggested-by: Stefan Müller-Klieser <s.mueller-klieser@phytec.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 32 ++++++++++++++++++++++----------
 sound/soc/codecs/tlv320aic31xx.h |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e5a1e2be17aa..bf92d36b8f8a 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -501,6 +501,10 @@ static const struct snd_soc_dapm_widget common31xx_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("MICBIAS", SND_SOC_NOPM, 0, 0, mic_bias_event,
 			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
+	/* Keep BCLK/WCLK enabled even if DAC/ADC is powered down */
+	SND_SOC_DAPM_SUPPLY("Activate I2S clocks", AIC31XX_IFACE2, 2, 0,
+			    NULL, 0),
+
 	/* Outputs */
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
@@ -553,6 +557,8 @@ static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Output Right", SND_SOC_NOPM, 0, 0,
 			   aic31xx_right_output_switches,
 			   ARRAY_SIZE(aic31xx_right_output_switches)),
+
+	SND_SOC_DAPM_AIF_OUT("AIF OUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_widget aic311x_dapm_widgets[] = {
@@ -640,6 +646,8 @@ aic31xx_audio_map[] = {
 
 	{"ADC", NULL, "MIC_GAIN_CTL"},
 
+	{"AIF OUT", NULL, "ADC"},
+
 	/* Left Output */
 	{"Output Left", "From Left DAC", "DAC Left"},
 	{"Output Left", "From MIC1LP", "MIC1LP"},
@@ -673,25 +681,29 @@ aic310x_audio_map[] = {
 
 /*
  * Always connected DAPM routes for codec clock master modes.
- * If the codec is the master on the I2S bus, we need to power on components
- * to have valid DAC_CLK and also the DACs and ADC for playback/capture.
+ * If the codec is the master on the I2S bus, we need to power up components
+ * to have valid DAC_CLK.
+ *
+ * In order to have the I2S clocks on the bus either the DACs/ADC need to be
+ * enabled, or the P0/R29/D2 (Keep bclk/wclk in power down) need to be set.
+ *
  * Otherwise the codec will not generate clocks on the bus.
  */
 static const struct snd_soc_dapm_route
 common31xx_cm_audio_map[] = {
-	{"DAC Left Input", "Off", "AIF IN"},
-	{"DAC Right Input", "Off", "AIF IN"},
+	{"HPL", NULL, "AIF IN"},
+	{"HPR", NULL, "AIF IN"},
 
-	{"HPL", NULL, "DAC Left"},
-	{"HPR", NULL, "DAC Right"},
+	{"AIF IN", NULL, "Activate I2S clocks"},
 };
 
 static const struct snd_soc_dapm_route
 aic31xx_cm_audio_map[] = {
-	{"MIC1LP P-Terminal", "Off", "MIC1LP"},
-	{"MIC1RP P-Terminal", "Off", "MIC1RP"},
-	{"MIC1LM P-Terminal", "Off", "MIC1LM"},
-	{"MIC1LM M-Terminal", "Off", "MIC1LM"},
+	{"AIF OUT", NULL, "MIC1LP"},
+	{"AIF OUT", NULL, "MIC1RP"},
+	{"AIF OUT", NULL, "MIC1LM"},
+
+	{"AIF OUT", NULL, "Activate I2S clocks"},
 };
 
 static int aic31xx_add_controls(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 15ac7cba86fe..0b587585b38b 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -160,6 +160,7 @@ struct aic31xx_pdata {
 #define AIC31XX_DACMOD2BCLK		0x01
 #define AIC31XX_ADC2BCLK		0x02
 #define AIC31XX_ADCMOD2BCLK		0x03
+#define AIC31XX_KEEP_I2SCLK		BIT(2)
 
 /* AIC31XX_ADCFLAG */
 #define AIC31XX_ADCPWRSTATUS_MASK	BIT(6)
-- 
2.16.1


--===============0229433784841117872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0229433784841117872==--
