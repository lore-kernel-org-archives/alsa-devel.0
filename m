From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFD] Add hw_params support for hostless stream BE
	DAIs
Date: Tue, 23 Feb 2016 10:51:14 +0000
Message-ID: <1456224674.6424.22.camel@loki>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2B7260476
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 11:52:44 +0100 (CET)
In-Reply-To: <20160216161747.GA18103@jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, broonie@kernel.org, "Guiriec, Sebastien" <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-02-16 at 21:47 +0530, Jeeja KP wrote:
> We have no mechanism to configure hw_params for DAIs which are hostless.
> Like a loop or DAIs connected to internal sinks/sources.
> 

Fwiw, a few years back Peter, Sebastien and I were considering a similar
mechanism for the ABE on OMAP4. We never got around to implementing or
upstreaming though....

One comment below.

> Problem Statement:
> 	During a BE-BE loop of  DSP or a SRC->SINK path, we cannot program
> 	hw_params. There are no hw_params from user as these are hostless.
> 	This scenario can happens in below 2 cases:
> 	
> Case 1: BE-BE loop aka hostless stream through SoC DSP
> 	Hostless stream can be defined by BE to BE connection and in this case
> 	the path is enabled or disabled by the state of the DAPM graph. This
> 	usually means there is a mixer control that can be used to connect or
> 	disconnect the path between both DAIs.
> Example:
> 			|--------------/----------------|
> 			|				|
> 			|				|
> 		      codec out			    modem_in
> 			|				|
> 			|				|
> 		     ssp0_TX			    ssp1_RX
> 			|				|
> 			|				|
> 		  AIFI_Playback			dummy_capture
> 			
> 	In the above case (SSP0,codec playback,SSp1 dai needs to be configured 
> 	and turned on with  the selected hw_params). 
> 
> Case 2: SoC Internal Sink or Source
> Example:
>             		WOV SINK (DAPM Sink)
> 				|
> 				|
> 				|                 
> 			     Switch
> 				|
> 				|
> 				w1
> 				|
> 			dmic rx (BE dai widget)
> 				|
> 			Capture(codec dai widget)
> 				|
> 			    DMIC AIF
> 				|
> 			      DMic
> 				|
> 		Soc DMic (MIC Widget) (SRC)
> 
> 	In the above case BE (dmic RX) dai hw_params needs to applied.
> 	
> Approach:
> 	1. Allow params to be defined for other BE dai link also. this
> 	currently applicable only for codec_codec link.
> 
> 	2. when params is defined for BE dai link, create params kcontrols
> 	and associate it with the dai widgets. this will allow params to be
> 	selected via Kcontrol for each dai defined in the dai link.
> 

The only problem we have with using a kcontrol to define params is that
we already have an existing kernel ioctl and public C API to define
SW/HW params. This would add another mechanism, unless each new kcontrol
allows modification of a single param ?

Liam

