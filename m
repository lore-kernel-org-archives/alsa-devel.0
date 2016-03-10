From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/6] ASoC: core: add
 snd_soc_add_dai_pcm_controls helper
Date: Thu, 10 Mar 2016 10:36:46 +0530
Message-ID: <20160310050646.GD11154@localhost>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
 <1457441641-7501-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 739DE260614
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 06:02:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457441641-7501-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 08, 2016 at 01:53:56PM +0100, Arnaud Pouliquen wrote:
> Add helper function to register DAI controls that need to be 
> linked to pcm device.
> A list is handled in case controls are created before dai_link probe

Overall this patch looks good to us. But on first read it is not very clear
how PCM and DAIs are inter related and why you need to do this. Since we are
having similar issues we were able to quickly understand this, the
suggestion would be to elborate a bit more in changelog.

Second, why do we need a new API for this. Why not use existing asoc
concepts and add one more field in dai_driver for dai_controls.
Core can automagically create those controls and link to PCM.

Lastly, this doesn't help our usecase of DPCM where the HDMI codec is
connected to a BE, so that rtd cannot be used and we need to link to FE, so
not sure how we can solve that...

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  include/sound/soc-dai.h |   1 +
>  include/sound/soc.h     |   2 +
>  sound/soc/soc-core.c    | 164 +++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 146 insertions(+), 21 deletions(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 964b7de..6e0fcb0 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -292,6 +292,7 @@ struct snd_soc_dai {
>  	unsigned int rx_mask;
>  
>  	struct list_head list;
> +	struct list_head list_pcm_ctl;
>  };
>  
>  static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 02b4a21..044adcf 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -598,6 +598,8 @@ int snd_soc_add_card_controls(struct snd_soc_card *soc_card,
>  	const struct snd_kcontrol_new *controls, int num_controls);
>  int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
>  	const struct snd_kcontrol_new *controls, int num_controls);
> +int snd_soc_add_dai_pcm_controls(struct snd_soc_dai *dai,
> +	const struct snd_kcontrol_new *controls, int num_controls);
>  int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_info *uinfo);
>  int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 790ee2b..95aae5e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1582,11 +1582,63 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
>  	return 0;
>  }
>  
> +static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
> +	const struct snd_kcontrol_new *controls, int num_controls,
> +	const char *prefix, void *data)
> +{
> +	int err, i;
> +
> +	for (i = 0; i < num_controls; i++) {
> +		const struct snd_kcontrol_new *control = &controls[i];
> +
> +		err = snd_ctl_add(card, snd_soc_cnew(control, data,
> +						     control->name, prefix));
> +		if (err < 0) {
> +			dev_err(dev, "ASoC: Failed to add %s: %d\n",
> +				control->name, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct snd_soc_dai_pcm_ctls {
> +	struct snd_kcontrol_new *controls;
> +	int num_controls;
> +	struct list_head list;
> +};
> +
> +static int soc_link_dai_pcm_controls(struct snd_soc_card *card,
> +				     struct snd_soc_dai *dai,
> +				     struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai_pcm_ctls *ctls, *_ctls;
> +	struct snd_kcontrol_new *kctl;
> +	int i, ret;
> +
> +	list_for_each_entry_safe(ctls, _ctls,  &dai->list_pcm_ctl, list) {
> +		kctl = ctls->controls;
> +		for (i = 0; i < ctls->num_controls; i++)
> +			kctl[i].device = rtd->pcm->device;
> +
> +		ret = snd_soc_add_controls(card->snd_card, dai->dev, kctl,
> +					   ctls->num_controls, NULL, dai);
> +		kfree(kctl);
> +		list_del(&ctls->list);
> +		kfree(ctls);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int soc_probe_link_dais(struct snd_soc_card *card,
>  		struct snd_soc_pcm_runtime *rtd, int order)
>  {
>  	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *dai, *cpu_dai = rtd->cpu_dai;
>  	int i, ret;
>  
>  	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
> @@ -1651,6 +1703,35 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  				       dai_link->stream_name, ret);
>  				return ret;
>  			}
> +
> +			/* link  CPU DAI pcm controls to pcm device */
> +			if (!list_empty(&cpu_dai->list_pcm_ctl))
> +				ret = soc_link_dai_pcm_controls(card, cpu_dai,
> +								rtd);
> +			if (ret < 0) {
> +				dev_err(card->dev,
> +					"ASoC: Can't link %s control to %s :%d\n",
> +					cpu_dai->name, dai_link->stream_name,
> +					ret);
> +				return ret;
> +			}
> +
> +			/* link CODEC DAI pcm control to pcm device */
> +			for (i = 0; i < rtd->num_codecs; i++) {
> +				dai = rtd->codec_dais[i];
> +				if (!list_empty(&dai->list_pcm_ctl))
> +					ret = soc_link_dai_pcm_controls(card,
> +								      dai, rtd);
> +				if (ret < 0)
> +					break;
> +			}
> +			if (ret < 0) {
> +				dev_err(card->dev,
> +					"ASoC: Can't link %s control to %s :%d\n",
> +					dai->name, dai_link->stream_name, ret);
> +				return ret;
> +			}
> +
>  		} else {
>  			INIT_DELAYED_WORK(&rtd->delayed_work,
>  						codec2codec_close_delayed_work);
> @@ -2187,26 +2268,6 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_cnew);
>  
> -static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
> -	const struct snd_kcontrol_new *controls, int num_controls,
> -	const char *prefix, void *data)
> -{
> -	int err, i;
> -
> -	for (i = 0; i < num_controls; i++) {
> -		const struct snd_kcontrol_new *control = &controls[i];
> -		err = snd_ctl_add(card, snd_soc_cnew(control, data,
> -						     control->name, prefix));
> -		if (err < 0) {
> -			dev_err(dev, "ASoC: Failed to add %s: %d\n",
> -				control->name, err);
> -			return err;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
>  					       const char *name)
>  {
> @@ -2320,6 +2381,65 @@ int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
>  EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
>  
>  /**
> + * snd_soc_add_dai_pcm_controls - add an array of pcm controls to a DAI.
> + * Convenience function to add a list of DAI controls linked to the PCM device.
> + *
> + * @dai: DAI to add controls to
> + * @controls: array of controls to add
> + * @num_controls: number of elements in the array
> + *
> + * Return 0 for success, else error.
> + */
> +int snd_soc_add_dai_pcm_controls(struct snd_soc_dai *dai,
> +				 const struct snd_kcontrol_new *controls,
> +				 int num_controls)
> +{
> +	struct snd_soc_card *card = dai->component->card;
> +	struct snd_soc_pcm_runtime *rtd;
> +	struct snd_soc_dai_pcm_ctls *ctls_list;
> +	struct snd_kcontrol_new *kctl;
> +	int i, dai_found = 0;
> +
> +	for (i = 0; i < num_controls; i++) {
> +		if (controls[i].iface != SNDRV_CTL_ELEM_IFACE_PCM) {
> +			dev_err(dai->dev, "%s: not a pcm device control !!!\n",
> +				controls[i].name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	kctl = kcalloc(num_controls, sizeof(*kctl), GFP_KERNEL);
> +	memcpy(kctl, controls,  sizeof(*kctl) * num_controls);
> +
> +	if (dai->probed) {
> +		/* pcm device exists. Control can be linked to it */
> +		list_for_each_entry(rtd, &card->rtd_list, list) {
> +			if (dai == rtd->cpu_dai) {
> +				dai_found = 1;
> +				break;
> +			}
> +		}
> +		if (!dai_found)
> +			return -EINVAL;
> +
> +		for (i = 0; i < num_controls; i++)
> +			kctl[i].device = rtd->pcm->device;
> +		snd_soc_add_controls(card->snd_card, dai->dev, kctl,
> +				     num_controls, NULL, dai);
> +		kfree(kctl);
> +	} else {
> +		/* pcm device does not exists. Postpone to dai link creation */
> +		ctls_list = kzalloc(sizeof(*ctls_list), GFP_KERNEL);
> +		ctls_list->controls = kctl;
> +		ctls_list->num_controls = num_controls;
> +		list_add(&ctls_list->list, &dai->list_pcm_ctl);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_add_dai_pcm_controls);
> +
> +/**
>   * snd_soc_dai_set_sysclk - configure DAI system or master clock.
>   * @dai: DAI
>   * @clk_id: DAI specific clock ID
> @@ -2795,6 +2915,8 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
>  	if (!dai->driver->ops)
>  		dai->driver->ops = &null_dai_ops;
>  
> +	INIT_LIST_HEAD(&dai->list_pcm_ctl);
> +
>  	list_add(&dai->list, &component->dai_list);
>  	component->num_dai++;
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
