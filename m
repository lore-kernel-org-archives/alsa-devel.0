From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFT v2 6/6] ASoC: core: Add support for DAI
	multicodec
Date: Sat, 22 Mar 2014 09:33:35 +0100
Message-ID: <532D4ADF.7030804@metafoo.de>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
 <1395415650-20045-7-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-066.synserver.de (smtp-out-069.synserver.de
 [212.40.185.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 093A02610B7
 for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2014 09:32:53 +0100 (CET)
In-Reply-To: <1395415650-20045-7-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2014 04:27 PM, Benoit Cousson wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>
> DAI link assumes a one to one mapping between CPU DAI and CODEC. In
> some cases, the same CPU DAI can be connected to several codecs.
> This is the case for example, if you connect two mono codecs to the
> same I2S link in order to have a stereo card.
> The current ASoC implementation does not allow such setup.
>
> Add support for DAI links composed of a single CPU DAI and multiple
> CODECs. Sound cards have to pass the CODECs array in the corresponding
> DAI link through a new 'snd_soc_dai_link_codec' struct. Each CODEC in
> this array is described in the same manner single CODEC DAIs are
> (either DT/OF node or codec_name).
>
> CPU DAI in a multicodec DAI link can have more channels than what each
> CODEC has. The number of channels each CODEC is responsible for is
> machine specific, hence it's fixed up in machine drivers in a similar
> way to what DPCM does.
>
> Fix a trailing space in the header as well.

This has been a feature that has been missing for quite a while, thanks for 
taking care of this. There are a few things that need to be fixed, but 
nothing that's not fixable.

I'd expect that after this patch has been applied there are no more usages 
of rtd->codec_dai. There are some though.

soc_pcm_params_symmetry() and soc_pcm_has_symmetry(), this should be trivial 
just loop over all the codecs.

rtd_get_codec_widget() this should be slightly restructured and merged with 
rtd_get_cpu_widget() to have a single function that takes a DAI and returns 
the widget. And then in dpcm_prune_paths() loop over all the codecs and only 
prune if neither of them are in the list.

dpcm_get_be() loop over all the codecs if you find one where the widget 
matches return the be.

soc_dpcm_be_digital_mute() mute all codecs.

snd_soc_dapm_connect_dai_link_widgets() needs to add a route for each codec 
DAI to the CPU DAI

A few places in soc-compress.c, but which should all be very similar to 
soc-pcm.c

I haven't fully understood how exactly the channel fixup works, so I didn't 
comment on it yet.

>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> [fparent@baylibre.com: Adapt to 3.14+]
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bcousson@baylibre.com: Change tdm mask fixup, add missing iteration
> over codecs array]
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
> ---
>   include/sound/soc-dai.h |   5 +
>   include/sound/soc.h     |  16 ++
>   sound/soc/soc-core.c    | 356 ++++++++++++++++++++++++++-------------
>   sound/soc/soc-dapm.c    |  39 +++--
>   sound/soc/soc-pcm.c     | 438 +++++++++++++++++++++++++++++++++---------------
>   5 files changed, 596 insertions(+), 258 deletions(-)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 2f66d5e..5391e70 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -274,6 +274,11 @@ struct snd_soc_dai {
>   	struct snd_soc_codec *codec;
>   	struct snd_soc_component *component;
>
> +	/* CODEC TDM slot masks and params (for fixup) */
> +	unsigned int tx_mask;
> +	unsigned int rx_mask;
> +	struct snd_pcm_hw_params params[2];
> +
>   	struct snd_soc_card *card;
>
>   	struct list_head list;
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 0b83168..fd14ec6 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -830,6 +830,15 @@ struct snd_soc_platform_driver {
>   	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
>   };
>
> +struct snd_soc_dai_link_codec {

For the sake of symmetry maybe name this snd_soc_dai_link_component and drop 
the 'codec_' prefix in front of the struct fields. There is no reason why 
this couldn't be used for CPU dais as well at some point.

> +	const char *codec_name;
> +	const struct device_node *codec_of_node;
> +	const char *codec_dai_name;

I'd like to see this split up into the descriptive part that holds the name, 
of_node etc, and the runtime data that holds the pointer to the DAIs. The 
descriptive part goes in the dai_link struct the. The pointers to the DAIs 
go into the snd_soc_pcm_runtime struct. This is how it is used the only 
place where you need both is in soc_bind_dai_link.

> +
> +	struct snd_soc_codec *codec;

We are trying to remove the asymmetry between the CPU side DAI and the CODEC 
side DAI of the DAI link. E.g. the cpu_dai can also be a CODEC. The only 
reason why there still is a codec pointer in the snd_soc_pcm_runtime struct 
is because there are still a few places where it is used (and for auxdevs). 
But we shouldn't mimic this for new code. Just use codec_dai->codec instead 
when you actually need a pointer to the codec.

> +	struct snd_soc_dai *codec_dai;
> +};
> +
>   struct snd_soc_platform {
>   	const char *name;
>   	int id;
> @@ -878,6 +887,10 @@ struct snd_soc_dai_link {
>   	const struct device_node *codec_of_node;
>   	/* You MUST specify the DAI name within the codec */
>   	const char *codec_dai_name;
> +
> +	struct snd_soc_dai_link_codec *codecs;
> +	int num_codecs;

unsigned int

> +
>   	/*
>   	 * You MAY specify the link's platform/PCM/DMA driver, either by
>   	 * device name, or by DT/OF node, but not both. Some forms of link
> @@ -1067,6 +1080,9 @@ struct snd_soc_pcm_runtime {
>   	struct snd_soc_dai *codec_dai;
>   	struct snd_soc_dai *cpu_dai;
>
> +	struct snd_soc_dai_link_codec *codecs;

With the changes suggested above this simply becomes:

	struct snd_soc_dai **codec_dais;

Which should also make the code shorter at places since

> +	int num_codecs;

unsigned int

> +
>   	struct delayed_work delayed_work;
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *debugfs_dpcm_root;
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index cfa481e..6b6fc39 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
[...]
> +	/* Find CODEC from registered CODECs */
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		codecs[i].codec = soc_find_codec(codecs[i].codec_of_node,
> +						 codecs[i].codec_name);
> +		if (!codecs[i].codec) {
> +			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
> +				codecs[i].codec_name);
> +			return -EPROBE_DEFER;
> +		}
>   	}
>
> -	/* Find CODEC DAI from registered list */
> -	rtd->codec_dai = soc_find_codec_dai(rtd->codec,
> -					    dai_link->codec_dai_name);
> -	if (!rtd->codec_dai) {
> -		dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
> -			dai_link->codec_dai_name);
> -		return -EPROBE_DEFER;
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		codecs[i].codec_dai = soc_find_codec_dai(
> +						codecs[i].codec,
> +						codecs[i].codec_dai_name);
> +		if (!codecs[i].codec_dai) {
> +			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
> +				codecs[i].codec_dai_name);
> +			return -EPROBE_DEFER;
> +		}
>   	}

