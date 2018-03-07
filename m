From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add support for
	Bay Trail CR / SSP0 using boards" to the asoc tree
Date: Wed, 07 Mar 2018 14:21:56 +0000
Message-ID: <E1etZx6-0002ia-Na@debutante>
References: <20180304143610.21125-20-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B3E2673CF
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:02 +0100 (CET)
In-Reply-To: <20180304143610.21125-20-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Add support for Bay Trail CR / SSP0 using boards

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

>From 8a880a2014e3ab50e66252335bd71d61b0487a30 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:07 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add support for Bay Trail CR /
 SSP0 using boards

Despite its name being prefixed with bytcr, before this commit the
bytcr_rt5651 machine driver could not work with Bay Trail CR boards,
as those only have SSP0 and it only supported SSP0-AIF1 setups.

This commit adds support for this, autodetecting AIF1 vs AIF2 based on
BIOS tables.

While at it also add support for SSP2-AIF2 setups, as that requires only
minimal extra code on top of the code adding SSP0-AIF1 / SSP0-AIF2 support.

Note this code is all copy-pasted from bytcr_rt5640.c. I've looked into
merging the 2 machine drivers into 1 to avoid copy-pasting, but there are
enough subtile differences to make this hard *and* with all the quirks the
machine driver already is full with if (variant-foo) then ... else ...
constructs adding more of these is going to make the code unreadable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 217 +++++++++++++++++++++++++++++++---
 1 file changed, 201 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b798ebb18bf1..103c4b0e6505 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <asm/cpu_device_id.h>
 #include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -72,6 +73,9 @@ enum {
 #define BYT_RT5651_DMIC_EN		BIT(16)
 #define BYT_RT5651_MCLK_EN		BIT(17)
 #define BYT_RT5651_MCLK_25MHZ		BIT(18)
+#define BYT_RT5651_SSP2_AIF2		BIT(19) /* default is using AIF1  */
+#define BYT_RT5651_SSP0_AIF1		BIT(20)
+#define BYT_RT5651_SSP0_AIF2		BIT(21)
 
 /* jack-detect-source + dmic-en + ovcd-th + -sf + terminating empty entry */
 #define MAX_NO_PROPS 5
@@ -81,8 +85,7 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
-static unsigned long byt_rt5651_quirk = BYT_RT5651_DMIC_MAP |
-					BYT_RT5651_MCLK_EN;
+static unsigned long byt_rt5651_quirk = BYT_RT5651_MCLK_EN;
 
 static void log_quirks(struct device *dev)
 {
@@ -110,9 +113,16 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk MCLK_EN enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_25MHZ)
 		dev_info(dev, "quirk MCLK_25MHZ enabled");
+	if (byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2)
+		dev_info(dev, "quirk SSP2_AIF2 enabled\n");
+	if (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1)
+		dev_info(dev, "quirk SSP0_AIF1 enabled\n");
+	if (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)
+		dev_info(dev, "quirk SSP0_AIF2 enabled\n");
 }
 
 #define BYT_CODEC_DAI1	"rt5651-aif1"
+#define BYT_CODEC_DAI2	"rt5651-aif2"
 
 static int byt_rt5651_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
 					      int rate, int bclk_ratio)
@@ -156,6 +166,8 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	int ret;
 
 	codec_dai = snd_soc_card_get_codec_dai(card, BYT_CODEC_DAI1);
+	if (!codec_dai)
+		codec_dai = snd_soc_card_get_codec_dai(card, BYT_CODEC_DAI2);
 	if (!codec_dai) {
 		dev_err(card->dev,
 			"Codec dai not found; Unable to set platform clock\n");
@@ -213,13 +225,6 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Speaker", NULL, "Platform Clock"},
 	{"Line In", NULL, "Platform Clock"},
 
-	{"AIF1 Playback", NULL, "ssp2 Tx"},
-	{"ssp2 Tx", NULL, "codec_out0"},
-	{"ssp2 Tx", NULL, "codec_out1"},
-	{"codec_in0", NULL, "ssp2 Rx"},
-	{"codec_in1", NULL, "ssp2 Rx"},
-	{"ssp2 Rx", NULL, "AIF1 Capture"},
-
 	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5651 */
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
@@ -267,6 +272,42 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_hs_in3_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_ssp0_aif1_map[] = {
+	{"ssp0 Tx", NULL, "modem_out"},
+	{"modem_in", NULL, "ssp0 Rx"},
+
+	{"AIF1 Playback", NULL, "ssp0 Tx"},
+	{"ssp0 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5651_ssp0_aif2_map[] = {
+	{"ssp0 Tx", NULL, "modem_out"},
+	{"modem_in", NULL, "ssp0 Rx"},
+
+	{"AIF2 Playback", NULL, "ssp0 Tx"},
+	{"ssp0 Rx", NULL, "AIF2 Capture"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5651_ssp2_aif1_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5651_ssp2_aif2_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"AIF2 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Rx", NULL, "AIF2 Capture"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -291,9 +332,16 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	snd_pcm_format_t format = params_format(params);
 	int rate = params_rate(params);
+	int bclk_ratio;
 
-	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, 50);
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		bclk_ratio = 32;
+	else
+		bclk_ratio = 50;
+
+	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, bclk_ratio);
 }
 
 static int byt_rt5651_quirk_cb(const struct dmi_system_id *id)
@@ -420,6 +468,26 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5651_ssp2_aif2_map,
+					ARRAY_SIZE(byt_rt5651_ssp2_aif2_map));
+	} else if (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5651_ssp0_aif1_map,
+					ARRAY_SIZE(byt_rt5651_ssp0_aif1_map));
+	} else if (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5651_ssp0_aif2_map,
+					ARRAY_SIZE(byt_rt5651_ssp0_aif2_map));
+	} else {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5651_ssp2_aif1_map,
+					ARRAY_SIZE(byt_rt5651_ssp2_aif1_map));
+	}
+	if (ret)
+		return ret;
+
 	ret = snd_soc_add_card_controls(card, byt_rt5651_controls,
 					ARRAY_SIZE(byt_rt5651_controls));
 	if (ret) {
@@ -485,18 +553,26 @@ static int byt_rt5651_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	int ret;
+	int ret, bits;
 
-	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	/* The DSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
-	/* set SSP2 to 24-bit */
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+	if ((byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) ||
+	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
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
-	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+	 * with explicit setting to I2S 2ch. The word length is set with
 	 * dai_set_tdm_slot() since there is no other API exposed
 	 */
 	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
@@ -510,7 +586,7 @@ static int byt_rt5651_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		return ret;
 	}
 
-	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, bits);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
 		return ret;
