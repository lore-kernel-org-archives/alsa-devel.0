From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: core: Add API to use DMI name in
 sound card long name
Date: Wed, 21 Dec 2016 08:37:28 -0600
Message-ID: <9511f55d-8a49-7e32-7faf-9d3fa26820ca@linux.intel.com>
References: <cover.1482324245.git.mengdong.lin@linux.intel.com>
 <748589b74f8f4a6fefe7e545c21a6db5e71a74e1.1482324245.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D3F2668D1
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 15:37:31 +0100 (CET)
In-Reply-To: <748589b74f8f4a6fefe7e545c21a6db5e71a74e1.1482324245.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


>  /* Utility functions to get clock rates from various things */
>  int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>  int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
> @@ -1094,6 +1096,8 @@ struct snd_soc_card {
>  	const char *name;
>  	const char *long_name;
>  	const char *driver_name;
> +	char dmi_longname[80];

why 80? is this linked to DMI restrictions on board/product names?

>
> +/**
> + * snd_soc_set_dmi_name() - Register DMI names to card
> + * @card: The card to register DMI names
> + * @flavour: The flavour "differentiator" for the card amongst its peers.
> + *
> + * Intel DSP platform drivers are used by many different devices but are
> + * difficult for userspace to differentiate, since machine drivers ususally
> + * use their own name as the card name (short name) and leave the card long
> + * name blank. This function will allow DMI info to be used in the sound
> + * card long name, thereby helping userspace load the correct UCM (Use Case
> + * Manager) configuration.
> + * Possible card long names may be:
> + * broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH
> + * broadwell-rt286-Intel Corp.-Broadwell Client platform-Wilson Beach SDS
> + * bytcr-rt5640-ASUSTeK COMPUTER INC.-T100TA-T100TA
> + * bytcr-rt5651-Circuitco-Minnowboard Max D0 PLATFORM-MinnowBoard MAX

You may want to add a comment that the '.' is not a separator but part 
of the DMI name. I was trying to figure out why there were cases with .-

> + *
> + * This function also supports flavoring the card longname to provide
> + * the extra differentiation.
> + *
> + * Returns 0 on success, otherwise a negative error code.
> + */
> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
> +{
> +	const char *vendor, *product, *board;
> +
> +	if (card->long_name)
> +		return 0; /* long name already set by driver or from DMI */
> +
> +	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> +	if (!vendor) {
> +		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
> +		return 0;
> +	}
> +
> +	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> +	board = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (!board && !product) {
> +		/* fall back to using legacy name */
> +		dev_warn(card->dev, "ASoC: no DMI board/product name!\n");
> +		return 0;
> +	}
> +
> +	/* make up dmi long name as:
> +	 * card name (usually machine driver name) -vendor -product -board
> +	 */
> +	snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
> +			"%s-%s", card->name, vendor);
> +
> +	if (product) {
> +		strncat(card->dmi_longname, "-",
> +			sizeof(card->snd_card->longname));
> +		strncat(card->dmi_longname, product,
> +			sizeof(card->snd_card->longname));
> +	}
> +
> +	if (board) {
> +		strncat(card->dmi_longname, "-",
> +			sizeof(card->snd_card->longname));
> +		strncat(card->dmi_longname, board,
> +			sizeof(card->snd_card->longname));
> +	}
> +
> +
> +	/* Add flavour to dmi long name */
> +	if (flavour) {
> +		strncat(card->dmi_longname, "-",
> +			sizeof(card->snd_card->longname));
> +		strncat(card->dmi_longname, flavour,
> +			sizeof(card->snd_card->longname));
> +	}

how is the 'flavour' defined? This doesn't seem to come from the DMI 
decode information? Is this for example intended to be used with quirks?


> +
> +	/* set long name */
> +	card->long_name = card->dmi_longname;
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
> +
>  static int snd_soc_instantiate_card(struct snd_soc_card *card)
>  {
>  	struct snd_soc_codec *codec;
>