I suggest to restructure this to:

	for (i = 0; i < rtd->num_codecs; i++) {
		rtd->codec_dais[i] = soc_find_codec_dai(codecs[i]);
		if (!rtd->codecs_dais[i])
			...
	}

And in soc_find_codec_dai lookup both the CODEC and the DAI

[...]
> +static int soc_dai_link_init(struct snd_soc_card *card, int num)
>   {
>   	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
>   	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
> -	const char *temp;
> -	int ret;
> +	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
> +	const char **temp;
> +	int i, ret;
>
>   	rtd->card = card;
>
> -	/* machine controls, routes and widgets are not prefixed */
> -	temp = codec->name_prefix;
> -	codec->name_prefix = NULL;
> +	temp = devm_kzalloc(card->dev, rtd->num_codecs * sizeof(char *),
> +			    GFP_KERNEL);


There is a patch http://permalink.gmane.org/gmane.linux.alsa.devel/120606 
which removes the temporary name_prefix = NULL. Having that patch applied 
first should make this a lot simpler. I don't think you'd even need patch 5 
then since this doesn't need to actually loop over all the CODECs anymore.

> +	if (!temp)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		/* Make sure all DAPM widgets are instantiated */
> +		snd_soc_dapm_new_widgets(codecs[i].codec->dapm.card);

We remove this per component snd_soc_dapm_new_widgets() calls a while ago, 
there is now only one call to snd_soc_dapm_new_widgets() once all components 
have been initialized.

> +
> +		/* machine controls, routes and widgets are not prefixed */
> +		temp[i] = codecs[i].codec->name_prefix;
> +		codecs[i].codec->name_prefix = NULL;
> +	}
>
>   	/* do machine specific initialization */
>   	if (dai_link->init) {
> @@ -1318,15 +1364,15 @@ static int soc_dai_link_init(struct snd_soc_card *card,
>   			return ret;
>   	}
>
> -	codec->name_prefix = temp;
> +	for (i = 0; i < rtd->num_codecs; i++)
> +		codecs[i].codec->name_prefix = temp[i];
>
> -	rtd->codec = codec;
> +	devm_kfree(card->dev, temp);
>
>   	return 0;
>   }
>
[...]
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c8a780d..6c6b7bea 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
[...]
> -static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
> -	int event)
> +static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
> +				  struct snd_soc_dai *cpu_dai,
> +				  struct snd_soc_dai *codec_dai,
> +				  int stream, int event)
>   {
> -
>   	struct snd_soc_dapm_widget *w_cpu, *w_codec;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>
>   	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
>   		w_cpu = cpu_dai->playback_widget;
> @@ -3582,9 +3593,15 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
>   			      int event)
>   {
>   	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai;
> +	int i;
>
>   	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> -	soc_dapm_stream_event(rtd, stream, event);
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		codec_dai = rtd->codecs[i].codec_dai;
> +		soc_dapm_stream_event(rtd, cpu_dai, codec_dai, stream, event);

This needs some refactoring. The looping over all the CODEC should be moved 
into soc_dapm_stream_event(). We don't want to call seperatly for each CODEC 
dapm_power_widgets().

> +	}
>   	mutex_unlock(&card->dapm_mutex);
>   }
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 330eaf0..01d6dd0 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
[...]
> @@ -78,24 +83,30 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
>   void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
>   {
[...]
>   }
>
> +

