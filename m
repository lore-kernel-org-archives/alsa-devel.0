From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v8 1/3] ASoC: da7210: Add support for DAPM
Date: Fri, 21 Oct 2011 18:16:08 +0530
Message-ID: <1319201168.24621.210.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E47A1039A5
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 14:35:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for DAPM covering all inputs and outputs
as well as ADC and DAC.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v7:
- Re-factored the patch to only include DAPM for existing IOs.
(i.e. removed DAPM support for AUX, line outs etc.  This will be
added via other patches which add actual support for those IOs)

Changes since v3:
- Added missing routes for In-mixer left and right
- Added comment explaining rational behind use of STANDBY registers

Changes since v1:
- used supply widget for mic bias
- removed mic bias hookup
- assigned dapm widgets and routes in card struct
- removed explicit setting of default mixer settings
- removed explicit setting of ios to standby mode
---
 sound/soc/codecs/da7210.c |  145 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index e9ee6a4..7a4b952 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -29,6 +29,8 @@
 #define DA7210_CONTROL			0x01
 #define DA7210_STATUS			0x02
 #define DA7210_STARTUP1			0x03
+#define DA7210_STARTUP2			0x04
+#define DA7210_STARTUP3			0x05
 #define DA7210_MIC_L			0x07
 #define DA7210_MIC_R			0x08
 #define DA7210_AUX1_L			0x09
@@ -372,6 +374,120 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 		       0, snd_soc_get_volsw, da7210_put_noise_sup_sw),
 };
 
