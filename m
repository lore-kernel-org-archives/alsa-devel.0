From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] [v2] ASoC: Intel: boards: Add Cometlake
 machine driver support
Date: Thu, 15 Aug 2019 08:46:50 -0500
Message-ID: <d076be46-1327-1c4c-5fba-8c01c272d4cb@linux.intel.com>
References: <1565851909-13825-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2032F8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 16:13:42 +0200 (CEST)
In-Reply-To: <1565851909-13825-1-git-send-email-mac.chiang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
Cc: sathya.prakash.m.r@intel.com, broonie@kernel.org, ranjani.sridharan@intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org



On 8/15/19 1:51 AM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
> 
> reuse and add Cometlake support with:
> SSP0 for DA7219 headphone codec
> SSP1 for MAX98357a speaker amp codec
> 
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

Thank you, this looks good and much simpler than the previous versions.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> Changelog:
>    v2:
>      - included GENERIC config on APL/KBL platforms as well
>      - reuse the same pcm_id and dai_id, modify in tplg support
>      - replace with soc_intel_is_cml() instead
> ---
> ---
>   sound/soc/intel/boards/Kconfig                    | 27 ++++++++++++++------
>   sound/soc/intel/boards/bxt_da7219_max98357a.c     | 31 ++++++++++++++++++++++-
>   sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 12 +++++++++
>   sound/soc/intel/common/soc-intel-quirks.h         |  5 ++++
>   4 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 50bf149..f3d88c87 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -256,16 +256,20 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
>   
>   endif ## SND_SOC_INTEL_SKL
>   
> +config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
> +	tristate
> +	select SND_SOC_DA7219
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDAC_HDMI
> +
>   if SND_SOC_INTEL_APL
>   
>   config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>   	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
>   	depends on I2C && ACPI
>   	depends on MFD_INTEL_LPSS || COMPILE_TEST
> -	select SND_SOC_DA7219
> -	select SND_SOC_MAX98357A
> -	select SND_SOC_DMIC
> -	select SND_SOC_HDAC_HDMI
> +	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
>   	select SND_HDA_DSP_LOADER
>   	help
>   	   This adds support for ASoC machine driver for Broxton-P platforms
> @@ -326,10 +330,7 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
>   	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
>   	depends on I2C && ACPI
>   	depends on MFD_INTEL_LPSS || COMPILE_TEST
> -	select SND_SOC_DA7219
> -	select SND_SOC_MAX98357A
> -	select SND_SOC_DMIC
> -	select SND_SOC_HDAC_HDMI
> +	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
>   	help
>   	  This adds support for ASoC Onboard Codec I2S machine driver. This will
>   	  create an alsa sound card for DA7219 + MAX98357A I2S audio codec.
> @@ -412,4 +413,14 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
>   	   If unsure select "N".
>   endif ## SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
>   
> +if (SND_SOC_SOF_COMETLAKE_LP && SND_SOC_SOF_HDA_LINK)
> +
> +config SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH
> +	tristate "CML_LP with DA7219 and MAX98357A in I2S Mode"
> +	depends on I2C && ACPI
> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
> +	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
> +
> +endif ## SND_SOC_SOF_COMETLAKE_LP && SND_SOC_SOF_HDA_LINK
> +
>   endif ## SND_SOC_INTEL_MACH
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index c0d865a..ac1dea5 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -179,10 +179,17 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   	int ret;
>   	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>   	struct snd_soc_component *component = rtd->codec_dai->component;
> +	int clk_freq;
>   
>   	/* Configure sysclk for codec */
> -	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 19200000,
> +	if (soc_intel_is_cml())
> +		clk_freq = 24000000;
> +	else
> +		clk_freq = 19200000;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, clk_freq,
>   				     SND_SOC_CLOCK_IN);
> +
>   	if (ret) {
>   		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
>   		return ret;
> @@ -683,6 +690,25 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   				broxton_dais[i].cpus->dai_name = "SSP2 Pin";
>   			}
>   		}
> +	} else if (soc_intel_is_cml()) {
> +		unsigned int i;
> +
> +		broxton_audio_card.name = "cmlda7219max";
> +
> +		for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
> +			/* MAXIM_CODEC is connected to SSP1. */
> +			if (!strcmp(broxton_dais[i].codecs->dai_name,
> +					BXT_MAXIM_CODEC_DAI)) {
> +				broxton_dais[i].name = "SSP1-Codec";
> +				broxton_dais[i].cpus->dai_name = "SSP1 Pin";
> +			}
> +			/* DIALOG_CODEC is connected to SSP0 */
> +			else if (!strcmp(broxton_dais[i].codecs->dai_name,
> +					BXT_DIALOG_CODEC_DAI)) {
> +				broxton_dais[i].name = "SSP0-Codec";
> +				broxton_dais[i].cpus->dai_name = "SSP0 Pin";
> +			}
> +		}
>   	}
>   
>   	/* override plaform name, if required */
> @@ -700,6 +726,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   static const struct platform_device_id bxt_board_ids[] = {
>   	{ .name = "bxt_da7219_max98357a" },
>   	{ .name = "glk_da7219_max98357a" },
> +	{ .name = "cml_da7219_max98357a" },
>   	{ }
>   };
>   
> @@ -720,6 +747,8 @@ MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
>   MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
>   MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
>   MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
> +MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:bxt_da7219_max98357a");
>   MODULE_ALIAS("platform:glk_da7219_max98357a");
> +MODULE_ALIAS("platform:cml_da7219_max98357a");
> diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> index c36c0aa..4ea32b2 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> @@ -19,6 +19,11 @@ static struct snd_soc_acpi_codecs cml_codecs = {
>   	.codecs = {"10EC5682"}
>   };
>   
> +static struct snd_soc_acpi_codecs cml_spk_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98357A"}
> +};
> +
>   struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
>   	{
>   		.id = "INT34C2",
> @@ -29,6 +34,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
>   		.sof_tplg_filename = "sof-cnl-rt274.tplg",
>   	},
>   	{
> +		.id = "DLGS7219",
> +		.drv_name = "cml_da7219_max98357a",
> +		.quirk_data = &cml_spk_codecs,
> +		.sof_fw_filename = "sof-cnl.ri",
> +		.sof_tplg_filename = "sof-cml-da7219-max98357a.tplg",
> +	},
> +	{
>   		.id = "MX98357A",
>   		.drv_name = "sof_rt5682",
>   		.quirk_data = &cml_codecs,
> diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
> index 4718fd3..e6357d3 100644
> --- a/sound/soc/intel/common/soc-intel-quirks.h
> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> @@ -36,6 +36,7 @@ SOC_INTEL_IS_CPU(byt, INTEL_FAM6_ATOM_SILVERMONT);
>   SOC_INTEL_IS_CPU(cht, INTEL_FAM6_ATOM_AIRMONT);
>   SOC_INTEL_IS_CPU(apl, INTEL_FAM6_ATOM_GOLDMONT);
>   SOC_INTEL_IS_CPU(glk, INTEL_FAM6_ATOM_GOLDMONT_PLUS);
> +SOC_INTEL_IS_CPU(cml, INTEL_FAM6_KABYLAKE_MOBILE);
>   
>   static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
>   {
> @@ -110,6 +111,10 @@ static inline bool soc_intel_is_glk(void)
>   	return false;
>   }
>   
> +static inline bool soc_intel_is_cml(void)
> +{
> +	return false;
> +}
>   #endif
>   
>    #endif /* _SND_SOC_INTEL_QUIRKS_H */
> 