Extra newline

>   /**
>    * snd_soc_runtime_ignore_pmdown_time() - Check whether to ignore the power down delay
>    * @rtd: The ASoC PCM runtime that should be checked.
> @@ -107,11 +118,16 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
>    */
>   bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
>   {
> +	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
> +	int i, ignore = 0;
> +
>   	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
>   		return true;
>
> -	return rtd->cpu_dai->component->ignore_pmdown_time &&
> -			rtd->codec_dai->component->ignore_pmdown_time;
> +	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
> +		ignore |= codecs[i].codec_dai->component->ignore_pmdown_time;

This should be "ignore = 1" and then ignore &= ... for each CODEC. We only 
want to ignore the power down delay if all components agree that they do not 
need it.

> +
> +	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
>   }
>
>   /**
> @@ -310,32 +326,66 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
>   	}
>   }
[...]
> -	soc_pcm_apply_msb(substream, codec_dai);
> +	soc_pcm_apply_msb(substream, codecs[0].codec_dai);

I think how this should work is that there should only be a msb constraint 
if all the CODEC DAIs have a msb contraint and then it should be the maximum 
over all the contraints.

>   	soc_pcm_apply_msb(substream, cpu_dai);
>
[...]
>   /*
>    * Called by ALSA when the hardware params are set by application. This
>    * function can also be called multiple times and can allocate buffers
> @@ -667,9 +766,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_platform *platform = rtd->platform;
> +	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> -	int ret = 0;
> +	int i, ret = 0;
>
>   	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
>
> @@ -686,13 +785,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>   		}
>   	}
>
> -	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_params) {
> -		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
> -		if (ret < 0) {
> -			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
> -				" %d\n", codec_dai->name, ret);
> -			goto codec_err;
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = codecs[i].codec_dai;
> +		struct snd_pcm_hw_params *codec_params;
> +
> +		codec_params = &codec_dai->params[substream->stream];
> +
> +		/* copy params for each codec */
> +		memcpy(codec_params, params, sizeof(struct snd_pcm_hw_params));
> +
> +		/* fixup params based on TDM slot masks */
> +		if (codec_dai->tx_mask)
> +			soc_pcm_codec_params_fixup(codec_params,
> +						   codec_dai->tx_mask);
> +		if (codec_dai->rx_mask)
> +			soc_pcm_codec_params_fixup(codec_params,
> +						   codec_dai->rx_mask);
> +
> +		if (codec_dai->driver->ops &&
> +		    codec_dai->driver->ops->hw_params) {
> +			ret = codec_dai->driver->ops->hw_params(substream,
> +						codec_params, codec_dai);
> +			if (ret < 0) {
> +				dev_err(codec_dai->dev,
> +					"ASoC: can't set %s hw params: %d\n",
> +					codec_dai->name, ret);
> +				goto codec_err;
> +			}
>   		}
> +
> +		codec_dai->rate = params_rate(codec_params);
> +		codec_dai->channels = params_channels(codec_params);
> +		codec_dai->sample_bits = snd_pcm_format_physical_width(
> +						params_format(codec_params));