@@ -605,12 +681,32 @@ static struct snd_soc_card byt_rt5651_card = {
 };
 
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
+static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
+static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+
+static bool is_valleyview(void)
+{
+	static const struct x86_cpu_id cpu_ids[] = {
+		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+		{}
+	};
+
+	if (!x86_match_cpu(cpu_ids))
+		return false;
+	return true;
+}
+
+struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
+	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
+	u64 mclock_value;    /* usually 25MHz (0x17d7940), ignored */
+};
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
+	bool is_bytcr = false;
 	int ret_val = 0;
 	int dai_index = 0;
 	int i;
@@ -643,6 +739,73 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		"%s%s", "i2c-", i2c_name);
 	byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
 
+	/*
+	 * swap SSP0 if bytcr is detected
+	 * (will be overridden if DMI quirk is detected)
+	 */
+	if (is_valleyview()) {
+		struct sst_platform_info *p_info = mach->pdata;
+		const struct sst_res_info *res_info = p_info->res_info;
+
+		if (res_info->acpi_ipc_irq_index == 0)
+			is_bytcr = true;
+	}
+
+	if (is_bytcr) {
+		/*
+		 * Baytrail CR platforms may have CHAN package in BIOS, try
+		 * to find relevant routing quirk based as done on Windows
+		 * platforms. We have to read the information directly from the
+		 * BIOS, at this stage the card is not created and the links
+		 * with the codec driver/pdata are non-existent
+		 */
+
+		struct acpi_chan_package chan_package;
+
+		/* format specified: 2 64-bit integers */
+		struct acpi_buffer format = {sizeof("NN"), "NN"};
+		struct acpi_buffer state = {0, NULL};
+		struct snd_soc_acpi_package_context pkg_ctx;
+		bool pkg_found = false;
+
+		state.length = sizeof(chan_package);
+		state.pointer = &chan_package;
+
+		pkg_ctx.name = "CHAN";
+		pkg_ctx.length = 2;
+		pkg_ctx.format = &format;
+		pkg_ctx.state = &state;
+		pkg_ctx.data_valid = false;
+
+		pkg_found = snd_soc_acpi_find_package_from_hid(mach->id,
+							       &pkg_ctx);
+		if (pkg_found) {
+			if (chan_package.aif_value == 1) {
+				dev_info(&pdev->dev, "BIOS Routing: AIF1 connected\n");
+				byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF1;
+			} else  if (chan_package.aif_value == 2) {
+				dev_info(&pdev->dev, "BIOS Routing: AIF2 connected\n");
+				byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF2;
+			} else {
+				dev_info(&pdev->dev, "BIOS Routing isn't valid, ignored\n");
+				pkg_found = false;
+			}
+		}
+
+		if (!pkg_found) {
+			/* no BIOS indications, assume SSP0-AIF2 connection */
+			byt_rt5651_quirk |= BYT_RT5651_SSP0_AIF2;
+		}
+
+		/* change defaults for Baytrail-CR capture */
+		byt_rt5651_quirk |= BYT_RT5651_JD1_1 |
+				    BYT_RT5651_OVCD_TH_2000UA |
+				    BYT_RT5651_OVCD_SF_0P75 |
+				    BYT_RT5651_IN2_HS_IN3_MAP;
+	} else {
+		byt_rt5651_quirk |= BYT_RT5651_DMIC_MAP;
+	}
+
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
 
@@ -653,6 +816,28 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	log_quirks(&pdev->dev);
 
+	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
+	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
+		/* fixup codec aif name */
+		snprintf(byt_rt5651_codec_aif_name,
+			sizeof(byt_rt5651_codec_aif_name),
+			"%s", "rt5651-aif2");
+
+		byt_rt5651_dais[dai_index].codec_dai_name =
+			byt_rt5651_codec_aif_name;
+	}
+
+	if ((byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) ||
+	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
+		/* fixup cpu dai name name */
+		snprintf(byt_rt5651_cpu_dai_name,
+			sizeof(byt_rt5651_cpu_dai_name),
+			"%s", "ssp0-port");
+
+		byt_rt5651_dais[dai_index].cpu_dai_name =
+			byt_rt5651_cpu_dai_name;
+	}
+
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
-- 
2.16.2