+/*
+ * DAPM Controls
+ *
+ * Current DAPM implementation covers almost all codec components e.g. IOs,
+ * mixers, PGAs,ADC and DAC.
+ */
+/* In Mixer Left */
+static const struct snd_kcontrol_new da7210_dapm_inmixl_controls[] = {
+	SOC_DAPM_SINGLE("Mic Left Switch", DA7210_INMIX_L, 0, 1, 0),
+	SOC_DAPM_SINGLE("Mic Right Switch", DA7210_INMIX_L, 1, 1, 0),
+};
+
+/* In Mixer Right */
+static const struct snd_kcontrol_new da7210_dapm_inmixr_controls[] = {
+	SOC_DAPM_SINGLE("Mic Right Switch", DA7210_INMIX_R, 0, 1, 0),
+	SOC_DAPM_SINGLE("Mic Left Switch", DA7210_INMIX_R, 1, 1, 0),
+};
+
+/* Out Mixer Left */
+static const struct snd_kcontrol_new da7210_dapm_outmixl_controls[] = {
+	SOC_DAPM_SINGLE("DAC Left Switch", DA7210_OUTMIX_L, 4, 1, 0),
+};
+
+/* Out Mixer Right */
+static const struct snd_kcontrol_new da7210_dapm_outmixr_controls[] = {
+	SOC_DAPM_SINGLE("DAC Right Switch", DA7210_OUTMIX_R, 4, 1, 0),
+};
+
+/* DAPM widgets */
+static const struct snd_soc_dapm_widget da7210_dapm_widgets[] = {
+	/* Input Side */
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("MICL"),
+	SND_SOC_DAPM_INPUT("MICR"),
+
+	/* Input PGAs */
+	SND_SOC_DAPM_PGA("Mic Left", DA7210_STARTUP3, 0, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Mic Right", DA7210_STARTUP3, 1, 1, NULL, 0),
+
+	SND_SOC_DAPM_PGA("INPGA Left", DA7210_INMIX_L, 7, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("INPGA Right", DA7210_INMIX_R, 7, 0, NULL, 0),
+
+	/* Input Mixers */
+	SND_SOC_DAPM_MIXER("In Mixer Left", SND_SOC_NOPM, 0, 0,
+		&da7210_dapm_inmixl_controls[0],
+		ARRAY_SIZE(da7210_dapm_inmixl_controls)),
+
+	SND_SOC_DAPM_MIXER("In Mixer Right", SND_SOC_NOPM, 0, 0,
+		&da7210_dapm_inmixr_controls[0],
+		ARRAY_SIZE(da7210_dapm_inmixr_controls)),
+
+	/* ADCs */
+	SND_SOC_DAPM_ADC("ADC Left", "Capture", DA7210_STARTUP3, 5, 1),
+	SND_SOC_DAPM_ADC("ADC Right", "Capture", DA7210_STARTUP3, 6, 1),
+
+	/* Output Side */
+	/* DACs */
+	SND_SOC_DAPM_DAC("DAC Left", "Playback", DA7210_STARTUP2, 5, 1),
+	SND_SOC_DAPM_DAC("DAC Right", "Playback", DA7210_STARTUP2, 6, 1),
+
+	/* Output Mixers */
+	SND_SOC_DAPM_MIXER("Out Mixer Left", SND_SOC_NOPM, 0, 0,
+		&da7210_dapm_outmixl_controls[0],
+		ARRAY_SIZE(da7210_dapm_outmixl_controls)),
+
+	SND_SOC_DAPM_MIXER("Out Mixer Right", SND_SOC_NOPM, 0, 0,
+		&da7210_dapm_outmixr_controls[0],
+		ARRAY_SIZE(da7210_dapm_outmixr_controls)),
+
+	/* Output PGAs */
+	SND_SOC_DAPM_PGA("OUTPGA Left Enable", DA7210_OUTMIX_L, 7, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUTPGA Right Enable", DA7210_OUTMIX_R, 7, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Headphone Left", DA7210_STARTUP2, 3, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Headphone Right", DA7210_STARTUP2, 4, 1, NULL, 0),
+
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+};
+
+/* DAPM audio route definition */
+static const struct snd_soc_dapm_route da7210_audio_map[] = {
+	/* Dest       Connecting Widget    source */
+	/* Input path */
+	{"Mic Left", NULL, "MICL"},
+	{"Mic Right", NULL, "MICR"},
+
+	{"In Mixer Left", "Mic Left Switch", "Mic Left"},
+	{"In Mixer Left", "Mic Right Switch", "Mic Right"},
+
+	{"In Mixer Right", "Mic Right Switch", "Mic Right"},
+	{"In Mixer Right", "Mic Left Switch", "Mic Left"},
+
+	{"INPGA Left", NULL, "In Mixer Left"},
+	{"ADC Left", NULL, "INPGA Left"},
+
+	{"INPGA Right", NULL, "In Mixer Right"},
+	{"ADC Right", NULL, "INPGA Right"},
+
+	/* Output path */
+	{"Out Mixer Left", "DAC Left Switch", "DAC Left"},
+	{"Out Mixer Right", "DAC Right Switch", "DAC Right"},
+
+	{"OUTPGA Left Enable", NULL, "Out Mixer Left"},
+	{"OUTPGA Right Enable", NULL, "Out Mixer Right"},
+
+	{"Headphone Left", NULL, "OUTPGA Left Enable"},
+	{"HPL", NULL, "Headphone Left"},
+
+	{"Headphone Right", NULL, "OUTPGA Right Enable"},
+	{"HPR", NULL, "Headphone Right"},
+};
+
 /* Codec private data */
 struct da7210_priv {
 	enum snd_soc_control_type control_type;
@@ -411,29 +527,6 @@ static int da7210_volatile_register(struct snd_soc_codec *codec,
 		return 0;
 	}
 }
-static int da7210_startup(struct snd_pcm_substream *substream,
-			  struct snd_soc_dai *dai)
-{
-	int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	struct snd_soc_codec *codec = dai->codec;
-
-	if (is_play) {
-		/* Enable Out */
-		snd_soc_update_bits(codec, DA7210_OUTMIX_L, 0x1F, 0x10);
-		snd_soc_update_bits(codec, DA7210_OUTMIX_R, 0x1F, 0x10);
-
-	} else {
-		/* Volume 7 */
-		snd_soc_update_bits(codec, DA7210_MIC_L, 0x7, 0x7);
-		snd_soc_update_bits(codec, DA7210_MIC_R, 0x7, 0x7);
-
-		/* Enable Mic */
-		snd_soc_update_bits(codec, DA7210_INMIX_L, 0x1F, 0x1);
-		snd_soc_update_bits(codec, DA7210_INMIX_R, 0x1F, 0x1);
-	}
-
-	return 0;
-}
 
 /*
  * Set PCM DAI word length.
@@ -603,7 +696,6 @@ static int da7210_mute(struct snd_soc_dai *dai, int mute)
 
 /* DAI operations */
 static struct snd_soc_dai_ops da7210_dai_ops = {
-	.startup	= da7210_startup,
 	.hw_params	= da7210_hw_params,
 	.set_fmt	= da7210_set_dai_fmt,
 	.digital_mute	= da7210_mute,
@@ -742,6 +834,11 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 
 	.controls		= da7210_snd_controls,
 	.num_controls		= ARRAY_SIZE(da7210_snd_controls),
+
+	.dapm_widgets		= da7210_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(da7210_dapm_widgets),
+	.dapm_routes		= da7210_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.1