Those should only be set if all of the hw_params calls succeeded.

>   	}
>
>   	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_params) {
[...]
> @@ -764,16 +892,21 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
>   		cpu_dai->sample_bits = 0;
>   	}
>
> -	if (codec_dai->active == 1) {
> -		codec_dai->rate = 0;
> -		codec_dai->channels = 0;
> -		codec_dai->sample_bits = 0;
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		codec_dai = codecs[i].codec_dai;
> +		if (codec_dai->active == 1)

Missing brackets

> +			codec_dai->rate = 0;
> +			codec_dai->channels = 0;
> +			codec_dai->sample_bits = 0;
>   	}
>
[...]
> @@ -2193,22 +2353,29 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
>   int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>   {
>   	struct snd_soc_platform *platform = rtd->platform;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
> +	struct snd_soc_dai *codec_dai;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>   	struct snd_pcm *pcm;
>   	char new_name[64];
>   	int ret = 0, playback = 0, capture = 0;
> +	int i;
>
>   	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
>   		playback = rtd->dai_link->dpcm_playback;
>   		capture = rtd->dai_link->dpcm_capture;
>   	} else {
> -		if (codec_dai->driver->playback.channels_min &&
> -		    cpu_dai->driver->playback.channels_min)
> -			playback = 1;
> -		if (codec_dai->driver->capture.channels_min &&
> -		    cpu_dai->driver->capture.channels_min)
> -			capture = 1;
> +		for (i = 0; i < rtd->num_codecs; i++) {
> +			codec_dai = codecs[i].codec_dai;
> +			if (codec_dai->driver->playback.channels_min &&
> +			    cpu_dai->driver->playback.channels_min)
> +				playback++;
> +			if (codec_dai->driver->capture.channels_min &&
> +			    cpu_dai->driver->capture.channels_min)
> +				capture++;
> +		}
> +		capture = (rtd->num_codecs == capture);
> +		playback = (rtd->num_codecs == playback);

Hm... I'd say the runtime should support playback or capture if at least one 
of the codecs support playback or capture. Not only if all of them support it.

>   	}
>
>   	if (rtd->dai_link->playback_only) {
[...]
