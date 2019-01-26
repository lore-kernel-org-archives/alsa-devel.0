From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add KBL Dialog
 Maxim98373 I2S machine driver
Date: Sat, 26 Jan 2019 02:34:18 +0000
Message-ID: <20ADAB092842284E95860F279283C5645693C936@BGSMSX104.gar.corp.intel.com>
References: <1548096190-24584-1-git-send-email-jenny.tc@intel.com>
 <1548096190-24584-2-git-send-email-jenny.tc@intel.com>
 <0498d272-d635-5fc3-f343-0f4b449a3101@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id B3FB02666B3
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 03:34:29 +0100 (CET)
In-Reply-To: <0498d272-d635-5fc3-f343-0f4b449a3101@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>
Cc: "N, Harshapriya" <harshapriya.n@intel.com>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "M,
 Naveen" <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

>Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Boards: Add KBL Dialog
>Maxim98373 I2S machine driver
>
>
>On 1/21/19 12:43 PM, Jenny TC wrote:
>> This patch adds Kabylake I2S machine driver with:
>> DA7219 audio codec(SSP1) and MAXIM98373(SSP0) speaker amplifier.
>> The driver enables two different machine driver paths - one with
>> Maxim98373 + DA7219 and another one without DA7219
>
>What is the difference with kbl_da7219_max98357a? the amps are on the
>same SSP but with a two amps instead of one.
>
>Could this be converged so that we avoid 90+ % copy/paste just to change a
>component?

Pierre,
Let me compare these two drivers and  see if these two drivers can be converged

