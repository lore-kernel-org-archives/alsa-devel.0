From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/5] ASoC: Intel: Add Geminilake Dialog
 Maxim machine driver support
Date: Wed, 4 Apr 2018 10:18:44 -0500
Message-ID: <d0a5ec7f-6460-8eb7-82c2-fb1633dd1bbf@linux.intel.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
 <1522817219-3750-4-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 56B41266DD3
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 17:18:47 +0200 (CEST)
In-Reply-To: <1522817219-3750-4-git-send-email-naveen.m@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On 4/3/18 11:46 PM, Naveen Manohar wrote:
> Patch adds required changes in bxt machine to use MAX98357A codec
> as speaker on SSP1 & DA7219 codec as headset on SSP2 on GLK board.
> 
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> ---
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 283 ++++++++++++++++++++++++--
>   1 file changed, 267 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index 1c1e70c..7725aa1 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -16,6 +16,7 @@
>    * GNU General Public License for more details.
>    */
>   
> +#include <asm/cpu_device_id.h>
>   #include <linux/input.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -33,6 +34,7 @@
>   #define DUAL_CHANNEL		2
>   #define QUAD_CHANNEL		4
>   
> +static struct snd_soc_card *audio_card;
>   static struct snd_soc_jack broxton_headset;
>   static struct snd_soc_jack broxton_hdmi[3];
>   
> @@ -103,7 +105,7 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
>   			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
>   };
>   
> -static const struct snd_soc_dapm_route broxton_map[] = {
> +static const struct snd_soc_dapm_route audio_map[] = {
>   	/* HP jack connectors - unknown if we have jack detection */
>   	{"Headphone Jack", NULL, "HPL"},
>   	{"Headphone Jack", NULL, "HPR"},
> @@ -118,15 +120,6 @@ static const struct snd_soc_dapm_route broxton_map[] = {
>   	{"DMic", NULL, "SoC DMIC"},
>   
>   	/* CODEC BE connections */
> -	{"HiFi Playback", NULL, "ssp5 Tx"},
> -	{"ssp5 Tx", NULL, "codec0_out"},
> -
> -	{"Playback", NULL, "ssp1 Tx"},
> -	{"ssp1 Tx", NULL, "codec1_out"},
> -
> -	{"codec0_in", NULL, "ssp1 Rx"},
> -	{"ssp1 Rx", NULL, "Capture"},
> -
>   	{"HDMI1", NULL, "hif5-0 Output"},
>   	{"HDMI2", NULL, "hif6-0 Output"},
>   	{"HDMI2", NULL, "hif7-0 Output"},
> @@ -146,6 +139,28 @@ static const struct snd_soc_dapm_route broxton_map[] = {
>   	{ "Headset Mic", NULL, "Platform Clock" },
>   };
>   
> +static const struct snd_soc_dapm_route broxton_map[] = {
> +	{"HiFi Playback", NULL, "ssp5 Tx"},
> +	{"ssp5 Tx", NULL, "codec0_out"},
> +
> +	{"Playback", NULL, "ssp1 Tx"},
> +	{"ssp1 Tx", NULL, "codec1_out"},
> +
> +	{"codec0_in", NULL, "ssp1 Rx"},
> +	{"ssp1 Rx", NULL, "Capture"},
> +};
> +
> +static const struct snd_soc_dapm_route gemini_map[] = {
> +	{"HiFi Playback", NULL, "ssp1 Tx"},
> +	{"ssp1 Tx", NULL, "codec0_out"},
> +
> +	{"Playback", NULL, "ssp2 Tx"},
> +	{"ssp2 Tx", NULL, "codec1_out"},
> +
> +	{"codec0_in", NULL, "ssp2 Rx"},
> +	{"ssp2 Rx", NULL, "Capture"},
> +};
> +
>   static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   			struct snd_pcm_hw_params *params)
>   {
> @@ -524,6 +539,199 @@ static struct snd_soc_dai_link broxton_dais[] = {
>   	},
>   };
>   
> +/* geminilake digital audio interface glue - connects codec <--> CPU */
> +static struct snd_soc_dai_link geminilake_dais[] = {
> +	/* Front End DAI links */
> +	[BXT_DPCM_AUDIO_PB] = {
> +		.name = "Bxt Audio Port",
> +		.stream_name = "Audio",
> +		.cpu_dai_name = "System Pin",
> +		.platform_name = "0000:00:0e.0",
> +		.dynamic = 1,
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.nonatomic = 1,
> +		.init = broxton_da7219_fe_init,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.dpcm_playback = 1,
> +		.ops = &broxton_da7219_fe_ops,
> +	},
> +	[BXT_DPCM_AUDIO_CP] = {
> +		.name = "Bxt Audio Capture Port",
> +		.stream_name = "Audio Record",
> +		.cpu_dai_name = "System Pin",
> +		.platform_name = "0000:00:0e.0",
> +		.dynamic = 1,
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.nonatomic = 1,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.dpcm_capture = 1,
> +		.ops = &broxton_da7219_fe_ops,
> +	},
> +	[BXT_DPCM_AUDIO_REF_CP] = {
> +		.name = "Bxt Audio Reference cap",
> +		.stream_name = "Refcap",
> +		.cpu_dai_name = "Reference Pin",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "0000:00:0e.0",
> +		.init = NULL,
> +		.dpcm_capture = 1,
> +		.nonatomic = 1,
> +		.dynamic = 1,
> +		.ops = &broxton_refcap_ops,
> +	},
> +	[BXT_DPCM_AUDIO_DMIC_CP] = {
> +		.name = "Bxt Audio DMIC cap",
> +		.stream_name = "dmiccap",
> +		.cpu_dai_name = "DMIC Pin",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "0000:00:0e.0",
> +		.init = NULL,
> +		.dpcm_capture = 1,
> +		.nonatomic = 1,
> +		.dynamic = 1,
> +		.ops = &broxton_dmic_ops,
> +	},
> +	[BXT_DPCM_AUDIO_HDMI1_PB] = {
> +		.name = "Bxt HDMI Port1",
> +		.stream_name = "Hdmi1",
> +		.cpu_dai_name = "HDMI1 Pin",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "0000:00:0e.0",
> +		.dpcm_playback = 1,
> +		.init = NULL,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.nonatomic = 1,
> +		.dynamic = 1,
> +	},
> +	[BXT_DPCM_AUDIO_HDMI2_PB] =	{
> +		.name = "Bxt HDMI Port2",
> +		.stream_name = "Hdmi2",
> +		.cpu_dai_name = "HDMI2 Pin",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "0000:00:0e.0",
> +		.dpcm_playback = 1,
> +		.init = NULL,
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.nonatomic = 1,
> +		.dynamic = 1,
> +	},
> +	[BXT_DPCM_AUDIO_HDMI3_PB] =	{
> +		.name = "Bxt HDMI Port3",
> +		.stream_name = "Hdmi3",
> +		.cpu_dai_name = "HDMI3 Pin",
> +		.codec_name = "snd-soc-dummy",
> +		.codec_dai_name = "snd-soc-dummy-dai",
> +		.platform_name = "0000:00:0e.0",
> +		.trigger = {
> +			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.dpcm_playback = 1,
> +		.init = NULL,
> +		.nonatomic = 1,
> +		.dynamic = 1,
> +	},
> +	/* Back End DAI links */
> +	{
> +		/* SSP1 - Codec */
> +		.name = "SSP1-Codec",
> +		.id = 0,
> +		.cpu_dai_name = "SSP1 Pin",
> +		.platform_name = "0000:00:0e.0",
> +		.no_pcm = 1,
> +		.codec_name = "MX98357A:00",
> +		.codec_dai_name = BXT_MAXIM_CODEC_DAI,
> +		.dai_fmt = SND_SOC_DAIFMT_I2S |
> +			SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		.ignore_pmdown_time = 1,
> +		.be_hw_params_fixup = broxton_ssp_fixup,
> +		.dpcm_playback = 1,
> +	},
> +	{
> +		/* SSP2 - Codec */
> +		.name = "SSP2-Codec",
> +		.id = 1,
> +		.cpu_dai_name = "SSP2 Pin",
> +		.platform_name = "0000:00:0e.0",
> +		.no_pcm = 1,
> +		.codec_name = "i2c-DLGS7219:00",
> +		.codec_dai_name = BXT_DIALOG_CODEC_DAI,
> +		.init = broxton_da7219_codec_init,
> +		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		.ignore_pmdown_time = 1,
> +		.be_hw_params_fixup = broxton_ssp_fixup,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +	},

As I mentioned it in my earlier reviews, you could have kept the same 
dailinks for the two platforms and just update the first backend to be 
SSP5 for BXT and SSP1 for GLK, and the second as SSP1 for BXT and SSP2 
for Dialog. These updates would just be string replacements which can be 
done dynamically.
No need to copy the same structure when all you are about is 4 strings 
that change the routing.


> +	{
> +		.name = "dmic01",
> +		.id = 2,
> +		.cpu_dai_name = "DMIC01 Pin",
> +		.codec_name = "dmic-codec",
> +		.codec_dai_name = "dmic-hifi",
> +		.platform_name = "0000:00:0e.0",
> +		.ignore_suspend = 1,
> +		.be_hw_params_fixup = broxton_dmic_fixup,
> +		.dpcm_capture = 1,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "iDisp1",
> +		.id = 3,
> +		.cpu_dai_name = "iDisp1 Pin",
> +		.codec_name = "ehdaudio0D2",
> +		.codec_dai_name = "intel-hdmi-hifi1",
> +		.platform_name = "0000:00:0e.0",
> +		.init = broxton_hdmi_init,
> +		.dpcm_playback = 1,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "iDisp2",
> +		.id = 4,
> +		.cpu_dai_name = "iDisp2 Pin",
> +		.codec_name = "ehdaudio0D2",
> +		.codec_dai_name = "intel-hdmi-hifi2",
> +		.platform_name = "0000:00:0e.0",
> +		.init = broxton_hdmi_init,
> +		.dpcm_playback = 1,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "iDisp3",
> +		.id = 5,
> +		.cpu_dai_name = "iDisp3 Pin",
> +		.codec_name = "ehdaudio0D2",
> +		.codec_dai_name = "intel-hdmi-hifi3",
> +		.platform_name = "0000:00:0e.0",
> +		.init = broxton_hdmi_init,
> +		.dpcm_playback = 1,
> +		.no_pcm = 1,
> +	},
> +};
> +
> +static int is_geminilake(void)
> +{
> +	static const struct x86_cpu_id cpu_ids[] = {
> +		{ X86_VENDOR_INTEL, 6, 0x7A }, /* Geminilake CPU_ID */
> +		{}
> +	};
> +
> +	if (x86_match_cpu(cpu_ids))
> +		return true;
> +	return false;
> +}
> +
>   #define NAME_SIZE	32
>   static int bxt_card_late_probe(struct snd_soc_card *card)
>   {
> @@ -533,6 +741,13 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
>   	int err, i = 0;
>   	char jack_name[NAME_SIZE];
>   
> +	if (is_geminilake())
> +		snd_soc_dapm_add_routes(&card->dapm, gemini_map,
> +				ARRAY_SIZE(gemini_map));
> +	else
> +		snd_soc_dapm_add_routes(&card->dapm, broxton_map,
> +				ARRAY_SIZE(broxton_map));
> +
>   	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
>   		component = pcm->codec_dai->component;
>   		snprintf(jack_name, sizeof(jack_name),
> @@ -559,7 +774,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
>   }
>   
>   /* broxton audio machine driver for SPT + da7219 */
> -static struct snd_soc_card broxton_audio_card = {
> +static struct snd_soc_card bxt_audio_card_da7219_m98357a = {
>   	.name = "bxtda7219max",
>   	.owner = THIS_MODULE,
>   	.dai_link = broxton_dais,
> @@ -568,8 +783,24 @@ static struct snd_soc_card broxton_audio_card = {
>   	.num_controls = ARRAY_SIZE(broxton_controls),
>   	.dapm_widgets = broxton_widgets,
>   	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
> -	.dapm_routes = broxton_map,
> -	.num_dapm_routes = ARRAY_SIZE(broxton_map),
> +	.dapm_routes = audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(audio_map),
> +	.fully_routed = true,
> +	.late_probe = bxt_card_late_probe,
> +};
> +
> +/* geminilake audio machine driver for SPT + DA7219 */
> +static struct snd_soc_card glk_audio_card_da7219_m98357a = {
> +	.name = "glkda7219max",
> +	.owner = THIS_MODULE,
> +	.dai_link = geminilake_dais,
> +	.num_links = ARRAY_SIZE(geminilake_dais),
> +	.controls = broxton_controls,
> +	.num_controls = ARRAY_SIZE(broxton_controls),
> +	.dapm_widgets = broxton_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
> +	.dapm_routes = audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(audio_map),
>   	.fully_routed = true,
>   	.late_probe = bxt_card_late_probe,
>   };
> @@ -584,18 +815,36 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   
>   	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>   
> -	broxton_audio_card.dev = &pdev->dev;
> -	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
> +	audio_card =
> +		(struct snd_soc_card *)pdev->id_entry->driver_data;
> +
> +	audio_card->dev = &pdev->dev;
> +	snd_soc_card_set_drvdata(audio_card, ctx);
>   
> -	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
> +	return devm_snd_soc_register_card(&pdev->dev, audio_card);
>   }
>   
> +static const struct platform_device_id bxt_board_ids[] = {
> +	{
> +		.name = "bxt_da7219_max98357a",
> +		.driver_data =
> +			(kernel_ulong_t)&bxt_audio_card_da7219_m98357a,
> +	},
> +	{
> +		.name = "glk_da7219_max98357a",
> +		.driver_data =
> +			(kernel_ulong_t)&glk_audio_card_da7219_m98357a,
> +	},
> +	{ }
> +};
> +
>   static struct platform_driver broxton_audio = {
>   	.probe = broxton_audio_probe,
>   	.driver = {
>   		.name = "bxt_da7219_max98357a",
>   		.pm = &snd_soc_pm_ops,
>   	},
> +	.id_table = bxt_board_ids,
>   };
>   module_platform_driver(broxton_audio)
>   
> @@ -605,5 +854,7 @@ MODULE_AUTHOR("Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>");
>   MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
>   MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
>   MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
> +MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:bxt_da7219_max98357a");
> +MODULE_ALIAS("platform:glk_da7219_max98357a");
> 