> 	3. Before powering on the dai widget and if the dai is not powered
> 	with the stream event, then dai_ops(hw_params) for the dai widget will
> 	be called.This will apply the selected hw_params.
> 
> 	4. with the above, fix_up can be removed and can use .params to 
> 	select the parameter.
> 
> Core Changes:
> 	1. params definition needs to changed, currently this is defined to used
> 	only for codec codec link. define new flag to identifying codec 
> 	codec link.
> 
> 	2. if params is defined for any BE dai link, then create kcontrol for
> 	each dai defined in the dai_link and associated the kcontrol to dai 
> 	widget.
> 
> 	3. In the powering sequence check if the dai widget and if the event is
> 	not a stream event, SND_SOC_DAPM_STREAM_NOP , then call dai ops with 
> 	the selected params. This will apply the hw_params for dai.
> 
> 1. params definition:
> 		- Add new flag in struct snd_soc_dai_link.
> 		- Based on this flag create, the codec codec link instead of
> 		  params
> struct snd_soc_dai_link {
>         const struct snd_soc_pcm_stream *params;
>         unsigned int num_params;
> 
> +       /* flag to create codec codec based on the flag*/
> +       unsigned int codec_link:1;
> +
>         unsigned int dai_fmt;           /* format to set on init */
> 
>         enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
> 
> 	- creation of dai link based on the codec_link flag
> static int soc_probe_link_dais(struct snd_soc_card *card,
> int num, int order)
>                 }
>         } else {
> 
> -               if (!dai_link->params) {
> +               if (!dai_link->codec_link) {
>                         /* create the pcm */
>                         ret = soc_new_pcm(rtd, num);
>                         if (ret < 0) {
> 						
> 2. when params is defined for BE dai link, create params kcontrols and
> associate it with the dai widgets. this will allow params to be selected
> via Kcontrol for each dai defined in the dai link.
> a. Move the param control creation from snd_soc_dapm_new_pcm and add new
> API to created kcontrols with the params.
> +snd_soc_dapm_create_param_control(struct snd_soc_card *card,
> +					const struct snd_soc_pcm_stream *params,
> +					unsigned int num_params)
> {
> 	/* create kcontrol based on the params */
> }
> 
> - modify the snd_soc_dapm_new_pcm to create the param control
> int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
> 			 const struct snd_soc_pcm_stream *params,
> 			 unsigned int num_params,
> 			 struct snd_soc_dapm_widget *source,
> 			 struct snd_soc_dapm_widget *sink)
> {
> 
> 	template.kcontrol_news = snd_soc_dapm_create_param_control(card,
> 							params, num_params);
>  	if (!template.kcontrol_news) {
>  		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
>  			link_name);
>  		ret = -ENOMEM;
> -		goto outfree_private_value;
> +		goto outfree_link_name;
>  	}
>  
> 
> b. add new API snd_soc_dapm_new_dai_params() to create kcontrol for dai and associated it to dai.
> +int snd_soc_dapm_new_dai_params(struct snd_soc_card *card,
> +			 const struct snd_soc_pcm_stream *params,
> +			 unsigned int num_params,
> +			 struct snd_soc_dapm_widget *dai_w)
> +{
> +	struct snd_kcontrol_new *kcontrol_news;
> +
> +	kcontrol_news = snd_soc_dapm_create_param_control(card, params,
> +								num_params);
> +	if (!kcontrol_news) {
> +		dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
> +			dai_w->name);
> +		return -EINVAL;
> +	}
> +
> +	dai_w->num_kcontrols = 1;
> +	dai_w->kcontrol_news = kcontrol_news;
> +
> +	dai_w->params = params;
> +	dai_w->num_params = num_params;
> +
> +	return 0;
> +
> +}
> +
> +++ b/include/sound/soc-dapm.h
> +int snd_soc_dapm_new_dai_params(struct snd_soc_card *card,
> +			 const struct snd_soc_pcm_stream *params,
> +			 unsigned int num_params,
> +			 struct snd_soc_dapm_widget *dai_w);
> 
> 
> c. if the be dai link has .params defined, call new API snd_soc_dapm_new_dai_params
> 
> +static int soc_link_be_params_widget(struct snd_soc_card *card,
> +				struct snd_soc_dai *dai,
> +				const struct snd_soc_pcm_stream *params,
> +				unsigned int num_params)
> +{
> +	int ret;
> +	struct snd_soc_dapm_widget *w;
> +   
> +   if (!strcmp(dai->name, "snd-soc-dummy"))
> +		return 0;
> +		
> +	if (dai->playback_widget) {
> +		w = dai->playback_widget;
> +		ret = snd_soc_dapm_new_dai_params(card, params,
> +								num_params, w);
> +
> +		if (ret != 0) {
> +			dev_err(card->dev,
> +					"ASoC: Can't create params widget=%s %d\n",
> +					w->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (dai->capture_widget) {
> +		w = dai->capture_widget;
> +		ret = snd_soc_dapm_new_dai_params(card, params,
> +								num_params, w);
> +
> +		if (ret != 0) {
> +			dev_err(card->dev,
> +				"ASoC: Can't create params widget=%s %d\n",
> +				w->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int soc_link_be_params_dai_widgets(struct snd_soc_card *card,
> +				struct snd_soc_dai_link *dai_link,
> +				struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int ret, i;
> +
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec = rtd->codec_dais[i];
> +
> +		ret = soc_link_be_params_widget(card, codec,
> +							dai_link->params,
> +							dai_link->num_params);
> +
> +		if (!ret)
> +			return ret;
> +	}
> +
> +	return soc_link_be_params_widget(card, cpu_dai, dai_link->params,
> +						dai_link->num_params);
> +}
> +
> 
> @@ -1651,6 +1714,13 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  				       dai_link->stream_name, ret);
>  				return ret;
>  			}
> +			if (dai_link->params && dai_link->no_pcm) {
> +				/* create dai link controls */
> +				ret = soc_link_be_params_dai_widgets(card,
> +								dai_link, rtd);
> +				if (ret)
> +					return ret;
> +			}
>  		} else {
>  			INIT_DELAYED_WORK(&rtd->delayed_work,
>  						codec2codec_close_delayed_work);
> 
> 
> 3. Applying the hw_params for dai widget
> 
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -1398,9 +1398,64 @@ static void dapm_seq_check_event(struct snd_soc_card *
> card,
>  	}
>  }
>  
> +static int snd_soc_dai_params(struct snd_soc_dapm_widget *w, int event)
> +{
> +	struct snd_soc_dai *dai;
> +	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
> +	struct snd_pcm_substream substream;
> +	struct snd_pcm_hw_params *params = NULL;
> +	u64 fmt;
> +	int ret = 0;
> +
> +	if (WARN_ON(!config))
> +		return -EINVAL;
> +
> +	dai = w->priv;
> +
> +	if (config->formats) {
> +		fmt = ffs(config->formats) - 1;
> +	} else {
> +		dev_warn(w->dapm->dev, "ASoC: Invalid format %llx specified\n",
> +			 config->formats);
> +		fmt = 0;
> +	}
> +
> +	/* Currently very limited parameter selection */
> +	params = kzalloc(sizeof(*params), GFP_KERNEL);
> +	if (!params) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	snd_mask_set(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
> +
> +	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min =
> +		config->rate_min;
> +	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->max =
> +		config->rate_max;
> +
> +	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
> +		= config->channels_min;
> +	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
> +		= config->channels_max;
> +
> +	memset(&substream, 0, sizeof(substream));
> +	if (w->id == snd_soc_dapm_dai_in)
> +		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
> +	else
> +		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
> +
> +	ret = soc_dai_hw_params(&substream, params, dai);
> +	if (ret < 0)
> +		goto out;
> +out:
> +	kfree(params);
> +	return ret;
> +}
> +
>  /* Apply the coalesced changes from a DAPM sequence */
>  static void dapm_seq_run_coalesced(struct snd_soc_card *card,
> -				   struct list_head *pending)
> +				   struct list_head *pending,
> +				   int event)
>  {
>  	struct snd_soc_dapm_context *dapm;
>  	struct snd_soc_dapm_widget *w;
> @@ -1413,6 +1468,14 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
>  	dapm = w->dapm;
>  
>  	list_for_each_entry(w, pending, power_list) {
> +		if ((event == SND_SOC_DAPM_STREAM_NOP) &&
> +			((w->id == snd_soc_dapm_dai_out) ||
> +			(w->id == snd_soc_dapm_dai_in))) {
> +			snd_soc_dai_params(w, SND_SOC_DAPM_PRE_PMU);
> +		}
> +	}
> +
> +	list_for_each_entry(w, pending, power_list) {
>  		WARN_ON(reg != w->reg || dapm != w->dapm);
>  		w->power = w->new_power;
>  
> @@ -1447,6 +1510,13 @@ static void dapm_seq_run_coalesced(struct snd_soc_card *card,
>  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
>  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
>  	}
> +	list_for_each_entry(w, pending, power_list) {
> +		if ((event == SND_SOC_DAPM_STREAM_NOP) &&
> +			((w->id == snd_soc_dapm_dai_out) ||
> +			(w->id == snd_soc_dapm_dai_in))) {
> +			snd_soc_dai_params(w, SND_SOC_DAPM_POST_PMD);
> +		}
> +	}
>  }
>  
>  /* Apply a DAPM power sequence.
> @@ -1482,7 +1552,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
>  		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
>  		    w->dapm != cur_dapm || w->subseq != cur_subseq) {
>  			if (!list_empty(&pending))
> -				dapm_seq_run_coalesced(card, &pending);
> +				dapm_seq_run_coalesced(card, &pending, event);
>  
>  			if (cur_dapm && cur_dapm->seq_notifier) {
>  				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
> @@ -1545,7 +1615,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
>  	}
>  
>  	if (!list_empty(&pending))
> -		dapm_seq_run_coalesced(card, &pending);
> +		dapm_seq_run_coalesced(card, &pending, event);
>  
>  	if (cur_dapm && cur_dapm->seq_notifier) {
>  		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
> -- 
> 1.7.9.5
> 
> Comments welcome, based on discussion we will send patches.
> 
> --Jeeja