>
>> --- a/sound/soc/intel/boards/Kconfig
>> +++ b/sound/soc/intel/boards/Kconfig
>> @@ -315,6 +315,20 @@ endif ## SND_SOC_INTEL_KBL
>>
>>   if SND_SOC_INTEL_GLK
>>
>> +config SND_SOC_INTEL_KBL_DA7219_MAX98373_MACH
>Wrong location, you need to add this in the KBL parts.
>> +	tristate "ASoC Audio driver for KBL with DA7219 and MAX98373 in
>I2S Mode"
>> +	depends on X86_INTEL_LPSS && I2C
>> +	select SND_SOC_INTEL_SST
>this needs to go, this is the "old-style", SND_SOC_INTEL_SST is already
>selected at a higher level.
>> +enum {
>> +	KBL_DPCM_AUDIO_PB = 0,
>> +	KBL_DPCM_AUDIO_ECHO_REF_CP,
>> +	KBL_DPCM_AUDIO_REF_CP,
>> +	KBL_DPCM_AUDIO_DMIC_CP,
>> +	KBL_DPCM_AUDIO_HDMI1_PB,
>> +	KBL_DPCM_AUDIO_HDMI2_PB,
>> +	KBL_DPCM_AUDIO_HDMI3_PB,
>> +	KBL_DPCM_AUDIO_HS_PB,
>> +	KBL_DPCM_AUDIO_CP,
>usually the last two are before HDMI?
>> +};
>>
>> +
>> +	jack = &ctx->kabylake_headset;
>> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1,
>KEY_VOICECOMMAND);
>> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
>> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
>KEY_VOLUMEDOWN);
>
>this looks like the "old order", this has changed to
>
>  	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
>	snd_jack_set_key(jack->jack, SND_JACK_BTN_2,
>KEY_VOLUMEDOWN);
>	snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
>KEY_VOICECOMMAND);
>
>see e.g ('ASoC: Intel: kbl_da7219_max98927: fix the audio jack button
>remapping')
>
>i remember asking that existing machine drivers be realigned (which didn't
>happen btw), let's make sure new drivers are aligned from Day 1
>
>> +
>> +	da7219_aad_jack_det(component, &ctx->kabylake_headset);
>> +
>> +	return 0;
>> +}
>> +
>> +static int kabylake_dmic_init(struct snd_soc_pcm_runtime *rtd) {
>> +	int ret;
>> +
>> +	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC
>DMIC");
>> +	if (ret)
>> +		dev_err(rtd->dev, "SoC DMIC - Ignore suspend failed %d\n",
>ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int
>> +device) {
>> +	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd-
>>card);
>> +	struct snd_soc_dai *dai = rtd->codec_dai;
>> +	struct kbl_hdmi_pcm *pcm;
>> +
>> +	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
>> +	if (!pcm)
>> +		return -ENOMEM;
>> +
>> +	pcm->device = device;
>> +	pcm->codec_dai = dai;
>> +
>> +	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
>> +
>> +	return 0;
>> +}
>> +
>> +static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd) {
>> +	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI1_PB); }
>> +
>> +static int kabylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd) {
>> +	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI2_PB); }
>> +
>> +static int kabylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd) {
>> +	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI3_PB); }
>> +
>> +static int kabylake_da7219_fe_init(struct snd_soc_pcm_runtime *rtd) {
>> +	struct snd_soc_dapm_context *dapm;
>> +	struct snd_soc_component *component = rtd->cpu_dai-
>>component;
>> +
>> +	dapm = snd_soc_component_get_dapm(component);
>> +	snd_soc_dapm_ignore_suspend(dapm, "Reference Capture");
>> +
>> +	return 0;
>> +}
>> +
>> +static const unsigned int rates[] = {
>> +	48000,
>> +};
>> +
>> +static const struct snd_pcm_hw_constraint_list constraints_rates = {
>> +	.count = ARRAY_SIZE(rates),
>> +	.list  = rates,
>> +	.mask = 0,
>> +};
>> +
>> +static const unsigned int channels[] = {
>> +	DUAL_CHANNEL,
>> +};
>> +
>> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
>> +	.count = ARRAY_SIZE(channels),
>> +	.list = channels,
>> +	.mask = 0,
>> +};
>> +
>> +static unsigned int channels_quad[] = {
>> +	QUAD_CHANNEL,
>> +};
>> +
>> +static struct snd_pcm_hw_constraint_list constraints_channels_quad = {
>> +	.count = ARRAY_SIZE(channels_quad),
>> +	.list = channels_quad,
>> +	.mask = 0,
>> +};
>> +
>> +static int kbl_fe_startup(struct snd_pcm_substream *substream) {
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>> +	/*
>> +	 * On this platform for PCM device we support,
>> +	 * 48Khz
>> +	 * stereo
>> +	 * 24 bit audio
>> +	 */
>> +
>> +	runtime->hw.channels_max = DUAL_CHANNEL;
>> +	snd_pcm_hw_constraint_list(runtime, 0,
>SNDRV_PCM_HW_PARAM_CHANNELS,
>> +					   &constraints_channels);
>> +
>> +	runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_LE;
>> +	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
>> +
>> +	snd_pcm_hw_constraint_list(runtime, 0,
>> +				SNDRV_PCM_HW_PARAM_RATE,
>&constraints_rates);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct snd_soc_ops kabylake_da7219_fe_ops = {
>> +	.startup = kbl_fe_startup,
>> +};
>> +
>> +static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
>> +		struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_interval *channels = hw_param_interval(params,
>> +				SNDRV_PCM_HW_PARAM_CHANNELS);
>> +
>> +	/*
>> +	 * set BE channel constraint as user FE channels
>> +	 */
>> +
>> +	if (params_channels(params) == 2)
>> +		channels->min = channels->max = 2;
>> +	else
>> +		channels->min = channels->max = 4;
>> +
>> +	return 0;
>> +}
>> +
>> +static int kabylake_dmic_startup(struct snd_pcm_substream
>*substream)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>> +	runtime->hw.channels_min = runtime->hw.channels_max =
>QUAD_CHANNEL;
>> +	snd_pcm_hw_constraint_list(runtime, 0,
>SNDRV_PCM_HW_PARAM_CHANNELS,
>> +			&constraints_channels_quad);
>> +
>> +	runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_LE;
>> +	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
>> +
>> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +			SNDRV_PCM_HW_PARAM_RATE,
>&constraints_rates); }
>> +
>> +static struct snd_soc_ops kabylake_dmic_ops = {
>> +	.startup = kabylake_dmic_startup,
>> +};
>> +
>> +static const unsigned int rates_16000[] = {
>> +	16000,
>> +};
>> +
>> +static const struct snd_pcm_hw_constraint_list constraints_16000 = {
>> +	.count = ARRAY_SIZE(rates_16000),
>> +	.list  = rates_16000,
>> +};
>> +
>> +static const unsigned int ch_mono[] = {
>> +	1,
>> +};
>> +static const struct snd_pcm_hw_constraint_list constraints_refcap = {
>> +	.count = ARRAY_SIZE(ch_mono),
>> +	.list  = ch_mono,
>> +};
>> +
>> +static int kabylake_refcap_startup(struct snd_pcm_substream
>> +*substream) {
>> +	substream->runtime->hw.channels_max = 1;
>> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +
>	SNDRV_PCM_HW_PARAM_CHANNELS,
>> +					&constraints_refcap);
>> +
>> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +				SNDRV_PCM_HW_PARAM_RATE,
>> +				&constraints_16000);
>> +}
>> +
>> +
>> +static struct snd_soc_ops skylaye_refcap_ops = {
>> +	.startup = kabylake_refcap_startup,
>> +};
>> +
>> +static struct snd_soc_codec_conf max98373_codec_conf[] = {
>> +
>> +	{
>> +		.dev_name = MAXIM_DEV0_NAME,
>> +		.name_prefix = "Right",
>> +	},
>> +
>> +	{
>> +		.dev_name = MAXIM_DEV1_NAME,
>> +		.name_prefix = "Left",
>> +	},
>> +};
>> +
>> +static struct snd_soc_dai_link_component ssp0_codec_components[] = {
>> +	{ /* Left */
>> +		.name = MAXIM_DEV0_NAME,
>> +		.dai_name = MAX98373_CODEC_DAI,
>> +	},
>> +
>> +	{  /* For Right */
>> +		.name = MAXIM_DEV1_NAME,
>> +		.dai_name = MAX98373_CODEC_DAI,
>> +	},
>> +
>> +};
>> +
>> +/* kabylake digital audio interface glue - connects codec <--> CPU */
>> +static struct snd_soc_dai_link kabylake_dais[] = {
>> +	/* Front End DAI links */
>> +	[KBL_DPCM_AUDIO_PB] = {
>> +		.name = "Kbl Audio Port",
>> +		.stream_name = "Audio",
>> +		.cpu_dai_name = "System Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dynamic = 1,
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.nonatomic = 1,
>> +		.init = kabylake_da7219_fe_init,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.dpcm_playback = 1,
>> +		.ops = &kabylake_da7219_fe_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
>> +		.name = "Kbl Audio Echo Reference cap",
>> +		.stream_name = "Echoreference Capture",
>> +		.cpu_dai_name = "Echoref Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.capture_only = 1,
>> +		.nonatomic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_REF_CP] = {
>> +		.name = "Kbl Audio Reference cap",
>> +		.stream_name = "Wake on Voice",
>> +		.cpu_dai_name = "Reference Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.dpcm_capture = 1,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +		.ops = &skylaye_refcap_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_DMIC_CP] = {
>> +		.name = "Kbl Audio DMIC cap",
>> +		.stream_name = "dmiccap",
>> +		.cpu_dai_name = "DMIC Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.dpcm_capture = 1,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +		.ops = &kabylake_dmic_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI1_PB] = {
>> +		.name = "Kbl HDMI Port1",
>> +		.stream_name = "Hdmi1",
>> +		.cpu_dai_name = "HDMI1 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI2_PB] = {
>> +		.name = "Kbl HDMI Port2",
>> +		.stream_name = "Hdmi2",
>> +		.cpu_dai_name = "HDMI2 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI3_PB] = {
>> +		.name = "Kbl HDMI Port3",
>> +		.stream_name = "Hdmi3",
>> +		.cpu_dai_name = "HDMI3 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_HS_PB] = {
>> +		.name = "Kbl Audio Headset Playback",
>> +		.stream_name = "Headset Audio",
>> +		.cpu_dai_name = "System Pin2",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +		.init = kabylake_da7219_fe_init,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.ops = &kabylake_da7219_fe_ops,
>> +
>> +	},
>> +	[KBL_DPCM_AUDIO_CP] = {
>> +		.name = "Kbl Audio Capture Port",
>> +		.stream_name = "Audio Record",
>> +		.cpu_dai_name = "System Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dynamic = 1,
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.nonatomic = 1,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.dpcm_capture = 1,
>> +		.ops = &kabylake_da7219_fe_ops,
>> +	},
>> +
>> +
>> +	/* Back End DAI links */
>> +	{
>> +		/* SSP0 - Codec */
>> +		.name = "SSP0-Codec",
>> +		.id = 0,
>> +		.cpu_dai_name = "SSP0 Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.no_pcm = 1,
>> +		.codecs = ssp0_codec_components,
>> +		.num_codecs = ARRAY_SIZE(ssp0_codec_components),
>> +		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
>> +			SND_SOC_DAIFMT_NB_NF |
>> +			SND_SOC_DAIFMT_CBS_CFS,
>> +		.dpcm_playback = 1,
>> +		.dpcm_capture = 1,
>> +		.ignore_pmdown_time = 1,
>> +		.be_hw_params_fixup = kabylake_ssp_fixup,
>> +		.ops = &kabylake_ssp0_ops,
>> +	},
>> +	{
>> +		/* SSP1 - Codec */
>> +		.name = "SSP1-Codec",
>> +		.id = 1,
>> +		.cpu_dai_name = "SSP1 Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.no_pcm = 1,
>> +		.codec_name = "i2c-DLGS7219:00",
>> +		.codec_dai_name = KBL_DIALOG_CODEC_DAI,
>> +		.init = kabylake_da7219_codec_init,
>> +		.dai_fmt = SND_SOC_DAIFMT_I2S |
>SND_SOC_DAIFMT_NB_NF |
>> +			SND_SOC_DAIFMT_CBS_CFS,
>> +		.ignore_pmdown_time = 1,
>> +		.be_hw_params_fixup = kabylake_ssp_fixup,
>> +		.dpcm_playback = 1,
>> +		.dpcm_capture = 1,
>> +	},
>> +	{
>> +		.name = "dmic01",
>> +		.id = 2,
>> +		.cpu_dai_name = "DMIC01 Pin",
>> +		.codec_name = "dmic-codec",
>> +		.codec_dai_name = "dmic-hifi",
>> +		.init = kabylake_dmic_init,
>> +		.platform_name = "0000:00:1f.3",
>> +		.be_hw_params_fixup = kabylake_dmic_fixup,
>> +		.ignore_suspend = 1,
>> +		.dpcm_capture = 1,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp1",
>> +		.id = 3,
>> +		.cpu_dai_name = "iDisp1 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi1",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = kabylake_hdmi1_init,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp2",
>> +		.id = 4,
>> +		.cpu_dai_name = "iDisp2 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi2",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = kabylake_hdmi2_init,
>> +		.dpcm_playback = 1,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp3",
>> +		.id = 5,
>> +		.cpu_dai_name = "iDisp3 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi3",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = kabylake_hdmi3_init,
>> +		.dpcm_playback = 1,
>> +		.no_pcm = 1,
>> +	},
>> +};
>> +
>> +/* kabylake digital audio interface glue - connects codec <--> CPU */
>> +static struct snd_soc_dai_link kabylake_max98373_dais[] = {
>> +	/* Front End DAI links */
>> +	[KBL_DPCM_AUDIO_PB] = {
>> +		.name = "Kbl Audio Port",
>> +		.stream_name = "Audio",
>> +		.cpu_dai_name = "System Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dynamic = 1,
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.nonatomic = 1,
>> +		.init = kabylake_da7219_fe_init,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.dpcm_playback = 1,
>> +		.ops = &kabylake_da7219_fe_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
>> +		.name = "Kbl Audio Echo Reference cap",
>> +		.stream_name = "Echoreference Capture",
>> +		.cpu_dai_name = "Echoref Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.capture_only = 1,
>> +		.nonatomic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_REF_CP] = {
>> +		.name = "Kbl Audio Reference cap",
>> +		.stream_name = "Wake on Voice",
>> +		.cpu_dai_name = "Reference Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.dpcm_capture = 1,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +		.ops = &skylaye_refcap_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_DMIC_CP] = {
>> +		.name = "Kbl Audio DMIC cap",
>> +		.stream_name = "dmiccap",
>> +		.cpu_dai_name = "DMIC Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = NULL,
>> +		.dpcm_capture = 1,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +		.ops = &kabylake_dmic_ops,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI1_PB] = {
>> +		.name = "Kbl HDMI Port1",
>> +		.stream_name = "Hdmi1",
>> +		.cpu_dai_name = "HDMI1 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI2_PB] = {
>> +		.name = "Kbl HDMI Port2",
>> +		.stream_name = "Hdmi2",
>> +		.cpu_dai_name = "HDMI2 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +	[KBL_DPCM_AUDIO_HDMI3_PB] = {
>> +		.name = "Kbl HDMI Port3",
>> +		.stream_name = "Hdmi3",
>> +		.cpu_dai_name = "HDMI3 Pin",
>> +		.codec_name = "snd-soc-dummy",
>> +		.codec_dai_name = "snd-soc-dummy-dai",
>> +		.platform_name = "0000:00:1f.3",
>> +		.trigger = {
>> +			SND_SOC_DPCM_TRIGGER_POST,
>SND_SOC_DPCM_TRIGGER_POST},
>> +		.dpcm_playback = 1,
>> +		.init = NULL,
>> +		.nonatomic = 1,
>> +		.dynamic = 1,
>> +	},
>> +
>> +	/* Back End DAI links */
>> +	{
>> +		/* SSP0 - Codec */
>> +		.name = "SSP0-Codec",
>> +		.id = 0,
>> +		.cpu_dai_name = "SSP0 Pin",
>> +		.platform_name = "0000:00:1f.3",
>> +		.no_pcm = 1,
>> +		.codecs = ssp0_codec_components,
>> +		.num_codecs = ARRAY_SIZE(ssp0_codec_components),
>> +		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
>> +			SND_SOC_DAIFMT_NB_NF |
>> +			SND_SOC_DAIFMT_CBS_CFS,
>> +		.dpcm_playback = 1,
>> +		.dpcm_capture = 1,
>> +		.ignore_pmdown_time = 1,
>> +		.be_hw_params_fixup = kabylake_ssp_fixup,
>> +		.ops = &kabylake_ssp0_ops,
>> +	},
>> +	{
>> +		.name = "dmic01",
>> +		.id = 1,
>> +		.cpu_dai_name = "DMIC01 Pin",
>> +		.codec_name = "dmic-codec",
>> +		.codec_dai_name = "dmic-hifi",
>> +		.init = kabylake_dmic_init,
>> +		.platform_name = "0000:00:1f.3",
>> +		.be_hw_params_fixup = kabylake_dmic_fixup,
>> +		.ignore_suspend = 1,
>> +		.dpcm_capture = 1,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp1",
>> +		.id = 2,
>> +		.cpu_dai_name = "iDisp1 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi1",
>> +		.platform_name = "0000:00:1f.3",
>> +		.dpcm_playback = 1,
>> +		.init = kabylake_hdmi1_init,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp2",
>> +		.id = 3,
>> +		.cpu_dai_name = "iDisp2 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi2",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = kabylake_hdmi2_init,
>> +		.dpcm_playback = 1,
>> +		.no_pcm = 1,
>> +	},
>> +	{
>> +		.name = "iDisp3",
>> +		.id = 4,
>> +		.cpu_dai_name = "iDisp3 Pin",
>> +		.codec_name = "ehdaudio0D2",
>> +		.codec_dai_name = "intel-hdmi-hifi3",
>> +		.platform_name = "0000:00:1f.3",
>> +		.init = kabylake_hdmi3_init,
>> +		.dpcm_playback = 1,
>> +		.no_pcm = 1,
>> +	},
>> +};
>> +
>> +#define NAME_SIZE	32
>> +static int kabylake_card_late_probe(struct snd_soc_card *card) {
>> +	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
>> +	struct kbl_hdmi_pcm *pcm;
>> +	struct snd_soc_component *component = NULL;
>> +	struct snd_soc_dapm_context *dapm = &card->dapm;
>> +	int err, i = 0;
>> +	char jack_name[NAME_SIZE];
>> +
>> +	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
>> +		component = pcm->codec_dai->component;
>> +		snprintf(jack_name, sizeof(jack_name),
>> +			"HDMI/DP, pcm=%d Jack", pcm->device);
>> +		err = snd_soc_card_jack_new(card, jack_name,
>> +					SND_JACK_AVOUT, &skylake_hdmi[i],
>> +					NULL, 0);
>> +
>> +		if (err)
>> +			return err;
>> +
>> +		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
>> +				&skylake_hdmi[i]);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		i++;
>> +
>> +	}
>> +
>> +	if (!component)
>> +		return -EINVAL;
>> +
>> +	err = hdac_hdmi_jack_port_init(component, &card->dapm);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	err = snd_soc_dapm_disable_pin(dapm, "Left Spk");
>> +	if (err) {
>> +		dev_err(card->dev, "failed to disable Left Spk: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = snd_soc_dapm_disable_pin(dapm, "Right Spk");
>> +	if (err) {
>> +		dev_err(card->dev, "failed to disable Right Spk: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return snd_soc_dapm_sync(dapm);
>> +}
>> +
>> +/* kabylake audio machine driver for SPT + DA7219 */ static struct
>> +snd_soc_card kbl_audio_card_da7219_m98373 = {
>> +	.name = "kblda7219m98373",
>> +	.owner = THIS_MODULE,
>> +	.dai_link = kabylake_dais,
>> +	.num_links = ARRAY_SIZE(kabylake_dais),
>> +	.controls = kabylake_controls,
>> +	.num_controls = ARRAY_SIZE(kabylake_controls),
>> +	.dapm_widgets = kabylake_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(kabylake_widgets),
>> +	.dapm_routes = kabylake_map,
>> +	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
>> +	.codec_conf = max98373_codec_conf,
>> +	.num_configs = ARRAY_SIZE(max98373_codec_conf),
>> +	.fully_routed = true,
>> +	.late_probe = kabylake_card_late_probe, };
>> +
>> +/* kabylake audio machine driver for Maxim98373 */ static struct
>> +snd_soc_card kbl_audio_card_max98373 = {
>> +	.name = "kblmax98373",
>> +	.owner = THIS_MODULE,
>> +	.dai_link = kabylake_max98373_dais,
>> +	.num_links = ARRAY_SIZE(kabylake_max98373_dais),
>> +	.controls = kabylake_controls,
>> +	.num_controls = ARRAY_SIZE(kabylake_controls),
>> +	.dapm_widgets = kabylake_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(kabylake_widgets),
>> +	.dapm_routes = kabylake_map,
>> +	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
>> +	.codec_conf = max98373_codec_conf,
>> +	.num_configs = ARRAY_SIZE(max98373_codec_conf),
>> +	.fully_routed = true,
>> +	.late_probe = kabylake_card_late_probe, };
>> +
>> +static int kabylake_audio_probe(struct platform_device *pdev) {
>> +	struct kbl_codec_private *ctx;
>> +
>> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>> +
>> +	kabylake_audio_card =
>> +		(struct snd_soc_card *)pdev->id_entry->driver_data;
>> +
>> +	kabylake_audio_card->dev = &pdev->dev;
>> +	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
>> +
>> +	return devm_snd_soc_register_card(&pdev->dev,
>kabylake_audio_card);
>> +}
>> +
>> +static const struct platform_device_id kbl_board_ids[] = {
>> +	{
>> +		.name = "kbl_da7219_max98373",
>> +		.driver_data =
>> +			(kernel_ulong_t)&kbl_audio_card_da7219_m98373,
>> +	},
>> +	{
>> +		.name = "kbl_max98373",
>> +		.driver_data =
>> +			(kernel_ulong_t)&kbl_audio_card_max98373,
>> +	},
>> +	{ }
>> +};
>> +
>> +static struct platform_driver kabylake_audio = {
>> +	.probe = kabylake_audio_probe,
>> +	.driver = {
>> +		.name = "kbl_da7219_max98373",
>> +		.pm = &snd_soc_pm_ops,
>> +	},
>> +	.id_table = kbl_board_ids,
>> +};
>> +
>> +module_platform_driver(kabylake_audio)
>> +
>> +/* Module information */
>> +MODULE_DESCRIPTION("Audio KabyLake Machine driver for MAX98373
>&
>> +DA7219"); MODULE_AUTHOR("Sathya Prakash M R
>> +<sathya.prakash.m.r@intel.com>"); MODULE_AUTHOR("Sathyanarayana
>> +Nujella <sathyanarayana.nujella@intel.com>");
>> +MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:kbl_da7219_max98373");
>> +MODULE_ALIAS("platform:kbl_max98373");
