From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/10] ASoC: Intel: bytcht_es8316: Add support
	for SSP0 (BYTCR)
Date: Thu,  3 Jan 2019 14:45:30 +0100
Message-ID: <20190103134535.13861-6-hdegoede@redhat.com>
References: <20190103134535.13861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D09267BBA
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:45:48 +0100 (CET)
In-Reply-To: <20190103134535.13861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add support for having the codec connected to SSP0 instead of SSP2. This
is controlled through a new quirk parameter, similar to how this is done
in the bytcr_rt5640 and bytcr_rt5651 machine drivers.

Bay Trail CR (cost reduced) SoCs do not have an SSP2, so we default to SSP0
there.

Note the SPP0 quirk gets BIT(16) because bits 0-15 are reserved for non
boolean quirks like the input-map added in a later commit in this series.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 76 ++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index e29f00560b00..3358d82499a3 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -37,6 +39,20 @@ struct byt_cht_es8316_private {
 	struct clk *mclk;
 };
 
+#define BYT_CHT_ES8316_SSP0			BIT(16)
+
+static int quirk;
+
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, int, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
+
+static void log_quirks(struct device *dev)
+{
+	if (quirk & BYT_CHT_ES8316_SSP0)
+		dev_info(dev, "quirk SSP0 enabled");
+}
+
 static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
@@ -55,7 +71,16 @@ static const struct snd_soc_dapm_route byt_cht_es8316_audio_map[] = {
 
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
+};
+
+static const struct snd_soc_dapm_route byt_cht_es8316_ssp0_map[] = {
+	{"Playback", NULL, "ssp0 Tx"},
+	{"ssp0 Tx", NULL, "modem_out"},
+	{"modem_in", NULL, "ssp0 Rx"},
+	{"ssp0 Rx", NULL, "Capture"},
+};
 
+static const struct snd_soc_dapm_route byt_cht_es8316_ssp2_map[] = {
 	{"Playback", NULL, "ssp2 Tx"},
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
@@ -74,10 +99,23 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
+	const struct snd_soc_dapm_route *custom_map;
+	int num_routes;
 	int ret;
 
 	card->dapm.idle_bias_off = true;
 
+	if (quirk & BYT_CHT_ES8316_SSP0) {
+		custom_map = byt_cht_es8316_ssp0_map;
+		num_routes = ARRAY_SIZE(byt_cht_es8316_ssp0_map);
+	} else {
+		custom_map = byt_cht_es8316_ssp2_map;
+		num_routes = ARRAY_SIZE(byt_cht_es8316_ssp2_map);
+	}
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
+
 	/*
 	 * The firmware might enable the clock at boot (this information
 	 * may or may not be reflected in the enable clock register).
@@ -123,14 +161,21 @@ static int byt_cht_es8316_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	int ret;
+	int ret, bits;
 
 	/* The DSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
-	/* set SSP2 to 24-bit */
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+	if (quirk & BYT_CHT_ES8316_SSP0) {
+		/* set SSP0 to 16-bit */
+		params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
+		bits = 16;
+	} else {
+		/* set SSP2 to 24-bit */
+		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+		bits = 24;
+	}
 
 	/*
 	 * Default mode for SSP configuration is TDM 4 slot, override config
@@ -147,7 +192,7 @@ static int byt_cht_es8316_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, bits);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
 		return ret;
@@ -232,6 +277,11 @@ static struct snd_soc_card byt_cht_es8316_card = {
 	.fully_routed = true,
 };
 
+static const struct x86_cpu_id baytrail_cpu_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT }, /* Valleyview */
+	{}
+};
+
 static char codec_name[SND_ACPI_I2C_ID_LEN];
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
@@ -266,6 +316,24 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		byt_cht_es8316_dais[dai_index].codec_name = codec_name;
 	}
 
+	/* Check for BYTCR or other platform and setup quirks */
+	if (x86_match_cpu(baytrail_cpu_ids) &&
+	    mach->mach_params.acpi_ipc_irq_index == 0) {
+		/* On BYTCR default to SSP0 */
+		quirk = BYT_CHT_ES8316_SSP0;
+	} else {
+		quirk = 0;
+	}
+	if (quirk_override != -1) {
+		dev_info(dev, "Overriding quirk 0x%x => 0x%x\n", quirk,
+			 quirk_override);
+		quirk = quirk_override;
+	}
+	log_quirks(dev);
+
+	if (quirk & BYT_CHT_ES8316_SSP0)
+		byt_cht_es8316_dais[dai_index].cpu_dai_name = "ssp0-port";
+
 	/* get the clock */
 	priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
 	if (IS_ERR(priv->mclk)) {
-- 
2.20.1
